package DAO;

import Module.LessonCompletion;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class for handling LessonCompletion database operations
 */
public class LessonCompletionDAO extends DBContext {
    
    /**
     * Insert a new lesson completion record
     * @param completion The LessonCompletion object to insert
     * @return true if successful, false otherwise
     */
    public boolean insert(LessonCompletion completion) {
        String sql = "INSERT INTO LessonCompletions (LessonID, UserID, CompletionDate) VALUES (?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, completion.getLessonId());
            ps.setInt(2, completion.getUserId());
            ps.setTimestamp(3, new java.sql.Timestamp(completion.getCompletionDate().getTime()));
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error inserting lesson completion: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Check if a lesson has been completed by a user
     * @param lessonId The ID of the lesson
     * @param userId The ID of the user
     * @return true if the lesson has been completed, false otherwise
     */
    public boolean isLessonCompleted(int lessonId, int userId) {
        String sql = "SELECT COUNT(*) FROM LessonCompletions WHERE LessonID = ? AND UserID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ps.setInt(2, userId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.out.println("Error checking lesson completion: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Get all completed lessons for a user
     * @param userId The ID of the user
     * @return List of LessonCompletion records for the user
     */
    public List<LessonCompletion> getCompletedLessons(int userId) {
        List<LessonCompletion> completions = new ArrayList<>();
        String sql = "SELECT * FROM LessonCompletions WHERE UserID = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                LessonCompletion completion = new LessonCompletion();
                completion.setCompletionId(rs.getInt("CompletionID"));
                completion.setLessonId(rs.getInt("LessonID"));
                completion.setUserId(rs.getInt("UserID"));
                completion.setCompletionDate(rs.getTimestamp("CompletionDate"));
                
                completions.add(completion);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving completed lessons: " + e.getMessage());
        }
        
        return completions;
    }
    
    /**
     * Get completion percentage for a course
     * @param courseId The ID of the course
     * @param userId The ID of the user
     * @return Percentage of course completion (0-100)
     */
    public double getCourseCompletionPercentage(int courseId, int userId) {
        String sql = "SELECT " +
                    "(SELECT COUNT(*) FROM LessonCompletions LC " +
                    "JOIN Lessons L ON LC.LessonID = L.LessonID " +
                    "JOIN Subjects S ON L.SubjectID = S.SubjectID " +
                    "WHERE S.CourseID = ? AND LC.UserID = ?) AS CompletedCount, " +
                    "(SELECT COUNT(*) FROM Lessons L " +
                    "JOIN Subjects S ON L.SubjectID = S.SubjectID " +
                    "WHERE S.CourseID = ?) AS TotalCount";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ps.setInt(2, userId);
            ps.setInt(3, courseId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int completedCount = rs.getInt("CompletedCount");
                int totalCount = rs.getInt("TotalCount");
                
                if (totalCount > 0) {
                    return (double) completedCount / totalCount * 100;
                }
            }
            
        } catch (SQLException e) {
            System.out.println("Error calculating course completion percentage: " + e.getMessage());
        }
        
        return 0.0;
    }
} 