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
            connection = getConnection();
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
                c.setLevel(rs.getString("SkillLevel"));
                listCourse.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Error getting all courses: " + e.getMessage());
        } finally {
            closeResources();
        }
        return listCourse;
    }

    public ArrayList<Course> getAllByPage(int start, int numCourse) {
        ArrayList<Course> listCoursePage = new ArrayList<>();
        String sql = "SELECT * FROM Courses \n" +
                "ORDER BY CreatedDate DESC\n" +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, start);
            pre.setInt(2, numCourse);
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
                c.setLevel(rs.getString("SkillLevel"));
                listCoursePage.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Error getting courses by page: " + e.getMessage());
        } finally {
            closeResources();
        }
        return listCoursePage;
    }

    public Course getById(int courseID) {
        String sql = "select * from Courses where CourseID = ?";
        ArrayList<Course> listCourse = new ArrayList<>();
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setObject(1, courseID);
            resultSet = statement.executeQuery();
            CourseTypeDAO ctDAO = new CourseTypeDAO();
            ExpertDAO eDAO = new ExpertDAO();
            while (resultSet.next()) {
                Course c = new Course();
                c.setCourseId(resultSet.getInt("CourseID"));
                c.setCourseName(resultSet.getString("CourseName"));
                c.setDescription(resultSet.getString("Description"));
                c.setCreateDate(resultSet.getDate("CreatedDate"));
                c.setPrice(resultSet.getFloat("Price"));
                c.setTitle(resultSet.getString("title"));
                c.setThumbnail(resultSet.getString("thumbnail"));
                c.setStatus(resultSet.getBoolean("status"));
                c.setCourseType(ctDAO.getByID(resultSet.getInt("course_typeId")));
                c.setExpert(eDAO.getByID(resultSet.getInt("ExpertID")));
                c.setLevel(resultSet.getString("SkillLevel"));
                listCourse.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Error getting course: " + e.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }

    public ArrayList<Course> getCourse(String search, int categoryID, String arrange, int start, int row) {
        ArrayList<Course> listCourse = new ArrayList<>();
        String sql = "SELECT * FROM Courses WHERE 1=1";
        if (search != null && !search.isEmpty()) {
            sql += " AND CourseName LIKE ?";
        }
        if (categoryID > 0) {
            sql += " AND course_typeId = ?";
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
        if (start >= 0) {
            sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        }
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            int index = 1;
            if (search != null && !search.isEmpty()) {
                pre.setString(index++, "%" + search + "%");
            }
            if (categoryID > 0) {
                pre.setInt(index++, categoryID);
            }
            if (start >= 0) {
                pre.setInt(index++, start);
                pre.setInt(index, row);
            }
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
        } catch (SQLException e) {
            System.out.println("Error getting filtered courses: " + e.getMessage());
        } finally {
            closeResources();
        }
        return listCourse;
    }

    public static void main(String[] args) {
        CourseDAO courseDAO = new CourseDAO();
        Course course = courseDAO.getCourseById(1);
        System.out.println(course.getCourseName());
    }

    public Course getCourseById(int courseId) {
        Course course = null;
        String sql = "SELECT * FROM Courses WHERE CourseID = ?";

        try {
            connection = getConnection();
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
                CourseTypeDAO asd = new CourseTypeDAO();
                CourseType courseType = asd.getByID(courseTypeId);
                course.setCourseType(courseType);

                int expertId = rs.getInt("ExpertID");
                ExpertDAO exd = new ExpertDAO();
                Expert expert = exd.getByID(expertId);
                course.setExpert(expert);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving course: " + e.getMessage());
        } finally {
            closeResources();
        }

        return course;
    }

    public List<Course> getCoursesByCourseIds(List<Integer> courseIds) {
        List<Course> courses = new ArrayList<>();
        if (courseIds.isEmpty()) {
            return courses;
        }
        
        String sql = "SELECT * FROM Courses WHERE CourseID IN (" + String.join(",", Collections.nCopies(courseIds.size(), "?")) + ")";

        try {
            connection = getConnection();
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
                CourseTypeDAO asd = new CourseTypeDAO();
                CourseType courseType = asd.getByID(courseTypeId);
                course.setCourseType(courseType);
                course.setDescription(rs.getString("Description"));
                course.setCreateDate(rs.getDate("CreatedDate"));
                course.setPrice(rs.getFloat("Price"));
                course.setTitle(rs.getString("Title"));
                course.setThumbnail(rs.getString("Thumbnail"));
                course.setStatus(rs.getBoolean("Status"));

                int expertId = rs.getInt("ExpertID");
                ExpertDAO exd = new ExpertDAO();
                Expert expert = exd.getByID(expertId);
                course.setExpert(expert);

                courses.add(course);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving courses by IDs: " + e.getMessage());
        } finally {
            closeResources();
        }

        return courses;
    }
    
}
