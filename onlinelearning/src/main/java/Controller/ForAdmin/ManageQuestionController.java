package Controller.ForAdmin;

import DAO.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import Module.Subject;
import java.util.List;
import Module.QuestionAnswer;
import Module.Question;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;

import Module.CourseType;
import Module.QuestionType;


@WebServlet(name = "ManageQuestion", urlPatterns = {"/manage-question"})
public class ManageQuestionController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            searchByFilter(request, response);
        } else {
            switch (action) {
                case "edit" :
                    ShowEditForm(request,response);
                    break;
            }
        }
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            searchByFilter(request, response);
        } else if (action.equals("update")) {
            updateQuestion(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }


    private void searchByFilter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");
        String subject = request.getParameter("subject");
        String level = request.getParameter("level");
        String status = request.getParameter("status");
        String pageSizeStr = request.getParameter("pageSize");
        String[] optionChoice = request.getParameterValues("optionChoice");

        int page = 1;
        int pageSize = 5;

        if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeStr);
            } catch (NumberFormatException e) {
                System.out.println(e.getMessage() + " is not a number");
            }
        }
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1)
                    page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        SubjectDAO subjectDAO = new SubjectDAO();
        List<Subject> subjectList = subjectDAO.findAll();


        QuestionTypeDAO questionTypeDAO = new QuestionTypeDAO();
        List<QuestionType> questionTypes = questionTypeDAO.findAll();

        QuestionDAO questionDAO = new QuestionDAO();
        List<Question> questionList = questionDAO.getQuestionByFilter(search, subject, level, status, page, pageSize);
        int totalQuestion = questionDAO.getTotalQuestionByFilter(search, subject, level, status);
        int totalPage = (int) Math.ceil((double) totalQuestion / pageSize);

        List<Object> listColum = new java.util.ArrayList<>();
        if (optionChoice != null) {
            for (int i = 0; i < optionChoice.length; i++) {
                switch (optionChoice[i]) {
                    case "idChoice":
                        listColum.add("idChoice");
                        break;
                    case "subjectChoice":
                        listColum.add("subjectChoice");
                        break;
                    case "levelChoice":
                        listColum.add("levelChoice");
                        break;
                    case "statusChoice":
                        listColum.add("statusChoice");
                        break;
                    case "contentChoice":
                        listColum.add("contentChoice");
                        break;
                    case "typeChoice":
                        listColum.add("typeChoice");
                        break;
                    case "actionChoice":
                        listColum.add("actionChoice");
                        break;
                }
            }
        } else {
            listColum.add("idChoice");
            listColum.add("contentChoice");
            listColum.add("subjectChoice");
            listColum.add("levelChoice");
            listColum.add("typeChoice");
            listColum.add("statusChoice");
            listColum.add("actionChoice");
        }
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("questionList", questionList);
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("questionTypes", questionTypes);

        request.setAttribute("subject", subject);
        request.setAttribute("level", level);
        request.setAttribute("status", status);
        request.setAttribute("search", search);
        request.setAttribute("listColum", listColum);
        request.setAttribute("pageSize", pageSize);
        request.getRequestDispatcher("/admin/manage-question.jsp").forward(request, response);
    }


    private void ShowEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Nhan tham so
        String questionIdStr = request.getParameter("questionId");
        int questionId = 0;
        try{
            questionId = Integer.parseInt(questionIdStr);
        }catch (NumberFormatException e){
            System.out.println(e.getMessage());
        }
        //Lay ra question can edit va cau hoi va hinh anh tuong ung
        QuestionDAO questionDAO = new QuestionDAO();
        Question question = questionDAO.GetQuestionById(questionId);

        //Lấy ra questionType
        QuestionTypeDAO questionTypeDAO = new QuestionTypeDAO();
        List<QuestionType> questionTypes = questionTypeDAO.findAll();

        //Lay ra subject
        SubjectDAO subjectDAO = new SubjectDAO();
        List<Subject> subjectList = subjectDAO.findAll();

        //Lay ra Answer cua question
        QuestionAnswerDAO questionAnswerDAO = new QuestionAnswerDAO();
        List<QuestionAnswer> questionAnswers = questionAnswerDAO.getAnswerByQuestionId(questionId);
        // Set Attribute
        request.setAttribute("question", question);
        request.setAttribute("questionTypes", questionTypes);
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("questionAnswers", questionAnswers);
        //day ve JSP
        request.getRequestDispatcher("/admin/edit-question.jsp").forward(request, response);
    }

    private void updateQuestion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        String content = request.getParameter("content");
        int level = Integer.parseInt(request.getParameter("level"));
        int subjectId = Integer.parseInt(request.getParameter("subject"));
        int mark = Integer.parseInt(request.getParameter("mark"));
        int questionTypeId = Integer.parseInt(request.getParameter("questionType"));
        boolean isActive = Boolean.parseBoolean(request.getParameter("status"));
        
        // Get the current question
        QuestionDAO questionDAO = new QuestionDAO();
        Question question = questionDAO.GetQuestionById(questionId);
        
        // Update question properties
        question.setContent(content);
        question.setLevel(level);
        
        // Set subject
        SubjectDAO subjectDAO = new SubjectDAO();
        Subject subject = subjectDAO.getSubjectById(subjectId);
        question.setSubject(subject);
        
        question.setMark(mark);
        
        // Set question type
        QuestionTypeDAO questionTypeDAO = new QuestionTypeDAO();
        QuestionType questionType = questionTypeDAO.getQuestionTypeById(questionTypeId);
        question.setQuestionType(questionType);
        
        question.setStatus(isActive);
        
        // Handle MP3 file if uploaded
        Part audioPart = request.getPart("audioFile");
        String deleteAudio = request.getParameter("deleteAudio");
        
        if (deleteAudio != null && deleteAudio.equals("true")) {
            // Delete the existing audio file
            question.setMp3(null);
        } else if (audioPart != null && audioPart.getSize() > 0) {
            // Save the new audio file
            String fileName = getSubmittedFileName(audioPart);
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            String uploadPath = request.getServletContext().getRealPath("/uploads/audio/");
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            
            audioPart.write(uploadPath + File.separator + uniqueFileName);
            question.setMp3(uniqueFileName);
        }
        
        // Update the question in the database
        boolean updated = questionDAO.update(question);
        
        // Handle question answers
        if (updated) {
            // First delete existing answers
            QuestionAnswerDAO answerDAO = new QuestionAnswerDAO();
            answerDAO.deleteAnswersByQuestionId(questionId);
            
            // Then add new answers
            int optionCount = 0;
            String optionValue;
            
            while ((optionValue = request.getParameter("option" + (optionCount + 1))) != null) {
                QuestionAnswer answer = new QuestionAnswer();
                answer.setContent(optionValue);
                answer.setQuestionId(questionId);
                answer.setSortOrder(optionCount + 1);
                
                String isCorrectParam = request.getParameter("isCorrect" + (optionCount + 1));
                boolean isCorrect = isCorrectParam != null && 
                                   (isCorrectParam.equals("on") || isCorrectParam.equals("true"));
                answer.setCorrect(isCorrect);
                
                answerDAO.insert(answer);
                optionCount++;
            }
        }
        
        // Redirect back to the question list
        response.sendRedirect(request.getContextPath() + "/manage-question");
    }

    // Helper method to get the submitted file name
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}