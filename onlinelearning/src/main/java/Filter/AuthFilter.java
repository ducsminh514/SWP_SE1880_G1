package Filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Module.User;
public class AuthFilter implements Filter {
    public void init(FilterConfig fConfig) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Lấy tài khoản từ session
        User account = (session != null) ? (User) session.getAttribute("account") : null;
        String uri = req.getRequestURI();

        // Cho phép truy cập các trang không yêu cầu đăng nhập
        if (uri.endsWith("login.jsp") || uri.endsWith("LoginServlet")) {
            chain.doFilter(request, response);
            return;
        }

        // Nếu chưa đăng nhập, chuyển hướng về login.jsp
        if (account == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        // Nếu trang admin nhưng user không phải admin -> chặn truy cập
        if (uri.contains("/admin") && !"admin".equalsIgnoreCase(account.getUserName())) {
            res.sendRedirect("home"); // Chuyển về trang user
            return;
        }

        chain.doFilter(request, response);
    }

    public void destroy() {}
}