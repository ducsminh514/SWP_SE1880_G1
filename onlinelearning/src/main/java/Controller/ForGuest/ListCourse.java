package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;

import DAO.ReviewCourseDAO;
import Module.ReviewCourse ;
import DAO.CourseDAO;
import Module.Course ;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="ListCourse", urlPatterns={"/listCourse"})
public class ListCourse extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListCourse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListCourse at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        CourseDAO cDAO = new CourseDAO();
        ArrayList<Course> listCourse= new ArrayList<>() ;
        String numCourse = request.getParameter("numCourse");
        String pageCourse = request.getParameter("page");
        if (numCourse == null) {
            if (pageCourse == null) {
                listCourse = cDAO.getAllByPage(1, 5);
            } else {
                int pageNumCourse = 0;
                try {
                    pageNumCourse = Integer.parseInt(pageCourse);
                    listCourse = cDAO.getAllByPage(5 * pageNumCourse - 5, 5);
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
            }
        } else {
            try{
                int numC = Integer.parseInt(numCourse);
                if (pageCourse == null) {
                    listCourse = cDAO.getAllByPage(1, numC);
                } else {
                    int pageNumCourse = 0;
                    try {
                        pageNumCourse = Integer.parseInt(pageCourse);
                        listCourse = cDAO.getAllByPage(numC * pageNumCourse - numC, numC);
                    } catch (NumberFormatException e) {
                        System.out.println(e);
                    }
                }
            }catch(NumberFormatException e) {
                System.out.println(e);
            }
        }
        ReviewCourseDAO rcDAO = new ReviewCourseDAO();
        LinkedHashMap<Course,Float> mapRatingCourse = new LinkedHashMap<>();
        for(Course c: listCourse){
            mapRatingCourse.put(c, rcDAO.getRatingOfCourse(c.getCourseId())) ;
        }

        request.setAttribute("mapRatingCourse",mapRatingCourse);
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
