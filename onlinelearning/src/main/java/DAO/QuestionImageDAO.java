package DAO;
import Module.QuestionImage;
import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuestionImageDAO extends DBContext implements GenericDAO<QuestionImage> {

    @Override
    public List<QuestionImage> findAll() {
        return List.of();
    }

    @Override
    public QuestionImage getFromResultSet(ResultSet resultSet) throws SQLException {
        QuestionImage questionImage = new QuestionImage();
        questionImage.setImageId(resultSet.getInt("ImageID"));
        questionImage.setImageTitle(resultSet.getString("ImageTitle"));
        questionImage.setQuestionImangeId(resultSet.getInt("QuestionImageID"));
        return questionImage;
    }

    @Override
    public int insert(QuestionImage questionImage) {
        return 0;
    }

    @Override
    public boolean delete(QuestionImage questionImage) {
        return false;
    }

    @Override
    public boolean update(QuestionImage questionImage) {
        return false;
    }

    public List<QuestionImage> getImageByQuestionImage(int questionImageID) {
        String sql = "\n" +
                "SELECT [ImageID]\n" +
                "      ,[ImageTitle]\n" +
                "      ,[QuestionImageID]\n" +
                "  FROM [dbo].[QuestionImages]\n" +
                "  Where [QuestionImageID] = ? " ;
        List<QuestionImage> questionImagesList = new ArrayList<>();
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, questionImageID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                questionImagesList.add(getFromResultSet(rs));
            }
        }
         catch (SQLException e) {
             System.out.println(e.getMessage());
        }
        return questionImagesList;
    }
}
