package Controller.ForTransaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Module.User;

import java.io.IOException;

@WebServlet(name = "PaymentProcessServlet", urlPatterns = {"/payment-process"})
public class PaymentProcessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thông tin khóa học và gói giá từ URL
        String courseIdParam = request.getParameter("courseId");
        String pricePackageIdParam = request.getParameter("pricePackageId");
        System.out.println("course1: " +courseIdParam);
        System.out.println("price1: "+pricePackageIdParam);
        // Kiểm tra tham số đầu vào
        if (courseIdParam == null || pricePackageIdParam == null) {
            response.sendRedirect("home");
            return;
        }
        
        // Lấy phiên hiện tại để kiểm tra đăng nhập
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        
        // Nếu người dùng đã đăng nhập, chuyển hướng đến trang thanh toán thông thường
        if (user != null) {
            response.sendRedirect("payment?courseId=" + courseIdParam + "&pricePackageId=" + pricePackageIdParam);
        } else {
            // Nếu người dùng chưa đăng nhập, chuyển hướng đến trang Express Checkout
            response.sendRedirect("express-checkout?courseId=" + courseIdParam + "&pricePackageId=" + pricePackageIdParam);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 