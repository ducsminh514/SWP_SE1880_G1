package DAO;

import dal.DBContext;
import Module.QuestionType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.function.Predicate;

public class QuestionTypeDAO extends DBContext implements GenericDAO<QuestionType> {

    @Override
    public List<QuestionType> findAll() {
        return List.of();
    }

    @Override
    public QuestionType getFromResultSet(ResultSet resultSet) throws SQLException {
        QuestionType questionType = new QuestionType();
        questionType.setQuestionTypeId(resultSet.getInt("QuestionTypeId"));
        questionType.setQuestionTypeName(resultSet.getString("QuestionTypeName"));
        return questionType;
    }

    @Override
    public int insert(QuestionType questionType) {
        return 0;
    }

    @Override
    public boolean delete(QuestionType questionType) {
        return false;
    }

    @Override
    public boolean update(QuestionType questionType) {
        return false;
    }

    public QuestionType getQuestionTypeById(int id){
        String sql = "select * from QuestionType where QuestionTypeId = ?";
        QuestionType questionType = new QuestionType();

        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                questionType = getFromResultSet(rs);
                return questionType;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
}
