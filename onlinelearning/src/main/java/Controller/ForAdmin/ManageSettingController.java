package Controller.ForAdmin;

import DAO.SettingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import Module.Setting;

@WebServlet(name = "ManageSettingController", urlPatterns = {"/manage-setting"})
public class ManageSettingController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            SearchByFilter(request, response);
        } else {
            switch (action) {
                case "edit":
                    EditSettingForm(request, response);
                    break;
                case "add":
                    request.getRequestDispatcher("admin/add-setting.jsp").forward(request, response);
                    break;
                case "deactive":
                    DeactiveSetting(request, response);
                    break;
                default:
                    SearchByFilter(request, response);
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
        } else {
            switch (action) {
                case "update":
                    UpdateSetting(request, response);
                    break;
                case "deactive":
                    DeactiveSetting(request, response);
                    break;
                case "addNewSetting":
                    AddSetting(request, response);
                    break;
                default:
                    SearchByFilter(request, response);
                    break;
            }
        }

    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }


    private void SearchByFilter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String typeFilter = request.getParameter("type");
        String statusFilter = request.getParameter("status");
        String searchFilter = request.getParameter("search");


        // set pagnition
        int page = 1;
        int pageSize = 3;
        String pageStr = request.getParameter(("page"));
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1)
                    page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        SettingDAO settingDAO = new SettingDAO();
        List<Setting> settingList = settingDAO.findSettingWithFilter(typeFilter, statusFilter, searchFilter, page, pageSize);
        int totalSettings = settingDAO.getTotalSettingByFilter(typeFilter, statusFilter, searchFilter);
        int totalPage = (int) Math.ceil((double) totalSettings / pageSize);

        request.setAttribute("totalPage", totalPage);
//        request.setAttribute("totalSettings", totalSettings);
        request.setAttribute("settingList", settingList);
        request.setAttribute("currentPage", page);

        request.setAttribute("searchFilter", searchFilter);
        request.setAttribute("typeFilter", typeFilter);
        request.setAttribute("statusFilter", statusFilter);

        request.getRequestDispatcher("/admin/manage-setting.jsp").forward(request, response);
    }

    private void EditSettingForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String settingId = request.getParameter("settingId");
        int id = Integer.parseInt(settingId);
        SettingDAO settingDAO = new SettingDAO();
        Setting setting = settingDAO.getSettingById(settingId);
        if (setting != null) {
            request.setAttribute("setting", setting);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            String currentTime = LocalDateTime.now().format(formatter);
            request.setAttribute("currentTime", currentTime);
            request.getRequestDispatcher("admin/edit-setting.jsp").forward(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/manage-setting");
    }

    private void DeactiveSetting(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String settingId = request.getParameter("id");
        if (settingId != null && !settingId.isEmpty()) {
            try {
                SettingDAO settingDAO = new SettingDAO();
                Setting setting = settingDAO.getSettingById(settingId);

                if (setting != null && setting.getSettingId() > 0) {
                    boolean rs = settingDAO.delete(setting);
                    if (rs) {
                        setToastMessage(request, "Setting deactivated successfully", "success");
                    } else {
                        setToastMessage(request, "Failed to deactivate setting", "error");
                    }
                } else {
                    setToastMessage(request, "Setting not found", "error");
                }
            } catch (Exception e) {
                setToastMessage(request, "Error: " + e.getMessage(), "error");
            }
        } else {
            setToastMessage(request, "Setting ID is required", "error");
        }
        response.sendRedirect(request.getContextPath() + "/manage-setting");
    }

    private void UpdateSetting(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String settingId = request.getParameter("settingId");
        String type = request.getParameter("type");
        String value = request.getParameter("value");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String order = request.getParameter("order");
        String createdAt = request.getParameter("createdAt");
        String updatedAt = request.getParameter("updatedAt");

        Setting setting = new Setting();
        setting.setSettingId(Integer.parseInt(settingId));
        setting.setType(type);
        setting.setValue(value);
        setting.setDescription(description);
        setting.setStatus(Boolean.parseBoolean(status));
        setting.setOrder(Integer.parseInt(order));
        setting.setCreatedAt(createdAt);
        setting.setUpdatedAt(updatedAt);
        SettingDAO settingDAO = new SettingDAO();
        boolean rs = settingDAO.update(setting);
        if (rs) {
            setToastMessage(request, "Setting updated successfully", "success");
            response.sendRedirect(request.getContextPath() + "/manage-setting?action=edit&settingId=" + settingId);
        } else {
            setToastMessage(request, "Failed to update setting", "error");
            request.setAttribute("setting", setting);
            request.getRequestDispatcher("/admin/edit-account.jsp").forward(request, response);
        }

    }

    private void setToastMessage(HttpServletRequest request, String message, String type) {
        request.getSession().setAttribute("toastMessage", message);
        request.getSession().setAttribute("toastType", type);
    }


    private void AddSetting(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String value = request.getParameter("value");
        String description = request.getParameter("description");
        String orderStr = request.getParameter("order");
        String statusStr = request.getParameter("status");
        // Validate the input
        if (type == null || value == null || description == null || orderStr == null || statusStr == null) {
            setToastMessage(request, "Tất cả các trường phải được điền đầy đủ!", "error");
            request.getRequestDispatcher("/admin/add-setting.jsp").forward(request, response);
            return;
        }
        int order = -1;
        boolean status = false;
        try {
            order = Integer.parseInt(orderStr);
            status = Boolean.parseBoolean(statusStr);
        } catch (NumberFormatException e) {
            setToastMessage(request, "Lỗi định dạng số, vui lòng kiểm tra lại!", "error");
            request.getRequestDispatcher("/admin/add-setting.jsp").forward(request, response);
            return;
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String currentTime = LocalDateTime.now().format(formatter);  // Đảm bảo định dạng giờ là "yyyy-MM-dd HH:mm:ss"
        String createdAt = currentTime;
        String updatedAt = currentTime;

        Setting setting = new Setting();
        setting.setType(type);
        setting.setValue(value);
        setting.setDescription(description);
        setting.setOrder(order);
        setting.setStatus(status);
        setting.setCreatedAt(createdAt);
        setting.setUpdatedAt(updatedAt);

        SettingDAO settingDAO = new SettingDAO();
        int rs = settingDAO.insert(setting);

        if (rs > 0) {
            setToastMessage(request, "Thêm setting thành công", "success");
        } else {
            setToastMessage(request, "Thêm setting không thành công", "error");
        }
        // Redirect to manage settings page
        response.sendRedirect(request.getContextPath() + "/manage-setting");
    }
}
