package Controller.ForCustomer;

import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

import DAO.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import Module.*;

@WebServlet(name = "QuizServlet", urlPatterns = {"/quiz"})
public class QuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_raw = request.getParameter("id");
        int quizid = 0;
        ArrayList<Question> listQuestion = new ArrayList<>();
        ArrayList<QuestionAnswer> listans = new ArrayList<>();
        QuestionDAO qd = new QuestionDAO();
        LessonQuizDAO lessonQuizDAO = new LessonQuizDAO();
        QuizQuesionsDAO quizzQuestionDAO = new QuizQuesionsDAO();
        QuestionAnswerDAO questionAnswerDAO = new QuestionAnswerDAO();
        try {
            quizid = Integer.parseInt(id_raw);
            int totalQuestions = lessonQuizDAO.getQuestionCountByQuizId(quizid);
            request.setAttribute("num", totalQuestions);
            LessonQuiz lessonQuiz= lessonQuizDAO.takeLessonQuizByQuizQuestionID(quizid);
            request.setAttribute("lessonQuiz",lessonQuiz);
            listQuestion= quizzQuestionDAO.getQuestion(quizid);
            request.setAttribute("listQuestion", listQuestion);
            listans = questionAnswerDAO.getAnswer(quizid);
            request.setAttribute("listans", listans);
            request.setAttribute("id", quizid);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid data!");
        }
        request.getRequestDispatcher("quizpage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        HttpSession session = request.getSession();
        String id_raw = request.getParameter("id");
        int quizId = Integer.parseInt(id_raw);
        QuestionAnswerDAO questionAnswerDAO = new QuestionAnswerDAO();
        QuizAttendDAO quizAttendDAO = new QuizAttendDAO();
        QuizResultDetailDAO quizResultDetailDAO = new QuizResultDetailDAO();
        ArrayList<QuestionAnswer> Answers = questionAnswerDAO.getAnswer(quizId);
        ArrayList<QuizResultDetail> resultDetails = new ArrayList<>();
        ArrayList<QuizResultDetailImage> resultImages = new ArrayList<>();
        QuestionDAO qd= new QuestionDAO();
        int totalScore = 0;
        for (QuestionAnswer Answer:Answers){
            String userAnswerRadio = request.getParameter("radio");
            String AnswerText = request.getParameter("answertext" );
            Collection<Part> userImageParts = request.getParts();
            List<Part> imageParts = userImageParts.stream()
                    .filter(part -> part.getName().startsWith("images_" + Answer.getQuestionId()))
                    .collect(Collectors.toList());
            QuizResultDetail detail = new QuizResultDetail();
            detail.setQuizAttendID(quizAttendDAO.findQuizAttendIDbyQuizQuestionID(quizId));
            detail.setQuestionID(Answer.getQuestionId());
            if (userAnswerRadio != null ) {
                // Nếu người dùng chọn một đáp án (radio), lưu answerId
                detail.setChooseOptionID(Integer.parseInt(userAnswerRadio));  // Lưu ID đáp án
                detail.setAnswerText(null);  // Đối với câu trả lời dạng radio, không cần lưu văn bản
                detail.setCorrect(Answer.isCorrect());
                if (Answer.isCorrect()){
                    totalScore += questionAnswerDAO.GetMarkfromQuestion(Answer.getQuestionId());
                }
            } else {
                // Nếu câu trả lời là văn bản, lưu vào AnswerText
                int a= 0;
                detail.setChooseOptionID( a);  // Không có chọn lựa đáp án
                detail.setAnswerText(AnswerText );  // Lưu câu trả lời văn bản
                boolean isCorrect = AnswerText.equals(Answer.getContent());
                detail.setCorrect(isCorrect);
                if (isCorrect) {
                    totalScore += questionAnswerDAO.GetMarkfromQuestion(Answer.getQuestionId());
                }
            }
            resultDetails.add(detail);
            quizResultDetailDAO.saveQuizResultDetails(resultDetails);
            for (Part imagePart : imageParts) {
                if (imagePart.getSize() > 0) {
                    // Lưu từng hình ảnh vào hệ thống hoặc cơ sở dữ liệu


                    // Tạo thư mục nếu chưa tồn tại


                }
            }
        }
        int quizAttendID =quizAttendDAO.findQuizAttendIDbyQuizQuestionID(quizId);
        quizAttendDAO.updateTotalScore(quizAttendID, totalScore);
        request.setAttribute("score", totalScore);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
