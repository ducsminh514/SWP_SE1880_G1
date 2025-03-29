package Controller.ForAdmin;

import DAO.CourseDAO;
import DAO.LessonDAO;
import DAO.LessonQuizDAO;
import DAO.SubjectDAO;
import Module.Course;
import Module.Lesson;
import Module.LessonQuiz;
import Module.Subject;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ManageLessonQuizController", urlPatterns = {"/admin-manage-lesson-quiz"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10,  // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ManageLessonQuizController extends HttpServlet {

    private final LessonQuizDAO lessonQuizDAO = new LessonQuizDAO();
    private final LessonDAO lessonDAO = new LessonDAO();
    private final SubjectDAO subjectDAO = new SubjectDAO();
    private final CourseDAO courseDAO = new CourseDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listLessonQuizzes(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "deactivate":
                deactivateLessonQuiz(request, response);
                break;
            case "getSubjects":
                getSubjectsByCourse(request, response);
                break;
            case "getLessons":
                getLessonsBySubject(request, response);
                break;
            case "getLessonInfo":
                getLessonInfo(request, response);
                break;
            case "manage":
                manageQuizQuestions(request, response);
                break;
            default:
                listLessonQuizzes(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addLessonQuiz(request, response);
                break;
            case "edit":
                updateLessonQuiz(request, response);
                break;
            default:
                listLessonQuizzes(request, response);
                break;
        }
    }

    private void listLessonQuizzes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<LessonQuiz> lessonQuizzes = lessonQuizDAO.findAll();

            // Create a map to hold subject info for each lesson
            Map<Integer, Subject> subjectMap = new HashMap<>();

            // For each quiz, retrieve the subject info and store it in the map
            for (LessonQuiz quiz : lessonQuizzes) {
                Lesson lesson = quiz.getLesson();
                if (lesson != null) {
                    // Get subject info if not already in the map
                    if (!subjectMap.containsKey(lesson.getSubjectId())) {
                        Subject subject = subjectDAO.getSubjectById(lesson.getSubjectId());
                        if (subject != null) {
                            subjectMap.put(lesson.getSubjectId(), subject);
                        }
                    }
                }
            }

            // Add the subject map as an attribute for the JSP to use
            request.setAttribute("subjectMap", subjectMap);
            request.setAttribute("lessonQuizzes", lessonQuizzes);
            request.getRequestDispatcher("/admin/manage-lesson-quiz.jsp").forward(request, response);
        } catch (Exception e) {
            setToastMessage(request, "Error: " + e.getMessage(), "error");
            response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Course> courses = courseDAO.getAll();
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/admin/add-lesson-quiz.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int quizId = Integer.parseInt(request.getParameter("id"));
        LessonQuiz quiz = lessonQuizDAO.findById(quizId);

        if (quiz != null) {
            // Get the current lesson's subject and course
            Lesson lesson = quiz.getLesson();
            if (lesson != null) {
                Subject subject = subjectDAO.getSubjectById(lesson.getSubjectId());
                if (subject != null) {
                    // We have the subject, now get all courses for the dropdown
                    List<Course> courses = courseDAO.getAll();
                    request.setAttribute("courses", courses);
                }
            }

            request.setAttribute("quiz", quiz);
            request.getRequestDispatcher("/admin/edit-lesson-quiz.jsp").forward(request, response);
        } else {
            setToastMessage(request, "Quiz not found", "error");
            response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz");
        }
    }

    private void addLessonQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form data for the lesson
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            String lessonName = request.getParameter("lessonName");
            int duration = Integer.parseInt(request.getParameter("duration"));

            // Get form data for the quiz
            int passPercentage = Integer.parseInt(request.getParameter("passPercentage"));
            int timeLimit = Integer.parseInt(request.getParameter("timeLimit"));
            int attemptAllowed = Integer.parseInt(request.getParameter("attemptAllowed"));
            boolean status = request.getParameter("status") != null;

            // First, create a new lesson of type QUIZ
            Lesson newLesson = new Lesson();
            newLesson.setSubjectId(subjectId);
            newLesson.setLessonName(lessonName);
            newLesson.setContent(""); // Empty content since it's a quiz
            newLesson.setDuration(duration);

            // Get max order number for this subject and add 1
            List<Lesson> subjectLessons = lessonDAO.getBySubject(subjectId);
            int maxOrderNo = 0;
            for (Lesson lesson : subjectLessons) {
                if (lesson.getOrderNo() > maxOrderNo) {
                    maxOrderNo = lesson.getOrderNo();
                }
            }
            newLesson.setOrderNo(maxOrderNo + 1);

            newLesson.setStatusLesson(true); // Set status to active
            newLesson.setType("QUIZ"); // Set type to QUIZ

            // Set dates
            Date currentDate = new Date();
            newLesson.setCreatedDate(currentDate);
            newLesson.setUpdateDate(currentDate);

            // Insert lesson into database
            int lessonId = lessonDAO.insert(newLesson);

            if (lessonId <= 0) {
                setToastMessage(request, "Failed to create lesson", "error");
                response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz?action=add");
                return;
            }

            // Create a new LessonQuiz object
            LessonQuiz quiz = new LessonQuiz();
            Lesson lesson = lessonDAO.findById(lessonId);
            quiz.setLesson(lesson);
            quiz.setPassPercentage(passPercentage);
            quiz.setTimeLimit(timeLimit);
            quiz.setAttemptAllowed(attemptAllowed);
            quiz.setStatus(status);

            // Process image file if provided
            Part imagePart = request.getPart("imageFile");
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/uploads/quiz-images/");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + fileName;
                imagePart.write(filePath);

                // Set image URL in quiz object
                quiz.setImageUrl("/uploads/quiz-images/" + fileName);
            }

            // Process MP3 file if provided
            Part mp3Part = request.getPart("mp3File");
            if (mp3Part != null && mp3Part.getSize() > 0) {
                String fileName = Paths.get(mp3Part.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/uploads/quiz-mp3/");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + fileName;
                mp3Part.write(filePath);

                // Set MP3 URL in quiz object
                quiz.setMp3Url("/uploads/quiz-mp3/" + fileName);
            }

            // Insert quiz into database
            int result = lessonQuizDAO.insert(quiz);

            if (result > 0) {
                setToastMessage(request, "Quiz added successfully", "success");
            } else {
                // If quiz insertion failed, try to delete the lesson we just created
                lessonDAO.delete(lesson);
                setToastMessage(request, "Failed to add quiz", "error");
            }
        } catch (Exception e) {
            setToastMessage(request, "Error: " + e.getMessage(), "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz");
    }

    private void updateLessonQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get quiz ID from form
            int quizId = Integer.parseInt(request.getParameter("quizId"));

            // Get existing quiz from database
            LessonQuiz existingQuiz = lessonQuizDAO.findById(quizId);

            if (existingQuiz == null) {
                setToastMessage(request, "Quiz not found", "error");
                response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz");
                return;
            }

            // Get form data for updating the lesson
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            String lessonName = request.getParameter("lessonName");
            int duration = Integer.parseInt(request.getParameter("duration"));
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));

            // Get the existing lesson
            Lesson lesson = lessonDAO.findById(lessonId);
            if (lesson == null) {
                setToastMessage(request, "Lesson not found", "error");
                response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz?action=edit&id=" + quizId);
                return;
            }

            // Update the lesson details
            lesson.setLessonName(lessonName);
            lesson.setDuration(duration);
            lesson.setSubjectId(subjectId);
            lesson.setUpdateDate(new Date());

            // Update the lesson in the database
            boolean lessonUpdated = lessonDAO.update(lesson);
            if (!lessonUpdated) {
                setToastMessage(request, "Failed to update lesson", "error");
                response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz?action=edit&id=" + quizId);
                return;
            }

            // Get form data for the quiz
            int passPercentage = Integer.parseInt(request.getParameter("passPercentage"));
            int timeLimit = Integer.parseInt(request.getParameter("timeLimit"));
            int attemptAllowed = Integer.parseInt(request.getParameter("attemptAllowed"));
            boolean status = request.getParameter("status") != null;

            // Update quiz object
            existingQuiz.setPassPercentage(passPercentage);
            existingQuiz.setTimeLimit(timeLimit);
            existingQuiz.setAttemptAllowed(attemptAllowed);
            existingQuiz.setStatus(status);

            // Process image file if provided
            Part imagePart = request.getPart("imageFile");
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/uploads/quiz-images/");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + fileName;
                imagePart.write(filePath);

                // Set new image URL in quiz object
                existingQuiz.setImageUrl("/uploads/quiz-images/" + fileName);
            }

            // Process MP3 file if provided
            Part mp3Part = request.getPart("mp3File");
            if (mp3Part != null && mp3Part.getSize() > 0) {
                String fileName = Paths.get(mp3Part.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/uploads/quiz-mp3/");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + fileName;
                mp3Part.write(filePath);

                // Set new MP3 URL in quiz object
                existingQuiz.setMp3Url("/uploads/quiz-mp3/" + fileName);
            }

            // Update quiz in database
            boolean result = lessonQuizDAO.update(existingQuiz);

            if (result) {
                setToastMessage(request, "Quiz updated successfully", "success");
            } else {
                setToastMessage(request, "Failed to update quiz", "error");
            }
        } catch (Exception e) {
            setToastMessage(request, "Error: " + e.getMessage(), "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz");
    }

    private void deactivateLessonQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int quizId = Integer.parseInt(request.getParameter("id"));
            LessonQuiz quiz = lessonQuizDAO.findById(quizId);

            if (quiz != null) {
                // Set quiz status to inactive
                quiz.setStatus(false);

                // Update quiz in database
                boolean result = lessonQuizDAO.update(quiz);

                if (result) {
                    setToastMessage(request, "Quiz deactivated successfully", "success");
                } else {
                    setToastMessage(request, "Failed to deactivate quiz", "error");
                }
            } else {
                setToastMessage(request, "Quiz not found", "error");
            }
        } catch (Exception e) {
            setToastMessage(request, "Error: " + e.getMessage(), "error");
        }

        response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz");
    }

    /**
     * Retrieves subjects for a specific course and returns them as JSON
     */
    private void getSubjectsByCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            ArrayList<Subject> subjects = subjectDAO.findByCourse(courseId);

            // Write JSON response
            out.print(gson.toJson(subjects));

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Invalid course ID format");
            out.print(gson.toJson(error));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            out.print(gson.toJson(error));
        } finally {
            out.flush();
        }
    }

    /**
     * Retrieves lessons for a specific subject and returns them as JSON
     */
    private void getLessonsBySubject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            ArrayList<Lesson> lessons = lessonDAO.getBySubject(subjectId);

            // Write JSON response
            out.print(gson.toJson(lessons));

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Invalid subject ID format");
            out.print(gson.toJson(error));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            out.print(gson.toJson(error));
        } finally {
            out.flush();
        }
    }

    /**
     * Retrieves information about a lesson, including its subject and course
     */
    private void getLessonInfo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            Lesson lesson = lessonDAO.findById(lessonId);

            if (lesson != null) {
                // Get the subject for this lesson
                Subject subject = subjectDAO.getSubjectById(lesson.getSubjectId());

                // Create a response using HashMap
                Map<String, Object> result = new HashMap<>();
                result.put("lessonId", lesson.getLessonId());
                result.put("lessonName", lesson.getLessonName());
                result.put("subjectId", lesson.getSubjectId());

                // Include course ID if subject exists
                if (subject != null) {
                    result.put("courseId", subject.getCourse().getCourseId());
                }

                // Convert to JSON using gson
                Gson gson = new Gson();
                out.print(gson.toJson(result));
            } else {
                out.print("{}"); // Empty JSON object if lesson not found
            }
        } catch (Exception e) {
            out.print("{}"); // Empty JSON object if an error occurs
        }
    }

    /**
     * Redirects to the question management page for a specific quiz
     */
    private void manageQuizQuestions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int quizId = Integer.parseInt(request.getParameter("id"));
            LessonQuiz quiz = lessonQuizDAO.findById(quizId);

            if (quiz != null) {
                // Set the quiz in the request and forward to the question management page
                request.setAttribute("quiz", quiz);

                // Get the subject and course info
                Lesson lesson = quiz.getLesson();
                if (lesson != null) {
                    Subject subject = subjectDAO.getSubjectById(lesson.getSubjectId());
                    if (subject != null) {
                        request.setAttribute("subject", subject);
                    }
                }

                // Forward to the manage questions page
                request.getRequestDispatcher("/admin/manage-quiz-questions.jsp").forward(request, response);
            } else {
                setToastMessage(request, "Quiz not found", "error");
                response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz");
            }
        } catch (Exception e) {
            setToastMessage(request, "Error: " + e.getMessage(), "error");
            response.sendRedirect(request.getContextPath() + "/admin-manage-lesson-quiz");
        }
    }

    private void setToastMessage(HttpServletRequest request, String message, String type) {
        request.getSession().setAttribute("toastMessage", message);
        request.getSession().setAttribute("toastType", type);
    }
}
