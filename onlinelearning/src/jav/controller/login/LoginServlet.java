package jav.controller.login;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jav.dal.DAO;
import jav.model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet  extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet </title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet  at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String u=request.getParameter("user");
        String p=request.getParameter("password");
        DAO d = new DAO();
        User a =d.checkAuthen(u, p);
        if (a==null) {
            request.setAttribute("error", "Username/Email  or Password incorrect!!!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }else if (u.equalsIgnoreCase("admin")) {
            HttpSession session = request.getSession();
            session.setAttribute("account", a);
            response.sendRedirect("admin");
        }

        else {
            HttpSession session = request.getSession();
            session.setAttribute("account", a);
            response.sendRedirect("home");

        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}


