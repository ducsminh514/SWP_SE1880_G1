package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;

import DAO.CommentCourseDAO;
import DAO.CommentPostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Module.User ;
@WebServlet(name="AddCommentCourse", urlPatterns={"/addCommentCourse"})
public class AddCommentCourse extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCommentPsot</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCommentPsot at " + request.getContextPath () + "</h1>");
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
        String courseID= (String)session.getAttribute("courseId");
        int parentId=0 , courseId=0 ;
        try{
            parentId= Integer.parseInt(parentID) ;
            courseId = Integer.parseInt(courseID) ;
        }catch(NumberFormatException e){
            System.out.println(e);
        }
        String content = (String)session.getAttribute("content") ;
        session.removeAttribute("parentId");
        session.removeAttribute("courseId");
        session.removeAttribute("content");
        CommentCourseDAO ccDAO = new CommentCourseDAO();
        ccDAO.insert(parentId,courseId,userId,content);
        request.getRequestDispatcher("/courseDetail?courseId="+courseId).forward(request,response);
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