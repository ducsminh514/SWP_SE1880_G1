package Controller.ForCourse;

import DAO.LessonDAO;
import DAO.LessonTextDAO;
import DAO.LessonVideoDAO;
import DAO.LessonFileDAO;
import DAO.LessonQuizDAO;
import Module.Lesson;
import Module.LessonText;
import Module.LessonVideo;
import Module.LessonFile;
import Module.LessonQuiz;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "LessonContentServlet", urlPatterns = {"/lesson-content"})
public class LessonContentServlet extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       // Set response content type
       response.setContentType("application/json");
       response.setCharacterEncoding("UTF-8");

       // Get lesson ID from request
       String lessonIdStr = request.getParameter("lessonId");
       PrintWriter out = response.getWriter();

       if (lessonIdStr == null || lessonIdStr.isEmpty()) {
           JsonObject errorJson = new JsonObject();
           errorJson.addProperty("error", "Lesson ID is required");
           out.print(errorJson.toString());
           return;
       }

       try {
           int lessonId = Integer.parseInt(lessonIdStr);

           // Get lesson details
           LessonDAO lessonDAO = new LessonDAO();
           Lesson lesson = lessonDAO.findById(lessonId);

           if (lesson == null) {
               JsonObject errorJson = new JsonObject();
               errorJson.addProperty("error", "Lesson not found");
               out.print(errorJson.toString());
               return;
           }

           // Create JSON response
           JsonObject jsonResponse = new JsonObject();
           jsonResponse.addProperty("lessonId", lesson.getLessonId());
           jsonResponse.addProperty("lessonName", lesson.getLessonName());
           jsonResponse.addProperty("lessonType", lesson.getType());
           jsonResponse.addProperty("duration", lesson.getDuration());

           // Based on lesson type, fetch specific content
           String lessonType = lesson.getType();
           if (lessonType != null) {
               switch (lessonType.toLowerCase()) {
                   case "text":
                       // Get text content
                       LessonTextDAO textDAO = new LessonTextDAO();
                       LessonText text = textDAO.getLessonTextByLessonId(lessonId);
                       if (text != null) {
                           jsonResponse.addProperty("content", text.getContent());
                       }
                       break;

                   case "video":
                       // Get video details
                       LessonVideoDAO videoDAO = new LessonVideoDAO();
                       LessonVideo video = videoDAO.getLessonVideoByLessonId(lessonId);
                       if (video != null) {
                           jsonResponse.addProperty("videoUrl", video.getVideoUrl());
                           jsonResponse.addProperty("videoDuration", video.getVideoDuration());
                           jsonResponse.addProperty("transcript", video.getTranscript());
                           jsonResponse.addProperty("downloadAllowed", video.isDownloadAllowed());
                       }
                       break;

                   case "file":
                       // Get file details
                       LessonFileDAO fileDAO = new LessonFileDAO();
                       LessonFile file = fileDAO.getLessonFileByLessonId(lessonId);
                       if (file != null) {
                           jsonResponse.addProperty("fileUrl", file.getFileUrl());
                           jsonResponse.addProperty("fileType", file.getFileType());
                           jsonResponse.addProperty("fileSize", file.getFileSize());
                       }
                       break;

                   case "quiz":
                       // Get quiz details
                       LessonQuizDAO quizDAO = new LessonQuizDAO();
                       List<LessonQuiz> quizzes = quizDAO.findByLessonId(lessonId);
                       LessonQuiz quiz = quizzes.isEmpty() ? null : quizzes.get(0);
                       if (quiz != null) {
                           jsonResponse.addProperty("quizId", quiz.getLessonQuizID());
                           jsonResponse.addProperty("passPercentage", quiz.getPassPercentage());
                           jsonResponse.addProperty("timeLimit", quiz.getTimeLimit());
                           jsonResponse.addProperty("attemptAllowed", quiz.getAttemptAllowed());
                       }
                       break;

                   default:
                       jsonResponse.addProperty("content", lesson.getContent());
                       break;
               }
           } else {
               // If no specific type, use the general content
               jsonResponse.addProperty("content", lesson.getContent());
           }

           // Send the response
           out.print(jsonResponse.toString());

       } catch (NumberFormatException e) {
           JsonObject errorJson = new JsonObject();
           errorJson.addProperty("error", "Invalid lesson ID");
           out.print(errorJson.toString());
       } catch (Exception e) {
           JsonObject errorJson = new JsonObject();
           errorJson.addProperty("error", "Error loading lesson content: " + e.getMessage());
           out.print(errorJson.toString());
       }
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       doGet(request, response);
   }
}