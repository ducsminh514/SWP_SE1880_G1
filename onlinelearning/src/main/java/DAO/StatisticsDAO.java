package DAO;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * This class provides methods to retrieve statistics data from the database
 * for admin dashboard and reports
 */
public class StatisticsDAO extends DBContext {

    /**
     * Get user statistics including total users, active users, and users by role
     * @return Map containing user statistics
     */
    public Map<String, Object> getUserStats() {
        Map<String, Object> stats = new HashMap<>();
        
        try {
            connection = getConnection();
            
            // Get total users
            String totalQuery = "SELECT COUNT(*) as total FROM Users";
            PreparedStatement st = connection.prepareStatement(totalQuery);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                stats.put("totalUsers", rs.getInt("total"));
            }
            
            // Get active users (logged in within last 30 days)
            String activeQuery = "SELECT COUNT(*) as active FROM Users WHERE CreatedDate >= DATEADD(day, -30, GETDATE())";
            st = connection.prepareStatement(activeQuery);
            rs = st.executeQuery();
            
            if (rs.next()) {
                stats.put("activeUsers", rs.getInt("active"));
            }
            
            // Get users by role
            String roleQuery = "SELECT r.RoleName as role, COUNT(*) as count FROM Users u JOIN Roles r ON u.RoleID = r.RoleID GROUP BY r.RoleName, r.RoleID";
            st = connection.prepareStatement(roleQuery);
            rs = st.executeQuery();
            
            Map<String, Integer> usersByRole = new HashMap<>();
            while (rs.next()) {
                usersByRole.put(rs.getString("role"), rs.getInt("count"));
            }
            stats.put("usersByRole", usersByRole);
            
        } catch (SQLException e) {
            System.out.println("Error getting user stats: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return stats;
    }
    
    /**
     * Get course enrollment statistics
     * @return Map of course names to enrollment counts
     */
    public Map<String, Integer> getCourseEnrollmentStats() {
        Map<String, Integer> stats = new LinkedHashMap<>();
        
        try {
            connection = getConnection();
            
            String query = "SELECT c.CourseName as name, COUNT(e.EnrollmentID) as enrollment_count " +
                          "FROM Courses c LEFT JOIN Enrollments e ON c.CourseID = e.CourseID " +
                          "GROUP BY c.CourseID, c.CourseName " +
                          "ORDER BY enrollment_count DESC";
            
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                stats.put(rs.getString("name"), rs.getInt("enrollment_count"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error getting course enrollment stats: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return stats;
    }
    
    /**
     * Get quiz performance statistics
     * @return Map containing quiz statistics
     */
    public Map<String, Object> getQuizStats() {
        Map<String, Object> stats = new HashMap<>();
        List<Map<String, Object>> quizData = new ArrayList<>();
        
        try {
            connection = getConnection();
            
            // Get total attempts
            String totalAttemptsQuery = "SELECT COUNT(*) as total FROM QuizAttends";
            PreparedStatement st = connection.prepareStatement(totalAttemptsQuery);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                stats.put("totalAttempts", rs.getInt("total"));
            }
            
            // Get quiz-specific data
            String quizQuery = "SELECT lq.LessonQuizID as quiz_id, lq.QuizTitle as title, " +
                              "COUNT(qa.QuizAttendID) as attempts, " +
                              "AVG(qa.Score) as avg_score, " +
                              "SUM(CASE WHEN qa.Passed = 1 THEN 1 ELSE 0 END) as passed, " +
                              "SUM(CASE WHEN qa.Passed = 0 THEN 1 ELSE 0 END) as failed " +
                              "FROM LessonQuiz lq " +
                              "LEFT JOIN QuizAttends qa ON lq.LessonQuizID = qa.LessonQuizID " +
                              "GROUP BY lq.LessonQuizID, lq.QuizTitle " +
                              "ORDER BY attempts DESC";
            
            st = connection.prepareStatement(quizQuery);
            rs = st.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> quiz = new HashMap<>();
                quiz.put("quizId", rs.getInt("quiz_id"));
                quiz.put("title", rs.getString("title"));
                quiz.put("attempts", rs.getInt("attempts"));
                quiz.put("avgScore", rs.getDouble("avg_score"));
                
                int passed = rs.getInt("passed");
                int total = passed + rs.getInt("failed");
                double passRate = total > 0 ? (double) passed / total * 100 : 0;
                quiz.put("passRate", Math.round(passRate * 10) / 10.0); // Round to 1 decimal place
                
                quizData.add(quiz);
            }
            
            stats.put("quizData", quizData);
            
        } catch (SQLException e) {
            System.out.println("Error getting quiz stats: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return stats;
    }
    
    /**
     * Get user registration data by period
     * @param period The period type (daily, weekly, monthly, yearly)
     * @return Map of dates to registration counts
     */
    public Map<String, Integer> getUserRegistrationsByPeriod(String period) {
        Map<String, Integer> registrations = new LinkedHashMap<>();
        String query = "";
        
        try {
            connection = getConnection();
            
            // Set up query based on period
            switch (period.toLowerCase()) {
                case "daily":
                    query = "SELECT CONVERT(VARCHAR(10), CreatedDate, 120) AS period, COUNT(*) AS count " +
                           "FROM Users " +
                           "WHERE CreatedDate >= DATEADD(day, -30, GETDATE()) " +
                           "GROUP BY CONVERT(VARCHAR(10), CreatedDate, 120) " +
                           "ORDER BY period ASC";
                    break;
                    
                case "weekly":
                    query = "SELECT CONCAT(DATEPART(YEAR, CreatedDate), '-Week ', DATEPART(WEEK, CreatedDate)) AS period, " +
                           "COUNT(*) AS count FROM Users " +
                           "WHERE CreatedDate >= DATEADD(week, -12, GETDATE()) " +
                           "GROUP BY DATEPART(YEAR, CreatedDate), DATEPART(WEEK, CreatedDate), " +
                           "CONCAT(DATEPART(YEAR, CreatedDate), '-Week ', DATEPART(WEEK, CreatedDate)) " +
                           "ORDER BY period ASC";
                    break;
                    
                case "yearly":
                    query = "SELECT CONVERT(VARCHAR(4), CreatedDate, 120) AS period, COUNT(*) AS count " +
                           "FROM Users " +
                           "GROUP BY CONVERT(VARCHAR(4), CreatedDate, 120) " +
                           "ORDER BY period ASC";
                    break;
                    
                case "monthly":
                default:
                    query = "SELECT CONVERT(VARCHAR(7), CreatedDate, 120) AS period, COUNT(*) AS count " +
                           "FROM Users " +
                           "WHERE CreatedDate >= DATEADD(month, -12, GETDATE()) " +
                           "GROUP BY CONVERT(VARCHAR(7), CreatedDate, 120) " +
                           "ORDER BY period ASC";
                    break;
            }
            
            PreparedStatement st = connection.prepareStatement(query);
            ResultSet rs = st.executeQuery();
            
            // Fill in the results
            while (rs.next()) {
                registrations.put(rs.getString("period"), rs.getInt("count"));
            }
            
            // Fill in missing periods with zero counts
            fillMissingPeriods(registrations, period);
            
        } catch (SQLException e) {
            System.out.println("Error getting user registrations by period: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return registrations;
    }
    
    /**
     * Helper method to fill in missing periods with zero counts
     */
    private void fillMissingPeriods(Map<String, Integer> data, String periodType) {
        if (data.isEmpty()) {
            // Generate default periods if no data
            LocalDate now = LocalDate.now();
            DateTimeFormatter formatter;
            int limit;
            
            switch (periodType.toLowerCase()) {
                case "daily":
                    formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    limit = 30; // Last 30 days
                    for (int i = limit - 1; i >= 0; i--) {
                        LocalDate date = now.minusDays(i);
                        data.putIfAbsent(date.format(formatter), 0);
                    }
                    break;
                    
                case "weekly":
                    limit = 12; // Last 12 weeks
                    for (int i = limit - 1; i >= 0; i--) {
                        LocalDate date = now.minusWeeks(i);
                        int weekNum = date.get(java.time.temporal.WeekFields.ISO.weekOfYear());
                        String weekKey = date.getYear() + "-Week " + weekNum;
                        data.putIfAbsent(weekKey, 0);
                    }
                    break;
                    
                case "yearly":
                    formatter = DateTimeFormatter.ofPattern("yyyy");
                    limit = 5; // Last 5 years
                    for (int i = limit - 1; i >= 0; i--) {
                        LocalDate date = now.minusYears(i);
                        data.putIfAbsent(date.format(formatter), 0);
                    }
                    break;
                    
                case "monthly":
                default:
                    formatter = DateTimeFormatter.ofPattern("yyyy-MM");
                    limit = 12; // Last 12 months
                    for (int i = limit - 1; i >= 0; i--) {
                        LocalDate date = now.minusMonths(i);
                        data.putIfAbsent(date.format(formatter), 0);
                    }
                    break;
            }
        }
    }
} 