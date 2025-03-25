package DAO;

import dal.DBContext;
import Module.Subject;
import Module.Course;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO extends DBContext implements GenericDAO<Subject> {

    @Override
    public List<Subject> findAll() {
        String sql = "\n" +
                "SELECT [SubjectID]\n" +
                "      ,[CourseID]\n" +
                "      ,[SubjectName]\n" +
                "      ,[Description]\n" +
                "      ,[OrderNo]\n" +
                "      ,[CreatedDate]\n" +
                "  FROM [dbo].[Subjects]\n";
        List<Subject> subjectList = new ArrayList<Subject>();
        try{
            PreparedStatement st  = connection.prepareStatement(sql);
            ResultSet rs  = st.executeQuery();
            while(rs.next()){
                subjectList.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return subjectList;
    }


    @Override
    public int insert(Subject subject) {
        return 0;
    }

    @Override
    public boolean delete(Subject subject) {
        return false;
    }

    @Override
    public boolean update(Subject subject) {
        return false;
    }

    @Override
    public Subject getFromResultSet(ResultSet resultSet) throws SQLException {
        CourseDAO courseDAO = new CourseDAO();
        Course course = courseDAO.getCourseById(resultSet.getInt("CourseID"));
        Subject subject = new Subject();
        subject.setSubjectId(resultSet.getInt("SubjectID"));
        subject.setCourse(course);
        subject.setSubjectName(resultSet.getString("SubjectName"));
        subject.setDescription(resultSet.getString("Description"));
        subject.setOrderNo(resultSet.getInt("OrderNo"));
        subject.setCreateDate(resultSet.getDate("CreatedDate"));
        return subject;
    }

    public Subject getSubjectById(int id){
        String sql = "\n" +
                "SELECT [SubjectID]\n" +
                "      ,[CourseID]\n" +
                "      ,[SubjectName]\n" +
                "      ,[Description]\n" +
                "      ,[OrderNo]\n" +
                "      ,[CreatedDate]\n" +
                "  FROM [dbo].[Subjects]\n" +
                "  WHERE SubjectID = ? ";
        Subject subject = new Subject();
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                subject = getFromResultSet(rs);
                return subject;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return subject;
    }
    public static void main(String[] args) {
        SubjectDAO subjectDAO = new SubjectDAO();
        List<Subject> subjects = subjectDAO.findAll();
        for(Subject subject : subjects){
            System.out.println(subject.getSubjectName());
        }
    }


    public ArrayList<Subject> findByCourse(int courseId){
        String sql = "Select * from Subjects where CourseID=?" ;
        ArrayList<Subject> listSubject = new ArrayList<>() ;
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1,courseId);
            ResultSet rs = pre.executeQuery();
            CourseDAO cDAO = new CourseDAO() ;
            while(rs.next()){
                Subject s = new Subject() ;
                s.setCourse(cDAO.getById(courseId));
                s.setDescription(rs.getString("Description"));
                s.setCreateDate(rs.getDate("CreatedDate"));
                s.setSubjectId(rs.getInt("SubjectID"));
                s.setSubjectName(rs.getString("SubjectName"));
                s.setOrderNo(rs.getInt("OrderNo"));
                listSubject.add(s) ;
            }
            return listSubject ;
        }catch(SQLException e){
            System.out.println(e);
        }
        return listSubject ;
    }

    public int countSubject(int courseId) {
        String sql = "select COUNT(*) from Subjects where CourseID=?";
        int cnt = 0;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseId);
            ResultSet rs = pre.executeQuery();
            cnt = rs.getInt(1);
            return cnt;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return cnt;
    }
}
