package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import Module.Post;

public class ReviewPostDAO extends DBContext {
    public float getRatingOfPost(int postId) {
        String sql = "SELECT AVG(Rating) FROM PostReview WHERE PostID = ?";
        float rating = 0;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, postId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                rating = rs.getFloat(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return rating;
    }

    public ArrayList<Post> getAll() {
        String sql = "select * from PostReview";
        ArrayList<Post> listPostReview = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            PostDAO pDAO = new PostDAO();
            CustomerDAO
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

    public HashMap<Integer, Float> mapRating() {

    }
}
