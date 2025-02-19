package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Module.Enrollment ;
public class EnrollmentDAO extends DBContext {
    public int totalEnrollment (int courseId){
        int total =0 ;
        String sql = "SELECT COUNT(DISTINCT CustomerID ) FROM Enrollments WHERE CourseID = ? GROUP BY CourseID;\n";
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1,courseId);
            Enrollment e = new Enrollment();
            ResultSet rs = pre.executeQuery();
            if(rs.next()){
                total = rs.getInt(1);
            }
        }catch(SQLException e){
            System.out.println(e);
        }
        return total;
    }
}
