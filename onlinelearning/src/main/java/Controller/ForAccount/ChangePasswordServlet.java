package Controller.ForAccount;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Module.User;
import DAO.UserDAO;
@WebServlet(name = " ChangePasswordServlet", urlPatterns = {"/change"})
public class ChangePasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangePasswordServelet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordServelet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String passWord = request.getParameter("pass");
        String pass = request.getParameter("npass");
        String re_pass = request.getParameter("cfpass");
        String passwordPattern = "^(?=.*[A-Z])(?=.*[\\W_]).{6,}$";
        boolean isValidPassword = Pattern.matches(passwordPattern, passWord);
                if (!isValidPassword) {
            request.setAttribute("error", "Password must contain at least 1 uppercase letter and 1 special character.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        UserDAO ud= new UserDAO();
        HttpSession session = request.getSession();
        if (!(re_pass.equals(pass))) {
            session.setAttribute("error", "Your pass is not match");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
        if (session == null) {
            response.sendRedirect("login");
        } else {
            User user = (User) session.getAttribute("account");
            //response.getWriter().println("UserID:"+user.getUserId());
            if (passWord.equals(user.getPassword())) {
                ud.changePassword(pass, user.getUserId());
                session.setAttribute("message", "Change complete");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } else {
                session.setAttribute("error", "Your old pass not correct!");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            }

        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

