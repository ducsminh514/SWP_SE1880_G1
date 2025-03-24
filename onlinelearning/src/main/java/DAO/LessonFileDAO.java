package DAO;

import Module.LessonFile;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO class for handling LessonFile database operations
 */
public class LessonFileDAO extends DBContext {
    
    /**
     * Retrieves file content for a specific lesson
     * @param lessonId The ID of the lesson
     * @return LessonFile object containing the file information
     */
    public LessonFile getLessonFileByLessonId(int lessonId) {
        LessonFile lessonFile = null;
        String sql = "SELECT * FROM LessonFile WHERE lessonId = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                lessonFile = new LessonFile();
                lessonFile.setLessonId(rs.getInt("lessonId"));
                lessonFile.setFileUrl(rs.getString("fileUrl"));
                lessonFile.setFileType(rs.getString("fileType"));
                lessonFile.setFileSize(rs.getInt("fileSize"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving lesson file: " + e.getMessage());
        }
        
        return lessonFile;
    }
} 