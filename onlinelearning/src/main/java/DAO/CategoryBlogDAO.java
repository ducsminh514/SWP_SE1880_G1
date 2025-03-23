package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.CategoryBlog ;
import dal.DBContext;

public class CategoryBlogDAO extends DBContext {


    public ArrayList<CategoryBlog> getAll(){
        String sql = "select * from CategoryBlog" ;
        ArrayList<CategoryBlog> listCategoryBlog = new ArrayList<>();
        try{
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while(rs.next()){
                CategoryBlog c = new CategoryBlog();
                c.setCategoryBlogId(rs.getInt("CategoryBlogID"));
                c.setCategoryBlogName(rs.getString("CategoryBlogName"));
                listCategoryBlog.add(c) ;
            }
            return listCategoryBlog ;
        }catch(SQLException e){
             System.out.println(e);
        }
        return listCategoryBlog ;
    }

    public CategoryBlog getByID(int id){
        ArrayList<CategoryBlog> list = getAll();
        for(CategoryBlog c: list){
            if(c.getCategoryBlogId() == id ){
                return c ;
            }
        }
        return null;
    }
}
