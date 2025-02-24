package Controller.ForAdmin;

import DAO.CourseTypeDAO;
import DAO.QuestionDAO;
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

@WebServlet(name="ManageQuestion", urlPatterns={"/manage-question"})
public class ManageQuestionController  extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
            String action = request.getParameter("action");
            if(action ==null){
                searchByFilter(request, response);
            }else{

            }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
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


        int page = 1;
        int pageSize = 3;
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



        QuestionDAO questionDAO = new QuestionDAO();
        List<Question> questionList = questionDAO.getQuestionByFilter(search,subject,level,status, page, pageSize);
        int totalQuestion = questionDAO.getTotalQuestionByFilter(search,subject,level,status);
        int totalPage = (int) Math.ceil((double) totalQuestion / pageSize);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("questionList", questionList);
        request.setAttribute("courseTypes", courseTypes);

        request.setAttribute("subject", subject);
        request.setAttribute("level", level);
        request.setAttribute("status", status);
        request.setAttribute("search", search);

        request.getRequestDispatcher("/admin/manage-question.jsp").forward(request,response);
    }
}