package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import DAO.*;
import DTO.CourseDetailDTO;
import Module.Course ;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.CourseType ;
import Module.Slider ;
import Module.PriceCourse ;
@WebServlet(name="ListCourse", urlPatterns={"/listCourse"})
public class ListCourse extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListCourse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListCourse at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        CourseDAO cDAO = new CourseDAO();
        ArrayList<Course> listCourse= new ArrayList<>() ;
        String numEachPage = request.getParameter("numberOfCourse");
        PriceCourseDAO pcDAO = new PriceCourseDAO();
        EnrollmentDAO emDAO = new EnrollmentDAO();
        ReviewCourseDAO rvDAO = new ReviewCourseDAO();
        SliderDAO sDAO = new SliderDAO() ;
        CourseDetailDTO courseDetail = new CourseDetailDTO();
        String arrange = request.getParameter("arrange");
        String Page = request.getParameter("page");
        String search = request.getParameter("search");
        String category = request.getParameter("cate");
        int cateID = 0;
        //chuyen categoryId
        if (category != null && !category.isEmpty()) {
            try {
                cateID = Integer.parseInt(category);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }
        // chuyen numPageCourse
        int numCoursePage =9 ;
        if(numEachPage!= null && !numEachPage.isEmpty()){
            try{
                numCoursePage= Integer.parseInt(numEachPage) ;
            }catch(NumberFormatException e){
                System.out.println(e);
            }
        }
        // neu khong phan trang
        int page = 0;
        if (Page == null || Page.isEmpty()) {
            listCourse = cDAO.getCourse(search, cateID, arrange,0,numCoursePage);
            request.setAttribute("currentPage", 1);
        } else {
            // neu phan trang
            try{
                page = Integer.parseInt(Page);
                listCourse = cDAO.getCourse(search, cateID, arrange,numCoursePage*page-numCoursePage,numCoursePage);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
            request.setAttribute("currentPage", page);
        }
        // lay num page
        int pageNum = cDAO.getCourse( search, cateID, arrange,-1,0).size() / numCoursePage;
        if (cDAO.getCourse( search, cateID, arrange,-1,0).size() % numCoursePage != 0) {
            pageNum += 1;
        }
        request.setAttribute("pageNum", pageNum);
        // chuyen ve courseDetail
        ArrayList<CourseDetailDTO> listFinal = new ArrayList<>();
        for(Course c: listCourse){
            PriceCourse p = pcDAO.getById(pcDAO.lowestSalePrice(c.getCourseId())) ;
            CourseDetailDTO cd = new CourseDetailDTO();
            cd.setCourse(c);
            cd.setOriginalPrice(p.getPrice());
            cd.setRating(rvDAO.getRatingOfCourse(c.getCourseId()));
            cd.setTotalEnrollment(emDAO.totalEnrollment(c.getCourseId()));
            cd.setLowestSalePrice(p.getSalePrice());
            listFinal.add(cd) ;
        }
        request.setAttribute("listCourse",listFinal);
        ArrayList<CourseDetailDTO> listRecentDTO = listFinal;
        Collections.sort(listRecentDTO, new Comparator<CourseDetailDTO>() {
            @Override
            public int compare(CourseDetailDTO cd1, CourseDetailDTO cd2) {
                return cd2.getCourse().getCreateDate().compareTo(cd1.getCourse().getCreateDate());
            }
        });
        ArrayList<CourseDetailDTO> listRecent = new ArrayList<>();
        if(listRecentDTO.size()<3){
            listRecent = listRecentDTO;
        }else{
            for(int i=0 ;i<3 ;i++){
                listRecent.add(listRecentDTO.get(i)) ;
            }
        }
        request.setAttribute("listRecent",listRecent);
        CourseTypeDAO ctDAO = new CourseTypeDAO();
        ArrayList<CourseType> listCourseType = ctDAO.getAll();
        request.setAttribute("listCourseType",listCourseType);
        ArrayList<Course> listRatingCourse = cDAO.getCourse(null,0,"rating",0,6) ;
        request.setAttribute("listRatingCourse",listRatingCourse);
        ArrayList<Slider> listSlider = sDAO.getAll();
        request.setAttribute("listSlider",listSlider);
        request.setAttribute("search", search);
        request.setAttribute("cate", category);
        request.setAttribute("arrange",arrange);
        request.setAttribute("numberOfCourse",numCoursePage);
        request.getRequestDispatcher("ListCourse.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
