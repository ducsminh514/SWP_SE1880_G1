package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import Module.ReviewPost ;
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
//            System.out.println(rating);
        } catch (SQLException e) {
            System.out.println(e);
        }
        return rating;
    }

    public ArrayList<ReviewPost> getAll() {
        String sql = "select * from PostReview";
        ArrayList<ReviewPost> listPostReview = new ArrayList<>();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            PostDAO pDAO = new PostDAO();
            CustomerDAO cDAO = new CustomerDAO();
            while (rs.next()) {
                ReviewPost r = new ReviewPost() ;
                r.setPost(pDAO.getById(rs.getInt("PostID")));
                r.setReviewPostId(rs.getInt("PostReviewID"));
                r.setComment(rs.getString("Comment"));
                r.setStatus(rs.getBoolean("Status"));
                r.setReviewDate(rs.getDate("ReviewDate"));
                r.setCustomer(cDAO.getByID(rs.getInt("CustomerID")));
                r.setRating(rs.getFloat("Rating"));
                listPostReview.add(r);
            }
            return listPostReview;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listPostReview;
    }

    public HashMap<Post, Float> mapRating() {
        HashMap<Post,Float> map = new HashMap<>();
        ArrayList<Float>  listRating = new ArrayList<>() ;
        PostDAO pDAO = new PostDAO();
        ArrayList<Post> listPost = pDAO.getAll() ;
        for(Post p: listPost){
            map.put(pDAO.getById(p.getPostId()),getRatingOfPost(p.getPostId()));
        }
        return map ;
    }
}




