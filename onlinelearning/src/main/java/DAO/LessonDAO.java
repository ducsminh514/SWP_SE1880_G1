package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
}
