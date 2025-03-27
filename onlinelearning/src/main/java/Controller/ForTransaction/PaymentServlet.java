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

@WebServlet(name="PaymentServlet", urlPatterns={"/payment"})
public class PaymentServlet extends HttpServlet {

    // VNPay Configuration
    private static final String VNP_VERSION = "2.1.0";
    private static final String VNP_COMMAND = "pay";
    private static final String VNP_TMN_CODE = " CJERXUQK"; // Replace with your merchant code
    private static final String VNP_HASH_SECRET = "V2D93XMJK3HUJMPKNPMACGWZ3B7EM4W2"; // Replace with your hash secret
    private static final String VNP_API_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    private static final String VNP_RETURN_URL = "http://localhost:8080/onlinelearning/check-payment";

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
        double amount = pricePackage.getSalePrice();

        // Convert amount to VND (required by VNPay) - assuming price is in USD
        // 1 USD = 24,000 VND (approximation)
        long amountVND = Math.round(amount * 24000 * 100); // Convert to VND and then multiply by 100 as per VNPay format

        // Create payment URL for VNPay
        String paymentUrl = createVNPayPaymentUrl(orderId, amountVND, course.getCourseName());

        // Store order details in session
        session.setAttribute("orderId", orderId);
        session.setAttribute("amount", amount);
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
            // Get current time and format
            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String createDate = formatter.format(cld.getTime());

            // Create vnpay payment url
            Map<String, String> vnpParams = new HashMap<>();
            vnpParams.put("vnp_Version", VNP_VERSION);
            vnpParams.put("vnp_Command", VNP_COMMAND);
            vnpParams.put("vnp_TmnCode", VNP_TMN_CODE);
            vnpParams.put("vnp_Amount", String.valueOf(amountVND));
            vnpParams.put("vnp_CurrCode", "VND");
            vnpParams.put("vnp_BankCode", ""); // Leave blank for payment method selection
            vnpParams.put("vnp_TxnRef", orderId);
            vnpParams.put("vnp_OrderInfo", "Thanh toan khoa hoc: " + orderInfo);
            vnpParams.put("vnp_OrderType", "other"); // default value
            vnpParams.put("vnp_Locale", "vn");
            vnpParams.put("vnp_ReturnUrl", VNP_RETURN_URL);
            vnpParams.put("vnp_IpAddr", "127.0.0.1");
            vnpParams.put("vnp_CreateDate", createDate);

            // Build query string
            List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
            Collections.sort(fieldNames);

            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();

            Iterator<String> itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = itr.next();
                String fieldValue = vnpParams.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }

            // Create hmac-sha512 signature
            String vnpSecureHash = hmacSHA512(VNP_HASH_SECRET, hashData.toString());
            query.append("&vnp_SecureHash=").append(vnpSecureHash);

            // Return the full URL
            String paymentUrl = VNP_API_URL + "?" + query.toString();

            // Debug logs
            System.out.println("VNPay Payment URL: " + paymentUrl);

            return paymentUrl;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    // HMAC_SHA512 encoding for VNPay secure hash
    private String hmacSHA512(String key, String data) throws Exception {
        Mac sha512Hmac = Mac.getInstance("HmacSHA512");
        SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
        sha512Hmac.init(keySpec);
        byte[] hmacBytes = sha512Hmac.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder result = new StringBuilder();
        for (byte b : hmacBytes) {
            result.append(String.format("%02x", b));
        }
        return result.toString();
    }

    private void checkPaymentStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String orderId = (String) session.getAttribute("orderId");
        Integer courseId = (Integer) session.getAttribute("courseId");
        Integer pricePackageId = (Integer) session.getAttribute("pricePackageId");
        User user = (User) session.getAttribute("account");

        if (orderId == null || courseId == null || pricePackageId == null || user == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Check payment status with VNPay
        boolean paymentSuccess = checkVNPayPaymentStatus(orderId);

        if (paymentSuccess) {
            // Create enrollment record
            EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
//            enrollmentDAO.insertEnrollment(user.getUserId(), courseId, new Date(), pricePackageId);

            // Clear session data
            session.removeAttribute("orderId");
            session.removeAttribute("courseId");
            session.removeAttribute("pricePackageId");
            session.removeAttribute("amount");

            response.sendRedirect("payment-success.jsp");
        } else {
            response.sendRedirect("payment-failure.jsp");
        }
    }

    private boolean checkVNPayPaymentStatus(String orderId) {
        // TODO: Implement VNPay payment status check
        // This is a placeholder - you need to integrate with VNPay API
        return true;
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