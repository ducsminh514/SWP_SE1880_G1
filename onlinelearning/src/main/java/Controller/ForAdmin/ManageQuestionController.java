package Controller.ForAdmin;

import DAO.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import Module.Subject;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;
import java.util.ArrayList;

import Module.QuestionAnswer;
import Module.Question;
import Module.QuestionImage;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;

import Module.CourseType;
import Module.QuestionType;

import java.util.Set;
import java.util.HashSet;

@MultipartConfig
@WebServlet(name = "ManageQuestion", urlPatterns = {"/manage-question"})
public class ManageQuestionController extends HttpServlet {

    private QuestionDAO questionDAO;
    private QuestionTypeDAO questionTypeDAO;
    private SubjectDAO subjectDAO;
    private QuestionAnswerDAO questionAnswerDAO;
    private QuestionImageDAO questionImageDAO;

    @Override
    public void init() throws ServletException {
        questionDAO = new QuestionDAO();
        questionTypeDAO = new QuestionTypeDAO();
        subjectDAO = new SubjectDAO();
        questionAnswerDAO = new QuestionAnswerDAO();
        questionImageDAO = new QuestionImageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            searchByFilter(request, response);
        } else {
            switch (action) {
                case "edit":
                    ShowEditForm(request, response);
                    break;
                case "changeStatus":
                    changeQuestionStatus(request, response);
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

    /**
     * Efficiently fetch questions and their related data in bulk to avoid N+1 query problem
     * @param search Search term for question content
     * @param subject Filter by subject ID
     * @param level Filter by question level
     * @param status Filter by question status
     * @param page Current page number
     * @param pageSize Number of items per page
     * @return List of questions with their related data
     */
    private List<Question> getQuestionsWithRelatedData(String search, String subject, String level, String status, int page, int pageSize) {
        // 1. Get basic question data
        List<Question> questions = questionDAO.getQuestionByFilter(search, subject, level, status, page, pageSize);

        if (questions.isEmpty()) {
            return questions;
        }

        // 2. Extract IDs for bulk fetching
        Set<Integer> questionIds = new HashSet<>();
        Set<Integer> subjectIds = new HashSet<>();
        Set<Integer> questionTypeIds = new HashSet<>();

        for (Question question : questions) {
            questionIds.add(question.getQuestionId());
            if (question.getSubject() != null) {
                subjectIds.add(question.getSubject().getSubjectId());
            }
            if (question.getQuestionType() != null) {
                questionTypeIds.add(question.getQuestionType().getQuestionTypeId());
            }
        }

        // 3. Fetch all related data in bulk
        Map<Integer, List<QuestionImage>> imagesByQuestionId = new HashMap<>();
        List<QuestionImage> allImages = questionImageDAO.getImagesByQuestionIds(new ArrayList<>(questionIds));
        for (QuestionImage image : allImages) {
            imagesByQuestionId.computeIfAbsent(image.getQuestionImangeId(), k -> new ArrayList<>()).add(image);
        }

        // Get subjects and question types in bulk
        Map<Integer, Subject> subjectMap = questionDAO.getSubjectsByIds(new ArrayList<>(subjectIds));
        Map<Integer, QuestionType> questionTypeMap = questionTypeDAO.getQuestionTypesByIds(new ArrayList<>(questionTypeIds));

        // 4. Update questions with the fetched data
        for (Question question : questions) {
            // Set subject
            if (question.getSubject() != null && subjectMap.containsKey(question.getSubject().getSubjectId())) {
                question.setSubject(subjectMap.get(question.getSubject().getSubjectId()));
            }

            // Set question type
            if (question.getQuestionType() != null && questionTypeMap.containsKey(question.getQuestionType().getQuestionTypeId())) {
                question.setQuestionType(questionTypeMap.get(question.getQuestionType().getQuestionTypeId()));
            }

            // Set images
            List<QuestionImage> images = imagesByQuestionId.get(question.getQuestionId());
            if (images != null) {
                question.setQuestionImage(images);
            }
        }

        return questions;
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

        // Get all subjects and question types up front (these are typically small tables)
        List<Subject> subjectList = subjectDAO.findAll();
        List<QuestionType> questionTypes = questionTypeDAO.findAll();

        // Use the new optimized method instead of the standard DAO method
        List<Question> questionList = getQuestionsWithRelatedData(search, subject, level, status, page, pageSize);
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
        // Nhận tham số
        String questionIdStr = request.getParameter("questionId");
        int questionId = 0;
        try {
            questionId = Integer.parseInt(questionIdStr);
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manage-question?error=invalid_id");
            return;
        }

        // Lấy ra question cần edit - sử dụng DAO đã khởi tạo
        Question question = questionDAO.GetQuestionById(questionId);

        if (question == null) {
            response.sendRedirect(request.getContextPath() + "/manage-question?error=not_found");
            return;
        }

        // Lấy dữ liệu cần thiết cho form - all in one go
        List<QuestionImage> questionImages = questionImageDAO.getImageByQuestionId(questionId);
        List<QuestionType> questionTypes = questionTypeDAO.findAll();
        List<Subject> subjectList = subjectDAO.findAll();
        List<QuestionAnswer> questionAnswers = questionAnswerDAO.getAnswerByQuestionId(questionId);

        // Set Attribute
        request.setAttribute("question", question);
        request.setAttribute("questionImages", questionImages);
        request.setAttribute("questionTypes", questionTypes);
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("questionAnswers", questionAnswers);

        // Gửi về JSP
        request.getRequestDispatcher("/admin/edit-question.jsp").forward(request, response);
    }

    private void updateQuestion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String questionIdStr = request.getParameter("questionId");
        int questionId = Integer.parseInt(questionIdStr);
        String content = request.getParameter("content");
        int level = Integer.parseInt(request.getParameter("level"));
        int subjectId = Integer.parseInt(request.getParameter("subject"));
        int mark = Integer.parseInt(request.getParameter("mark"));
        int questionTypeId = Integer.parseInt(request.getParameter("questionType"));
        boolean isActive = Boolean.parseBoolean(request.getParameter("status"));

        // Get the current question
        Question question = questionDAO.GetQuestionById(questionId);

        // Update question properties
        question.setContent(content);
        question.setLevel(level);

        // Set subject
        Subject subject = subjectDAO.getSubjectById(subjectId);
        question.setSubject(subject);
        question.setMark(mark);
        // Set question type
        QuestionType questionType = questionTypeDAO.getQuestionTypeById(questionTypeId);
        question.setQuestionType(questionType);
        question.setStatus(isActive);
        question.setLessonQuizId(1);
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

        // Handle existing images
        String[] imageIds = request.getParameterValues("imageId");
        String[] deleteFlags = request.getParameterValues("deleteImage");

        if (imageIds != null && deleteFlags != null) {
            for (int i = 0; i < imageIds.length; i++) {
                int imageId = Integer.parseInt(imageIds[i]);
                boolean deleteFlag = Boolean.parseBoolean(deleteFlags[i]);

                if (deleteFlag) {
                    // Delete the image
                    QuestionImage image = new QuestionImage();
                    image.setImageId(imageId);
                    questionImageDAO.delete(image);
                }
            }
        }

        // Handle new images
        Collection<Part> imageParts = request.getParts();
        for (Part part : imageParts) {
            if (part.getName().startsWith("newImageFile[") && part.getSize() > 0) {
                // Extract index from name
                String name = part.getName();
                int startIndex = name.indexOf('[') + 1;
                int endIndex = name.indexOf(']');
                int index = Integer.parseInt(name.substring(startIndex, endIndex));

                // Get corresponding title
                String titleParam = "newImageTitle[" + index + "]";
                String imageTitle = request.getParameter(titleParam);

                // Save the image file
                String fileName = getSubmittedFileName(part);
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                String uploadPath = request.getServletContext().getRealPath("/uploads/images/");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                part.write(uploadPath + File.separator + uniqueFileName);

                // Create and save new QuestionImage
                QuestionImage newImage = new QuestionImage();
                newImage.setImageTitle(imageTitle);
                // Lưu đường dẫn tương đối đến file ảnh
                String relativePath = "/uploads/images/" + uniqueFileName;
                newImage.setImageURL(relativePath);
                newImage.setQuestionImangeId(questionId);
                questionImageDAO.insert(newImage);
            }
        }

        // Update the question in the database
        boolean updated = questionDAO.update(question);

        // Handle question answers
        if (updated) {
            // First delete existing answers
            questionAnswerDAO.deleteAnswersByQuestionId(questionId);

            // Then add new answers
            int optionCount = 0;
            String[] optionValue;

            optionValue = request.getParameterValues("option");
            for (int i = 0; i < optionValue.length; i++) {
                if (optionValue[i] == null || optionValue[i].trim().isEmpty()) break;
                QuestionAnswer answer = new QuestionAnswer();
                answer.setContent(optionValue[i]);
                answer.setQuestionId(questionId);
                answer.setSortOrder(i);

                String isCorrectParam = request.getParameter("isCorrect" + (i + 1));
                boolean isCorrect = isCorrectParam != null &&
                        (isCorrectParam.equals("on") || isCorrectParam.equals("true"));
                answer.setCorrect(isCorrect);

                questionAnswerDAO.insert(answer);
                // optionCount++;
                System.out.println("Added option: " + optionValue + ", isCorrect: " + isCorrect);
            }
            
            // Set success toast message
            setToastMessage(request, "Question updated successfully", "success");
        } else {
            // Set error toast message
            setToastMessage(request, "Failed to update question", "error");
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

    private void changeQuestionStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters
            String questionIdStr = request.getParameter("questionId");
            String currentStatusStr = request.getParameter("currentStatus");

            if (questionIdStr == null || currentStatusStr == null) {
                setToastMessage(request, "Missing parameters", "error");
                response.sendRedirect(request.getContextPath() + "/manage-question");
                return;
            }

            int questionId = Integer.parseInt(questionIdStr);
            boolean currentStatus = Boolean.parseBoolean(currentStatusStr);

            // Get the question from the database
            Question question = questionDAO.GetQuestionById(questionId);
            if (question == null) {
                setToastMessage(request, "Question not found", "error");
                response.sendRedirect(request.getContextPath() + "/manage-question");
                return;
            }

            // Toggle the status
            question.setStatus(!currentStatus);

            // Update the question
            boolean updated = questionDAO.update(question);

            if (updated) {
                setToastMessage(request, "Question status changed successfully", "success");
            } else {
                setToastMessage(request, "Failed to update question status", "error");
            }
            
            response.sendRedirect(request.getContextPath() + "/manage-question");
            
        } catch (NumberFormatException e) {
            setToastMessage(request, "Invalid parameters", "error");
            response.sendRedirect(request.getContextPath() + "/manage-question");
        } catch (Exception e) {
            System.out.println("Error changing question status: " + e.getMessage());
            setToastMessage(request, "Unexpected error", "error");
            response.sendRedirect(request.getContextPath() + "/manage-question");
        }
    }
    
    // Helper method to set toast message
    private void setToastMessage(HttpServletRequest request, String message, String type) {
        request.getSession().setAttribute("toastMessage", message);
        request.getSession().setAttribute("toastType", type);
    }
}