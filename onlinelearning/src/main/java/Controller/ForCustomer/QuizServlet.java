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
        String Page = request.getParameter("page");
        int quizid = 0;
        ArrayList<Question> listQuestion = new ArrayList<>();
        ArrayList<QuestionAnswer> listans = new ArrayList<>();
        QuestionDAO qd = new QuestionDAO();


        try {
            quizid = Integer.parseInt(id_raw);
            int totalQuestions = qd.getQuestionCountByQuizId(quizid);
            request.setAttribute("num", totalQuestions);

            int page = 0;
            if (Page == null || Page.isEmpty()) {
                listQuestion = qd.getQuestion(quizid, 0);
                request.setAttribute("currentPage", 1);
            } else {
                try {
                    page = Integer.parseInt(Page);
                    listQuestion = qd.getQuestion(quizid, page - 1);
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
                request.setAttribute("currentPage", page);
            }
            LessonQuiz lessonQuiz= qd.takeLessonQuizByQuizQuestionID(quizid);
            request.setAttribute("lessonQuiz",lessonQuiz);

            request.setAttribute("listQuestion", listQuestion);
            listans = qd.getAnswer(quizid);
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
        HttpSession session = request.getSession();
        String id_raw = request.getParameter("id");
        int quizId = Integer.parseInt(id_raw);
        ArrayList<QuestionAnswer> Answers = new QuestionDAO().getAnswer(quizId);
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
            detail.setQuizAttendID(qd.findQuizAttendIDbyQuizQuestionID(quizId));
            detail.setQuestionID(Answer.getQuestionId());
            if (userAnswerRadio != null ) {
                // Nếu người dùng chọn một đáp án (radio), lưu answerId
                detail.setChooseOptionID(Integer.parseInt(userAnswerRadio));  // Lưu ID đáp án
                detail.setAnswerText(null);  // Đối với câu trả lời dạng radio, không cần lưu văn bản
                detail.setCorrect(Answer.isCorrect());
                if (Answer.isCorrect()){
                    totalScore += qd.GetMarkfromQuestion(Answer.getQuestionId());
                }
            } else {
                // Nếu câu trả lời là văn bản, lưu vào AnswerText
                int a= 0;
                detail.setChooseOptionID( a);  // Không có chọn lựa đáp án
                detail.setAnswerText(AnswerText );  // Lưu câu trả lời văn bản
                boolean isCorrect = AnswerText.equals(Answer.getContent());
                detail.setCorrect(isCorrect);
                if (isCorrect) {
                    totalScore += qd.GetMarkfromQuestion(Answer.getQuestionId());
                }
            }
            resultDetails.add(detail);
            qd.saveQuizResultDetails(resultDetails);
            for (Part imagePart : imageParts) {
                if (imagePart.getSize() > 0) {
                    // Lưu từng hình ảnh vào hệ thống hoặc cơ sở dữ liệu
                    String fileName = imagePart.getSubmittedFileName();
                    String uploadDir = "C:/Users/MSI/IdeaProject/SWP_SE1880_G1/onlinelearning/src/main/webapp/assets/images/"; // Đường dẫn lưu trữ hình ảnh

                    // Tạo thư mục nếu chưa tồn tại
                    File uploadDirFile = new File(uploadDir);
                    if (!uploadDirFile.exists()) {
                        uploadDirFile.mkdir();
                    }

                    // Lưu hình ảnh
                    File file = new File(uploadDir + fileName);
                    try (InputStream inputStream = imagePart.getInputStream();
                         OutputStream outputStream = new FileOutputStream(file)) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                    }

                    // Thêm hình ảnh vào resultImages
                    QuizResultDetailImage imageDetail = new QuizResultDetailImage();
                    imageDetail.setImageQuizID(Answer.getAnswerId());  // Gán ID câu trả lời cho ảnh
                    imageDetail.setTitle(file.getAbsolutePath());  // Lưu đường dẫn của ảnh
                    resultImages.add(imageDetail);
                    qd.saveQuizResultDetailImages(resultImages);

                }
            }
        }
        int quizAttendID =qd.findQuizAttendIDbyQuizQuestionID(quizId);
        qd.updateTotalScore(quizAttendID, totalScore);
        request.setAttribute("score", totalScore);
        request.getRequestDispatcher("result.jsp").forward(request, response);


    }



    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
