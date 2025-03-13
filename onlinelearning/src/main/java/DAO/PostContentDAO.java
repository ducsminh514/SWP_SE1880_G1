package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.Post ;
import Module.PostContent ;
public class PostContentDAO extends DBContext {
    public void insert(PostContent p){
        String sql ="INSERT INTO [dbo].[PostContent]\n" +
                "           ([PostID]\n" +
                "           ,[ContentType]\n" +
                "           ,[Content]\n" +
                "           ,[Note]\n" +
                "           ,[OrderIndex])\n" +
                "     VALUES\n" +
                "           (?,?,?,?,?)" ;
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1,p.getPost().getPostId());
            pre.setString(2,p.getContentType());
            pre.setString(3,p.getContent());
            pre.setString(4,p.getNote());
            pre.setInt(5,p.getOrderIndex());
            pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("ngu1");
        }
    }
    public ArrayList<PostContent> getByPostId(int postId) {
        ArrayList<PostContent> contents = new ArrayList<>();
        String sql = "SELECT * FROM PostContent WHERE PostID = ? ORDER BY OrderIndex ASC";
        PostDAO pDAO = new PostDAO() ;
        try {
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1, postId);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                PostContent content = new PostContent();
                content.setContentId(rs.getInt("ContentId"));
                content.setContentType(rs.getString("ContentType"));
                content.setContent(rs.getString("Content"));
                content.setOrderIndex(rs.getInt("OrderIndex"));
                content.setPost(pDAO.getById(rs.getInt("PostID")));
                content.setNote(rs.getString("Note"));
                contents.add(content);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return contents;
    }
}
