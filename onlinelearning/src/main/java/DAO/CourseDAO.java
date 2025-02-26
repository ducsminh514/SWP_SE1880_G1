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
            ExpertDAO eDAO = new ExpertDAO() ;
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
                c.setExpert(eDAO.getByID(rs.getInt("ExpertID")));
                listCourse.add(c) ;
            }
            return listCourse;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listCourse;
    }


    public ArrayList<Course> getAllByPage(int start,int numCourse) {
        ArrayList<Course> listCoursePage = new ArrayList<>();
        String sql = "SELECT * FROM Courses \n" +
                "ORDER BY CreatedDate DESC\n" +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1,start);
            pre.setInt(2,numCourse);
            ResultSet rs = pre.executeQuery();
            CourseTypeDAO ctDAO = new CourseTypeDAO();
            ExpertDAO eDAO = new ExpertDAO() ;
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
                c.setExpert(eDAO.getByID(rs.getInt("ExpertID")));
                listCoursePage.add(c) ;
            }
            return listCoursePage;
        } catch (SQLException e) {
            System.out.println("ngu");
        }
        return listCoursePage;
    }

    public Course getById (int courseID){
        ArrayList<Course> list = getAll();
        for(Course c: list){
            if(c.getCourseId() == courseID){
                return c;
            }
        }
        return null;
    }

    public ArrayList<Course> getCourse(String search, int categoryID , String arrange , int start , int row){
        ArrayList<Course> listCourse = new ArrayList<>();
        String sql = "SELECT * FROM Courses WHERE 1=1";
        if(search != null && !search.isEmpty()){
            sql += " AND CourseName LIKE ?" ;
        }
        if(categoryID >0){
            sql += " AND course_typeId = ?" ;
        }
        if (arrange != null && !arrange.isEmpty()) {
            if (arrange.equalsIgnoreCase("rating")) {
                sql += " ORDER BY (SELECT AVG(Rating) from ReviewCourse WHERE ReviewCourse.CourseID = Courses.CourseID) DESC ";
            } else if (arrange.equalsIgnoreCase("date-soon")) {
                sql += " ORDER BY CreatedDate ASC ";
            } else if (arrange.equalsIgnoreCase("date-late")) {
                sql += " ORDER BY CreatedDate DESC ";
            } else {
                sql += " ORDER BY CreatedDate DESC ";
            }
        } else {
            sql += " ORDER BY CreatedDate DESC ";
        }
        if(start>=0){
            sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        }
        try{
            PreparedStatement pre = connection.prepareStatement(sql);
            int index =1 ;
            if(search != null && !search.isEmpty()){
                pre.setString(index++, "%" + search + "%");
            }
            if(categoryID >0){
                pre.setInt(index++,categoryID);
            }
            if(start>=0){
                pre.setInt(index++, start);
                pre.setInt(index , row);
            }
            ResultSet rs = pre.executeQuery();
            CourseTypeDAO ctDAO = new CourseTypeDAO();
            ExpertDAO eDAO = new ExpertDAO() ;
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
                c.setExpert(eDAO.getByID(rs.getInt("ExpertID")));
                listCourse.add(c) ;
            }
            return listCourse ;
        }catch (SQLException e){
            System.out.println(e);
        }
        return null;
    }
}
