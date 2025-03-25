package DAO;

import dal.DBContext;
import Module.QuizzQuestion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Module.Question;
import DAO.QuestionImageDAO;
import Module.QuestionImage;
public class QuizQuesionsDAO extends DBContext implements GenericDAO<QuizzQuestion> {

    @Override
    public List<QuizzQuestion> findAll() {
        List<QuizzQuestion> questions = new ArrayList<>();
        String sql = "SELECT * FROM QuizQuestions";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                questions.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            handleException(e);
        }
        return questions;
    }

    @Override
    public QuizzQuestion getFromResultSet(ResultSet rs) throws SQLException {
        return mapResultSet(rs);
    }

    private QuizzQuestion mapResultSet(ResultSet rs) throws SQLException {
        QuizzQuestion qq = new QuizzQuestion();
        qq.setQuizQuestionId(rs.getInt("QuizQuestionID"));
        qq.setQuestionId(rs.getInt("QuestionID"));
        qq.setSortOrder(rs.getInt("SortOrder"));
        qq.setLessonQuizId(rs.getInt("LessonQuizID"));
        return qq;
    }

    @Override
    public int insert(QuizzQuestion quizzQuestion) {
        String sql = "INSERT INTO QuizQuestions (QuestionID, SortOrder, LessonQuizID) OUTPUT INSERTED.QuizQuestionID VALUES (?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quizzQuestion.getQuestionId());
            st.setInt(2, quizzQuestion.getSortOrder());
            st.setInt(3, quizzQuestion.getLessonQuizId());
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            handleException(e);
        }
        return 0;
    }

    @Override
    public boolean delete(QuizzQuestion quizzQuestion) {
        String sql = "DELETE FROM QuizQuestions WHERE QuizQuestionID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quizzQuestion.getQuizQuestionId());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            handleException(e);
        }
        return false;
    }

    @Override
    public boolean update(QuizzQuestion quizzQuestion) {
        String sql = "UPDATE QuizQuestions SET "
                + "QuestionID = ?, "
                + "SortOrder = ?, "
                + "LessonQuizID = ? "
                + "WHERE QuizQuestionID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, quizzQuestion.getQuestionId());
            st.setInt(2, quizzQuestion.getSortOrder());
            st.setInt(3, quizzQuestion.getLessonQuizId());
            st.setInt(4, quizzQuestion.getQuizQuestionId());
            
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            handleException(e);
        }
        return false;
    }

    // Additional methods
    public List<QuizzQuestion> findByLessonQuiz(int lessonQuizId) {
        List<QuizzQuestion> questions = new ArrayList<>();
        String sql = "SELECT * FROM QuizQuestions WHERE LessonQuizID = ? ORDER BY SortOrder";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, lessonQuizId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    questions.add(mapResultSet(rs));
                }
            }
        } catch (SQLException e) {
            handleException(e);
        }
        return questions;
    }

    public void updateSortOrder(int quizQuestionId, int newSortOrder) {
        String sql = "UPDATE QuizQuestions SET SortOrder = ? WHERE QuizQuestionID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, newSortOrder);
            st.setInt(2, quizQuestionId);
            st.executeUpdate();
        } catch (SQLException e) {
            handleException(e);
        }
    }

    public boolean exists(int lessonQuizId, int questionId) {
        String sql = "SELECT COUNT(*) FROM QuizQuestions WHERE LessonQuizID = ? AND QuestionID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, lessonQuizId);
            st.setInt(2, questionId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            handleException(e);
        }
        return false;
    }

    private void handleException(SQLException e) {
        System.err.println("SQL Error in QuizQuestionsDAO: " + e.getMessage());
        e.printStackTrace();
    }

    public ArrayList<Question>getQuestion(int quizId){
        ArrayList<Question> listQuestion = new ArrayList<>();
        String sql = "SELECT q.*, qq.SortOrder FROM Question q "
                + "JOIN QuizQuestions qq ON q.QuestionId = qq.QuestionId "
                + "WHERE qq.QuizQuestionID = ? "
                ;
        QuestionTypeDAO qtd= new QuestionTypeDAO();
        try{
            QuestionDAO qd= new QuestionDAO();
            QuestionImageDAO qim= new QuestionImageDAO();
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1,quizId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Question c= new Question();
                List<QuestionImage> listImage = new ArrayList<>();
                listImage = qim.getImageByQuestionId(rs.getInt("QuestionID"));
                c.setQuestionId(rs.getInt("QuestionID"));
                c.setContent(rs.getString("Content"));
                c.setMp3(rs.getString("Mp3"));
                c.setQuestionImage(listImage);
                c.setLevel(rs.getInt("Level"));
                c.setMark(rs.getInt("Mark"));
                c.setQuestionType(qtd.getQuestionTypeById(rs.getInt("QuestionTypeId")));
                listQuestion.add(c);

            }
            return listQuestion ;
        }catch (SQLException e){
            System.out.println(e);
            System.out.println("getQuestion");
        }
        return null;
    }
}
