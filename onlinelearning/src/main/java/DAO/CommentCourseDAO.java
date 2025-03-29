package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import Module.CommentCourse ;
public class CommentCourseDAO extends DBContext {

    public ArrayList<CommentCourse> getCommentsByCourseID(int courseId) {
        ArrayList<CommentCourse> commentList = new ArrayList<>();
        Map<Integer, CommentCourse> commentMap = new HashMap<>();

        String sql = "WITH CommentHierarchy AS (\n" +
                "    SELECT CommentCourseID, ParentID, CourseID, UserID, Content, CreateDate, 0 AS Depth\n" +
                "    FROM CommentCourse \n" +
                "    WHERE CourseID = ? AND ParentID IS NULL\n" +
                "    UNION ALL\n" +
                "    SELECT cp.CommentCourseID, cp.ParentID, cp.CourseID, cp.UserID, cp.Content, cp.CreateDate, ch.Depth + 1\n" +
                "    FROM CommentCourse cp\n" +
                "    INNER JOIN CommentHierarchy ch \n" +
                "        ON cp.ParentID = ch.CommentCourseID\n" +
                ")\n" +
                "SELECT * \n" +
                "FROM CommentHierarchy \n" +
                "ORDER BY Depth ASC, CreateDate ASC;\n";

        try {
            PreparedStatement pre = connection.prepareStatement(sql) ;
            CourseDAO cDAO = new CourseDAO();
            UserDAO uDAO = new UserDAO();
            pre.setInt(1, courseId);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                CommentCourse comment = new CommentCourse();
                int id = rs.getInt("CommentCourseID");
                int parentID = rs.getInt("ParentID") ;
                comment.setCourse(cDAO.getById(courseId)); ;
                comment.setContent(rs.getString("Content"));
                comment.setParentId(parentID);
                comment.setUser(uDAO.getByID(rs.getInt("UserID")));
                comment.setCommentCourseId(id); ;
                comment.setCreateDate(rs.getDate("CreateDate"));
                commentMap.put(id, comment);
            }
            for (CommentCourse comment : commentMap.values()) {
                int  parentId = comment.getParentId();
                if (parentId == 0) {
                    commentList.add(comment); // Bình luận gốc
                } else if (commentMap.containsKey(parentId)) {
                    commentMap.get(parentId).addChild(comment); // Gán bình luận con vào cha
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return commentList;
    }

    public void insert(int parentId,int courseId,int userId , String content ){
        String sql ="INSERT INTO [dbo].[CommentCourse]\n" +
                "           ([ParentID]\n" +
                "           ,[CourseID]\n" +
                "           ,[UserID]\n" +
                "           ,[Content])\n" +
                "     VALUES\n" +
                "           (?,?,?,?)";
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1,parentId);
            pre.setInt(2,courseId);
            pre.setInt(3,userId);
            pre.setString(4,content);
            pre.executeUpdate();
        }catch (SQLException e){
            System.out.println(e);
        }
    }
}
