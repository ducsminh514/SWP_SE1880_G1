package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import Module.Lesson ;

public class LessonDAO extends DBContext {

    public ArrayList<Lesson> getBySubject(int subjectId){
        String sql = "DECLARE @SubjectID INT; \n" +
                "SET @SubjectID = ?;  \n" +
                "SELECT * \n" +
                "FROM Lessons\n" +
                "WHERE SubjectID = @SubjectID;" ;
        ArrayList<Lesson> list = new ArrayList<>() ;
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1,subjectId);
            ResultSet rs = pre.executeQuery() ;
            while(rs.next()){
                Lesson l = new Lesson() ;
                l.setLessonId(rs.getInt("LessonID"));
                l.setLessonName(rs.getString("LessonName"));
                l.setDuration(rs.getInt("Duration"));
                list.add(l) ;
            }
            return list ;
        }catch(SQLException e){
            System.out.println(e);
        }
        return list ;
    }
//
//    @Override
//    public List<Lesson> findAll() {
//        List<Lesson> lessons = new ArrayList<>();
//        String sql = "SELECT * FROM Lessons";
//        try (PreparedStatement st = connection.prepareStatement(sql);
//             ResultSet rs = st.executeQuery()) {
//            while (rs.next()) {
//                lessons.add(getFromResultSet(rs));
//            }
//        } catch (SQLException ex) {
//            handleException("Error finding all lessons", ex);
//        }
//        return lessons;
//    }
//
//    @Override
//    public Lesson getFromResultSet(ResultSet rs) throws SQLException {
//        Lesson lesson = new Lesson();
//        lesson.setLessonId(rs.getInt("LessonID"));
//        lesson.setSubjectId(rs.getInt("SubjectID"));
//        lesson.setLessonName(rs.getString("LessonName"));
//        lesson.setContent(rs.getString("Content"));
//        lesson.setDuration(rs.getInt("Duration"));
//        lesson.setOrderNo(rs.getInt("OrderNo"));
//        lesson.setStatusLesson(rs.getBoolean("status_lesson"));
//        lesson.setCreatedDate(rs.getDate("CreatedDate"));
//        lesson.setType(rs.getString("Type"));
//        lesson.setUpdateDate(rs.getDate("UpdateDate"));
//        return lesson;
//    }
//
//    @Override
//    public int insert(Lesson lesson) {
//        String sql = "INSERT INTO Lessons (SubjectID, LessonName, Content, Duration, "
//                   + "OrderNo, status_lesson, CreatedDate, Type, UpdateDate) "
//                   + "OUTPUT INSERTED.LessonID VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
//        try (PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, lesson.getSubjectId());
//            st.setString(2, lesson.getLessonName());
//            st.setString(3, lesson.getContent());
//            st.setInt(4, lesson.getDuration());
//            st.setInt(5, lesson.getOrderNo());
//            st.setBoolean(6, lesson.getStatusLesson());
//            st.setDate(7, new java.sql.Date(lesson.getCreatedDate().getTime()));
//            st.setString(8, lesson.getType());
//            st.setDate(9, new java.sql.Date(lesson.getUpdateDate().getTime()));
//
//            try (ResultSet rs = st.executeQuery()) {
//                if (rs.next()) {
//                    return rs.getInt(1);
//                }
//            }
//        } catch (SQLException ex) {
//            handleException("Error inserting lesson", ex);
//        }
//        return -1;
//    }
//
//    @Override
//    public boolean delete(Lesson lesson) {
//        String sql = "DELETE FROM Lessons WHERE LessonID = ?";
//        try (PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, lesson.getLessonId());
//            return st.executeUpdate() > 0;
//        } catch (SQLException ex) {
//            handleException("Error deleting lesson", ex);
//        }
//        return false;
//    }
//
//    @Override
//    public boolean update(Lesson lesson) {
//        String sql = "UPDATE Lessons SET "
//                   + "SubjectID = ?, LessonName = ?, Content = ?, Duration = ?, "
//                   + "OrderNo = ?, status_lesson = ?, CreatedDate = ?, "
//                   + "Type = ?, UpdateDate = ? "
//                   + "WHERE LessonID = ?";
//        try (PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, lesson.getSubjectId());
//            st.setString(2, lesson.getLessonName());
//            st.setString(3, lesson.getContent());
//            st.setInt(4, lesson.getDuration());
//            st.setInt(5, lesson.getOrderNo());
//            st.setBoolean(6, lesson.getStatusLesson());
//            st.setDate(7, new java.sql.Date(lesson.getCreatedDate().getTime()));
//            st.setString(8, lesson.getType());
//            st.setDate(9, new java.sql.Date(lesson.getUpdateDate().getTime()));
//            st.setInt(10, lesson.getLessonId());
//
//            return st.executeUpdate() > 0;
//        } catch (SQLException ex) {
//            handleException("Error updating lesson", ex);
//        }
//        return false;
//    }
//
//    // Additional methods
//    public Lesson findById(int id) {
//        String sql = "SELECT * FROM Lessons WHERE LessonID = ?";
//        try (PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, id);
//            try (ResultSet rs = st.executeQuery()) {
//                if (rs.next()) {
//                    return getFromResultSet(rs);
//                }
//            }
//        } catch (SQLException ex) {
//            handleException("Error finding lesson by ID", ex);
//        }
//        return null;
//    }
//
//    public List<Lesson> findLessonsBySubject(int subjectId, int page, int pageSize) {
//        List<Lesson> lessons = new ArrayList<>();
//        String sql = "SELECT * FROM Lessons WHERE SubjectID = ? "
//                   + "ORDER BY OrderNo OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
//        try (PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, subjectId);
//            st.setInt(2, (page - 1) * pageSize);
//            st.setInt(3, pageSize);
//
//            try (ResultSet rs = st.executeQuery()) {
//                while (rs.next()) {
//                    lessons.add(getFromResultSet(rs));
//                }
//            }
//        } catch (SQLException ex) {
//            handleException("Error finding lessons by subject", ex);
//        }
//        return lessons;
//    }
//
//    public int getTotalLessons() {
//        String sql = "SELECT COUNT(*) FROM Lessons";
//        try (PreparedStatement st = connection.prepareStatement(sql);
//             ResultSet rs = st.executeQuery()) {
//            if (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException ex) {
//            handleException("Error counting lessons", ex);
//        }
//        return 0;
//    }
//
//    private void handleException(String message, SQLException ex) {
//        System.err.println(message + ": " + ex.getMessage());
//        ex.printStackTrace();
//    }
//
//    public static void main(String[] args) {
//        LessonDAO dao = new LessonDAO();
//
//        // Test create new lesson
//        Lesson newLesson = new Lesson();
//        newLesson.setSubjectId(1);
//        newLesson.setLessonName("Bài học test");
//        newLesson.setContent("Nội dung test");
//        newLesson.setDuration(45);
//        newLesson.setOrderNo(5);
//        newLesson.setStatusLesson(true);
//        newLesson.setCreatedDate(new Date());
//        newLesson.setType("Lý thuyết");
//        newLesson.setUpdateDate(new Date());
//
//        // Test insert
//        int newId = dao.insert(newLesson);
//        System.out.println("New lesson ID: " + newId);
//
//        // Test find by ID
//        Lesson foundLesson = dao.findById(newId);
//        System.out.println("\nLesson after insert:");
//        printLessonDetails(foundLesson);
//
//        // Test update
//        if(foundLesson != null) {
//            foundLesson.setLessonName("Bài học đã cập nhật");
//            foundLesson.setContent("Nội dung mới");
//            boolean updateResult = dao.update(foundLesson);
//            System.out.println("\nUpdate result: " + (updateResult ? "Thành công" : "Thất bại"));
//
//            Lesson updatedLesson = dao.findById(newId);
//            System.out.println("Lesson after update:");
//            printLessonDetails(updatedLesson);
//        }
//
//        // Test find by subject with pagination
//        System.out.println("\nLessons in subject 1 (page 1, pageSize 5):");
//        List<Lesson> subjectLessons = dao.findLessonsBySubject(1, 1, 5);
//        subjectLessons.forEach(LessonDAO::printLessonDetails);
//
//        // Test delete
//        boolean deleteResult = dao.delete(foundLesson);
//        System.out.println("\nDelete result: " + (deleteResult ? "Thành công" : "Thất bại"));
//
//        // Verify delete
//        Lesson deletedLesson = dao.findById(newId);
//        System.out.println("Lesson after delete: " + (deletedLesson == null ? "Không tồn tại" : "Vẫn tồn tại"));
//
//        // Test count
//        System.out.println("\nTotal lessons: " + dao.getTotalLessons());
//    }
//
//    private static void printLessonDetails(Lesson lesson) {
//        if(lesson == null) {
//            System.out.println("Lesson không tồn tại");
//            return;
//        }
//        System.out.println("ID: " + lesson.getLessonId());
//        System.out.println("Tên bài: " + lesson.getLessonName());
//        System.out.println("Môn học ID: " + lesson.getSubjectId());
//        System.out.println("Thời lượng: " + lesson.getDuration() + " phút");
//        System.out.println("Thứ tự: " + lesson.getOrderNo());
//        System.out.println("Trạng thái: " + (lesson.getStatusLesson() ? "Kích hoạt" : "Ẩn"));
//        System.out.println("Loại: " + lesson.getType());
//        System.out.println("Ngày tạo: " + lesson.getCreatedDate());
//        System.out.println("Ngày cập nhật: " + lesson.getUpdateDate());
//        System.out.println("-----------------------------------");
//    }



}
