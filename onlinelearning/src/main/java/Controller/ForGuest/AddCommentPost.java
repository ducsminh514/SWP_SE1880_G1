package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;

import DAO.CommentPostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Module.User ;
@WebServlet(name="AddCommentPost", urlPatterns={"/addCommentPost"})
public class AddCommentPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCommentPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCommentPost at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account") ;
        int userId = user.getUserId() ;
        String parentID = (String)session.getAttribute("parentId");
        System.out.println(parentID);
        String postID= (String)session.getAttribute("postId");
        System.out.println(postID);
         int parentId=0 , postId=0 ;
         try{
             parentId= Integer.parseInt(parentID) ;
             postId = Integer.parseInt(postID) ;
         }catch(NumberFormatException e){
             System.out.println(e);
         }
         String content = (String)session.getAttribute("content") ;
         session.removeAttribute("parentId");
         session.removeAttribute("postId");
         session.removeAttribute("content");
         CommentPostDAO cpDAO = new CommentPostDAO();
         cpDAO.insert(parentId,postId,userId,content);
         request.getRequestDispatcher("/blogDetail?postId="+postId).forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account") ;
        int userId = user.getUserId() ;
        String parentID = (String)session.getAttribute("parentId");
        System.out.println(parentID);
        String postID= (String)session.getAttribute("postId");
        System.out.println(postID);
        int parentId=0 , postId=0 ;
        try{
            parentId= Integer.parseInt(parentID) ;
            postId = Integer.parseInt(postID) ;
        }catch(NumberFormatException e){
            System.out.println(e);
        }
        String content = (String)session.getAttribute("content") ;
        session.removeAttribute("parentId");
        session.removeAttribute("postId");
        session.removeAttribute("content");
        CommentPostDAO cpDAO = new CommentPostDAO();
        cpDAO.insert(parentId,postId,userId,content);
        request.getRequestDispatcher("/blogDetail?postId="+postId).forward(request,response);    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}