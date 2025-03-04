package Controller.ForGuest;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.*;

import DAO.CategoryBlogDAO;
import DAO.PostDAO;
import DAO.ReviewPostDAO;
import Module.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.CategoryBlog ;
@WebServlet(name = "listPost", urlPatterns = {"/listPost"})
public class ListPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet listPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet listPost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PostDAO pDAO = new PostDAO();
        ReviewPostDAO rpDAO = new ReviewPostDAO();
        String arrange = request.getParameter("arrange") ;
        String Page = request.getParameter("page");
        String search = request.getParameter("search") ;
        String category = request.getParameter("cate") ;
        int cateID = 0;
        if (category != null && !category.isEmpty()) {
            try {
                cateID = Integer.parseInt(category);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }
        ArrayList<Post> listPost = new ArrayList<>();
        int page = 0 ;
        if(Page == null || Page.isEmpty()){
            listPost = pDAO.getAllByPage(0, search, cateID, arrange,6);
            request.setAttribute("currentPage", 1);
        }else{
            try{
                page = Integer.parseInt(Page) ;
                listPost = pDAO.getAllByPage(6 * page - 6, search, cateID, arrange,6);
            }catch(NumberFormatException e){
                 System.out.println(e);
            }
            request.setAttribute("currentPage", page);
        }
        int sizePage = pDAO.getAllByPage(-1,search, cateID, arrange,6).size() ;
        int pageNum = sizePage/ 6;
        if (sizePage % 6 != 0) {
            pageNum += 1;
        }
        request.setAttribute("pageNum",pageNum);
        LinkedHashMap<Post,Float> mapRating = new LinkedHashMap<>();
        for (Post p : listPost) {
            mapRating.put(p,rpDAO.getRatingOfPost(p.getPostId())) ;
        }
        CategoryBlogDAO cbDAO = new CategoryBlogDAO();
        ArrayList<CategoryBlog> listCate = cbDAO.getAll() ;
        request.setAttribute("listCategoryBlog",listCate);
        request.setAttribute("mapRating",mapRating);
        ArrayList<Post> listLatest = pDAO.ArrangeByDate();
        request.setAttribute("recentPost",listLatest);
        request.setAttribute("search", search);
        request.setAttribute("cate", category);
        request.setAttribute("arrange",arrange);
        request.getRequestDispatcher("Blog-List.jsp").forward(request,response);
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
