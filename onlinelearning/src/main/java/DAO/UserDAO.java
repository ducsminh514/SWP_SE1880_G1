package DAO;

import dal.DBContext;
import Module.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Module.Role;
import org.mindrot.jbcrypt.BCrypt;
public class UserDAO extends DBContext implements GenericDAO<User>{


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

                User u = new User(rs.getInt("userId"), username,rs.getString("firstName"),rs.getString("lastName"),password,rs.getString("email"),rs.getString("phoneNumber"),rs.getDate("CreatedDate"),rs.getString("Gender"),rs.getString("Avatar"),rs.getInt("Age"),ro.getByRoleID(rs.getInt("roleId")),rs.getBoolean("status"));
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
//    public static void main(String[] args) {
//        UserDAO dao = new UserDAO();
//
//        String a = "duy";
//        String b = "123";
//        dao.checkAuthen(a,b);
//    }

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

    public User getUserByName(String username, String email) {

        String sql = "select*from Users where Username =? or Email =?";

        try {
            RoleDAO ro= new RoleDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User(rs.getInt("userId"), username,rs.getString("firstName"),rs.getString("lastName"),rs.getString("password"),rs.getString("email"),rs.getString("phoneNumber"),rs.getDate("CreatedDate"),rs.getString("Gender"),rs.getString("Avatar"),rs.getInt("Age"),ro.getByRoleID(rs.getInt("roleId")),rs.getBoolean("status"));
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
                User u = new User(rs.getInt("userId"), rs.getString("userName"),rs.getString("firstName"),rs.getString("lastName"),rs.getString("password"),rs.getString("email"),rs.getString("phoneNumber"),rs.getDate("CreatedDate"),rs.getString("Gender"),rs.getString("Avatar"),rs.getInt("Age"),ro.getByRoleID(rs.getInt("roleId")),rs.getBoolean("status"));
                System.out.println(u.getUserId());
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }

    public void insertUser1(User c) {
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([Username]\n"
                + "           ,[FirstName]\n"
                + "           ,[LastName]\n"
                + "           ,[Fullname]\n"
                + "           ,[Password]\n"
                + "           ,[Email]\n"
                + "           ,[PhoneNumber]\n"
                + "           ,[Gender]\n"
                + "           ,[Avatar ]\n"
                + "           ,[Age]\n"
                + "           ,[RoleID]\n"
                + "           ,[Status])\n"
                + " Values(?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getUserName());
            st.setString(2, c.getFirstName());
            st.setString(3, c.getLastName());
            st.setString(4,c.getFirstName()+c.getLastName());
            st.setString(5, c.getPassword());
            st.setString(6, c.getEmail());
            st.setString(7, c.getPhoneNumber());
            st.setString(8, c.getGender());
            st.setString(9, c.getAvatar());
            st.setInt(10, c.getAge());
            st.setInt(11,c.getRole().getRoleId());
            st.setObject(12,c.getStatus());
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean verifyUser(String email) {
        try {
            String sql = "UPDATE Users SET Status = 1 WHERE Email = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                users.add(getFromResultSet(rs));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return users;
    }

    @Override
    public boolean update(User user) {
        String sql = "\n" +
                "UPDATE [dbo].[Users]\n" +
                "   SET [Username] =?\n" +
                "      ,[FirstName] = ?\n" +
                "      ,[LastName] = ?\n" +
                "      ,[Password] =?\n" +
                "      ,[Email] = ?\n" +
                "      ,[PhoneNumber] =?\n" +
                "      ,[CreatedDate] = ?\n" +
                "      ,[Avatar] =?\n" +
                "      ,[Gender] = ?\n" +
                "      ,[Age] = ?\n" +
                "      ,[RoleID] = ?\n" +
                "      ,[Status] = ?\n" +
                " WHERE UserID = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            //st.setString(1, account.getUsername());
            st.setString(1, user.getUserName());
            st.setString(2, user.getFirstName());
            st.setString(3, user.getLastName());
            st.setString(4, user.getPassword());
            st.setString(5, user.getEmail());
            st.setString(6, user.getPhoneNumber());
            st.setObject(7,user.getCreateDate());
            st.setObject(8,user.getAvatar());
            st.setObject(9,user.getGender());
            st.setObject(10,user.getAge());
            st.setObject(11,user.getRole().getRoleId());
            st.setObject(12,user.getStatus());
            st.setInt(13,user.getUserId());

            int affectedRows = st.executeUpdate();

            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating user account: " + ex.getMessage());
            return false;
        }
    }

    @Override
    public boolean delete(User user) {
        return false;
    }

    @Override
    public int insert(User user) {
        String sql = "INSERT INTO [dbo].[Users]\n" +
                "           ([Username]\n" +
                "           ,[FirstName]\n" +
                "           ,[LastName]\n" +
                "           ,[Password]\n" +
                "           ,[Email]\n" +
                "           ,[PhoneNumber]\n" +
                "           ,[CreatedDate]\n" +
                "           ,[Gender]\n" +
                "           ,[Avatar]\n" +
                "           ,[Age]\n" +
                "           ,[RoleID]\n" +
                "           ,[Status])\n" +
                "     VALUES\n" +
                "          ?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?\n" +
                "           ,?)";

        try (PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setObject(1, user.getUserName());
            st.setString(2, user.getFirstName());
            st.setString(3, user.getLastName());
            st.setString(4, user.getPassword());
            st.setString(5, user.getEmail());
            st.setString(6, user.getPhoneNumber());
            st.setObject(7, user.getCreateDate());
            st.setObject(8, user.getGender());
            st.setObject(9, user.getAvatar());
            st.setObject(10, user.getAge());
            st.setInt(11, user.getRole().getRoleId());
            st.setObject(12, user.getStatus());

            int affectedRows = st.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating new user failed, no rows affected.");
            }
            try (ResultSet generatedKeys = st.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error inserting user: " + ex.getMessage());
            return -1; // Return -1 to indicate failure
        }    }

    @Override
    public User getFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("UserID"));
        user.setUserName(rs.getString("Username"));
        user.setFirstName(rs.getString("FirstName"));
        user.setLastName(rs.getString("LastName"));
        user.setPassword(rs.getString("Password"));
        user.setEmail(rs.getString("Email"));
        user.setPhoneNumber(rs.getString("PhoneNumber"));
        user.setCreateDate(rs.getDate("CreatedDate"));
        user.setGender(rs.getString("Gender"));
        user.setAvatar(rs.getString("Avatar"));
        user.setAge(rs.getInt("Age"));
        int roleID = rs.getInt("RoleID");
        user.setRole(new Role(roleID));
        user.setStatus(rs.getBoolean("Status"));
        return user;
    }

    public List<User> findAllNonAdminAccounts(int page, int pageSize) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE RoleID != ? ORDER BY UserID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;\n";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setObject(1, 1);
            st.setObject(2, (page-1)*pageSize);
            st.setObject(3, pageSize);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    users.add(getFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error finding non admin accounts: " + e.getMessage());
        }
        return users;
    }

    public int getTotalNonAdminAccount() {
        String sql = "SELECT COUNT(*) FROM Users WHERE RoleID != ?";
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, 1);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("error finding non admin accounts: " + e.getMessage());
        }
        return 0;
    }


    public User findById(int id) {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            try{
                ResultSet rs = st.executeQuery();
                User user = getFromResultSet(rs);
                if(user != null) {
                    return user;
                }
            } catch (SQLException e) {
                System.out.println("User not exist: " + e.getMessage());
            }
        } catch (SQLException e) {
            System.out.println("Error finding user: " + e.getMessage());
        }
        return null;
    }

    public boolean updateUser(User user) {
        String sql = "\n" +
                "UPDATE [dbo].[Users]\n" +
                "      Set[FirstName] = ?\n" +
                "      ,[LastName] = ?\n" +
                "      ,[Email] = ?\n" +
                "      ,[PhoneNumber] =?\n" +
                "      ,[Gender] = ?\n" +
                "      ,[Age] = ?\n" +
                " WHERE UserID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            //st.setString(1, account.getUsername());
            st.setString(1, user.getFirstName());
            st.setString(2, user.getLastName());
            st.setString(3, user.getEmail());
            st.setString(4, user.getPhoneNumber());
            st.setObject(5,user.getGender());
            st.setObject(6,user.getAge());
            st.setInt(7,user.getUserId());

            int rowsUpdated =st.executeUpdate();
            System.out.println("update user");
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating user account: " + ex.getMessage());
            return false;
        }
    }
        public static void main(String[] args) {
        User u = new User("duy1","duy1","duynguyenthe195@gmail.com","0825239239","male",22,2);
        UserDAO ud= new UserDAO();
        ud.updateUser(u);
    }
}
