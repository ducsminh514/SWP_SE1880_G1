package Controller.ForMarketing;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.UUID;

import DAO.CategoryBlogDAO;
import DAO.PostContentDAO;
import DAO.PostDAO;
import Module.CategoryBlog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.CategoryBlog ;
import jakarta.servlet.http.Part;
import Module.Post ;
import Module.PostContent ;
@WebServlet(name="AddNewPost", urlPatterns={"/addNewPost"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 5,
        maxFileSize = 1024 * 1024 * 500,
        maxRequestSize = 1024 * 1024 * 1000
)
public class AddNewPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddNewPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewPost at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        CategoryBlogDAO cbDAO = new CategoryBlogDAO();
        ArrayList<CategoryBlog> listCate = cbDAO.getAll();
        request.setAttribute("categories",listCate);
        request.getRequestDispatcher("Marketing/AddNewPostFile.jsp").forward(request,response);
    }
    private static final String UPLOAD_DIRECTORY = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String title = request.getParameter("title");
        int categoryId = 0 ;
        try{
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        }catch(NumberFormatException e){
            System.out.println(e);
        }
        Part thumbnailPart = request.getPart("thumbnail");
        String thumbnailFileName = null;
        if (thumbnailPart != null && thumbnailPart.getSize() > 0) {
             thumbnailFileName = saveFile(thumbnailPart, request);
        }
        PostDAO pDAO = new PostDAO() ;
        int postId = pDAO.insert(categoryId,1,title,thumbnailFileName);
        if(postId == 0){
            System.out.println("loi postDAO");
        }else {
            processContentBlocks(request,postId );
        }
        request.getRequestDispatcher("postList").forward(request,response);
    }
    private void processContentBlocks(HttpServletRequest request, int postId) throws IOException, ServletException {
        PostDAO pDAO = new PostDAO();
        PostContentDAO pcDAO = new PostContentDAO();
        int blockCount = getBlockCount(request); // Đếm số khối dựa trên contentType

        for (int i = 0; i < blockCount; i++) {
            PostContent postContent = new PostContent();
            postContent.setPost(pDAO.getById(postId));

            // Lấy contentType
            String contentType = request.getParameter("contentType[" + i + "]");
            if (contentType == null) continue;
            postContent.setContentType(contentType);

            // Lấy orderIndex (giả sử bạn đã xử lý trong updateOrderIndices)
            postContent.setOrderIndex(i); // Mặc định là i, hoặc lấy từ request nếu có

            // Lấy note
            String note = request.getParameter("note[" + i + "]");
            if (note != null && !note.isEmpty()) {
                postContent.setNote(note);
            }

            // Xử lý theo loại nội dung
            if ("TEXT".equals(contentType)) {
                String content = request.getParameter("content[" + i + "]");
                if (content != null) {
                    postContent.setContent(content);
                }
            } else if ("IMAGE".equals(contentType)) {
                Part filePart = request.getPart("imageFile[" + i + "]");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = saveFile(filePart, request);
                    postContent.setContent(fileName);
                } else {
                    System.out.println("No image file found for index " + i);
                }
            } else if ("VIDEO".equals(contentType)) {
                Part filePart = request.getPart("videoFile[" + i + "]");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = saveFile(filePart, request);
                    postContent.setContent(fileName);
                } else {
                    System.out.println("No video file found for index " + i);
                }
            }

            // Lưu vào database
            pcDAO.insert(postContent);
        }
    }

    // Đếm số khối dựa trên contentType
    private int getBlockCount(HttpServletRequest request) {
        int count = 0;
        while (request.getParameter("contentType[" + count + "]") != null) {
            count++;
        }
        return count;
    }
    private String saveFile(Part part, HttpServletRequest request) throws IOException {
        // Lấy tên file từ Content-Disposition header
        String submittedFileName = part.getSubmittedFileName();
        String fileExtension = submittedFileName.substring(submittedFileName.lastIndexOf('.'));

        // Tạo tên file duy nhất để tránh trùng lặp
        String fileName = UUID.randomUUID().toString() + fileExtension;

        // Tạo thư mục uploads nếu chưa tồn tại
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Lưu file vào thư mục uploads
        part.write(uploadPath + File.separator + fileName);

        // Trả về đường dẫn tương đối đến file
        return UPLOAD_DIRECTORY + "/" + fileName;
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

