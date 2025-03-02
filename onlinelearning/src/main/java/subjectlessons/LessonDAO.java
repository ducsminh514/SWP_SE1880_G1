/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package subjectlessons;
import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Admin
 */
public class LessonDAO extends DBContext{
    private static final String SELECT_ALL_LESSONS = "SELECT * FROM Lessons WHERE SubjectID = ?";
    private static final String UPDATE_LESSON_STATUS = "UPDATE Lessons SET status_lesson = ? WHERE LessonID = ?";
    private static String COUNT_SUBJECT_BYID = "SELECT COUNT(1) as totalSubject FROM Subjects WHERE SubjectID = ?"; 
    private final String ACTIVE_STATUS = "1";
    private final String INACTIVE_STATUS = "2";
    

    public List<Lesson> getLessonsBySubject(int subjectID) {
        List<Lesson> lessons = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_LESSONS)) {
            preparedStatement.setInt(1, subjectID);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                lessons.add(new Lesson(rs.getInt("LessonID"), rs.getInt("SubjectID"), rs.getString("LessonName"), rs.getBoolean("status_lesson")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lessons;
    }
    
    public int countSubjectById(int subjectID) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_SUBJECT_BYID)) {
            preparedStatement.setInt(1, subjectID);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                return rs.getInt("totalSubject");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public boolean updateLessonStatus(int lessonID, String status) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_LESSON_STATUS)) {
            preparedStatement.setBoolean(1, status.equals(ACTIVE_STATUS));
            preparedStatement.setInt(2, lessonID);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean insertLesson(AddLesssonDTO lesson) {
        String sql = "INSERT INTO Lessons (SubjectID, LessonName, Content, Duration, OrderNo, status_lesson, video_url, CreatedDate) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, lesson.getSubjectID());
            stmt.setString(2, lesson.getLessonName());
            stmt.setString(3, lesson.getContent());
            stmt.setInt(4, lesson.getDuration());
            stmt.setInt(5, lesson.getOrderNo());
            stmt.setBoolean(6, lesson.isStatusLesson());
            stmt.setString(7, lesson.getVideoUrl());
            stmt.setTimestamp(8, new Timestamp(lesson.getCreatedDate().getTime()));
            
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
