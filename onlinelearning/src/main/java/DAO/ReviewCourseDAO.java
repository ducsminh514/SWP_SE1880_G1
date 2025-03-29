package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import Module.ReviewCourse ;
import Module.Course;

public class ReviewCourseDAO extends DBContext {
    public float getRatingOfCourse(int courseId) {
        String sql = "DECLARE @CourseID INT;\n" +
                "SET @CourseID = ?;  -- Gán giá trị của CourseID vào biến\n" +
                "\n" +
                "SELECT AVG(Rating)\n" +
                "FROM ReviewCourse\n" +
                "WHERE CourseID = @CourseID\n" +
                "GROUP BY CourseID;\n";
        float rating = 0;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                rating = rs.getFloat(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return rating;
    }


    public ArrayList<ReviewCourse> getAll() {
        String sql = "select * from ReviewCourse";
        ArrayList<ReviewCourse> listCourseReview = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            CourseDAO courseDAO = new CourseDAO();
            CustomerDAO cDAO = new CustomerDAO();
            while (rs.next()) {
                ReviewCourse r = new ReviewCourse() ;
                r.setReviewCourseId(rs.getInt("ReviewCourseID"));
                r.setCourse(courseDAO.getById(rs.getInt("CourseID")));
                r.setCustomer(cDAO.getByID(rs.getInt("CustomerID")));
                r.setRating(rs.getFloat("Rating"));
                r.setComment(rs.getString("Comment"));
                r.setReviewFeedback(rs.getString("ReviewFeedback"));
                r.setReviewDate(rs.getDate("ReviewDate"));
                r.setStatus(rs.getBoolean("Status"));
                listCourseReview.add(r);
            }
            return listCourseReview;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listCourseReview;
    }

    public HashMap<Course, Float> mapRating() {
        HashMap<Course,Float> map = new HashMap<>();
        ArrayList<Float>  listRating = new ArrayList<>() ;
        CourseDAO cDAO = new CourseDAO();
        ArrayList<Course> listCourse = cDAO.getAll() ;
        for(Course c: listCourse){
            map.put(cDAO.getById(c.getCourseId()),getRatingOfCourse(c.getCourseId()));
        }
        return map ;
    }
}




