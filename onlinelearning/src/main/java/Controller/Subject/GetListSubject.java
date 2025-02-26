/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Subject;

import dao.SubjectDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
@WebServlet(name = "GetListSubject", urlPatterns = {"/getListSubject"})
public class GetListCourse extends HttpServlet {

  /**
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
   * methods.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  private final int PAGE_SIZE = 5;

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    SubjectDao subjectDao = new SubjectDao();
    // currentPage: trang hiện tại mặc định sẽ là 1.
    // nếu người dùng chuyển trang thì sẽ truyền tới servlet và được gán vào biến currentPage
    int currentPage = 1;
    if (request.getParameter("currentPage") != null) {
      currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    // textSearch: để filter theo tên khóa học như người dùng gõ vào thanh tìm kiếm
    String textSearch = request.getParameter("textSearch");
    // courseId: filter theo danh mục môn học. mặc định sẽ là 0 <=> người dùng chưa filter
    // nếu người dùng filter theo danh mục môn học thì sẽ gán vào biến courseId
    int courseId = 0;
    if (request.getParameter("courseId") != null) {
      courseId = Integer.parseInt(request.getParameter("courseId"));
    }
    // hàm subjectDao.getTotalRecord sẽ lấy ra tổng số lượng bản ghi của 1 table
    // totalSubject: tổng số lượng bản ghi của bảng Subjects
    int totalSubject = subjectDao.getTotalRecord("select * from Subjects");
    // totalPage tổng số trang người dùng có thể thấy
    // PAGE_SIZE số lượng khóa học trong 1 trang
    int totalPage;
    // nếu totalCourse chia cho PAGE_SIZE bị dư thì totalPage phải + 1 còn không thì giữ nguyên
    if (totalSubject % PAGE_SIZE == 0) {
      totalPage = totalSubject / PAGE_SIZE;
    } else {
      totalPage = totalSubject / PAGE_SIZE + 1;
    }
    // Lấy ra danh mục môn học
    String sqlCourse = "select * from Courses";
    ResultSet rsCourse = subjectDao.getData(sqlCourse);
    // Câu lệnh SQL để lấy ra Subjects mặc định có phân trang <=> khi người dùng chưa filter, tìm kiếm
    // offset: số lượng bản ghi sẽ bị bỏ qua
    // fetch: số lượng bản ghi lấy ra
    String sqlSubject = "select * from Subjects order by SubjectId offset " + ((currentPage - 1) * PAGE_SIZE) + " rows fetch next " + PAGE_SIZE + " rows only";
    if (textSearch != null && courseId != 0) {
      sqlSubject = "select * from Subjects "
              + "where SubjectName like '%" + textSearch + "%' and CourseId = " + courseId
              + "order by SubjectId offset " + ((currentPage - 1) * PAGE_SIZE) + " rows fetch next " + PAGE_SIZE + " rows only";
    }
    if (textSearch != null) {
      sqlSubject = "select * from Subjects "
              + "where SubjectName like '%" + textSearch + "%' "
              + "order by SubjectId offset " + ((currentPage - 1) * PAGE_SIZE) + " rows fetch next " + PAGE_SIZE + " rows only";
    }
    if (courseId != 0) {
      sqlSubject = "select * from Subjects "
              + "where CourseId = " + courseId + " "
              + "order by SubjectId offset " + ((currentPage - 1) * PAGE_SIZE) + " rows fetch next " + PAGE_SIZE + " rows only";
    }
    ResultSet rsSubject = subjectDao.getData(sqlSubject);
    request.setAttribute("totalPage", totalPage);
    request.setAttribute("rsCourse", rsCourse);
    request.setAttribute("rsSubject", rsSubject);
    request.setAttribute("currentPage", currentPage);
    request.getRequestDispatcher("list.jsp").forward(request, response);
  }

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
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
    processRequest(request, response);
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
