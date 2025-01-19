/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Module.Course;
import dal.DBContext;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Module.CourseType;
import Module.Expert;

import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Acer
 */
public class CourseDAO extends DBContext {

    public ArrayList<Course> getAll() {
        String sql = "select * from Courses";
        ArrayList<Course> listCourse = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            CourseTypeDAO ctDAO = new CourseTypeDAO();
            ExpertDAO eDAO = new ExpertDAO();
            while (rs.next()) {
                Course c = new Course();
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
                listCourse.add(c);
            }
            return listCourse;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listCourse;
    }

    public ArrayList<Course> getAllStatus1() {
        String sql = "select * from Courses where Status = 1";
        ArrayList<Course> listCourse = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            CourseTypeDAO ctDAO = new CourseTypeDAO();
            ExpertDAO eDAO = new ExpertDAO();
            while (rs.next()) {
                Course c = new Course();
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
                listCourse.add(c);
            }
            return listCourse;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listCourse;
    }

    public ArrayList<Course> getAllStatus2() {
        String sql = "select * from Courses where Status != 1";
        ArrayList<Course> listCourse = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            CourseTypeDAO ctDAO = new CourseTypeDAO();
            ExpertDAO eDAO = new ExpertDAO();
            while (rs.next()) {
                Course c = new Course();
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
                listCourse.add(c);
            }
            return listCourse;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listCourse;
    }

    public void deleteCourse(int courseId) {
        String sql = "delete from Courses where CourseID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseId);
            pre.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Course> searchCoursesByName(String txtSearch, int index, int size) {
        List<Course> list = new ArrayList<>();
        String sql = "WITH x AS (SELECT ROW_NUMBER() OVER (ORDER BY c.CourseID ) AS stt, \n"
                + "                              c.*\n"
                + "                               FROM Courses c\n"
                + "                               \n"
                + "                             WHERE c.CourseName LIKE ? ) \n"
                + "                               SELECT * FROM x WHERE stt BETWEEN ? * 5 - 4 AND ? * 5";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + txtSearch + "%");
            ps.setInt(2, index);
            ps.setInt(3, index);
            ResultSet rs = ps.executeQuery();
            CourseTypeDAO ctDAO = new CourseTypeDAO();
            ExpertDAO eDAO = new ExpertDAO();
            while (rs.next()) {
                Course c = new Course();
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
                list.add(c);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public void addCourse(Course course) {
        String sql = "INSERT INTO Courses (course_typeId, CourseName, Description, CreatedDate, Price, title, thumbnail, ExpertID, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setInt(1, course.getCourseType().getCourseTypeId());
            ps.setString(2, course.getCourseName());
            ps.setString(3, course.getDescription());

            ps.setDate(4, new java.sql.Date(course.getCreateDate().getTime()));
            ps.setFloat(5, course.getPrice());
            ps.setString(6, course.getTitle());
            ps.setString(7, course.getThumbnail());
            ps.setInt(8, course.getExpert().getExpertId());
            ps.setBoolean(9, course.isStatus());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        CourseDAO dao = new CourseDAO();
        List<Course> list = dao.getAllStatus1();
        System.out.println(list);
    }
}
