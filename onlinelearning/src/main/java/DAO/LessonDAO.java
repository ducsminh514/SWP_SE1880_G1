package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import Module.Lesson;

public class LessonDAO extends DBContext implements GenericDAO<Lesson>{

    @Override
    public List<Lesson> findAll() {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT * FROM Lessons";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                lessons.add(getFromResultSet(rs));
            }
        } catch (SQLException ex) {
            handleException("Error finding all lessons", ex);
        }
        return lessons;
    }

    @Override
    public Lesson getFromResultSet(ResultSet rs) throws SQLException {
        SubjectDAO sDAO = new SubjectDAO();
        Lesson lesson = new Lesson();
        lesson.setLessonId(rs.getInt("LessonID"));
        lesson.setSubject(sDAO.getSubjectById(rs.getInt("SubjectID")));
        lesson.setLessonName(rs.getString("LessonName"));
        lesson.setContent(rs.getString("Content"));
        lesson.setDuration(rs.getInt("Duration"));
        lesson.setOrderNo(rs.getInt("OrderNo"));
        lesson.setStatus(rs.getBoolean("status_lesson"));
        lesson.setCreateDate(rs.getDate("CreatedDate"));
        return lesson;
    }

    @Override
    public int insert(Lesson lesson) {
        String sql = "INSERT INTO Lessons (SubjectID, LessonName, Content, Duration, "
                   + "OrderNo, status_lesson, CreatedDate, Type, UpdateDate) "
                   + "OUTPUT INSERTED.LessonID VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, lesson.getSubject().getSubjectId());
            st.setString(2, lesson.getLessonName());
            st.setString(3, lesson.getContent());
            st.setInt(4, lesson.getDuration());
            st.setInt(5, lesson.getOrderNo());
            st.setBoolean(6, lesson.getStatus());
            st.setDate(7, new java.sql.Date(lesson.getCreateDate().getTime())) ;
            st.setString(8, null);
            st.setDate(9, null);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            handleException("Error inserting lesson", ex);
        }
        return -1;
    }

    @Override
    public boolean delete(Lesson lesson) {
        String sql = "DELETE FROM Lessons WHERE LessonID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, lesson.getLessonId());
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            handleException("Error deleting lesson", ex);
        }
        return false;
    }

    @Override
    public boolean update(Lesson lesson) {
        String sql = "UPDATE Lessons SET "
                   + "SubjectID = ?, LessonName = ?, Content = ?, Duration = ?, "
                   + "OrderNo = ?, status_lesson = ?, CreatedDate = ?, "
                   + "Type = ?, UpdateDate = ? "
                   + "WHERE LessonID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, lesson.getSubject().getSubjectId());
            st.setString(2, lesson.getLessonName());
            st.setString(3, lesson.getContent());
            st.setInt(4, lesson.getDuration());
            st.setInt(5, lesson.getOrderNo());
            st.setBoolean(6, lesson.getStatus());
            st.setDate(7, new java.sql.Date(lesson.getCreateDate().getTime()));
            st.setString(8, null);
            st.setDate(9, null);
            st.setInt(10, lesson.getLessonId());

            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            handleException("Error updating lesson", ex);
        }
        return false;
    }

    // Additional methods
    public Lesson findById(int id) {
        String sql = "SELECT * FROM Lessons WHERE LessonID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return getFromResultSet(rs);
                }
            }
        } catch (SQLException ex) {
            handleException("Error finding lesson by ID", ex);
        }
        return null;
    }

    public List<Lesson> findLessonsBySubject(int subjectId, int page, int pageSize) {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT * FROM Lessons WHERE SubjectID = ? "
                   + "ORDER BY OrderNo OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, subjectId);
            st.setInt(2, (page - 1) * pageSize);
            st.setInt(3, pageSize);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    lessons.add(getFromResultSet(rs));
                }
            }
        } catch (SQLException ex) {
            handleException("Error finding lessons by subject", ex);
        }
        return lessons;
    }

    public int getTotalLessons() {
        String sql = "SELECT COUNT(*) FROM Lessons";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            handleException("Error counting lessons", ex);
        }
        return 0;
    }

    private void handleException(String message, SQLException ex) {
        System.err.println(message + ": " + ex.getMessage());
        ex.printStackTrace();
    }




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

}
