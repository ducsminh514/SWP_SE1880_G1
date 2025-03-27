package DAO;

import dal.DBContext;
import Module.LessonQuiz;
import Module.Lesson;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LessonQuizDAO extends DBContext implements GenericDAO<LessonQuiz> {

    private final LessonDAO lessonDAO = new LessonDAO();

    @Override
    public List<LessonQuiz> findAll() {
        List<LessonQuiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM LessonQuiz";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                quizzes.add(mapResultSetToQuiz(rs));
            }
        } catch (SQLException e) {
            handleException("Error finding all quizzes", e);
        }
        return quizzes;
    }

    @Override
    public LessonQuiz getFromResultSet(ResultSet rs) throws SQLException {
        return mapResultSetToQuiz(rs);
    }

    private LessonQuiz mapResultSetToQuiz(ResultSet rs) throws SQLException {
        LessonQuiz quiz = new LessonQuiz();
        quiz.setLessonQuizID(rs.getInt("LessonQuizID"));
        
        // Get Lesson object using LessonDAO
        Lesson lesson = lessonDAO.findById(rs.getInt("LessonID"));
        quiz.setLesson(lesson);
        
        quiz.setPassPercentage(rs.getInt("PassPercentage"));
        quiz.setTimeLimit(rs.getInt("TimeLimit"));
        quiz.setAttemptAllowed(rs.getInt("AttemptAllowed"));
        quiz.setStatus(rs.getBoolean("Status"));
        quiz.setImageUrl(rs.getString("ImageUrl"));
        quiz.setMp3Url(rs.getString("Mp3Url"));
        return quiz;
    }

    @Override
    public int insert(LessonQuiz quiz) {
        String sql = "INSERT INTO LessonQuiz (LessonID, PassPercentage, TimeLimit, AttemptAllowed, Status, ImageUrl, Mp3Url) "
                   + "OUTPUT INSERTED.LessonQuizID VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quiz.getLesson().getLessonId());
            st.setInt(2, quiz.getPassPercentage());
            st.setInt(3, quiz.getTimeLimit());
            st.setInt(4, quiz.getAttemptAllowed());
            st.setBoolean(5, quiz.isStatus());
            st.setString(6, quiz.getImageUrl());
            st.setString(7, quiz.getMp3Url());

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            handleException("Error inserting quiz", e);
        }
        return -1;
    }

    @Override
    public boolean update(LessonQuiz quiz) {
        String sql = "UPDATE LessonQuiz SET LessonID = ?, PassPercentage = ?, TimeLimit = ?, "
                   + "AttemptAllowed = ?, Status = ?, ImageUrl = ?, Mp3Url = ? "
                   + "WHERE LessonQuizID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quiz.getLesson().getLessonId());
            st.setInt(2, quiz.getPassPercentage());
            st.setInt(3, quiz.getTimeLimit());
            st.setInt(4, quiz.getAttemptAllowed());
            st.setBoolean(5, quiz.isStatus());
            st.setString(6, quiz.getImageUrl());
            st.setString(7, quiz.getMp3Url());
            st.setInt(8, quiz.getLessonQuizID());

            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            handleException("Error updating quiz", e);
        }
        return false;
    }

    @Override
    public boolean delete(LessonQuiz quiz) {
        String sql = "DELETE FROM LessonQuiz WHERE LessonQuizID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quiz.getLessonQuizID());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            handleException("Error deleting quiz", e);
        }
        return false;
    }

    // Additional methods
    public LessonQuiz findById(int quizId) {
        String sql = "SELECT * FROM LessonQuiz WHERE LessonQuizID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quizId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToQuiz(rs);
                }
            }
        } catch (SQLException e) {
            handleException("Error finding quiz by ID", e);
        }
        return null;
    }

    public List<LessonQuiz> findByLessonId(int lessonId) {
        List<LessonQuiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM LessonQuiz WHERE LessonID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, lessonId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    quizzes.add(mapResultSetToQuiz(rs));
                }
            }
        } catch (SQLException e) {
            handleException("Error finding quizzes by lesson", e);
        }
        return quizzes;
    }

    private void handleException(String message, SQLException e) {
        System.err.println(message + ": " + e.getMessage());
        e.printStackTrace();
    }



    public int getQuestionCountByQuizId(int quizId) {
        String sql = "SELECT COUNT(*) AS NumberOfQuestions FROM QuizQuestions WHERE QuizQuestionID = ?";
        int questionCount = 0;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                questionCount = rs.getInt("NumberOfQuestions");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questionCount;
    }

    public LessonQuiz takeLessonQuizByQuizQuestionID(int id){
        String sql = "Select lq.* from LessonQuiz lq Join QuizQuestions qq on qq.LessonQuizID=lq.LessonQuizID where qq.QuizQuestionID=?"
                ;
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            LessonQuiz lessonQuiz= new LessonQuiz();
            if(rs.next()){
                lessonQuiz.setTimeLimit(rs.getInt("TimeLimit"));
                lessonQuiz.setLessonQuizID(rs.getInt("LessonQuizID"));
                lessonQuiz.setImageUrl(rs.getString("ImageUrl"));
                lessonQuiz.setAttemptAllowed(rs.getInt("AttemptAllowed"));
                lessonQuiz.setMp3Url(rs.getString("Mp3Url"));
                return lessonQuiz;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
}
