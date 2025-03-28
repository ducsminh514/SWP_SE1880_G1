package DAO;

import dal.DBContext;
import Module.QuizAttend;
import Module.User;
import Module.LessonQuiz;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizAttendDAO extends DBContext implements GenericDAO<QuizAttend> {

    private final UserDAO userDAO = new UserDAO();
    private final LessonQuizDAO lessonQuizDAO = new LessonQuizDAO();

    @Override
    public List<QuizAttend> findAll() {
        List<QuizAttend> attends = new ArrayList<>();
        String sql = "SELECT * FROM QuizAttends";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                attends.add(mapResultSetToAttend(rs));
            }
        } catch (SQLException e) {
            handleException("Error finding all quiz attends", e);
        }
        return attends;
    }

    @Override
    public QuizAttend getFromResultSet(ResultSet rs) throws SQLException {
        return mapResultSetToAttend(rs);
    }

    private QuizAttend mapResultSetToAttend(ResultSet rs) throws SQLException {
        QuizAttend attend = new QuizAttend();
        attend.setQuizAttendID(rs.getInt("QuizAttendID"));

        // Get User from UserDAO
        User user = userDAO.findById(rs.getInt("UserID"));
        attend.setUser(user);

        // Get LessonQuiz from LessonQuizDAO
        LessonQuiz lessonQuiz = lessonQuizDAO.findById(rs.getInt("LessonQuizID"));
        attend.setLessonQuiz(lessonQuiz);

        attend.setScore(rs.getDouble("Score"));
        attend.setPassed(rs.getBoolean("Passed"));
        attend.setStartTime(rs.getTimestamp("StartTime"));
        attend.setEndTime(rs.getTimestamp("EndTime"));
        return attend;
    }

    @Override
    public int insert(QuizAttend attend) {
        String sql = "INSERT INTO QuizAttends (UserID, LessonQuizID, Score, Passed, StartTime, EndTime) "
                + "OUTPUT INSERTED.QuizAttendID VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, attend.getUser().getUserId());
            st.setInt(2, attend.getLessonQuiz().getLessonQuizID());
            st.setDouble(3, attend.getScore());
            st.setBoolean(4, attend.isPassed());
            st.setTimestamp(5, new Timestamp(attend.getStartTime().getTime()));
            st.setTimestamp(6, new Timestamp(attend.getEndTime().getTime()));

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            handleException("Error inserting quiz attend", e);
        }
        return -1;
    }

    @Override
    public boolean update(QuizAttend attend) {
        String sql = "UPDATE QuizAttends SET UserID = ?, LessonQuizID = ?, Score = ?, "
                + "Passed = ?, StartTime = ?, EndTime = ? WHERE QuizAttendID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, attend.getUser().getUserId());
            st.setInt(2, attend.getLessonQuiz().getLessonQuizID());
            st.setDouble(3, attend.getScore());
            st.setBoolean(4, attend.isPassed());
            st.setTimestamp(5, new Timestamp(attend.getStartTime().getTime()));
            st.setTimestamp(6, new Timestamp(attend.getEndTime().getTime()));
            st.setInt(7, attend.getQuizAttendID());

            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            handleException("Error updating quiz attend", e);
        }
        return false;
    }

    @Override
    public boolean delete(QuizAttend attend) {
        String sql = "DELETE FROM QuizAttends WHERE QuizAttendID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, attend.getQuizAttendID());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            handleException("Error deleting quiz attend", e);
        }
        return false;
    }

    // Additional methods
    public QuizAttend findById(int id) {
        String sql = "SELECT * FROM QuizAttends WHERE QuizAttendID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAttend(rs);
                }
            }
        } catch (SQLException e) {
            handleException("Error finding quiz attend by ID", e);
        }
        return null;
    }

    public List<QuizAttend> findByUser(int userId) {
        List<QuizAttend> attends = new ArrayList<>();
        String sql = "SELECT * FROM QuizAttends WHERE UserID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    attends.add(mapResultSetToAttend(rs));
                }
            }
        } catch (SQLException e) {
            handleException("Error finding quiz attends by user", e);
        }
        return attends;
    }

    public List<QuizAttend> findByLessonQuiz(int lessonQuizId) {
        List<QuizAttend> attends = new ArrayList<>();
        String sql = "SELECT * FROM QuizAttends WHERE LessonQuizID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, lessonQuizId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    attends.add(mapResultSetToAttend(rs));
                }
            }
        } catch (SQLException e) {
            handleException("Error finding quiz attends by lesson quiz", e);
        }
        return attends;
    }

    private void handleException(String message, SQLException e) {
        System.err.println(message + ": " + e.getMessage());
        e.printStackTrace();
    }

    public static void main(String[] args) {
        QuizAttendDAO dao = new QuizAttendDAO();

        // Test create
        QuizAttend attend = new QuizAttend();
        attend.setUser(new UserDAO().findById(1)); // Giả sử user ID 1 tồn tại
        attend.setLessonQuiz(new LessonQuizDAO().findById(1)); // Giả sử lesson quiz ID 1 tồn tại
        attend.setScore(85.5);
        attend.setPassed(true);
        attend.setStartTime(new java.util.Date());
        attend.setEndTime(new java.util.Date());

        int newId = dao.insert(attend);
        System.out.println("New attend ID: " + newId);

        // Test find by ID
        QuizAttend found = dao.findById(newId);
        System.out.println("\nFound attend: " + (found != null ? "Success" : "Failed"));

        // Test update
        if(found != null) {
            found.setScore(90.0);
            boolean updateResult = dao.update(found);
            System.out.println("Update result: " + (updateResult ? "Success" : "Failed"));
        }

        // Test delete
        boolean deleteResult = dao.delete(found);
        System.out.println("Delete result: " + (deleteResult ? "Success" : "Failed"));
    }

    public int findQuizAttendIDbyQuizQuestionID(int id){
        String sql = "SELECT qa.QuizAttendID FROM QuizAttend qa JOIN LessonQuiz lq ON qa.LessonQuizID = lq.LessonQuizID JOIN QuizQuestions qq ON lq.LessonQuizID = qq.LessonQuizID WHERE qq.QuizQuestionID =?"
                ;
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1,id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                return rs.getInt("QuizAttendID");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return 0;
    }

    public void updateTotalScore(int quizAttendID, int totalScore) {
        String sql = "UPDATE QuizAttend SET Score = ? WHERE QuizAttendID = ?";
        try  {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, totalScore);  // Cập nhật điểm số
            st.setInt(2, quizAttendID);  // Cập nhật cho QuizAttendID cụ thể
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Gets the list of passed quiz attendances for a specific user and quiz
     */
    public List<QuizAttend> getPassedQuizzesByUser(int userId, int lessonQuizId) {
        List<QuizAttend> attends = new ArrayList<>();
        String sql = "SELECT * FROM QuizAttends WHERE UserID = ? AND LessonQuizID = ? AND Passed = 1";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setInt(2, lessonQuizId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    attends.add(mapResultSetToAttend(rs));
                }
            }
        } catch (SQLException e) {
            handleException("Error finding passed quizzes by user and lesson quiz", e);
        }
        return attends;
    }

    /**
     * Save a new QuizAttend record with direct IDs instead of objects
     */
    public int save(QuizAttend attend) {
        String sql = "INSERT INTO QuizAttends (UserID, LessonQuizID, Score, Passed, StartTime, EndTime) "
                + "OUTPUT INSERTED.QuizAttendID VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            // Get the user ID directly
            int userId = (attend.getUser() != null) ? attend.getUser().getUserId() : 0;
            int lessonQuizId = (attend.getLessonQuiz() != null) ? attend.getLessonQuiz().getLessonQuizID() : 0;

            st.setInt(1, userId);
            st.setInt(2, lessonQuizId);
            st.setDouble(3, attend.getScore());
            st.setBoolean(4, attend.isPassed());
            st.setTimestamp(5, new Timestamp(attend.getStartTime().getTime()));
            st.setTimestamp(6, new Timestamp(attend.getEndTime().getTime()));

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            handleException("Error saving quiz attend", e);
        }
        return -1;
    }
}
