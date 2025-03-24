package Controller.ForCourse;

import DAO.CourseDAO;
import DAO.EnrollmentDAO;
import DAO.SubjectDAO;
import DAO.LessonDAO;
import Module.Course;
import Module.Subject;
import Module.Lesson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CourseDetailLearningServlet", urlPatterns = {"/course-learning"})
public class CourseDetailLearningServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get course ID from request
        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null || courseIdStr.isEmpty()) {
            response.sendRedirect("listCourse");
            return;
        }
        
        try {
            int courseId = Integer.parseInt(courseIdStr);
            
            // Get DAOs
            CourseDAO courseDAO = new CourseDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            LessonDAO lessonDAO = new LessonDAO();
            EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
            
            // Get course information
            Course course = courseDAO.getCourseById(courseId);
            if (course == null) {
                response.sendRedirect("listCourse");
                return;
            }
            
            // Get list of subjects for this course
            ArrayList<Subject> listSubject = subjectDAO.findByCourse(courseId);
            
            // Create a map to store lessons for each subject
            Map<Integer, ArrayList<Lesson>> subjectLessonsMap = new HashMap<>();
            int totalLessons = 0;
            int totalDuration = 0;
            
            // Populate the map with lessons for each subject
            for (Subject subject : listSubject) {
                ArrayList<Lesson> lessons = lessonDAO.getBySubject(subject.getSubjectId());
                subjectLessonsMap.put(subject.getSubjectId(), lessons);
                
                // Calculate totals
                totalLessons += lessons.size();
                for (Lesson lesson : lessons) {
                    totalDuration += lesson.getDuration();
                }
            }
            
            // Set attributes for JSP
            request.setAttribute("course", course);
            request.setAttribute("listSubject", listSubject);
            request.setAttribute("subjectLessonsMap", subjectLessonsMap);
            request.setAttribute("subjectCount", listSubject.size());
            request.setAttribute("lessonCount", totalLessons);
            request.setAttribute("totalDuration", totalDuration);
            
            // TODO: Calculate user progress (this would require user session and completion data)
            // For now, we'll use placeholder values
            request.setAttribute("completedLessons", 0);
            request.setAttribute("progressPercentage", 0);
            
            // Forward to the JSP
            request.getRequestDispatcher("CourseDetailUser.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("listCourse");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This method could be used for actions like marking a lesson as complete,
        // submitting quiz answers, etc.
        doGet(request, response);
    }
} 