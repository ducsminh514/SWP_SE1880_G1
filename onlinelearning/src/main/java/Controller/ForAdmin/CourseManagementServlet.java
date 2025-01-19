package Controller.ForAdmin;

import DAO.CourseDAO;
import Module.Course;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "CourseManagementServlet", urlPatterns = {"/courseManagement"})
public class CourseManagementServlet extends HttpServlet {

    CourseDAO dao = new CourseDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "listAll";
        }

        switch (action) {
            case "listAll":
                listAll(request, response);
                break;
            case "searchStatus1":
                Active(request, response);
                break;
            case "searchStatus2":
                Deactive(request, response);
                break;

            default:
                listAll(request, response);
                break;
        }
    }

    private void listAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Course> aList = dao.getAll();

        request.setAttribute("aList", aList); // list course
        request.getRequestDispatcher("CourseHome.jsp").forward(request, response);
    }

    private void Active(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Course> aList = dao.getAllStatus1();

        request.setAttribute("aList", aList); // list course
        request.getRequestDispatcher("CourseHome.jsp").forward(request, response);
    }

    private void Deactive(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Course> aList = dao.getAllStatus2();

        request.setAttribute("aList", aList); // list course
        request.getRequestDispatcher("CourseHome.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtSearch = request.getParameter("txt");
        String pageStr = request.getParameter("page");
        int page = 1;
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
            }
        }
        List<Course> aList;
        if (txtSearch != null && !txtSearch.trim().isEmpty()) {
            aList = dao.searchCoursesByName(txtSearch, page, 5);
        } else {
            aList = dao.getAll();
        }
        request.setAttribute("aList", aList);
        request.getRequestDispatcher("CourseHome.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String courseIdRaw = request.getParameter("courseId");
        if (courseIdRaw != null) {
            try {
                int courseId = Integer.parseInt(courseIdRaw);
                // Delete the course by id
                dao.deleteCourse(courseId);
            } catch (NumberFormatException e) {
                System.out.println("Invalid course ID format: " + e.getMessage());
            }
        }

        response.sendRedirect("courseManagement");
    }

    @Override
    public String getServletInfo() {
        return "Manages course listing and deletion";
    }
}
