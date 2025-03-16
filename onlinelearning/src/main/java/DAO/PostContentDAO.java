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
            System.out.println("ngu2");
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

    public void update(PostContent p){
        String sql ="UPDATE [dbo].[PostContent]\n" +
                "   SET [PostID] = ?\n" +
                "      ,[ContentType] =?\n" +
                "      ,[Content] = ?\n" +
                "      ,[Note] = ?\n" +
                "      ,[OrderIndex] = ? \n" +
                " WHERE ContentId =? ";
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1,p.getPost().getPostId());
            pre.setString(2,p.getContentType());
            pre.setString(3,p.getContent());
            pre.setString(4,p.getNote());
            pre.setInt(5,p.getOrderIndex());
            pre.setInt(6,p.getContentId());
            pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("update:"+ e);
        }
    }

    public void delete(String content){
        String sql ="DELETE FROM [dbo].[PostContent]\n" +
                "WHERE Content = ?;\n" ;
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setString(1,content);
            pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("delete:" +e);
        }
    }

    public ArrayList<String> getAllContent(int postId) {
        String sql = "SELECT Content FROM PostContent WHERE PostID = ?";
        ArrayList<String> list = new ArrayList<>();

        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, postId);

            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString("Content"));  // Truy xuất theo tên cột thay vì chỉ số
                }
            }
        } catch (SQLException e) {
            System.out.println("Error while fetching data: " + e.getMessage());
        }

        return list.isEmpty() ? null : list;  // Trả về null nếu không có dữ liệu
    }

}
