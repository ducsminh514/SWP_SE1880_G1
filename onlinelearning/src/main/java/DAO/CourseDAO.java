package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

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

    public ArrayList<Course> getAllByPage(int start) {
        ArrayList<Course> listCoursePage = new ArrayList<>();
        String sql = "SELECT * FROM Courses \n"
                + "ORDER BY CourseID\n"
                + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY;";

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
                listCoursePage.add(c) ;
            }
            return listCoursePage;
        } catch (SQLException e) {
            System.out.println("ngu");
        }
        return listCoursePage;
    }
    public Course getCourseById(int courseId) {
        Course course = null;
        String sql = "SELECT * FROM Courses WHERE CourseID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, courseId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                course = new Course();
                course.setCourseId(rs.getInt("CourseID"));
                course.setCourseName(rs.getString("CourseName"));
                course.setDescription(rs.getString("Description"));
                course.setCreateDate(rs.getDate("CreatedDate"));
                course.setPrice(rs.getFloat("Price"));
                course.setTitle(rs.getString("Title"));
                course.setThumbnail(rs.getString("Thumbnail"));
                course.setStatus(rs.getBoolean("Status"));
                int courseTypeId = rs.getInt("course_typeId");
                CourseTypeDAO asd= new CourseTypeDAO();
                CourseType courseType = asd.getByID(courseTypeId);
                course.setCourseType(courseType);

                int expertId = rs.getInt("ExpertID");
                ExpertDAO exd= new ExpertDAO();
                Expert expert = exd.getByID(expertId);
                course.setExpert(expert);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println("Error retrieving course: " + e);
        }

        return course;
    }
    public List<Course> getCoursesByCourseIds(List<Integer> courseIds) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM Courses WHERE CourseID IN (" + String.join(",", Collections.nCopies(courseIds.size(), "?")) + ")";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            // Thiết lập các giá trị courseId vào câu lệnh SQL
            for (int i = 0; i < courseIds.size(); i++) {
                st.setInt(i + 1, courseIds.get(i));
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                // Lấy thông tin khóa học
                Course course = new Course();
                course.setCourseId(rs.getInt("CourseID"));
                course.setCourseName(rs.getString("CourseName"));
                int courseTypeId = rs.getInt("course_typeId");
                CourseTypeDAO asd= new CourseTypeDAO();
                CourseType courseType = asd.getByID(courseTypeId);
                course.setCourseType(courseType);
                course.setDescription(rs.getString("Description"));
                course.setCreateDate(rs.getDate("CreatedDate"));
                course.setPrice(rs.getFloat("Price"));
                course.setTitle(rs.getString("Title"));
                course.setThumbnail(rs.getString("Thumbnail"));
                course.setStatus(rs.getBoolean("Status"));

                int expertId = rs.getInt("ExpertID");
                ExpertDAO exd= new ExpertDAO();
                Expert expert = exd.getByID(expertId);
                course.setExpert(expert);


                courses.add(course);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println(e);
        }

        return courses;
    }

//    public static void main(String[] args) {
//        EnrollmentDAO ed= new EnrollmentDAO();
//        CourseDAO cd= new CourseDAO();
//        int a = 4;
//        List<Integer> courseIds = ed.getAllCourseIDsByCustomerID(a);
//        List<Course> courses = cd.getCoursesByCourseIds(courseIds);
//        // In ra danh sách CourseIDs cho CustomerID = 4
//        for (Integer courseId : courseIds) {
//            System.out.println(courseId);
//        }
//        for (Course course : courses) {
//            System.out.println("Course ID: " + course.getCourseId() + ", Course Name: " + course.getCourseName());
//            // In thêm các thông tin khác nếu cần
//        }
//    }
}
