package Controller.ForMarketing;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.UUID;

import DAO.CategoryBlogDAO;
import DAO.PostContentDAO;
import DAO.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.Post;
import Module.PostContent;
import Module.CategoryBlog;
import jakarta.servlet.http.Part;

@WebServlet(name = "PostDetail", urlPatterns = {"/postDetail"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 5,
        maxFileSize = 1024 * 1024 * 500,
        maxRequestSize = 1024 * 1024 * 1000
)
public class PostDetail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostDetail at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postID = request.getParameter("postId");
        int postId = 0;
        try {
            postId = Integer.parseInt(postID);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
        PostDAO pDAO = new PostDAO();
        Post p = pDAO.getById(postId);
        request.setAttribute("post", p);
        PostContentDAO pcDAO = new PostContentDAO();
        ArrayList<PostContent> listPostContent = pcDAO.getByPostId(p.getPostId());
//        System.out.println(listPostContent.size());
//        for(PostContent pc : listPostContent){
//            System.out.println(pc.getContent());
//        }
        request.setAttribute("listPostContent", listPostContent);
        CategoryBlogDAO cbDAO = new CategoryBlogDAO();
        ArrayList<CategoryBlog> listCate = cbDAO.getAll();
        request.setAttribute("categories", listCate);
        request.getRequestDispatcher("Marketing/Post-Detail.jsp").forward(request, response);
    }

    private static final String UPLOAD_DIRECTORY = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        int postId = 0;
        int categoryId = 0;
        try {
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
            postId = Integer.parseInt(request.getParameter("postId"));
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
        Part thumbnailPart = request.getPart("thumbnail");
        String thumbnailFileName = null;
        if (thumbnailPart != null && thumbnailPart.getSize() > 0) {
            thumbnailFileName = saveFile(thumbnailPart, request);
        } else {
            thumbnailFileName = request.getParameter("existingThumbnail");
        }
        PostDAO pDAO = new PostDAO();
        pDAO.update(categoryId, 1, title, thumbnailFileName, postId);
        processContentBlocks(request, postId);
        request.getRequestDispatcher("postDetail?postId="+ postId).forward(request, response);
    }

    private void processContentBlocks(HttpServletRequest request, int postId) throws IOException, ServletException {
        PostDAO pDAO = new PostDAO();
        PostContentDAO pcDAO = new PostContentDAO();
        // Lấy danh sách các khối nội dung
        ArrayList<PostContent> postContents = new ArrayList<>();
//        String[] contentIds = request.getParameterValues("contentId[]");
        String[] contents = request.getParameterValues("content[]");
        String[] contentTypes = request.getParameterValues("contentType[]");
        String[] notes = request.getParameterValues("note[]");
        String[] orderIndices = request.getParameterValues("orderIndex[]");
        String[] existingImages = request.getParameterValues("existingImage[]");
        String[] existingVideos = request.getParameterValues("existingVideo[]");
        ArrayList<String> listContent = pcDAO.getAllContent(postId) ;
        // Duyệt qua từng khối nội dung
        for (int i = 0; i < contentTypes.length; i++) {
            PostContent postContent = new PostContent();
            postContent.setPost(pDAO.getById(postId));
            postContent.setOrderIndex(Integer.parseInt(orderIndices[i]));
            postContent.setContentType(contentTypes[i]);
//
//            // Nếu là nội dung cũ, gán contentId
//            if (contentIds != null && i < contentIds.length && !contentIds[i].isEmpty()) {
//                try{
//                    int contentId = Integer.parseInt(contentIds[i]) ;
//                    postContent.setContentId(postId);
//                }catch(NumberFormatException e){
//                    System.out.println(e);
//                }
//                postContent.setContentId();
//            }
            String content = null;
            switch (contentTypes[i]) {
                case "TEXT":
                    content = contents[i] ;
                    postContent.setContent(content);
                    break;
                case "IMAGE":
                    Part imagePart = request.getPart("imageFile[" + i + "]");
                    if (imagePart != null && imagePart.getSize() > 0) {
                        // Xử lý upload file ảnh mới
                        String imagePath = saveFile(imagePart, request); // Hàm tự định nghĩa để lưu file
                        postContent.setContent(imagePath);
                        content = imagePath ;
                    } else if (existingImages != null && i < existingImages.length) {
                        // Giữ ảnh cũ nếu không upload ảnh mới
                        content = existingImages[i] ;
                        postContent.setContent(content);
                    }
                    postContent.setNote(notes[i]);
                    break;
                case "VIDEO":
                    Part videoPart = request.getPart("videoFile[" + i + "]");
                    if (videoPart != null && videoPart.getSize() > 0) {
                        // Xử lý upload file video mới
                        String videoPath = saveFile(videoPart, request); // Hàm tự định nghĩa để lưu file
                        postContent.setContent(videoPath);
                        content = videoPath ;
                    } else if (existingVideos != null && i < existingVideos.length) {
                        // Giữ video cũ nếu không upload video mới
                        content = existingVideos[i] ;
                        postContent.setContent(content);
                    }
                    postContent.setNote(notes[i]);
                    break;
            }

            if(checkExist(listContent,content)){
                pcDAO.update(postContent);
            }else{
                pcDAO.insert(postContent);
            }
            postContents.add(postContent);
        }

        // check delete
        checkDelete(postContents,listContent);
    }

    private void checkDelete(ArrayList<PostContent> newContents, ArrayList<String> oldContents) {
        PostContentDAO pcDAO = new PostContentDAO();
        // Duyệt qua tất cả các nội dung cũ
        for (String content : oldContents) {
            boolean found = false;
            // Kiểm tra nếu content trong oldContents có tồn tại trong newContents
            for (PostContent newContent : newContents) {
                if (newContent.getContent().equals(content)) {
                    found = true;
                    break;
                }
            }
            // Nếu không tìm thấy content trong newContents, thực hiện xóa
            if (!found) {
                pcDAO.delete(content);
            }
        }
    }

    private boolean checkExist(ArrayList<String> contents , String content){
        for(String c : contents){
            if(c.equals(content)){
                return true ;
            }
        }
        return false ;
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
