package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import DAO.*;
import DTO.CourseDetailDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.Course ;
import Module.PriceCourse ;
import Module.CourseType ;
import Module.CommentCourse ;
import Module.Lesson ;
import Module.Subject ;
@WebServlet(name="CourseDetail", urlPatterns={"/courseDetail"})
public class CourseDetail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CourseDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CourseDetail at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String courseID = request.getParameter("courseId") ;
        int courseId =0 ;
        EnrollmentDAO emDAO = new EnrollmentDAO();
        ReviewCourseDAO rvDAO = new ReviewCourseDAO() ;
        PriceCourseDAO pcDAO = new PriceCourseDAO() ;
        try{
            courseId = Integer.parseInt(courseID) ;
        }catch(NumberFormatException e){
            System.out.println(e) ;
        }
        CourseDAO cDAO = new CourseDAO() ;
        Course co = cDAO.getById(courseId) ;
        PriceCourse price = pcDAO.getById(pcDAO.lowestSalePrice(co.getCourseId())) ;
        CourseDetailDTO course = new CourseDetailDTO(co,rvDAO.getRatingOfCourse(courseId),price.getSalePrice(),emDAO.totalEnrollment(courseId),price.getPrice()) ;
        request.setAttribute("course",course);
        ArrayList<Course> listRecentCourse = cDAO.getCourse(null,0,"date-late",0,3) ;
        ArrayList<CourseDetailDTO> listRecent = new ArrayList<>() ;
        for(Course c: listRecentCourse){
            PriceCourse p = pcDAO.getById(pcDAO.lowestSalePrice(c.getCourseId())) ;
            CourseDetailDTO cd = new CourseDetailDTO();
            cd.setCourse(c);
            cd.setOriginalPrice(p.getPrice());
            cd.setRating(rvDAO.getRatingOfCourse(c.getCourseId()));
            cd.setTotalEnrollment(emDAO.totalEnrollment(c.getCourseId()));
            cd.setLowestSalePrice(p.getSalePrice());
            listRecent.add(cd) ;
        }
        request.setAttribute("listRecent" , listRecent);
        CourseTypeDAO ctDAO = new CourseTypeDAO() ;
        ArrayList<CourseType> listCourseType = ctDAO.getAll();
        request.setAttribute("listCourseType",listCourseType);
        CommentCourseDAO commentCourseDAO = new CommentCourseDAO() ;
        ArrayList<CommentCourse> listComment = commentCourseDAO.getCommentsByCourseID(courseId) ;
        request.setAttribute("listComment",listComment);
        SubjectDAO sDAO = new SubjectDAO() ;
        ArrayList<Subject> listSubject = sDAO.findByCourse(courseId) ;
        request.setAttribute("listSubject" ,listSubject);
        int countSubject = listSubject.size();
        request.setAttribute("cntSubject",countSubject);
        LessonDAO  lDAO = new LessonDAO() ;
        Map<Integer, ArrayList<Lesson>> subjectLessonsMap = new HashMap<>();
        for(Subject s: listSubject) {
            ArrayList<Lesson> listLesson = lDAO.getBySubject(s.getSubjectId());
            subjectLessonsMap.put(s.getSubjectId(), listLesson);
        }
        request.setAttribute("subjectLessonsMap", subjectLessonsMap);
        ArrayList<PriceCourse> pricePackage = pcDAO.getByCourse(courseId) ;
        request.setAttribute("pricePackage",pricePackage);
        request.getRequestDispatcher("CourseDetail.jsp").forward(request,response);
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