package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Module.*;

public class CourseDAO extends DBContext {
    public ArrayList<Course> getAll() {
        String sql = "select * from Courses";
        ArrayList<Course> listCourse = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            CourseTypeDAO ctDAO = new CourseTypeDAO();
            while (rs.next()) {
                Course c= new Course();
                c.setCourseId(rs.getInt("CourseID"));
                c.setCourseName(rs.getString("CourseName"));
                c.setDescription(rs.getString("Description"));
                c.setCreateDate(rs.getDate("CreatedDate"));
                c.setPrice(rs.getFloat("Price"));
                c.setTitle(rs.getString("title"));
                c.setThumbnail(rs.getString("thumbnail"));
                c.setStatus(rs.getBoolean("status"));
                c.setCourseType(ctDAO.getByID(rs.getInt("course_typeId")));

            }
            return listCourse;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listCourse;
    }
}
