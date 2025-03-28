package Controller.ForAccount;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "VerifyServlet2", urlPatterns = {"/verify2"})
public class VerifyServlet2 extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        if (email != null) {
            UserDAO ud = new UserDAO();
            boolean updated = ud.verifyUser(email);
            if (updated) {
                request.setAttribute("notification", "Authentication successful! You can log in.");
            } else {
                request.setAttribute("error", "Authentication failed! Invalid email.");
            }
        }
        request.getRequestDispatcher("verification2.jsp").forward(request, response);
    }
}