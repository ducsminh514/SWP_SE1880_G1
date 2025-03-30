package DAO;

import Module.LessonVideo;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO class for handling LessonVideo database operations
 */
public class LessonVideoDAO extends DBContext {
    
    /**
     * Retrieves video content for a specific lesson
     * @param lessonId The ID of the lesson
     * @return LessonVideo object containing the video information
     */
    public LessonVideo getLessonVideoByLessonId(int lessonId) {
        LessonVideo lessonVideo = null;
        String sql = "SELECT * FROM LessonVideo WHERE lessonId = ?";
        
        try {
            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                lessonVideo = new LessonVideo();
                lessonVideo.setLessonId(rs.getInt("lessonId"));
                lessonVideo.setVideoUrl(rs.getString("videoUrl"));
                lessonVideo.setVideoDuration(rs.getInt("videoDuration"));
                lessonVideo.setTranscript(rs.getString("transcript"));
                lessonVideo.setDownloadAllowed(rs.getBoolean("downloadAllowed"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving lesson video: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return lessonVideo;
    }
    
   
} 