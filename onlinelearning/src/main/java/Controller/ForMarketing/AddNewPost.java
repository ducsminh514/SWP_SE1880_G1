package Controller.ForMarketing;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import DAO.CategoryBlogDAO;
import Module.CategoryBlog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.CategoryBlog ;
@WebServlet(name="AddNewPost", urlPatterns={"/addNewPost"})
public class AddNewPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddNewPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewPost at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        CategoryBlogDAO cbDAO = new CategoryBlogDAO();
        ArrayList<CategoryBlog> listCate = cbDAO.getAll();
        request.setAttribute("categories",listCate);
        request.getRequestDispatcher("Marketing/AddNewPostFile.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

