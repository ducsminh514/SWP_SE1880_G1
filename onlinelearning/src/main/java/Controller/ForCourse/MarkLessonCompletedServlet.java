package Controller.ForCourse;

import DAO.LessonCompletionDAO;
import Module.LessonCompletion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import Module.User;
/**
 * Servlet to handle marking lessons as completed by users
 */
@WebServlet(name = "MarkLessonCompletedServlet", urlPatterns = {"/mark-lesson-completed"})
public class MarkLessonCompletedServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set response type
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Get lesson ID from request
        String lessonIdStr = request.getParameter("lessonId");

        // Get user session
        HttpSession session = request.getSession();
        Object accountObj = session.getAttribute("account");

        // Check if user is logged in
        if (accountObj == null) {
            out.print("{\"success\": false, \"message\": \"You must be logged in to track progress\"}");
            return;
        }

        // Get user ID from session
        int userId = -1;
        try {
            // Lấy userId từ đối tượng account
            if (accountObj instanceof User) {
                User user = (User) accountObj;
                userId = user.getUserId();
            } else {
                out.print("{\"success\": false, \"message\": \"Invalid user information in session\"}");
                return;
            }
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Error getting user information: " + e.getMessage() + "\"}");
            return;
        }

        if (lessonIdStr == null || lessonIdStr.isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Lesson ID is required\"}");
            return;
        }

        try {
            int lessonId = Integer.parseInt(lessonIdStr);

            // Create DAO for lesson completion
            LessonCompletionDAO completionDAO = new LessonCompletionDAO();

            // Check if lesson is already marked as completed
            if (completionDAO.isLessonCompleted(lessonId, userId)) {
                out.print("{\"success\": true, \"message\": \"Lesson already marked as completed\"}");
                return;
            }

            // Create completion record
            LessonCompletion completion = new LessonCompletion();
            completion.setLessonId(lessonId);
            completion.setUserId(userId);
            completion.setCompletionDate(new Date());

            // Save completion
            boolean result = completionDAO.insert(completion);

            if (result) {
                out.print("{\"success\": true, \"message\": \"Lesson marked as completed\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to mark lesson as completed\"}");
            }

        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Invalid lesson ID\"}");
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET requests are not supported, redirect to POST
        response.sendRedirect("course-learning");
    }
}