package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.PostImage;
public class PostImageDAO extends DBContext {
    public ArrayList<PostImage> getByPost(int postId){
        String sql = "select * from PostImage where PostID=?";
        ArrayList<PostImage> list = new ArrayList<>();
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1,postId);
            ResultSet rs = pre.executeQuery();
            PostDAO pDAO = new PostDAO();
            while(rs.next()){
                PostImage p = new PostImage();
                p.setPost(pDAO.getById(postId));
                p.setImageUrl(rs.getString("ImageURL"));
                p.setCreateDate(rs.getDate("CreateDate"));
                p.setPostImageId(rs.getInt("ImagePostID"));
                list.add(p);
            }
            return list;
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeResources();
        }
        return list;
    }

    public void insert(int postId, String url, String note){
        String sql ="INSERT INTO [dbo].[PostImage]\n" +
                "           ([PostID]\n" +
                "           ,[ImageURL]\n" +
                "           ,[Note])\n" +
                "     VALUES\n" +
                "           (?,?,?)";
        try{
            connection = getConnection();
            PreparedStatement pre= connection.prepareStatement(sql);
            pre.setInt(1,postId);
            pre.setString(2,url);
            pre.setString(3,note);
            pre.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeResources();
        }
    }

    public void delete(int postImageId){
        String sql ="DELETE FROM [dbo].[PostImage]\n" +
                "      WHERE ImagePostID=?";
        try{
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1,postImageId);
            pre.executeUpdate();
        }catch(SQLException e){
             System.out.println(e);
        }finally{
            closeResources();
        }
    }
    

}
