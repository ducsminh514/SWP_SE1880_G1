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
    private static final String SELECT_ALL_LESSONS = "SELECT * FROM Lessons WHERE PackageID = ?";
    private static final String UPDATE_LESSON_STATUS = "UPDATE Lessons SET status_lesson = ? WHERE LessonID = ?";
    private final String ACTIVE_STATUS = "1";
    private final String INACTIVE_STATUS = "2";
    

    public List<Lesson> getLessonsByPackage(int packageID) {
        List<Lesson> lessons = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_LESSONS)) {
            preparedStatement.setInt(1, packageID);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                lessons.add(new Lesson(rs.getInt("LessonID"), rs.getInt("PackageID"), rs.getString("LessonName"), rs.getBoolean("status_lesson")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lessons;
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
}
