package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import DAO.CourseDAO;
import DAO.PostDAO;
import DAO.ReviewCourseDAO;
import DAO.ReviewPostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.Course ;
import Module.Post ;
@WebServlet(name="home", urlPatterns={"/home"})
public class Home extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet home</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet home at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        CourseDAO cDAO = new CourseDAO();
        ReviewCourseDAO rcDAO = new ReviewCourseDAO();
        ArrayList<Course> listCourse= cDAO.getAll();
        LinkedHashMap<Course,Float> mapRatingCourse = new LinkedHashMap<>();
        for(Course c : listCourse){
            mapRatingCourse.put(c , rcDAO.getRatingOfCourse(c.getCourseId())) ;
        }
        request.setAttribute("mapRatingCourse",mapRatingCourse);
        PostDAO pDAO  = new PostDAO();
        ReviewPostDAO rpDAO = new ReviewPostDAO();
        ArrayList<Post> listPostArrange = pDAO.ArrangeByDate() ;
        ArrayList<Post> listHotPost = pDAO.getAll();
        Collections.sort(listHotPost, new Comparator<Post>() {
            @Override
            public int compare(Post p1, Post p2) {
                return Float.compare(rpDAO.getRatingOfPost(p2.getPostId()), rpDAO.getRatingOfPost(p1.getPostId()));
            }
        });

        LinkedHashMap<Post,Float> mapRatingPost = new LinkedHashMap<>() ;
        for(Post p : listHotPost) {
            mapRatingPost.put(p, rpDAO.getRatingOfPost(p.getPostId()));
        }
        request.setAttribute("listPost",listPostArrange);
        request.setAttribute("mapRatingPost",mapRatingPost);
        ArrayList<Post> listRecentPost = pDAO.ArrangeByDate();
        request.setAttribute("recentPost",listRecentPost);
        request.getRequestDispatcher("index.jsp").forward(request,response);
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
