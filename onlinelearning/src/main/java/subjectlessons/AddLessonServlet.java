///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package subjectlessons;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.sql.Timestamp;
//
///**
// *
// * @author Admin
// */
//@WebServlet(name = "AddLessonServlet", urlPatterns = {"/addLesson"})
//public class AddLessonServlet extends HttpServlet {
//
//    private final String ACTIVE_STATUS = "1";
//    private final String INACTIVE_STATUS = "2";
//
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet AddLessonServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet AddLessonServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    private static final long serialVersionUID = 1L;
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        try {
//            int subjectID = Integer.parseInt(request.getParameter("subjectID"));
//            String lessonName = request.getParameter("lessonName");
//            String content = request.getParameter("content");
//            int duration = Integer.parseInt(request.getParameter("duration"));
//            int orderNo = Integer.parseInt(request.getParameter("orderNo"));
//            boolean statusLesson = request.getParameter("statusLesson").equals(ACTIVE_STATUS);
//            String videoUrl = request.getParameter("videoUrl");
//            Timestamp createdDate = new Timestamp(System.currentTimeMillis());
//
//            AddLesssonDTO newLesson = new AddLesssonDTO(subjectID, lessonName, content, duration, orderNo, statusLesson, videoUrl, createdDate);
//            LessonDAO lessonDAO = new LessonDAO();
//            boolean isInserted = lessonDAO.insertLesson(newLesson);
//
//            if (isInserted) {
//                response.sendRedirect("lesson-list?subjectID="+subjectID);
//            } else {
//                response.sendError(500);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(500);
//        }
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
