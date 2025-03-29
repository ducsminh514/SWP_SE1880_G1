package Controller.ForTransaction;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import DAO.CourseDAO;
import DAO.PriceCourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Module.User ;
import Module.PriceCourse ;
import Module.Course ;
@WebServlet(name="SelectPricePackage", urlPatterns={"/select-price-package"})
public class SelectPricePackage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        int courseId= 0 , pricePackageId =0 ;
        // Get course and price package IDs
        try{
            if(request.getParameter("courseId") == null){
                courseId = Integer.parseInt((String)session.getAttribute("courseId"));
                pricePackageId = Integer.parseInt((String)session.getAttribute("pricePackageId"));
            }else{
                courseId = Integer.parseInt(request.getParameter("courseId"));
                pricePackageId = Integer.parseInt(request.getParameter("pricePackageId"));
            }
        }catch(NumberFormatException e){
            System.out.println(e);
        }
        System.out.println("course: "+ courseId);
        System.out.println("price:" + pricePackageId);
        // Get course and price package details
        CourseDAO courseDAO = new CourseDAO();
        PriceCourseDAO priceCourseDAO = new PriceCourseDAO();

        Course course = courseDAO.getById(courseId);
        PriceCourse pricePackage = priceCourseDAO.getById(pricePackageId);

        if (course == null || pricePackage == null) {
            response.sendRedirect("error.jsp");
            return;
        }
        session.removeAttribute("courseId");
        session.removeAttribute("pricePackageId");
        // Store selected course and price package in session
        session.setAttribute("selectedCourse", course);
        session.setAttribute("selectedPricePackage", pricePackage);
        session.setAttribute("selectedCourseId", courseId);
        session.setAttribute("selectedPricePackageId", pricePackageId);
        request.setAttribute("Course", course);
        request.setAttribute("PricePackage", pricePackage);

        // Redirect to order confirmation page
        request.getRequestDispatcher("Transaction/order-confirmation.jsp").forward(request,response);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Select Price Package Servlet";
    }
}