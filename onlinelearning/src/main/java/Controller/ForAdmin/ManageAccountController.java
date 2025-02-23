package Controller.ForAdmin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import DAO.UserDAO;
import Module.Role;
import Module.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManageAccountController", urlPatterns = {"/manage-account"})
public class ManageAccountController extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println(action);
        if (action == null || action.equals("list")) {
            searchByFilter(request, response);
        } else {
            switch (action) {
                case "edit":
                    editAccForm(request, response);
                    break;
                case "deactive":
                    deactiveAccount(request, response);
                    break;
            }
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "update":
                updateAccount(request, response);
                break;
            default:
                searchByFilter(request, response);
                break;
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }



    private void deactiveAccount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId");
        if (userId != null && !userId.isEmpty()) {
            int id = Integer.parseInt(userId);
            UserDAO userDAO = new UserDAO();
            boolean rs = userDAO.deactiveAccount(id);
            if (rs) {
                setToastMessage(request, "User deactive successfully", "success");
            } else {
                setToastMessage(request, "User deactive failed", "failed");
            }
        } else {
            setToastMessage(request, "Not found user id", "failed");
        }
        response.sendRedirect(request.getContextPath() + "/manage-account");
    }

    private void editAccForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        if (userId != null && !userId.isEmpty()) {
            int id = Integer.parseInt(userId);
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findById(id);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/admin/edit-account.jsp").forward(request, response);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/manage-account");
        }
    }

    private void updateAccount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        int userId = Integer.parseInt(request.getParameter("userId"));
        UserDAO userDAO = new UserDAO();

        User user = userDAO.findById(userId);

        int role = Integer.parseInt(request.getParameter("role"));
        String gender = request.getParameter("gender");
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setGender(gender);
        user.setStatus(status);
        user.setPhoneNumber(phone);
        user.setEmail(email);
        user.setRole(new Role(role));

        System.out.println("Updating user ID: " + userId);
        System.out.println("Role: " + role);
        System.out.println("Gender: " + gender);
        System.out.println("Status: " + status);
        System.out.println("Phone: " + phone);
        System.out.println("Email: " + email);
        boolean rs = userDAO.update(user);
        if (rs) {
            setToastMessage(request, "User updated successfully", "success");
            response.sendRedirect(request.getContextPath() + "/manage-account?action=edit&userId=" + userId);
        } else {
            setToastMessage(request, "Failed to update user", "error");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/edit-account.jsp").forward(request, response);
        }
    }

    private void searchByFilter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");
        String search = request.getParameter("search");
        String role = request.getParameter("role");


        int pageSize = 3;
        String pageStr = request.getParameter("page");
        int page = 1;  // Giá trị mặc định
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;  // Đảm bảo trang ít nhất là 1
            } catch (NumberFormatException e) {
                page = 1;  // Trở về giá trị mặc định nếu chuyển đổi thất bại
            }
        }

        UserDAO userDAO = new UserDAO();
        List<User> userList = userDAO.findUserByFilter(gender, status, role, search, page, pageSize);

        int totalUser = userDAO.getTotalUserByFiler(gender, status, role, search);
        int totalPage = (int) Math.ceil((double) totalUser / pageSize);


        request.setAttribute("role", role);
        request.setAttribute("gender", gender);
        request.setAttribute("status", status);
        request.setAttribute("search", search);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("userList", userList);

        request.getRequestDispatcher("/admin/manage-account.jsp").forward(request, response);

    }

    private void setToastMessage(HttpServletRequest request, String message, String type) {
        request.getSession().setAttribute("toastMessage", message);
        request.getSession().setAttribute("toastType", type);
    }


}

