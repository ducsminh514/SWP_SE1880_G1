package DAO;

import dal.DBContext;
import Module.CourseType;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CourseTypeDAO extends DBContext {

    public ArrayList<CourseType> getAll() {
        String sql = "select * from Course_Type";
        ArrayList<CourseType> listCourseType = new ArrayList<>();
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                CourseType ct = new CourseType();
                ct.setCourseTypeName(rs.getString("course_typeName"));
                ct.setCourseTypeId(rs.getInt("course_typeId"));
                listCourseType.add(ct);
            }
            return listCourseType;
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return listCourseType;
    }

    public CourseType getByID(int id) {
        String sql = "select * from Course_Type where course_typeId = ?";
        ArrayList<CourseType> listCourseType = new ArrayList<>();
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setObject(1, id);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                CourseType ct = new CourseType();
                ct.setCourseTypeName(resultSet.getString("course_typeName"));
                ct.setCourseTypeId(resultSet.getInt("course_typeId"));
                return ct;
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return null;
    }
    
  
}
