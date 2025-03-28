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
        String imageUrl = resultSet.getString("ImageURL");
        if (imageUrl != null) {
            questionImage.setImageURL(imageUrl);
        }
        questionImage.setQuestionImangeId(resultSet.getInt("QuestionImageID"));
        return questionImage;
    }

    @Override
    public int insert(QuestionImage questionImage) {
        String sql = "INSERT INTO QuestionImages (ImageTitle, ImageURL, QuestionImageID) VALUES (?, ?, ?)";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setString(1, questionImage.getImageTitle());
            st.setString(2, questionImage.getImageURL());
            st.setInt(3, questionImage.getQuestionImangeId());
            
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
    public boolean delete(QuestionImage questionImage) {
        String sql = "DELETE FROM QuestionImages WHERE ImageID = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, questionImage.getImageId());
            int affectedRows = st.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
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
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, questionImageID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                questionImagesList.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
        return questionImagesList;
    }
    
    public List<QuestionImage> getImageByQuestionId(int questionId) {
        String sql = "SELECT [ImageID], [ImageTitle], [ImageURL], [QuestionImageID] " +
                     "FROM [dbo].[QuestionImages] " +
                     "WHERE [QuestionImageID] = ?";
        List<QuestionImage> questionImagesList = new ArrayList<>();
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, questionId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                questionImagesList.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
        return questionImagesList;
    }

    public List<QuestionImage> getImagesByQuestionIds(List<Integer> questionIds) {
        List<QuestionImage> questionImagesList = new ArrayList<>();

        if (questionIds == null || questionIds.isEmpty()) {
            return questionImagesList;
        }

        // Build the query with a variable number of placeholders
        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < questionIds.size(); i++) {
            if (i > 0) placeholders.append(",");
            placeholders.append("?");
        }

        String sql = "SELECT [ImageID], [ImageTitle], [ImageURL], [QuestionImageID] " +
                "FROM [dbo].[QuestionImages] " +
                "WHERE [QuestionImageID] IN (" + placeholders.toString() + ")";

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);

            // Set all the question ID parameters
            for (int i = 0; i < questionIds.size(); i++) {
                st.setInt(i + 1, questionIds.get(i));
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                questionImagesList.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting images by question IDs: " + e.getMessage());
        } finally {
            closeResources();
        }

        return questionImagesList;
    }
  
}
