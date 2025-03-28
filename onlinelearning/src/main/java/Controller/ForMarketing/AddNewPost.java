package Controller.ForMarketing;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
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
        } else {
            String existingThumbnail = request.getParameter("existingThumbnail");
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

        // Get arrays of values instead of trying to access indexed parameters
        String[] contentTypes = request.getParameterValues("contentType[]");
        String[] notes = request.getParameterValues("note[]");
        Collection<Part> parts = request.getParts();
        if (contentTypes == null) {
            System.out.println("No content types found");
            return;
        }

        System.out.println("Found " + contentTypes.length + " content blocks to process");
        int imageIndex =1;
        int videoIndex =1 ;
        for (int i = 0; i < contentTypes.length; i++) {
            PostContent postContent = new PostContent();
            postContent.setPost(pDAO.getById(postId));

            // Set content type
            String contentType = contentTypes[i];
            if (contentType == null) continue;
            postContent.setContentType(contentType);

            // Set order index
            postContent.setOrderIndex(i);

            // Set note if available
            if (notes != null && notes.length > i && notes[i] != null && !notes[i].isEmpty()) {
                postContent.setNote(notes[i]);
            }

            // Process based on content type
            if ("TEXT".equals(contentType)) {
                String[] contents = request.getParameterValues("content[]");
                if (contents != null && contents.length > i) {
                    postContent.setContent(contents[i]);
//                    System.out.println(contents[i]);
                }
            } else if ("IMAGE".equals(contentType)) {
                // For files, we might still need to try both naming patterns
//                Part filePart = request.getPart("imageFile[" + i + "]");
//                if (filePart == null || filePart.getSize() == 0) {
//                    // Try alternative naming pattern
//                    filePart = request.getPart("imageFile[]");
//                }
//
//                if (filePart != null && filePart.getSize() > 0) {
//                    String fileName = saveFile(filePart, request);
//                    postContent.setContent(fileName);
//                } else {
//                    System.out.println("No image file found for index " + i);
//                    continue; // Skip this entry if no file
//                }
                int idImage = 1;
                for (Part iPart : parts) {
                    String name = iPart.getName();
                    if (name.startsWith("imageFile[") && name.endsWith("]") ) {
                        System.out.println(name);
                        if(idImage == imageIndex) {
                            if (iPart.getSize() > 0) {
                                String imagePath = saveFile(iPart, request);
                                // Hàm tự định nghĩa để lưu file
                                postContent.setContent(imagePath);
                                imageIndex++;
                                break;
                            }
                        }else{
                            idImage++;
                        }
                    }
                }
            }else if ("VIDEO".equals(contentType)) {
                int idVideo = 1;
                for (Part vPart : parts) {
                    String name = vPart.getName();
                    if (name.startsWith("videoFile[") && name.endsWith("]") ) {
                        System.out.println(name);
                        if(idVideo == videoIndex) {
                            if (vPart.getSize() > 0) {
                                String videoPath = saveFile(vPart, request);
                                // Hàm tự định nghĩa để lưu file
                                postContent.setContent(videoPath);
                                videoIndex++;
                                break;
                            }
                        }else{
                            idVideo++;
                        }
                    }
                }
            }

            // Save to database
            pcDAO.insert(postContent);
            System.out.println("Inserted PostContent with type: " + contentType);
        }
    }
    // Đếm số khối dựa trên contentType
    private int getBlockCount(HttpServletRequest request) {
//        System.out.println("All parameters: ");
        request.getParameterMap().forEach((key, values) -> {
//            System.out.println(key + ": " + Arrays.toString(values));
        });

        String[] contentTypes = request.getParameterValues("contentType[]");
        int count = (contentTypes != null) ? contentTypes.length : 0;
//        System.out.println("Block count: " + count);
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

