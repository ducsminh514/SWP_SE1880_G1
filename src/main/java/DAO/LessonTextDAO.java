package DAO;

import Module.LessonText;
import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO class for handling LessonText database operations
 */
public class LessonTextDAO extends DBContext {
    
    /**
     * Retrieves text content for a specific lesson
     * @param lessonId The ID of the lesson
     * @return LessonText object containing the text content
     */
    public LessonText getLessonTextByLessonId(int lessonId) {
        LessonText lessonText = null;
        String sql = "SELECT * FROM LessonText WHERE lessonId = ?";
        
        try {
            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                lessonText = new LessonText();
                lessonText.setLessonId(rs.getInt("lessonId"));
                lessonText.setContent(rs.getString("content"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving lesson text: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return lessonText;
    }
    

} 