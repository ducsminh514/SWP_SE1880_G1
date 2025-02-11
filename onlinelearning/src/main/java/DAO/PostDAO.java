package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Module.Post;

public class PostDAO extends DBContext {
    public ArrayList<Post> getAll() {
        String sql = "select * from Posts";
        ArrayList<Post> listPost = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            MarketingDAO mDAO = new MarketingDAO();
            CategoryBlogDAO cDAO = new CategoryBlogDAO();
            while (rs.next()) {
                Post p = new Post();
                p.setPostId(rs.getInt("PostID"));
                p.setContent(rs.getString("Content"));
                p.setCategoryBlog(cDAO.getByID(rs.getInt("CategoryBlogID")));
                p.setStatus(rs.getBoolean("Status"));
                p.setThumbnail(rs.getString("Thumbnail"));
                p.setCreateDate(rs.getDate("CreateDate"));
                p.setUpdateDate(rs.getDate("UpdateDate"));
                p.setTitle(rs.getString("Title"));
                p.setView(rs.getInt("Amount_View"));
                p.setPostFile(rs.getString("PostFile"));
                p.setMarketing(mDAO.getByID(rs.getInt("MarketingID")));
                listPost.add(p);
            }
            return listPost;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listPost;
    }

   public Post getById(int postID){
        ArrayList<Post> list = getAll() ;
        for(Post p: list){
            if(p.getPostId() == postID){
                return p;
            }
        }
        return null;
   }

   public ArrayList<Post> ArrangeByDate(){
        String sql ="SELECT TOP 6 * \n" +
                "FROM Posts\n" +
                "ORDER BY UpdateDate DESC;\n" ;
       ArrayList<Post> listP = new ArrayList<>();
       try {
           PreparedStatement pre = connection.prepareStatement(sql);
           ResultSet rs = pre.executeQuery();
           MarketingDAO mDAO = new MarketingDAO();
           CategoryBlogDAO cDAO = new CategoryBlogDAO();
           while (rs.next()) {
               Post p = new Post();
               p.setPostId(rs.getInt("PostID"));
               p.setContent(rs.getString("Content"));
               p.setCategoryBlog(cDAO.getByID(rs.getInt("CategoryBlogID")));
               p.setStatus(rs.getBoolean("Status"));
               p.setThumbnail(rs.getString("Thumbnail"));
               p.setCreateDate(rs.getDate("CreateDate"));
               p.setUpdateDate(rs.getDate("UpdateDate"));
               p.setTitle(rs.getString("Title"));
               p.setView(rs.getInt("Amount_View"));
               p.setPostFile(rs.getString("PostFile"));
               p.setMarketing(mDAO.getByID(rs.getInt("MarketingID")));
               listP.add(p);
           }
           return listP;
       } catch (SQLException e) {
           System.out.println(e);
       }
       return listP;
   }

   public ArrayList<Post> getByCategory(int categoryBlogId){
        ArrayList<Post> listByCate = new ArrayList<>();
        for(Post p : getAll()){
            if(p.getCategoryBlog().getCategoryBlogId() == categoryBlogId){
                listByCate.add(p) ;
            }
        }
        return listByCate;
   }

    public ArrayList<Post> getAllByPage(int start) {
        ArrayList<Post> listPost = new ArrayList<>();
        String sql = "SELECT * FROM Posts \n"
                + "ORDER BY PostID\n"
                + "OFFSET ? ROWS FETCH NEXT 6 ROWS ONLY;";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1,start);
            ResultSet rs = pre.executeQuery();
            MarketingDAO mDAO = new MarketingDAO();
            CategoryBlogDAO cDAO = new CategoryBlogDAO();
            while (rs.next()) {
                Post p = new Post();
                p.setPostId(rs.getInt("PostID"));
                p.setContent(rs.getString("Content"));
                p.setCategoryBlog(cDAO.getByID(rs.getInt("CategoryBlogID")));
                p.setStatus(rs.getBoolean("Status"));
                p.setThumbnail(rs.getString("Thumbnail"));
                p.setCreateDate(rs.getDate("CreateDate"));
                p.setUpdateDate(rs.getDate("UpdateDate"));
                p.setTitle(rs.getString("Title"));
                p.setView(rs.getInt("Amount_View"));
                p.setPostFile(rs.getString("PostFile"));
                p.setMarketing(mDAO.getByID(rs.getInt("MarketingID")));
                listPost.add(p);
            }
            return listPost;
        } catch (SQLException e) {
            System.out.println("ngu");
        }
        return listPost;
    }

}
