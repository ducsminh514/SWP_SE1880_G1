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
        }
        return listCourseType;
    }

    public CourseType getByID(int id) {
           ArrayList<CourseType> list = getAll();
           for(CourseType ct : list){
               if(ct.getCourseTypeId() == id){
                   return ct;
               }
           }
           return null;
    }
}
