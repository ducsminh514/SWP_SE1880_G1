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
       response.setContentType("text/html");
       response.setCharacterEncoding("UTF-8");

       // Get lesson ID from request
       String lessonIdStr = request.getParameter("lessonId");
       PrintWriter out = response.getWriter();

       if (lessonIdStr == null || lessonIdStr.isEmpty()) {
           out.print("<div class='alert alert-danger'>Lesson ID is required</div>");
           return;
       }

       try {
           int lessonId = Integer.parseInt(lessonIdStr);

           // Get lesson details
           LessonDAO lessonDAO = new LessonDAO();
           Lesson lesson = lessonDAO.findById(lessonId);

           if (lesson == null) {
               out.print("<div class='alert alert-danger'>Lesson not found</div>");
               return;
           }

           // Generate HTML content based on lesson type
           String lessonType = lesson.getType();
           StringBuilder htmlContent = new StringBuilder();

           // Common header for all lesson types
           htmlContent.append("<div class='lesson-header mb-4'>");
           htmlContent.append("<h4>").append(lesson.getLessonName()).append("</h4>");
           htmlContent.append("<div class='lesson-meta'>");
           htmlContent.append("<span><i class='fa fa-clock-o'></i> ").append(lesson.getDuration()).append(" minutes</span>");
           htmlContent.append("</div>");
           htmlContent.append("</div>");

           if (lessonType != null) {
               switch (lessonType.toLowerCase()) {
                   case "text":
                       // Get text content
                       LessonTextDAO textDAO = new LessonTextDAO();
                       LessonText text = textDAO.getLessonTextByLessonId(lessonId);
                       if (text != null) {
                           htmlContent.append("<div class='lesson-content'>");
                           htmlContent.append(text.getContent());
                           htmlContent.append("</div>");
                       }
                       break;

                   case "video":
                       // Get video details
                       LessonVideoDAO videoDAO = new LessonVideoDAO();
                       LessonVideo video = videoDAO.getLessonVideoByLessonId(lessonId);
                       if (video != null) {
                           htmlContent.append("<div class='video-container mb-4'>");
                           htmlContent.append("<iframe src='").append(video.getVideoUrl()).append("' allowfullscreen></iframe>");
                           htmlContent.append("</div>");

                           if (video.getTranscript() != null && !video.getTranscript().isEmpty()) {
                               htmlContent.append("<div class='transcript-container'>");
                               htmlContent.append("<h5>Transcript</h5>");
                               htmlContent.append("<div class='transcript-content'>").append(video.getTranscript()).append("</div>");
                               htmlContent.append("</div>");
                           }
                       }
                       break;

                   case "file":
                       // Get file details
                       LessonFileDAO fileDAO = new LessonFileDAO();
                       LessonFile file = fileDAO.getLessonFileByLessonId(lessonId);
                       if (file != null) {
                           htmlContent.append("<div class='file-container'>");
                           htmlContent.append("<h5>Download Resource</h5>");
                           htmlContent.append("<p>File Type: ").append(file.getFileType()).append("</p>");
                           htmlContent.append("<p>File Size: ").append(file.getFileSize()).append(" KB</p>");
                           htmlContent.append("<a href='").append(file.getFileUrl()).append("' class='btn' download>");
                           htmlContent.append("<i class='fa fa-download'></i> Download File</a>");
                           htmlContent.append("</div>");
                       }
                       break;

                   case "quiz":
                       // For quizzes, we'll just display a message and link to the quiz
                       htmlContent.append("<div class='quiz-container text-center p-5'>");
                       htmlContent.append("<h5>Quiz</h5>");
                       htmlContent.append("<p>This lesson contains a quiz to test your knowledge.</p>");
                       htmlContent.append("<a href='quiz?lessonId=").append(lessonId).append("' class='btn'>");
                       htmlContent.append("<i class='fa fa-check-circle'></i> Start Quiz</a>");
                       htmlContent.append("</div>");
                       break;

                   default:
                       htmlContent.append("<div class='lesson-content'>");
                       htmlContent.append(lesson.getContent());
                       htmlContent.append("</div>");
                       break;
               }
           } else {
               // If no specific type, use the general content
               htmlContent.append("<div class='lesson-content'>");
               htmlContent.append(lesson.getContent());
               htmlContent.append("</div>");
           }

           // Add completion button
           htmlContent.append("<div class='mt-4 text-right'>");
           htmlContent.append("<button class='btn' onclick='markLessonAsCompleted(").append(lessonId).append(")'>");
           htmlContent.append("<i class='fa fa-check-circle'></i> Mark as Completed</button>");
           htmlContent.append("</div>");

           // Send the response
           out.print(htmlContent.toString());

       } catch (NumberFormatException e) {
           out.print("<div class='alert alert-danger'>Invalid lesson ID</div>");
       } catch (Exception e) {
           out.print("<div class='alert alert-danger'>Error loading lesson content: " + e.getMessage() + "</div>");
       }
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
       doGet(request, response);
   }
}