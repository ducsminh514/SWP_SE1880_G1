package DAO;

import dal.DBContext;
import Module.QuestionType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Predicate;

public class QuestionTypeDAO extends DBContext implements GenericDAO<QuestionType> {

    @Override
    public List<QuestionType> findAll() {
        List<QuestionType> questionTypes = new ArrayList<>();
        String sql = "SELECT * FROM QuestionType";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                questionTypes.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
        return questionTypes;
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

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                questionType = getFromResultSet(rs);
                return questionType;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }


    public Map<Integer, QuestionType> getQuestionTypesByIds(List<Integer> questionTypeIds) {
        Map<Integer, QuestionType> questionTypeMap = new HashMap<>();

        if (questionTypeIds == null || questionTypeIds.isEmpty()) {
            return questionTypeMap;
        }

        // Build placeholders for IN clause
        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < questionTypeIds.size(); i++) {
            if (i > 0) placeholders.append(",");
            placeholders.append("?");
        }

        String sql = "SELECT * FROM QuestionType WHERE QuestionTypeId IN (" + placeholders.toString() + ")";

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);

            // Set parameters for the IN clause
            for (int i = 0; i < questionTypeIds.size(); i++) {
                st.setInt(i + 1, questionTypeIds.get(i));
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                QuestionType questionType = getFromResultSet(rs);
                questionTypeMap.put(questionType.getQuestionTypeId(), questionType);
            }
        } catch (SQLException e) {
            System.out.println("Error getting question types by IDs: " + e.getMessage());
        } finally {
            closeResources();
        }

        return questionTypeMap;
    }

}
