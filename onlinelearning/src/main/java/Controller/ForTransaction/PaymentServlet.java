package Controller.ForTransaction;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

import DAO.*;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Module.Course;
import Module.Customer;
import Module.Order;
import Module.PriceCourse;
import Module.User;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment"})
public class PaymentServlet extends HttpServlet {

    private VnPayService vnPayService = new VnPayService();

    long amount_global = 10000;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            processPayment(request, response);
        }
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("in that here--------------------------------------------------");
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "order-type";

        HttpSession session = request.getSession();
        CourseDAO cDAO = new CourseDAO() ;
        PriceCourseDAO pDAO = new PriceCourseDAO();
        UserDAO uDAO = new UserDAO();
        CustomerDAO cusDAO = new CustomerDAO();
        int courseId =(int)session.getAttribute("checkoutCourseId") ;
        int priceId =(int)session.getAttribute("checkoutPricePackageId") ;
        String email =(String)session.getAttribute("checkoutEmail") ;
        User user = uDAO.getUserByEmail(email) ;
        session.removeAttribute("checkoutCourseId");
        session.removeAttribute("checkoutPricePackageId");
        session.removeAttribute("checkoutEmail");

        Course course = cDAO.getById(courseId) ;
        PriceCourse pricePackage = pDAO.getById(priceId) ;
        if (course == null || pricePackage == null) {
            response.sendRedirect("error.jsp?message=Missing+course+information");
            return;
        }

        // Generate order ID
        String orderId = generateOrderId();
        double price = pricePackage.getSalePrice();

        // Create Order object and save to database
        Customer customer = null;
        int userId = 0;

        if (user != null) {
            userId = user.getUserId();
            CustomerDAO customerDAO = new CustomerDAO();
            int customerId = customerDAO.GetIDCustomerByID(userId);
            if (customerId > 0) {
                customer = customerDAO.getCustomerById(customerId);
            }
        }

        // Tạo đối tượng Order với các thông tin cơ bản
        Order order = new Order();
        order.setOrderCode(orderId);
        order.setPricePackage(pricePackage);
        order.setCustomer(customer);
        order.setAmount(price);
        order.setTransactionCode(null); // Sẽ được cập nhật sau khi thanh toán
        order.setOrderDate(new Date());
        order.setStatus("Processing"); // false = PENDING

        // Save order to database
        OrderDAO orderDAO = new OrderDAO();
        int orderDbId = orderDAO.insertOrder(order);


        // Lưu ID của đơn hàng trong DB vào đối tượng Order
        order.setOrderId(orderDbId);
        // Save the order info in session for VNPay query later

        // Convert amount to VND (required by VNPay)
        long amount = (long)(price *100); // Assuming 1 USD = 24,000 VND
        amount_global = (long)(price *100);

        // Ensure minimum amount for testing (VNPay requires minimum 10,000 VND)
        if (amount < 10000) {
            amount = 10000;
        }

        String vnp_TxnRef = Config.getRandomNumber(8);
        String vnp_IpAddr = Config.getIpAddress(request);

        String vnp_TmnCode = Config.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        String bankCode = request.getParameter("bankCode");

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = request.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;



//        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> url = " + urlTest);
//        response.sendRedirect(urlTest);
        // Forward to payment page with QR code

        int amount_tmp = (int)amount_global;
        String urlTest = vnPayService.createOrder(amount_tmp, "Thanh toan don hang", "http://localhost:9090/onlinelearning11/");
//        response.sendRedirect(urlTest);
    }

    private String generateOrderId() {
        // Format: ORDER_YYYYMMDD_HHMMSS_RANDOM
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
        return "ORDER_" + sdf.format(new Date()) + "_" + (int)(Math.random() * 1000);
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int amount_tmp = (int)amount_global;
        String urlTest = vnPayService.createOrder(amount_tmp, "Thanh toan don hang", "http://localhost:9090/onlinelearning11/");
        System.out.println("innnnnnnnnnnnnnnnnn" + urlTest);
        processRequest(request, response);
        response.sendRedirect(urlTest);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Posttttttttttttttttttttttttttttttttttttttttttttttt");
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Payment Servlet for handling course purchases and VNPay integration";
    }
}