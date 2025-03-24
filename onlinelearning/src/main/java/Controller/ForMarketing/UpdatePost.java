package Controller.ForMarketing;

import java.io.*;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collection;
import java.util.UUID;

import DAO.PostContentDAO;
import DAO.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import Module.Post;
import Module.PostContent;
import Module.CategoryBlog;
import jakarta.servlet.http.Part;

@WebServlet(name = "UpdatePost", urlPatterns = {"/updatePost"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 5,
        maxFileSize = 1024 * 1024 * 500,
        maxRequestSize = 1024 * 1024 * 1000
)
public class UpdatePost extends HttpServlet {

    private boolean check;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdatePost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        String statusStr = request.getParameter("status") ;
        boolean status = statusStr != null && statusStr.equals("on");
        Part thumbnailPart = request.getPart("thumbnail");
        String thumbnailFileName = null;
        if (thumbnailPart != null && thumbnailPart.getSize() > 0) {
            thumbnailFileName = saveFile(thumbnailPart, request);
        } else {
            thumbnailFileName = request.getParameter("existingThumbnail");
        }
        PostDAO pDAO = new PostDAO();
        pDAO.update(categoryId, status, title, thumbnailFileName, postId);
        processContentBlocks(request, postId);
        request.getRequestDispatcher("/postDetail?postId=" + postId).forward(request, response);
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
        String[] contentIds = request.getParameterValues("contentId[]");
        String[] oldContents = request.getParameterValues("oldContent[]");
        String[] checkValues = request.getParameterValues("check[]");
        Collection<Part> parts = request.getParts();
        ArrayList<String> listContent = pcDAO.getAllContent(postId);
        if(listContent != null) {
            System.out.println("số content ban đàu " + listContent.size());
        }
        // Duyệt qua từng khối nội dung
        System.out.println("số content lúc sau " + contentTypes.length);
        int imageIndex = 1;
        int videoIndex = 1;
        for (int i = 0; i < contentTypes.length; i++) {
            PostContent postContent = new PostContent();
            postContent.setPost(pDAO.getById(postId));
//            int order =0 ;
//            try{
//                order = Integer.parseInt(orderIndices[i]) ;
//            }catch(NumberFormatException e){
//                System.out.println("loi index: "+e);
//            }
            postContent.setOrderIndex(i);
            postContent.setContentType(contentTypes[i]);
            System.out.println("content Type: " + contentTypes[i]);
            // Nếu là nội dung cũ, gán contentId
            int contentId = 0;
            if (contentIds != null && i < contentIds.length && !contentIds[i].isEmpty()) {
                try {
                    contentId = Integer.parseInt(contentIds[i]);
                    postContent.setContentId(contentId);
                } catch (NumberFormatException e) {
                    System.out.println("loi id: " + e);
                }
            }
            String content = null;
            switch (contentTypes[i]) {
                case "TEXT":
                    content = contents[i];
                    postContent.setContent(content);
                    break;
                case "IMAGE":
                    if (checkValues != null && i < checkValues.length && "change".equals(checkValues[i])) {
                        int idImage = 1;
                        for (Part iPart : parts) {
                            String name = iPart.getName();
                            if (name.startsWith("imageFile[") && name.endsWith("]")) {
                                if (idImage == imageIndex) {
                                    if (iPart.getSize() > 0) {
                                        String imagePath = saveFile(iPart, request);
                                        // Hàm tự định nghĩa để lưu file
                                        postContent.setContent(imagePath);
                                        content = imagePath;
                                        imageIndex++;
                                        break;
                                    }
                                } else {
                                    idImage++;
                                }
                            }
                        }
                    }else{
                        // Giữ ảnh cũ nếu không upload ảnh mới
                        content = oldContents[i];
                        postContent.setContent(content);
                    }
                    postContent.setNote(notes[i]);
                    break;
                case "VIDEO":
                    boolean checkVideo = false;
                    int idVideo = 1;
                    for (Part vPart : parts) {
                        String name = vPart.getName();
                        if (name.startsWith("videoFile[") && name.endsWith("]")) {
                            if (idVideo == videoIndex) {
                                if (vPart.getSize() > 0) {
                                    String videoPath = saveFile(vPart, request);
                                    // Hàm tự định nghĩa để lưu file
                                    postContent.setContent(videoPath);
                                    content = videoPath;
                                    checkVideo = true;
                                    videoIndex++;
                                    break;
                                }
                            } else {
                                idVideo++;
                            }
                        }
                    }
                    if (!checkVideo) {
                        // Giữ ảnh cũ nếu không upload ảnh mới
                        content = oldContents[i];
                        postContent.setContent(content);
                    }
                    postContent.setNote(notes[i]);
                    break;
            }
            System.out.println("content: " + content);
            if(listContent == null){
                pcDAO.insert(postContent);
            } else if (checkExist(listContent, postContent.getContent())) {
                pcDAO.update(postContent);
            } else {
                pcDAO.insert(postContent);
            }
            postContents.add(postContent);
        }
        // check delete
        checkDelete(postContents, listContent);
        ArrayList<String> listFinal = pcDAO.getAllContent(postId);
        System.out.println(listFinal.size());
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

    private boolean checkExist(ArrayList<String> contents, String content) {
        for (String c : contents) {
            if (content.equals(c)) {
                return true;
            }
        }
        return false;
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

        // Tạo luồng đầu ra để sao chép dữ liệu
        File outputFile = new File(uploadPath + File.separator + fileName);
        try (InputStream input = part.getInputStream();
             FileOutputStream output = new FileOutputStream(outputFile)) {

            byte[] buffer = new byte[8192];
            int length;
            while ((length = input.read(buffer)) > 0) {
                output.write(buffer, 0, length);
            }
        }

        // Trả về đường dẫn tương đối đến file
        return UPLOAD_DIRECTORY + "/" + fileName;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
