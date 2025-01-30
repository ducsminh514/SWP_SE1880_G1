package DAO;

import dal.DBContext;
import Module.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;
public class UserDAO extends DBContext {


    public User checkAuthen(String username, String password) {
        String sql = "select * from Users where (Username=? or Email=?) and Password=?";
        if (connection == null) {
            System.out.println("Lỗi: Kết nối cơ sở dữ liệu chưa được khởi tạo!");

        }else {
            System.out.println("ok");
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
                System.out.println("checkAuthed");
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
            System.out.println("existUserByEmail");
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void changePassword(String plainPassword, int id) {
        String sql = "update Users set Password = ? where UserID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, plainPassword);
            st.setInt(2, id);
            st.executeUpdate();
            System.out.println("changePassword");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    public int getIdUserByEmail(String email){
        String sql = "select * from Users where email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                System.out.println("getIdUserByEmail");
                return rs.getInt("userId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
//    public static void main(String[] args) {
//        UserDAO ud = new UserDAO();
//        String e = "duynguyenthe195@gmail.com";
//        String otp1 ="123";
//        String as="1234";
//        ud.getIdUserByEmail(e);
//
//
//    }
    public User getUserByName(String username, String email) {

        String sql = "select*from Users where Username =? or Email =?";

        try {
            RoleDAO ro= new RoleDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User(rs.getInt("userId"), username,rs.getString("firstName"),rs.getString("lastName"),rs.getString("password"),rs.getString("email"),rs.getString("phoneNumber"),rs.getDate("CreatedDate"),rs.getInt("Age"),ro.getByRoleID(rs.getInt("roleId")),rs.getByte("status"));
                System.out.println(u.getUserId());
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }
    public User getUserByID(int id) {

        String sql = "select*from Users where UserID =?;";
        try {
            RoleDAO ro= new RoleDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User(rs.getInt("userId"), rs.getString("userName"),rs.getString("firstName"),rs.getString("lastName"),rs.getString("password"),rs.getString("email"),rs.getString("phoneNumber"),rs.getDate("CreatedDate"),rs.getInt("Age"),ro.getByRoleID(rs.getInt("roleId")),rs.getByte("status"));
                System.out.println(u.getUserId());
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }
//    INSERT INTO [dbo].[Users]
//            ([Username]
//            ,[FirstName]
//            ,[LastName]
//            ,[Fullname]
//            ,[Password]
//            ,[Email]
//            ,[PhoneNumber]
//            ,[CreatedDate]
//            ,[Age]
//            ,[RoleID]
//            ,[Status])
    public void insert(User c) {
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([Username]\n"
                + "           ,[FirstName]\n"
                + "           ,[LastName]\n"
                + "           ,[Fullname]\n"
                + "           ,[Password]\n"
                + "           ,[Email]\n"
                + "           ,[PhoneNumber]\n"
                + "           ,[Age]\n"
                + "           ,[RoleID])\n"
                + " Values(?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getUserName());
            st.setString(2, c.getFirstName());
            st.setString(3, c.getLastName());
            st.setString(4,c.getFirstName()+c.getLastName());
            st.setString(5, c.getPassword());
            st.setString(6, c.getEmail());
            st.setString(7, c.getPhoneNumber());
            st.setInt(8, c.getAge());
            st.setInt(9,c.getRole().getRoleId());
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public boolean verifyUser(String email) {
        try {
            String sql = "UPDATE Users SET status = 1 WHERE Email = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
