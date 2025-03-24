package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;

import DAO.CategoryBlogDAO;
import DAO.CommentPostDAO;
import DAO.PostDAO;
import DAO.ReviewPostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.Post;
import Module.CategoryBlog ;
import Module.CommentPost ;
@WebServlet(name = "BlogDetail", urlPatterns = {"/blogDetail"})
public class BlogDetail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BlogDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogDetail at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postID = request.getParameter("postId");
        PostDAO pDAO = new PostDAO();
        CategoryBlogDAO cDAO = new CategoryBlogDAO() ;
        ReviewPostDAO rpDAO = new ReviewPostDAO();
        int postId = 0;
        if (postID != null && !postID.isEmpty()) {
            try {
                postId = Integer.parseInt(postID);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }
        Post post = pDAO.getById(postId) ;
        request.setAttribute("post",post);
        ArrayList<Post> listRecentPost = pDAO.getAllByPage(0,null,0,"date-late",3) ;
        LinkedHashMap<Post,Float> mapRating = new LinkedHashMap<>();
        for (Post p : listRecentPost) {
            mapRating.put(p,rpDAO.getRatingOfPost(p.getPostId())) ;
        }
        request.setAttribute("listRecentPost", mapRating);
        ArrayList<CategoryBlog>  listCategory = cDAO.getAll() ;
        request.setAttribute("listCategory",listCategory);
        CommentPostDAO cpDAO = new CommentPostDAO() ;
        ArrayList<CommentPost> listComment = cpDAO.getCommentsByPostID(postId) ;
        request.setAttribute("listComment", listComment);
        int countAll = cpDAO.countAll() ;
        request.setAttribute("cntAll",countAll);
        request.getRequestDispatcher("Blog-Detail.jsp").forward(request,response);
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
