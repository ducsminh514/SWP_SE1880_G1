package Controller.ForAdmin;

import DAO.StatisticsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet controller for the Admin Dashboard main page
 * Provides statistics data for the dashboard
 */
@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin-dashboard"})
public class AdminDashboardController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminDashboardController.class.getName());
    private final StatisticsDAO statisticsDAO = new StatisticsDAO();
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

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
        
        LOGGER.log(Level.INFO, "AdminDashboardController doGet invoked");
        
        String action = request.getParameter("action");
        
        if (action == null) {
            // Load the dashboard view with initial statistics
            loadDashboardStats(request, response);
        } else {
            // Handle AJAX requests for specific statistics
            processStatisticsRequest(request, response, action);
        }
    }
    
    /**
     * Load initial statistics for the dashboard
     */
    private void loadDashboardStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            System.out.println("Loading dashboard statistics...");
            
            // Get user statistics
            Map<String, Object> userStats = statisticsDAO.getUserStats();
            LOGGER.log(Level.INFO, "Loaded user statistics: {0}", 
                userStats != null ? "Total users: " + userStats.get("totalUsers") : "null");
            
            // Add sample data if needed
            addSampleDataIfNeeded(userStats);
            
            // Get course enrollment statistics
            Map<String, Integer> courseEnrollmentStats = statisticsDAO.getCourseEnrollmentStats();
            LOGGER.log(Level.INFO, "Loaded course enrollment statistics: {0} courses", 
                courseEnrollmentStats != null ? courseEnrollmentStats.size() : 0);
            
            // Get quiz performance statistics
            Map<String, Object> quizStats = statisticsDAO.getQuizStats();
            LOGGER.log(Level.INFO, "Loaded quiz statistics: {0}", 
                quizStats != null ? "Total quizzes: " + 
                (quizStats.get("quizData") != null ? ((java.util.List<?>)quizStats.get("quizData")).size() : 0) : "null");
            
            // Set attributes for JSP
            request.setAttribute("userStats", userStats);
            request.setAttribute("courseEnrollmentStats", courseEnrollmentStats);
            request.setAttribute("quizStats", quizStats);
            
            // Forward to the dashboard view
            request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error loading dashboard stats: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard statistics");
        }
    }
    
    /**
     * Add sample data for testing if real data is missing or empty
     */
    private void addSampleDataIfNeeded(Map<String, Object> userStats) {
        if (userStats != null) {
            // Add sample user role data if empty
            if (!userStats.containsKey("usersByRole") || 
                ((Map<?,?>)userStats.get("usersByRole")).isEmpty()) {
                
                Map<String, Integer> sampleRoles = new HashMap<>();
                sampleRoles.put("Student", 8);
                sampleRoles.put("Teacher", 3);
                sampleRoles.put("Admin", 1);
                userStats.put("usersByRole", sampleRoles);
                System.out.println("Added sample user role data");
            }
        }
    }
    
    /**
     * Process AJAX requests for specific statistics
     */
    private void processStatisticsRequest(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        
        try {
            System.out.println("Processing statistics request: " + action);
            
            Map<String, Object> jsonData = new HashMap<>();
            
            switch (action) {
                case "userRegistration":
                    String period = request.getParameter("period");
                    if (period == null) {
                        period = "monthly";
                    }
                    
                    LOGGER.log(Level.INFO, "Processing user registration request for period: {0}", period);
                    Map<String, Integer> registrationData = getUserRegistrationByPeriod(period);
                    jsonData.put("data", registrationData);
                    break;
                    
                case "courseEnrollment":
                    Map<String, Integer> courseData = statisticsDAO.getCourseEnrollmentStats();
                    jsonData.put("data", courseData);
                    break;
                    
                case "quizPerformance":
                    Map<String, Object> quizStats = statisticsDAO.getQuizStats();
                    jsonData.put("data", quizStats);
                    break;
                    
                default:
                    jsonData.put("error", "Invalid action specified");
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    break;
            }
            
            sendJsonResponse(response, jsonData);
            
        } catch (Exception e) {
            System.err.println("Error processing statistics request: " + e.getMessage());
            e.printStackTrace();
            
            Map<String, Object> errorData = new HashMap<>();
            errorData.put("error", e.getMessage());
            
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            sendJsonResponse(response, errorData);
        }
    }
    
    private Map<String, Integer> getUserRegistrationByPeriod(String period) {
        try {
            return statisticsDAO.getUserRegistrationsByPeriod(period);
        } catch (Exception e) {
            System.err.println("Error getting user registration by period: " + e.getMessage());
            return generateSampleRegistrationData(period);
        }
    }
    
    private Map<String, Integer> generateSampleRegistrationData(String period) {
        Map<String, Integer> sampleData = new HashMap<>();
        LocalDate now = LocalDate.now();
        
        switch (period) {
            case "daily":
                for (int i = 0; i < 7; i++) {
                    LocalDate date = now.minusDays(i);
                    sampleData.put(date.format(DateTimeFormatter.ISO_LOCAL_DATE), (int) (Math.random() * 5));
                }
                break;
                
            case "weekly":
                for (int i = 0; i < 4; i++) {
                    sampleData.put(now.getYear() + "-Week " + (now.minusWeeks(i).get(
                        java.time.temporal.WeekFields.ISO.weekOfYear())), 
                        (int) (Math.random() * 15 + 5));
                }
                break;
                
            case "yearly":
                for (int i = 0; i < 4; i++) {
                    sampleData.put(String.valueOf(now.getYear() - i), (int) (Math.random() * 100 + 50));
                }
                break;
                
            case "monthly":
            default:
                for (int i = 0; i < 7; i++) {
                    LocalDate date = now.minusMonths(i);
                    sampleData.put(date.format(DateTimeFormatter.ofPattern("yyyy-MM")), 
                        (int) (Math.random() * 20 + 8));
                }
                break;
        }
        
        System.out.println("Generated sample " + period + " registration data");
        return sampleData;
    }
    
    /**
     * Send a JSON response
     */
    private void sendJsonResponse(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String jsonString = gson.toJson(data);
        
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonString);
            out.flush();
        }
    }
} 