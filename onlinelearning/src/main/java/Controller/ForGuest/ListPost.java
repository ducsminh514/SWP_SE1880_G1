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
        ArrayList<Post> listPost = pDAO.getAll();
        ArrayList<Post> list = new ArrayList<>() ;
        String arrange = request.getParameter("arrange") ;
        String Page = request.getParameter("page");
        String search = request.getParameter("search") ;
        String category = request.getParameter("cate") ;
        if( search!= null){
             for(Post p: listPost){
                 if(p.getTitle().contains(search) || p.getContent().contains(search)){
                     list.add(p);
                 }
             }
        }else if(category != null){
             try{
                 int cateId = Integer.parseInt(category);
                 list = pDAO.getByCategory(cateId);
             }catch(NumberFormatException e){
                 System.out.println(e);
             }
        }else{
            list = listPost ;
        }
        if(arrange == null){
            Collections.sort(list, new Comparator<Post>() {
                @Override
                public int compare(Post p1, Post p2) {
                    return p1.getUpdateDate().compareTo(p2.getUpdateDate());
                }
            });
        }else{
           if(arrange.equalsIgnoreCase("rating")){
               Collections.sort(list, new Comparator<Post>() {
                   @Override
                   public int compare(Post p1, Post p2) {
                       return Float.compare(rpDAO.getRatingOfPost(p2.getPostId()), rpDAO.getRatingOfPost(p1.getPostId()));
                   }
               });
           }else if(arrange.equalsIgnoreCase("date-soon")){
               Collections.sort(list, new Comparator<Post>() {
                   @Override
                   public int compare(Post p1, Post p2) {
                       return p1.getUpdateDate().compareTo(p2.getUpdateDate());
                   }
               });
           }else if(arrange.equalsIgnoreCase("date-late")){
               Collections.sort(list, new Comparator<Post>() {
                   @Override
                   public int compare(Post p1, Post p2) {
                       return p2.getUpdateDate().compareTo(p1.getUpdateDate());
                   }
               });
           }
        }
        ArrayList<Post> listFinal = new ArrayList<>() ;
        int pageNum = list.size()/6;
        if(list.size() % 6!=0){
            pageNum+=1 ;
        }
        int page = 0 ;
        if(Page == null){
            if(list.size()<6){
                 for(Post p : list){
                     listFinal.add(p) ;
                }
            }else{
                for(int i=0 ;i<6 ;i++){
                    listFinal.add(list.get(i)) ;
                }
            }
            request.setAttribute("currentPage", 1);
        }else{
            try{
                page = Integer.parseInt(Page) ;
                for(int i=page*6-6 ; i< page*6 ;i++){
                    listFinal.add(list.get(i)) ;
                }
            }catch(NumberFormatException e){
                 System.out.println(e);
            }
            request.setAttribute("currentPage", page);
        }
        request.setAttribute("pageNum",pageNum);
        LinkedHashMap<Post,Float> mapRating = new LinkedHashMap<>();
        for(Post p : listFinal){
            mapRating.put(p,rpDAO.getRatingOfPost(p.getPostId())) ;
        }
        CategoryBlogDAO cbDAO = new CategoryBlogDAO();
        ArrayList<CategoryBlog> listCate = cbDAO.getAll() ;
        request.setAttribute("listCategoryBlog",listCate);
        request.setAttribute("mapRating",mapRating);
        ArrayList<Post> listLatest = pDAO.ArrangeByDate();
        request.setAttribute("recentPost",listLatest);
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
