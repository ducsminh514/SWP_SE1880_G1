package Controller.ForMarketing;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.UUID;

import DAO.CategoryBlogDAO;
import DAO.PostContentDAO;
import DAO.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.Post;
import Module.PostContent;
import Module.CategoryBlog;
import jakarta.servlet.http.Part;

@WebServlet(name = "PostDetail", urlPatterns = {"/postDetail"})

public class PostDetail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostDetail at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postID = request.getParameter("postId");
        int postId = 0;
        try {
            postId = Integer.parseInt(postID);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
        PostDAO pDAO = new PostDAO();
        Post p = pDAO.getById(postId);
        request.setAttribute("post", p);
        PostContentDAO pcDAO = new PostContentDAO();
        ArrayList<PostContent> listPostContent = pcDAO.getByPostId(p.getPostId());
//        System.out.println(listPostContent.size());
//        for(PostContent pc : listPostContent){
//            System.out.println(pc.getContent());
//        }
        request.setAttribute("listPostContent", listPostContent);
        CategoryBlogDAO cbDAO = new CategoryBlogDAO();
        ArrayList<CategoryBlog> listCate = cbDAO.getAll();
        request.setAttribute("categories", listCate);
        request.getRequestDispatcher("Marketing/Post-Detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postID = request.getParameter("postId");
        int postId = 0;
        try {
            postId = Integer.parseInt(postID);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
        PostDAO pDAO = new PostDAO();
        Post p = pDAO.getById(postId);
        request.setAttribute("post", p);
        PostContentDAO pcDAO = new PostContentDAO();
        ArrayList<PostContent> listPostContent = pcDAO.getByPostId(p.getPostId());
//        System.out.println(listPostContent.size());
//        for(PostContent pc : listPostContent){
//            System.out.println(pc.getContent());
//        }
        request.setAttribute("listPostContent", listPostContent);
        CategoryBlogDAO cbDAO = new CategoryBlogDAO();
        ArrayList<CategoryBlog> listCate = cbDAO.getAll();
        request.setAttribute("categories", listCate);
        request.getRequestDispatcher("Marketing/Post-Detail.jsp").forward(request, response);    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
