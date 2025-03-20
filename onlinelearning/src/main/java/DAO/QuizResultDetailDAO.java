package DAO;

import dal.DBContext;
import Module.QuizResultDetail;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizResultDetailDAO extends DBContext implements GenericDAO<QuizResultDetail> {

    @Override
    public List<QuizResultDetail> findAll() {
        List<QuizResultDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM QuizResultDetail";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                QuizResultDetail detail = getFromResultSet(rs);
                list.add(detail);
            }
        } catch (SQLException ex) {
            System.out.println("Error in findAll: " + ex.getMessage());
            ex.printStackTrace();
        }
        return list;
    }

    @Override
    public QuizResultDetail getFromResultSet(ResultSet rs) throws SQLException {
        QuizResultDetail detail = new QuizResultDetail();
        detail.setQuizResultDetailID(rs.getInt("QuizResultDetailID"));
        detail.setQuizAttendID(rs.getInt("QuizAttendID"));
        detail.setQuestionID(rs.getInt("QuestionID"));

        // Xử lý ChooseOptionID (nullable)
        int chooseOptionID = rs.getInt("ChooseOptionID");
        if (rs.wasNull()) {
            chooseOptionID = 0;
        }
        detail.setChooseOptionID(chooseOptionID);

        // Xử lý IsCorrect (nullable)
        boolean isCorrect = rs.getBoolean("IsCorrect");
        if (rs.wasNull()) {
            isCorrect = false;
        }
        detail.setCorrect(isCorrect);

        detail.setAnswerText(rs.getString("AnswerText"));

        // Xử lý ImageQuizID (nullable)
        int imageQuizID = rs.getInt("ImageQuizID");
        if (rs.wasNull()) {
            imageQuizID = 0;
        }
        detail.setImageQuizID(imageQuizID);

        return detail;
    }

    @Override
    public int insert(QuizResultDetail quizResultDetail) {
        String sql = "INSERT INTO QuizResultDetail (QuizAttendID, QuestionID, ChooseOptionID, IsCorrect, AnswerText, ImageQuizID) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, quizResultDetail.getQuizAttendID());
            ps.setInt(2, quizResultDetail.getQuestionID());
            
            // Nếu ChooseOptionID = 0 (hoặc giá trị mặc định) thì gửi NULL cho DB
            if (quizResultDetail.getChooseOptionID() == 0) {
                ps.setNull(3, Types.INTEGER);
            } else {
                ps.setInt(3, quizResultDetail.getChooseOptionID());
            }
            ps.setBoolean(4, quizResultDetail.isCorrect());
            ps.setString(5, quizResultDetail.getAnswerText());
            
            if (quizResultDetail.getImageQuizID() == 0) {
                ps.setNull(6, Types.INTEGER);
            } else {
                ps.setInt(6, quizResultDetail.getImageQuizID());
            }
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating QuizResultDetail failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()){
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating QuizResultDetail failed, no ID obtained.");
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error inserting QuizResultDetail: " + ex.getMessage());
            ex.printStackTrace();
            return -1;
        }
    }

    @Override
    public boolean delete(QuizResultDetail quizResultDetail) {
        String sql = "DELETE FROM QuizResultDetail WHERE QuizResultDetailID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quizResultDetail.getQuizResultDetailID());
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error deleting QuizResultDetail: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(QuizResultDetail quizResultDetail) {
        String sql = "UPDATE QuizResultDetail SET QuizAttendID = ?, QuestionID = ?, ChooseOptionID = ?, IsCorrect = ?, AnswerText = ?, ImageQuizID = ? " +
                     "WHERE QuizResultDetailID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quizResultDetail.getQuizAttendID());
            ps.setInt(2, quizResultDetail.getQuestionID());
            
            if (quizResultDetail.getChooseOptionID() == 0) {
                ps.setNull(3, Types.INTEGER);
            } else {
                ps.setInt(3, quizResultDetail.getChooseOptionID());
            }
            ps.setBoolean(4, quizResultDetail.isCorrect());
            ps.setString(5, quizResultDetail.getAnswerText());
            
            if (quizResultDetail.getImageQuizID() == 0) {
                ps.setNull(6, Types.INTEGER);
            } else {
                ps.setInt(6, quizResultDetail.getImageQuizID());
            }
            ps.setInt(7, quizResultDetail.getQuizResultDetailID());
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating QuizResultDetail: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }
    
    // Phương thức bổ sung: Tìm kiếm QuizResultDetail theo ID
    public QuizResultDetail findById(int id) {
        String sql = "SELECT * FROM QuizResultDetail WHERE QuizResultDetailID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()){
                if (rs.next()) {
                    return getFromResultSet(rs);
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error finding QuizResultDetail by ID: " + ex.getMessage());
            ex.printStackTrace();
        }
        return null;
    }
}
