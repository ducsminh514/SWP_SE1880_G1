package Controller.ForCourse;

import DAO.CourseDAO;
import DAO.EnrollmentDAO;
import DAO.SubjectDAO;
import DAO.LessonDAO;
import DAO.QuizAttendDAO;
import DAO.LessonQuizDAO;
import Module.Course;
import Module.Subject;
import Module.Lesson;
import Module.LessonQuiz;
import Module.QuizAttend;
import Module.Enrollment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import Module.User;

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
            QuizAttendDAO quizAttendDAO = new QuizAttendDAO();
            LessonQuizDAO lessonQuizDAO = new LessonQuizDAO();

            // Get course information
            Course course = courseDAO.getCourseById(courseId);
            if (course == null) {
                response.sendRedirect("listCourse");
                return;
            }

            // Get list of subjects for this course
            ArrayList<Subject> listSubject = subjectDAO.findByCourse(courseId);

            // Get user ID from session for completion tracking
            HttpSession session = request.getSession();
            int userId = -1;
            try {
                // Get user object from session
                Object userObj = session.getAttribute("account");
                if (userObj != null && userObj instanceof User) {
                    User user = (User) userObj;
                    userId = user.getUserId();
                }
                // If we can't get userId from user object, keep default userId as -1
            } catch (Exception e) {
                System.out.println("Error getting userId from user object: " + e.getMessage());
                // Continue with default userId -1
            }

            // Get completed lessons from quiz attempts
            Set<Integer> completedLessonIds = new HashSet<>();
            if (userId > 0) {
                // For each lesson in the course, check if there are passed quizzes
                for (Subject subject : listSubject) {
                    ArrayList<Lesson> lessons = lessonDAO.getBySubject(subject.getSubjectId());
                    for (Lesson lesson : lessons) {
                        if ("quiz".equalsIgnoreCase(lesson.getType())) {
                            LessonQuiz quiz = lessonQuizDAO.getByLessonId(lesson.getLessonId());
                            if (quiz != null) {
                                List<QuizAttend> attempts = quizAttendDAO.getPassedQuizzesByUser(userId, quiz.getLessonQuizID());
                                if (attempts != null && !attempts.isEmpty()) {
                                    completedLessonIds.add(lesson.getLessonId());
                                }
                            }
                        }
                    }
                }
            }

            // Create a map to store lessons for each subject
            Map<Integer, ArrayList<Lesson>> subjectLessonsMap = new HashMap<>();
            int totalLessons = 0;
            int totalDuration = 0;

            // Populate the map with lessons for each subject
            for (Subject subject : listSubject) {
                ArrayList<Lesson> lessons = lessonDAO.getBySubject(subject.getSubjectId());

                // Mark completed lessons
                for (Lesson lesson : lessons) {
                    if (completedLessonIds.contains(lesson.getLessonId())) {
                        lesson.setCompleted(true);
                    }
                }
                subjectLessonsMap.put(subject.getSubjectId(), lessons);

                // Calculate totals
                totalLessons += lessons.size();
                for (Lesson lesson : lessons) {
                    totalDuration += lesson.getDuration();
                }
            }

            // Calculate progress percentage from Enrollments
            double progressPercentage = 0;
            if (userId > 0) {
                // Check if there's an enrollment for this course
                List<Integer> userCourses = enrollmentDAO.getAllCourseIDsByCustomerID(userId);
                if (userCourses.contains(courseId)) {
                    // Get the enrollment to check its progress percentage
                    List<Enrollment> enrollments = enrollmentDAO.getAllEnrollmentsByCustomerID(userId);
                    for (Enrollment enrollment : enrollments) {
                        if (enrollment.getCourse().getCourseId() == courseId) {
                            String progressStr = enrollment.getProcessPercentage();
                            if (progressStr != null && !progressStr.isEmpty()) {
                                try {
                                    progressPercentage = Double.parseDouble(progressStr);
                                } catch (NumberFormatException e) {
                                    System.out.println("Error parsing progress percentage: " + e.getMessage());
                                }
                            }
                            break;
                        }
                    }
                }
            }

            // Set attributes for JSP
            request.setAttribute("course", course);
            request.setAttribute("listSubject", listSubject);
            request.setAttribute("subjectLessonsMap", subjectLessonsMap);
            request.setAttribute("subjectCount", listSubject.size());
            request.setAttribute("lessonCount", totalLessons);
            request.setAttribute("totalDuration", totalDuration);
            request.setAttribute("completedLessons", completedLessonIds.size());
            request.setAttribute("progressPercentage", progressPercentage);

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
