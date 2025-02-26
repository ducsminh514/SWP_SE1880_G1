/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Subject;

import dao.SubjectDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.ResultSet;
import models.Courses;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateUpdate", urlPatterns = {"/updateUpdate"})
public class UpdateCourse extends HttpServlet {

    private static final String UPLOAD_DIR = "WebPages/uploads";
    // lý do lấy courseId ở doGet xog lại phải truyền ngược lại cho jsp
    // để có thể set được courseId vào <input type="hidden" name="courseId" value="<%=courseId%>" /> <=> submit form có trường courseId
    // nếu không truyền ngược lại thì khi submit form ở doPost sẽ không có id để thực hiện update

    // luồng của update
    // 1. Khi click vào btn Cập nhật ở màn list => gọi đến controller updateCourse với method get
    // 2. ở hàm doGet sẽ lấy thông của Course theo id để bên jsp có thể fill thông của Course vào form
    // 3.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // khi gọi 1 controller = 1 form có method get, bằng 1 đường dẫn
        SubjectDao subjectDao = new SubjectDao();
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        // lấy ra subject theo id
        Subject subject = subjectDao.getSubjectByID(subjectId);
        // lấy ra danh mục môn học
        String sqlCourse = "select * from Courses";
        ResultSet rsCourse = subjectDao.getData(sqlCourse);
        request.setAttribute("rsCourse", rsCourse);
        request.setAttribute("subject", subject);
        request.setAttribute("subjectId", subjectId);
        request.getRequestDispatcher("/update.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // khi gọi 1 controller = 1 form có method post,
        SubjectDao subjectDao = new SubjectDao();
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        String subjectName = request.getParameter("subjectName");
        String description = request.getParameter("description");
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int numberLesson = Integer.parseInt(request.getParameter("numberLesson"));
        String image = request.getParameter("image");
        String oldImage = request.getParameter("oldImage");
        String realImage;
        if (image != null && !image.trim().isEmpty()) {
            realImage = image;
        } else {
            realImage = oldImage;
        }
        // checkUpdate để check xem câu lệnh update có được thực hiện thành công không
        int checkUpdate = 0;
        Subjects newSubject = new Subjects(courseId, 1, numberLesson, subjectName, description, realImage);
        // cái courseDao.updateCourse sẽ return về int vì khi chạy câu lệnh insert/update sẽ nhận được số lượng bản ghi thực hiện thành công
        checkUpdate = subjectDao.updateSubject(newSubject, subjectId);
        if (checkUpdate > 0) {
            response.sendRedirect("http://localhost:8080/iter1/getListSubject");
        } else {
            request.setAttribute("message", "Cập nhật thất bại");
            Subject subject = subjectDao.getSubjectByID(subjectId);
            // lấy ra danh mục môn học
            String sqlCourse = "select * from Courses";
            ResultSet rsCourse = subjectDao.getData(sqlCourse);
            request.setAttribute("rsCourse", rsCourse);
            request.setAttribute("subject", subject);
            request.setAttribute("subjectId", subjectId);
            request.getRequestDispatcher("/update.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
