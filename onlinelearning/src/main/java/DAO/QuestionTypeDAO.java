package DAO;

import dal.DBContext;
import Module.QuestionType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;

public class QuestionTypeDAO extends DBContext implements GenericDAO<QuestionType> {

    @Override
    public List<QuestionType> findAll() {
        List<QuestionType> questionTypes = new ArrayList<>();
        String sql = "SELECT * FROM QuestionType";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                questionTypes.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
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

    public static void main(String[] args) {
        // Giả sử bạn đã thiết lập kết nối với cơ sở dữ liệu


        QuestionTypeDAO questionTypeDao = new QuestionTypeDAO();  // Giả sử bạn đã có lớp QuestionTypeDao

        // Gọi phương thức getQuestionTypeById với id là 1
        QuestionType questionType = questionTypeDao.getQuestionTypeById(1);

        // Kiểm tra kết quả trả về
        if (questionType != null) {
            System.out.println("Question Type ID: " + questionType.getQuestionTypeId());
            System.out.println("Question Type Name: " + questionType.getQuestionTypeName());
        } else {
            System.out.println("Không tìm thấy Question Type với ID 1.");
        }
    }
}
