package DAO;

import dal.DBContext;
import Module.Subject;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO extends DBContext implements GenericDAO<Subject> {

    @Override
    public List<Subject> findAll() {
        return List.of();
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
        return null;
    }

    public Subject getSubjectById(int id){
        return null;
    }

}
