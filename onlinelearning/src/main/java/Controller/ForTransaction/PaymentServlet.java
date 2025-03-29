package Controller.ForTransaction;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

import DAO.CourseDAO;
import DAO.EnrollmentDAO;
import DAO.PriceCourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Module.User ;
import Module.Course ;
import Module.PriceCourse ;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

@WebServlet(name="PaymentServlet", urlPatterns={"/payment", "/check-payment"})
public class PaymentServlet extends HttpServlet {

    // VNPay Configuration - Replace these with the values you get from VNPay
    private static final String VNP_VERSION = "2.1.0";
    private static final String VNP_COMMAND = "pay";
    private static final String VNP_TMN_CODE = "RMIW237P"; // Replace with your merchant code
    private static final String VNP_HASH_SECRET = "WEZHX6YDDTBINCKSE29ZCK8GZPRN8DQT"; // Replace with your hash secret
    private static final String VNP_API_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    private static final String VNP_RETURN_URL = "https://e5d5-2402-800-6d62-de65-dc73-7e9d-fc8-b0d4.ngrok-free.app/online/check-payment";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");

            if (action == null) {
                // Show order confirmation page
                showOrderConfirmation(request, response);
            } else if ("processPayment".equals(action)) {
                // Process order confirmation and generate QR code
                processPayment(request, response);
            } else if (action.equals("check-status")) {
                // Check payment status
                checkPaymentStatus(request, response);
            }
        }
    }

    private void showOrderConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int pricePackageId = Integer.parseInt(request.getParameter("pricePackageId"));

        CourseDAO courseDAO = new CourseDAO();
        PriceCourseDAO priceCourseDAO = new PriceCourseDAO();

        Course course = courseDAO.getById(courseId);
        PriceCourse pricePackage = priceCourseDAO.getById(pricePackageId);

        if (course == null || pricePackage == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Store in session for later retrieval
        session.setAttribute("selectedCourse", course);
        session.setAttribute("selectedPricePackage", pricePackage);
        session.setAttribute("selectedCourseId", courseId);
        session.setAttribute("selectedPricePackageId", pricePackageId);

        request.getRequestDispatcher("order-confirmation.jsp").forward(request, response);
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Get form data from request
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        String country = request.getParameter("country");

        // Get course and price package from session
        Course course = (Course) session.getAttribute("selectedCourse");
        PriceCourse pricePackage = (PriceCourse) session.getAttribute("selectedPricePackage");

        if (course == null || pricePackage == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Generate order ID
        String orderId = generateOrderId();
        int amount = (int)pricePackage.getSalePrice();

        // Convert amount to VND (required by VNPay) - assuming price is in USD
        // 1 USD = 24,000 VND (approximation)
//        long amountVND = Math.round(amount * 24000 * 100); // Convert to VND and then multiply by 100 as per VNPay format
        long amountVND = 10000 ;
        // Create payment URL for VNPay
        String paymentUrl = createVNPayPaymentUrl(orderId, amountVND, course.getCourseName());

        // Store order details in session
        request.setAttribute("orderId", orderId);
        request.setAttribute("amount", amount);
        session.setAttribute("selectedCourseId", course.getCourseId());
        session.setAttribute("selectedPricePackageId", pricePackage.getPriceId());
        request.setAttribute("qrCodeUrl",paymentUrl);
        // Store customer info
        session.setAttribute("customerName", fullName);
        session.setAttribute("customerEmail", email);
        session.setAttribute("customerPhone", phone);
        session.setAttribute("customerAddress", address);
        session.setAttribute("customerNote", note);
        session.setAttribute("customerCountry", country);

        // SOLUTION 1: Direct redirect to VNPay (recommended for production)
        request.getRequestDispatcher("Transaction/vnpay-payment.jsp").forward(request,response);

    }

    private String generateOrderId() {
        // Format: ORDER_YYYYMMDD_HHMMSS_RANDOM
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
        return "ORDER_" + sdf.format(new Date()) + "_" + (int)(Math.random() * 1000);
    }

    private String createVNPayPaymentUrl(String orderId, long amountVND, String orderInfo) {
        try {
            // Sử dụng múi giờ Asia/Ho_Chi_Minh để đồng bộ với VNPay
            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String createDate = formatter.format(cld.getTime());

            System.out.println("Thời gian tạo giao dịch: " + createDate);
            System.out.println("Múi giờ hiện tại: " + cld.getTimeZone().getDisplayName());

            // Tạo map chứa các tham số VNPay
            Map<String, String> vnpParams = new HashMap<>();
            vnpParams.put("vnp_Version", VNP_VERSION);
            vnpParams.put("vnp_Command", VNP_COMMAND);
            vnpParams.put("vnp_TmnCode", VNP_TMN_CODE);
            vnpParams.put("vnp_Amount", String.valueOf(amountVND));
            vnpParams.put("vnp_CurrCode", "VND");
            vnpParams.put("vnp_BankCode", ""); // Để trống để chọn phương thức thanh toán
            vnpParams.put("vnp_TxnRef", orderId);
            vnpParams.put("vnp_OrderInfo", "Thanh toan khoa hoc: " + orderInfo); // Không mã hóa URL ở đây
            vnpParams.put("vnp_OrderType", "other"); // giá trị mặc định
            vnpParams.put("vnp_Locale", "vn");
            vnpParams.put("vnp_ReturnUrl", VNP_RETURN_URL);
            vnpParams.put("vnp_IpAddr", "127.0.0.1");
            vnpParams.put("vnp_CreateDate", createDate);

            // In ra tất cả tham số để kiểm tra
            System.out.println("VNPay Parameters:");
            for (Map.Entry<String, String> entry : vnpParams.entrySet()) {
                System.out.println(entry.getKey() + ": " + entry.getValue());
            }

            // Xây dựng chuỗi query đã sắp xếp theo yêu cầu của VNPay
            List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
            Collections.sort(fieldNames);

            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();

            for (String fieldName : fieldNames) {
                String fieldValue = vnpParams.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    // Xây dựng hashData không mã hóa URL
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(fieldValue);

                    // Xây dựng query với mã hóa URL
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.UTF_8.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.toString()));

                    if (fieldName != fieldNames.get(fieldNames.size() - 1)) {
                        hashData.append('&');
                        query.append('&');
                    }
                }
            }

            // In ra dữ liệu hash để kiểm tra
            System.out.println("Hash Data: " + hashData.toString());

            // Tạo chữ ký HMAC-SHA512
            String vnpSecureHash = hmacSHA512(VNP_HASH_SECRET, hashData.toString());
            System.out.println("Generated Secure Hash: " + vnpSecureHash);

            // Thêm chữ ký vào query
            query.append("&vnp_SecureHash=").append(vnpSecureHash);

            // Tạo URL đầy đủ
            String paymentUrl = VNP_API_URL + "?" + query.toString();
            System.out.println("Final Payment URL: " + paymentUrl);

            return paymentUrl;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    // HMAC_SHA512 mã hóa để tạo chữ ký bảo mật VNPay
    private String hmacSHA512(String key, String data) {
        try {
            Mac sha512Hmac = Mac.getInstance("HmacSHA512");
            SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            sha512Hmac.init(keySpec);
            byte[] hmacBytes = sha512Hmac.doFinal(data.getBytes(StandardCharsets.UTF_8));

            StringBuilder result = new StringBuilder();
            for (byte b : hmacBytes) {
                result.append(String.format("%02x", b));
            }
            return result.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
    private void checkPaymentStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get all parameters from VNPay response
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }
        
        // Check if this is a VNPay response (has vnp_ResponseCode)
        String vnpResponseCode = fields.get("vnp_ResponseCode");
        String vnpTxnRef = fields.get("vnp_TxnRef"); // Transaction reference (order ID)
        
        // Debug log the response
        System.out.println("VNPay Response - Code: " + vnpResponseCode + ", OrderId: " + vnpTxnRef);
        System.out.println("Full parameters: " + fields);
        
        // If this is not a VNPay response (direct access to /check-payment)
        if (vnpResponseCode == null) {
            // Try to get orderId from the session or request
            String orderId = request.getParameter("orderId");
            if (orderId == null) {
                orderId = (String) session.getAttribute("orderId");
            }
            
            if (orderId != null) {
                response.sendRedirect("payment-pending.jsp?orderId=" + orderId);
            } else {
                response.sendRedirect("payment-failure.jsp?error=missing_order");
            }
            return;
        }
        
        // Check if payment was successful - "00" is success code in VNPay
        boolean paymentSuccess = "00".equals(vnpResponseCode);
        
        // Get session data
        Integer courseId = (Integer) session.getAttribute("selectedCourseId");
        Integer pricePackageId = (Integer) session.getAttribute("selectedPricePackageId");
        User user = (User) session.getAttribute("account");
        
        if (paymentSuccess) {
            if (courseId != null && pricePackageId != null && user != null) {
                try {
                    // Create enrollment record
                    EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
                    
                    // TODO: You need to complete the EnrollmentDAO implementation with the appropriate method
                    // Uncomment and use ONE of these lines based on your DAO implementation:
                    
                    // Option 1: If your DAO has this method signature:
                    // enrollmentDAO.insert(user.getUserId(), courseId, new Date(), pricePackageId);
                    
                    // Option 2: If your DAO expects different parameter types:
                    // enrollmentDAO.insert(user.getUserId(), courseId.intValue(), new Date(), pricePackageId.intValue());
                    
                    // Option 3: If your DAO has a different method name:
                    // enrollmentDAO.insertEnrollment(user.getUserId(), courseId, new Date(), pricePackageId);
                    
                    // For testing, you can temporarily comment out this line to avoid the error
                    System.out.println("Payment successful! Would enroll user " + user.getUserId() + 
                                      " in course " + courseId + " with price package " + pricePackageId);
                    
                    // Clear session data
                    session.removeAttribute("orderId");
                    session.removeAttribute("selectedCourseId");
                    session.removeAttribute("selectedPricePackageId");
                    session.removeAttribute("amount");
                    session.removeAttribute("selectedCourse");
                    session.removeAttribute("selectedPricePackage");
                    
                    response.sendRedirect("payment-success.jsp");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("payment-failure.jsp?error=enrollment_error");
                }
            } else {
                // Session data is missing
                System.out.println("Missing session data. CourseId: " + courseId +
                        ", PricePackageId: " + pricePackageId +
                        ", User: " + (user != null ? user.getUserId() : "null"));
                response.sendRedirect("payment-failure.jsp?error=session_expired");
            }
        } else {
            // Payment failed with a specific error code
            String errorMessage = getVNPayErrorMessage(vnpResponseCode);
            response.sendRedirect("payment-failure.jsp?error=" + vnpResponseCode + "&message=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8.toString()));
        }
    }
    
    // Helper method to get error message based on VNPay response code
    private String getVNPayErrorMessage(String responseCode) {
        switch (responseCode) {
            case "01": return "Transaction not found";
            case "02": return "Transaction failed";
            case "04": return "Invalid amount";
            case "05": return "Invalid merchant";
            case "06": return "Invalid bank code";
            case "07": return "Transaction received (pending)";
            case "09": return "Expired transaction";
            case "10": return "Duplicate transaction";
            case "11": return "Cancelled transaction";
            case "24": return "Customer cancelled transaction";
            case "51": return "Invalid account balance";
            case "65": return "Exceeds daily limit";
            case "75": return "Bank transaction limit exceeded";
            case "79": return "Invalid OTP authentication";
            case "99": return "Unknown error";
            default: return "Transaction failed with code: " + responseCode;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Payment Servlet";
    }

}