package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.PostVideo;
public class PostVideoDAO extends DBContext {
    public ArrayList<PostVideo> getByPost(int postId){
        String sql = "select * from PostVideo where PostID=?";
        ArrayList<PostVideo> list = new ArrayList<>();
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1,postId);
            ResultSet rs = pre.executeQuery();
            PostDAO pDAO = new PostDAO();
            while(rs.next()){
                PostVideo p = new PostVideo();
                p.setPost(pDAO.getById(postId));
                p.setVideoUrl(rs.getString("VideoURL"));
                p.setCreateDate(rs.getDate("CreateDate"));
                p.setPostVideoId(rs.getInt("PostVideoID"));
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
        String sql ="INSERT INTO [dbo].[PostVideo]\n" +
                "           ([PostID]\n" +
                "           ,[VideoURL]\n" +
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

    public void delete(int postVideoId){
        String sql ="DELETE FROM [dbo].[PostVideo]\n" +
                "      WHERE PostVideoID=?";
        try{
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1,postVideoId);
            pre.executeUpdate();
        }catch(SQLException e){
            System.out.println(e);
        }finally{
            closeResources();
        }
    }
    

}
