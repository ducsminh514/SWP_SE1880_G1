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
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                questionAnswers.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return questionAnswers;
    }


}
