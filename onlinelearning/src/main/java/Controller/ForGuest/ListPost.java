package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import DAO.PostDAO;
import Module.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "listPost", urlPatterns = {"/listPost"})
public class ListPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet listPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet listPost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PostDAO pDAO = new PostDAO();
        ArrayList<Post> listPost = new ArrayList<>();
        String pagePost = request.getParameter("page");
        if (pagePost == null) {
            listPost = pDAO.getAllByPage(1);
        } else {
            int pageNumPost = 0;
            try {
                pageNumPost = Integer.parseInt(pagePost);
                listPost = pDAO.getAllByPage(5 * pageNumPost - 5);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }
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
