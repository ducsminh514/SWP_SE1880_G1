package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.Expert;

public class ExpertDAO extends DBContext {
    public ArrayList<Expert> getAll() {
        String sql = "select * from Experts";
        ArrayList<Expert> listCourseType = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {

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
