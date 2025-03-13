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

    public ArrayList<Post> getAllByPage(int start,String search , int categoryID , String arrange , int numberPost ) {
        ArrayList<Post> listPost = new ArrayList<>();
        String sql = "SELECT * FROM Posts where 1=1" ;
        if(search != null && !search.isEmpty()){
            sql += " AND (Title LIKE ? OR Content LIKE ?)" ;
        }
        if(categoryID>0){
            sql += " AND CategoryBlogID = ?" ;
        }
        if (arrange != null && !arrange.isEmpty()) {
            if (arrange.equalsIgnoreCase("rating")) {
                sql += " ORDER BY (SELECT AVG(Rating) FROM PostReview WHERE PostReview.PostID = Posts.PostID) DESC ";
            } else if (arrange.equalsIgnoreCase("date-soon")) {
                sql += " ORDER BY UpdateDate ASC ";
            } else if (arrange.equalsIgnoreCase("date-late")) {
                sql += " ORDER BY UpdateDate DESC ";
            } else {
                sql += " ORDER BY UpdateDate DESC ";
            }
        } else {
            sql += " ORDER BY UpdateDate DESC ";
        }
        if(start>=0){
            sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            int index =1 ;
            if (search != null && !search.isEmpty()) {
                pre.setString(index++, "%" + search + "%");
                pre.setString(index++, "%" + search + "%");
            }
            if (categoryID > 0) {
                pre.setInt(index++, categoryID);
            }
            if(start>=0){
                pre.setInt(index++, start);
                pre.setInt(index, numberPost);
            }

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

    public int insert(int categoryBlogId,int marketingId , String title  ,String thumbnail){
        String sql ="INSERT INTO [dbo].[Posts]\n" +
                "           ([CategoryBlogID]\n" +
                "           ,[MarketingID]\n" +
                "           ,[Title]\n" +
                "           ,[Thumbnail])\n" +
                "     VALUES\n" +
                "           (?,?,?,?); SELECT SCOPE_IDENTITY() AS PostID" ;
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1,categoryBlogId);
            pre.setInt(2,marketingId);
            pre.setString(3,title);
            pre.setString(4,thumbnail);
            pre.executeUpdate() ;
            ResultSet rs = pre.getGeneratedKeys();
            if(rs.next()){
                int postId = rs.getInt(1) ;
                return  postId ;
            }
        }catch(SQLException e){
            System.out.println(e);
        }
        return 0 ;
    }

}
