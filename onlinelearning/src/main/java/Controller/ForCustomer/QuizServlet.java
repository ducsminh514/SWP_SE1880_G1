package Controller.ForCustomer;

import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

import DAO.QuestionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import Module.*;

@WebServlet(name = "QuizServlet", urlPatterns = {"/quiz"})
public class QuizServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet QuizServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuizServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_raw = request.getParameter("id");
        System.out.println("id_raw value in POST request: " + id_raw);
        int quizid = 0;
        ArrayList<Question> listQuestion = new ArrayList<>();
        ArrayList<QuestionAnswer> listans = new ArrayList<>();
        QuestionDAO qd = new QuestionDAO();

        try {
            quizid = Integer.parseInt(id_raw);
            int totalQuestions = qd.getQuestionCountByQuizId(quizid);
            request.setAttribute("num", totalQuestions);
            LessonQuiz lessonQuiz= qd.takeLessonQuizByID(quizid);
            request.setAttribute("lessonQuiz",lessonQuiz);
            listQuestion= qd.getQuestion(quizid);
            request.setAttribute("listQuestion", listQuestion);
            listans = qd.getAnswer(quizid);
            request.setAttribute("listans", listans);
            request.setAttribute("id", quizid);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid data!");
        }
        System.out.println("Received id: " + id_raw);
        request.getRequestDispatcher("quizpage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_raw = request.getParameter("id");
        if (id_raw == null || id_raw.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quiz ID is missing.");
            return;
        }
        int quizId = Integer.parseInt(id_raw);
        // Get answers and initialize variables
        ArrayList<QuestionAnswer> Answers = new QuestionDAO().getAnswer(quizId);
        ArrayList<QuizResultDetail> resultDetails = new ArrayList<>();
        ArrayList<QuizResultDetailImage> resultImages = new ArrayList<>();
        QuestionDAO qd = new QuestionDAO();
        int totalScore = 0;

        // Process each answer
        for (QuestionAnswer Answer : Answers) {
            String userAnswerRadio = request.getParameter("radio");
            String AnswerText = request.getParameter("answertext");

            // Process result details for text or radio answers
            QuizResultDetail detail = new QuizResultDetail();
            detail.setQuizAttendID(qd.findQuizAttendIDbyQuizQuestionID(quizId));
            detail.setQuestionID(Answer.getQuestionId());

            if (userAnswerRadio != null) {
                // If user selected a radio button answer
                detail.setChooseOptionID(Integer.parseInt(userAnswerRadio));
                detail.setAnswerText(null);  // No text answer for radio
                detail.setCorrect(Answer.isCorrect());
                if (Answer.isCorrect()) {
                    totalScore += qd.GetMarkfromQuestion(Answer.getQuestionId());
                }
            } else {
                // If the answer is text
                detail.setChooseOptionID(0);  // No radio answer
                detail.setAnswerText(AnswerText);
                boolean isCorrect = AnswerText.equals(Answer.getContent());
                detail.setCorrect(isCorrect);
                if (isCorrect) {
                    totalScore += qd.GetMarkfromQuestion(Answer.getQuestionId());
                }
            }

            // Add result detail to the list
            resultDetails.add(detail);

            // Process images for this question
            Collection<Part> userImageParts = request.getParts();
            List<Part> imageParts = userImageParts.stream()
                    .filter(part -> part.getName().startsWith("images_" + Answer.getQuestionId()))
                    .collect(Collectors.toList());

            for (Part imagePart : imageParts) {
                if (imagePart.getSize() > 0) {
                    // Generate a file path for the image
                    String fileName = imagePart.getSubmittedFileName();
                    String uploadDir = "C:/Users/MSI/IdeaProject/SWP_SE1880_G1/onlinelearning/src/main/webapp/assets/images/";

                    // Create directory if not exists
                    File uploadDirFile = new File(uploadDir);
                    if (!uploadDirFile.exists()) {
                        uploadDirFile.mkdir();
                    }

                    // Save the image to the directory
                    File file = new File(uploadDir + fileName);
                    try (InputStream inputStream = imagePart.getInputStream();
                         OutputStream outputStream = new FileOutputStream(file)) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                    }

                    // Add image details to the result
                    QuizResultDetailImage imageDetail = new QuizResultDetailImage();
                    imageDetail.setImageQuizID(Answer.getAnswerId());
                    imageDetail.setTitle(file.getAbsolutePath());
                    resultImages.add(imageDetail);
                }
            }
        }

        // Save the result details and images after processing all answers
        qd.saveQuizResultDetails(resultDetails);
        qd.saveQuizResultDetailImages(resultImages);

        // Update the total score in the database
        int quizAttendID = qd.findQuizAttendIDbyQuizQuestionID(quizId);
        qd.updateTotalScore(quizAttendID, totalScore);

        // Forward the score to the result page
        request.setAttribute("score", totalScore);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }



    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
