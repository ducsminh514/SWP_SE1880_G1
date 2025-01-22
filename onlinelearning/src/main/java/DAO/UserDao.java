package DAO;

import dal.DBContext;
import Module.User;
import Module.Role;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.mindrot.jbcrypt.BCrypt;
import DAO.RoleDAO;
public class UserDao extends DBContext {


    public User checkAuthen(String username, String password) {
        String sql = "select * from Users where (Username=? or Email=?) and Password=?";
        if (connection == null) {
            System.out.println("Lỗi: Kết nối cơ sở dữ liệu chưa được khởi tạo!");

        }else {
            System.out.println("hhh");
        }
        try {
            RoleDAO ro= new RoleDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, username);
            st.setString(3, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {

                User u = new User(rs.getInt("userId"), username,rs.getString("firstName"),rs.getString("lastName"),password,rs.getString("email"),rs.getString("phoneNumber"),rs.getDate("CreatedDate"),rs.getInt("Age"),ro.getByRoleID(rs.getInt("roleId")),rs.getByte("status"));
                System.out.println(u.getUserId());
                return u;
            }
            else {
                System.out.println("hhheeeeeeee1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    public boolean existUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            System.out.println("hhheeeeeeee");
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void changePassword(String plainPassword, int id) {
        String sql = "update Users set password = ? where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, hashPassword(plainPassword));
            st.setInt(2, id);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    public int getIdUserByEmail(String email){
        String sql = "select * from Users where email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                return rs.getInt("id");
            }
        } catch (SQLException e) {
        }
        return 0;
    }
    public static void main(String[] args) {
        UserDao ud = new UserDao();
        String e = "duynguyenthe195@gmail.com";
        String otp1 ="123";

    }



}
