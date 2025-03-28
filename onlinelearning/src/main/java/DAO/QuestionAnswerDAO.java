package DAO;

import dal.DBContext;
import Module.QuestionAnswer;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuestionAnswerDAO extends DBContext implements GenericDAO<QuestionAnswer> {
    @Override
    public List<QuestionAnswer> findAll() {
        return List.of();
    }

    @Override
    public int insert(QuestionAnswer questionAnswer) {
        String sql = "INSERT INTO QuestionAnswer (SortOrder, Content, QuestionID, IsCorrect) "
                   + "VALUES (?, ?, ?, ?)";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setInt(1, questionAnswer.getSortOrder());
            st.setString(2, questionAnswer.getContent());
            st.setInt(3, questionAnswer.getQuestionId());
            st.setBoolean(4, questionAnswer.isCorrect());
            
            int affectedRows = st.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = st.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    @Override
    public boolean delete(QuestionAnswer questionAnswer) {
        return false;
    }

    @Override
    public boolean update(QuestionAnswer questionAnswer) {
        return false;
    }

    @Override
    public QuestionAnswer getFromResultSet(ResultSet resultSet) throws SQLException {
        QuestionAnswer questionAnswer = new QuestionAnswer();
        questionAnswer.setAnswerId(resultSet.getInt("AnswerID"));
        questionAnswer.setSortOrder(resultSet.getInt("SortOrder"));
        questionAnswer.setContent(resultSet.getString("Content"));
        questionAnswer.setQuestionId(resultSet.getInt("QuestionID"));
        questionAnswer.setCorrect(resultSet.getBoolean("IsCorrect"));
        return questionAnswer;
    }

    public List<QuestionAnswer> getAnswerByQuestionId(int questionId){
        String sql  = "SELECT [AnswerID]\n" +
                "      ,[SortOrder]\n" +
                "      ,[Content]\n" +
                "      ,[QuestionID]\n" +
                "      ,[IsCorrect]\n" +
                "  FROM [dbo].[QuestionAnswer]\n" +
                "  WHERE QuestionID = ? ";
        List<QuestionAnswer> questionAnswers = new ArrayList<>();
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, questionId);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                questionAnswers.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
        return questionAnswers;
    }

    public boolean deleteAnswersByQuestionId(int questionId) {
        String sql = "DELETE FROM QuestionAnswer WHERE QuestionID = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, questionId);
            int affectedRows = st.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
        return false;
    }

    public ArrayList<QuestionAnswer> getAnswer(int id) {
        ArrayList<QuestionAnswer> list = new ArrayList<>();
        String sql = "SELECT a.* FROM QuestionAnswer a "
                + "JOIN Question q ON q.QuestionId = a.QuestionId "
                + "JOIN QuizQuestions qq ON qq.QuestionId = q.QuestionId "
                + "WHERE qq.QuizQuestionID = ? "
                + "ORDER BY a.SortOrder ASC";

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            // Set the parameter for QuizQuestionID
            pre.setInt(1, id);

            // Execute the query
            ResultSet rs = pre.executeQuery();

            // Iterate over the result set
            while (rs.next()) {
                QuestionAnswer qa = new QuestionAnswer();
                qa.setCorrect(rs.getBoolean("IsCorrect"));
                qa.setAnswerId(rs.getInt("AnswerID"));
                qa.setSortOrder(rs.getInt("SortOrder"));
                qa.setContent(rs.getString("Content"));
                qa.setQuestionId(rs.getInt("QuestionID"));
                list.add(qa);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching answers: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    public int GetMarkfromQuestion(int id){
        String sql = "select q.Mark from Question q where q.QuestionID=?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                return rs.getInt("Mark");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }
    

}
