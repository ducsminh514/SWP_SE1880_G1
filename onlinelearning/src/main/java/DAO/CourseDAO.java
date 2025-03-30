
package DAO;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import dal.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.TimeUnit;

import Module.*;
import dal.DBContext1;

public class CourseDAO extends DBContext1 {
    private final Cache<String, Object> cache;

    public CourseDAO() {
        // Khởi tạo cache với Caffeine
        cache = Caffeine.newBuilder()
                .expireAfterWrite(20, TimeUnit.MINUTES) // Cache hết hạn sau 10 phút
                .maximumSize(10000) // Giới hạn 1000 mục trong cache
                .build();
    }

    // Hàm tiện ích để tạo key cache từ tên phương thức và tham số
    private String generateCacheKey(String methodName, Object... params) {
        StringBuilder key = new StringBuilder(methodName);
        for (Object param : params) {
            key.append("_").append(param != null ? param.toString() : "null");
        }
        return key.toString();
    }

    public ArrayList<Course> getAll() {
        String cacheKey = generateCacheKey("getAll");
        @SuppressWarnings("unchecked")
        ArrayList<Course> cachedResult = (ArrayList<Course>) cache.getIfPresent(cacheKey);
        if (cachedResult != null) {
            return cachedResult;
        }
        String sql = "select * from Courses";
        ArrayList<Course> listCourse = new ArrayList<>();
        try (Connection connection = DBContext1.getConnection()) {
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
                c.setLevel(rs.getString("SkillLevel"));
                listCourse.add(c) ;
            }
            cache.put(cacheKey, listCourse);
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

        try (Connection connection = DBContext1.getConnection()) {
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
                c.setLevel(rs.getString("SkillLevel"));
                listCoursePage.add(c) ;
            }
            return listCoursePage;
        } catch (SQLException e) {
            System.out.println("ngu");
        }
        return listCoursePage;
    }

    public Course getById (int courseID){
        String sql = "select * from Courses where CourseID =?";
        try (Connection connection = DBContext1.getConnection()) {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseID);
            ResultSet rs = pre.executeQuery();
            CourseTypeDAO ctDAO = new CourseTypeDAO();
            ExpertDAO eDAO = new ExpertDAO();
            Course c = new Course();
            if (rs.next()) {
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
            }
            return c;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Course> getCourse(String search, int categoryID , String arrange , int start , int row){
        String cacheKey = generateCacheKey("getCourse", search, categoryID, arrange, start, row);
        @SuppressWarnings("unchecked")
        ArrayList<Course> cachedResult = (ArrayList<Course>) cache.getIfPresent(cacheKey);
        if (cachedResult != null) {
            return cachedResult;
        }
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
        try (Connection connection = DBContext1.getConnection()) {
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
            cache.put(cacheKey, listCourse); // Lưu vào cache
            return listCourse ;
        }catch (SQLException e){
            System.out.println(e);
        }
        return null;
    }
    public Course getCourseById(int courseId) {
        Course course = null;
        String sql = "SELECT * FROM Courses WHERE CourseID = ?";

        try (Connection connection = DBContext1.getConnection()) {
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

        try (Connection connection = DBContext1.getConnection()) {
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
            System.err.println("ngu1");
        }

        return courses;
    }
}
