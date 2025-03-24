package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import Module.CommentPost;

public class CommentPostDAO extends DBContext {

    public ArrayList<CommentPost> listParentComment(int postId) {
        String sql = "DECLARE @PostID INT;\n" +
                "SET @PostID = ?; -- Gán ID bài viết cần lấy bình luận\n" +
                "\n" +
                "SELECT * \n" +
                "FROM CommentPost\n" +
                "WHERE PostID = @PostID AND ParentID IS NULL\n" +
                "ORDER BY CreateDate DESC;\n";
        ArrayList<CommentPost> listComment = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, postId);
            ResultSet rs = pre.executeQuery();
            PostDAO pDAO = new PostDAO();
            UserDAO uDAO = new UserDAO();
            while (rs.next()) {
                CommentPost c = new CommentPost();
                c.setPost(pDAO.getById(postId));
                c.setContent(rs.getString("Content"));
                c.setParentId(rs.getInt("ParentID"));
                c.setUser(uDAO.getByID(rs.getInt("UserID")));
                c.setCommentPostId(rs.getInt("CommentPostID"));
                c.setCreateDate(rs.getDate("CreateDate"));
                listComment.add(c);
            }
            return listComment;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<CommentPost> listChildComment(int commentId) {
        String sql = "DECLARE @ParentCommentID INT;\n" +
                "SET @ParentCommentID = ?;\n" +
                "\n" +
                "SELECT * \n" +
                "FROM CommentPost\n" +
                "WHERE ParentID = @ParentCommentID\n" +
                "ORDER BY CreateDate DESC;\n";
        ArrayList<CommentPost> listComment = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, commentId);
            ResultSet rs = pre.executeQuery();
            PostDAO pDAO = new PostDAO();
            UserDAO uDAO = new UserDAO();
            while (rs.next()) {
                CommentPost c = new CommentPost();
                c.setPost(pDAO.getById(rs.getInt("PostID")));
                c.setContent(rs.getString("Content"));
                c.setParentId(commentId);
                c.setUser(uDAO.getByID(rs.getInt("UserID")));
                c.setCommentPostId(rs.getInt("CommentPostID"));
                c.setCreateDate(rs.getDate("CreateDate"));
                listComment.add(c);
            }
            return listComment;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }



    public int countAll(){
        String sql ="Select Count(*) from CommentPost";
        int cnt =0;
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            ResultSet rs= pre.executeQuery();
            if(rs.next()){
                cnt = rs.getInt(1);
            }
            return cnt ;
        }catch(SQLException e ){
            System.out.println(e);
        }
        return cnt;
    }

    public ArrayList<CommentPost> getCommentsByPostID(int postID) {
        ArrayList<CommentPost> commentList = new ArrayList<>();
        Map<Integer, CommentPost> commentMap = new HashMap<>();

        String sql = "WITH CommentHierarchy AS ( " +
                "    SELECT CommentPostID, ParentID, PostID, UserID, Content, CreateDate, 0 AS Depth " +
                "    FROM CommentPost WHERE PostID = ? AND ParentID IS NULL " +
                "    UNION ALL " +
                "    SELECT cp.CommentPostID, cp.ParentID, cp.PostID, cp.UserID, cp.Content, cp.CreateDate, ch.Depth + 1 " +
                "    FROM CommentPost cp INNER JOIN CommentHierarchy ch ON cp.ParentID = ch.CommentPostID " +
                ") " +
                "SELECT * FROM CommentHierarchy ORDER BY Depth ASC, CreateDate ASC;";

        try {
            PreparedStatement pre = connection.prepareStatement(sql) ;
            PostDAO pDAO = new PostDAO();
            UserDAO uDAO = new UserDAO();
            pre.setInt(1, postID);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                CommentPost comment = new CommentPost();
                int id = rs.getInt("CommentPostID");
                int parentID = rs.getInt("ParentID") ;
                comment.setPost(pDAO.getById(postID)) ;
                comment.setContent(rs.getString("Content"));
                comment.setParentId(parentID);
                comment.setUser(uDAO.getByID(rs.getInt("UserID")));
                comment.setCommentPostId(id) ;
                comment.setCreateDate(rs.getDate("CreateDate"));
                commentMap.put(id, comment);
            }
            for (CommentPost comment : commentMap.values()) {
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


    public void insert(int parentId,int postId,int userId , String content ){
        String sql ="INSERT INTO [dbo].[CommentPost]\n" +
                "           ([ParentID]\n" +
                "           ,[PostID]\n" +
                "           ,[UserID]\n" +
                "           ,[Content])\n" +
                "     VALUES\n" +
                "           (?,?,?,?)";
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1,parentId);
            pre.setInt(2,postId);
            pre.setInt(3,userId);
            pre.setString(4,content);
            pre.executeUpdate();
        }catch (SQLException e){
            System.out.println(e);
        }
    }
}
