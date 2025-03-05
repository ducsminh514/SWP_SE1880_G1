package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import Module.Course ;
import Module.PriceCourse ;
public class PriceCourseDAO extends DBContext {
   public int lowestSalePrice (int courseId){
       String sql ="DECLARE @CourseID INT;\n" +
               "SET @CourseID = ?;  \n" +
               "\n" +
               "SELECT PriceID\n" +
               "FROM PriceCourse\n" +
               "WHERE CourseID = @CourseID\n" +
               "AND SalePrice = (SELECT MIN(SalePrice) FROM PriceCourse WHERE CourseID = @CourseID);\n";
        int priceId =0;
       try{
           PreparedStatement pre = connection.prepareStatement(sql) ;
           pre.setInt(1,courseId);
           ResultSet rs = pre.executeQuery();
           if(rs.next()){
               priceId = rs.getInt(1);
           }
       }catch(SQLException e){
           System.out.println(e) ;
       }
       return priceId ;
   }

   public PriceCourse getById(int priceCourseId){
       String sql ="SELECT * FROM PriceCourse where PriceID =?" ;
       ArrayList<PriceCourse> list = new ArrayList<>() ;
       PriceCourse p = new PriceCourse();
       try{
           PreparedStatement pre = connection.prepareStatement(sql) ;
           pre.setInt(1,priceCourseId);
           ResultSet rs = pre.executeQuery();
           CourseDAO cDAO = new CourseDAO() ;
           if(rs.next()){
               p.setCourse(cDAO.getById(rs.getInt("CourseID")));
               p.setPrice(rs.getFloat("Price"));
               p.setPriceCourseName(rs.getString("PriceName"));
               p.setDescription(rs.getString("Description"));
               p.setPriceId(rs.getInt("PriceID"));
               p.setStatus(rs.getBoolean("Status"));
               p.setAccessDuration(rs.getInt("AccessDuration"));
               p.setSalePrice(rs.getFloat("SalePrice"));
           }
       }catch(SQLException e){
           System.out.println(e);
       }
       return p ;
   }
}
