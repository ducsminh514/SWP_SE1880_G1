package Controller.ForAdmin;

import DAO.CourseTypeDAO;
import DAO.QuestionDAO;
import DAO.QuestionTypeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

import Module.Question;

import java.io.IOException;
import java.io.PrintWriter;

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
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action == "list") {
            searchByFilter(request, response);
        } else {

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

        CourseTypeDAO courseTypeDAO = new CourseTypeDAO();
        List<CourseType> courseTypes = courseTypeDAO.getAll();
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
        }else{
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
        request.setAttribute("courseTypes", courseTypes);
        request.setAttribute("questionTypes", questionTypes);

        request.setAttribute("subject", subject);
        request.setAttribute("level", level);
        request.setAttribute("status", status);
        request.setAttribute("search", search);
        request.setAttribute("listColum", listColum);
        request.setAttribute("pageSize", pageSize);
        request.getRequestDispatcher("/admin/manage-question.jsp").forward(request, response);
    }


}