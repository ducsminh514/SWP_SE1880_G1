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
       String sql = "DECLARE @CourseID INT;\n" +
               "SET @CourseID = ?;\n" +
               "\n" +
               "SELECT TOP 1 PriceID " +
               "FROM PriceCourse " +
               "WHERE CourseID = @CourseID " +
               "ORDER BY SalePrice ASC";

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
       String sql ="DECLARE @PriceID INT;\n" +
               "\n" +
               "SET @PriceID = ?; -- Gán giá trị cho PriceID\n" +
               "\n" +
               "SELECT * FROM PriceCourse WHERE PriceID = @PriceID;\n" ;
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

   public ArrayList<PriceCourse> getByCourse(int courseId){
       String sql = "Select * from PriceCourse where CourseID = ?";
       ArrayList<PriceCourse> listPrice = new ArrayList<>() ;
       try{
           PreparedStatement pre = connection.prepareStatement(sql) ;
           pre.setInt(1,courseId);
           ResultSet rs = pre.executeQuery();
           CourseDAO cDAO = new CourseDAO() ;
           while(rs.next()){
               PriceCourse p = new PriceCourse() ;
               p.setCourse(cDAO.getById(rs.getInt("CourseID")));
               p.setPrice(rs.getFloat("Price"));
               p.setPriceCourseName(rs.getString("PriceName"));
               p.setDescription(rs.getString("Description"));
               p.setPriceId(rs.getInt("PriceID"));
               p.setStatus(rs.getBoolean("Status"));
               p.setAccessDuration(rs.getInt("AccessDuration"));
               p.setSalePrice(rs.getFloat("SalePrice"));
               listPrice.add(p) ;
           }
           return listPrice ;
       }catch(SQLException e){
           System.out.println(e);
       }
       return listPrice ;
   }
}
