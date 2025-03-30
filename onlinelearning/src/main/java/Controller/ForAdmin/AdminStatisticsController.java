package Controller.ForAdmin;

import DAO.StatisticsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AdminStatisticsController", urlPatterns = {"/admin-statistics"})
public class AdminStatisticsController extends HttpServlet {

    /**
     * Handles the HTTP GET request
     * 
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            // Load the dashboard view with initial statistics
            loadDashboardStats(request, response);
        } else {
            // Handle AJAX requests for specific statistics
            processStatisticsRequest(action, request, response);
        }
    }
    
    /**
     * Load initial statistics for the dashboard
     */
    private void loadDashboardStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        StatisticsDAO statsDAO = new StatisticsDAO();
        
        // Get user statistics
        Map<String, Object> userStats = statsDAO.getUserStats();
        request.setAttribute("userStats", userStats);
        
        // Get course enrollment statistics
        Map<String, Integer> courseEnrollmentStats = statsDAO.getCourseEnrollmentStats();
        request.setAttribute("courseEnrollmentStats", courseEnrollmentStats);
        
        // Get quiz performance statistics
        Map<String, Object> quizStats = statsDAO.getQuizStats();
        request.setAttribute("quizStats", quizStats);
        
        // Forward to the dashboard view
        request.getRequestDispatcher("/admin/statistics-dashboard.jsp").forward(request, response);
    }
    
    /**
     * Process AJAX requests for specific statistics
     */
    private void processStatisticsRequest(String action, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        StatisticsDAO statsDAO = new StatisticsDAO();
        Map<String, Object> result = new HashMap<>();
        
        try {
            switch (action) {
                case "userRegistration":
                    String period = request.getParameter("period");
                    if (period == null || period.isEmpty()) {
                        period = "monthly";
                    }
                    
                    Map<String, Integer> registrationData = statsDAO.getUserRegistrationsByPeriod(period);
                    result.put("data", registrationData);
                    break;
                    
                case "courseEnrollment":
                    Map<String, Integer> enrollmentStats = statsDAO.getCourseEnrollmentStats();
                    result.put("data", enrollmentStats);
                    break;
                    
                case "quizPerformance":
                    Map<String, Object> quizStats = statsDAO.getQuizStats();
                    result.put("data", quizStats);
                    break;
                    
                default:
                    result.put("error", "Invalid action requested");
            }
            
            // Send the JSON response
            sendJsonResponse(response, result);
            
        } catch (Exception e) {
            result.put("error", e.getMessage());
            sendJsonResponse(response, result);
        }
    }
    
    /**
     * Send a JSON response
     */
    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> data) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        out.print(convertToJson(data));
        out.flush();
    }
    
    /**
     * Convert a Map to JSON string
     */
    private String convertToJson(Map<String, Object> data) {
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        
        boolean first = true;
        for (Map.Entry<String, Object> entry : data.entrySet()) {
            if (!first) {
                sb.append(",");
            }
            first = false;
            
            sb.append(String.format("\"%s\":", entry.getKey()));
            
            Object value = entry.getValue();
            if (value instanceof String) {
                sb.append(String.format("\"%s\"", escapeJson((String) value)));
            } else if (value instanceof Number) {
                sb.append(value);
            } else if (value instanceof Boolean) {
                sb.append(value);
            } else if (value instanceof Map) {
                sb.append(convertMapToJson((Map<String, Object>) value));
            } else if (value instanceof Iterable) {
                sb.append(convertListToJson((Iterable<Object>) value));
            } else if (value == null) {
                sb.append("null");
            } else {
                sb.append(String.format("\"%s\"", escapeJson(value.toString())));
            }
        }
        
        sb.append("}");
        return sb.toString();
    }
    
    /**
     * Convert a Map to JSON string
     */
    private String convertMapToJson(Map<String, Object> map) {
        if (map == null || map.isEmpty()) {
            return "{}";
        }
        
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        
        boolean first = true;
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            if (!first) {
                sb.append(",");
            }
            first = false;
            
            sb.append(String.format("\"%s\":", entry.getKey()));
            
            Object value = entry.getValue();
            if (value instanceof String) {
                sb.append(String.format("\"%s\"", escapeJson((String) value)));
            } else if (value instanceof Number) {
                sb.append(value);
            } else if (value instanceof Boolean) {
                sb.append(value);
            } else if (value instanceof Map) {
                sb.append(convertMapToJson((Map<String, Object>) value));
            } else if (value instanceof Iterable) {
                sb.append(convertListToJson((Iterable<Object>) value));
            } else if (value == null) {
                sb.append("null");
            } else {
                sb.append(String.format("\"%s\"", escapeJson(value.toString())));
            }
        }
        
        sb.append("}");
        return sb.toString();
    }
    
    /**
     * Convert a List to JSON string
     */
    private String convertListToJson(Iterable<Object> list) {
        if (list == null) {
            return "[]";
        }
        
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        
        boolean first = true;
        for (Object item : list) {
            if (!first) {
                sb.append(",");
            }
            first = false;
            
            if (item instanceof String) {
                sb.append(String.format("\"%s\"", escapeJson((String) item)));
            } else if (item instanceof Number) {
                sb.append(item);
            } else if (item instanceof Boolean) {
                sb.append(item);
            } else if (item instanceof Map) {
                sb.append(convertMapToJson((Map<String, Object>) item));
            } else if (item instanceof Iterable) {
                sb.append(convertListToJson((Iterable<Object>) item));
            } else if (item == null) {
                sb.append("null");
            } else {
                sb.append(String.format("\"%s\"", escapeJson(item.toString())));
            }
        }
        
        sb.append("]");
        return sb.toString();
    }
    
    /**
     * Escape special characters in JSON string
     */
    private String escapeJson(String input) {
        if (input == null) {
            return "";
        }
        
        StringBuilder sb = new StringBuilder();
        for (char c : input.toCharArray()) {
            switch (c) {
                case '"':
                    sb.append("\\\"");
                    break;
                case '\\':
                    sb.append("\\\\");
                    break;
                case '/':
                    sb.append("\\/");
                    break;
                case '\b':
                    sb.append("\\b");
                    break;
                case '\f':
                    sb.append("\\f");
                    break;
                case '\n':
                    sb.append("\\n");
                    break;
                case '\r':
                    sb.append("\\r");
                    break;
                case '\t':
                    sb.append("\\t");
                    break;
                default:
                    sb.append(c);
            }
        }
        
        return sb.toString();
    }
} 