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
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.mindrot.jbcrypt.BCrypt;
import DAO.RoleDAO;
public class UserDAO extends DBContext {

    public User checkAuthen(String username, String password) {
        String sql = "select * from Users where (Username=? or Email=?) and Password=?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, username);
            st.setString(3, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                RoleDAO ro = new RoleDAO();
                User u = new User(rs.getInt("userId"), username, rs.getString("firstName"), rs.getString("lastName"),
                        password, rs.getString("email"), rs.getString("phoneNumber"), rs.getDate("CreatedDate"),
                        rs.getString("Gender"), rs.getString("Avatar"), rs.getInt("Age"),
                        ro.getByRoleID(rs.getInt("roleId")), rs.getBoolean("status"));
                System.out.println(u.getUserId());
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try {
            connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                users.add(getFromResultSet(rs));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            closeResources();
        }
        return users;
    }

    public boolean existUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    public void changePassword(String plainPassword, int id) {
        String sql = "update Users set Password = ? where UserID = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, plainPassword);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    public int getIdUserByEmail(String email) {
        String sql = "select * from Users where email = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("userId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    public User getUserByID(int id) {
        String sql = "select*from Users where UserID =?;";
        try {
            connection = getConnection();
            RoleDAO ro = new RoleDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User(rs.getInt("userId"), rs.getString("userName"), rs.getString("firstName"),
                        rs.getString("lastName"), rs.getString("password"), rs.getString("email"),
                        rs.getString("phoneNumber"), rs.getDate("CreatedDate"), rs.getString("Gender"),
                        rs.getString("Avatar"), rs.getInt("Age"), ro.getByRoleID(rs.getInt("roleId")),
                        rs.getBoolean("status"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return null;
    }

    public void insertUser1(User c) {
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([Username]\n"
                + "           ,[FirstName]\n"
                + "           ,[LastName]\n"
                + "           ,[Password]\n"
                + "           ,[Email]\n"
                + "           ,[PhoneNumber]\n"
                + "           ,[Gender]\n"
                + "           ,[Avatar ]\n"
                + "           ,[Age]\n"
                + "           ,[RoleID]\n"
                + "           ,[Status])\n"
                + " Values(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getUserName());
            st.setString(2, c.getFirstName());
            st.setString(3, c.getLastName());
            st.setString(4, c.getPassword());
            st.setString(5, c.getEmail());
            st.setString(6, c.getPhoneNumber());
            st.setString(7, c.getGender());
            st.setString(8, c.getAvatar());
            st.setInt(9, c.getAge());
            st.setInt(10, c.getRole().getRoleId());
            st.setBoolean(11, c.getStatus());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
    }

    public int insertUser2(User c) {
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([Username]\n"
                + "           ,[FirstName]\n"
                + "           ,[LastName]\n"
                + "           ,[Password]\n"
                + "           ,[Email]\n"
                + "           ,[PhoneNumber]\n"
                + "           ,[Gender]\n"
                + "           ,[Avatar]\n"
                + "           ,[Age]\n"
                + "           ,[RoleID]\n"
                + "           ,[Status])\n"
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, c.getUserName());
            st.setString(2, c.getFirstName());
            st.setString(3, c.getLastName());
            st.setString(4, c.getPassword());
            st.setString(5, c.getEmail());
            st.setString(6, c.getPhoneNumber());
            st.setString(7, c.getGender());
            st.setString(8, c.getAvatar());
            st.setInt(9, c.getAge());
            st.setInt(10, c.getRole().getRoleId());
            st.setBoolean(11, c.getStatus());

            st.executeUpdate();
            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return -1;
    }

    public boolean verifyUser(String email) {
        try {
            connection = getConnection();
            String sql = "UPDATE Users SET Status = 1 WHERE Email = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    public int GetIDByUserName(String name) {
        int userID = -1;
        String sql = "SELECT UserID FROM Users WHERE Username = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                userID = rs.getInt("UserID");
            }
        } catch (SQLException e) {
            System.out.println("Error finding user: " + e.getMessage());
        } finally {
            closeResources();
        }
        return userID;
    }

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

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getUserName());
            st.setString(2, user.getFirstName());
            st.setString(3, user.getLastName());
            st.setString(4, user.getPassword());
            st.setString(5, user.getEmail());
            st.setString(6, user.getPhoneNumber());
            st.setObject(7, user.getCreateDate());
            st.setObject(8, user.getAvatar());
            st.setObject(9, user.getGender());
            st.setObject(10, user.getAge());
            st.setObject(11, user.getRole().getRoleId());
            st.setObject(12, user.getStatus());
            st.setInt(13, user.getUserId());

            int affectedRows = st.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating user account: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    public ArrayList<User> getAll() {
        String sql = " select * from Users ";
        ArrayList<User> listAllUser = new ArrayList<>();
        RoleDAO ro = new RoleDAO();
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt("userId"), rs.getString("userName"), rs.getString("firstName"),
                        rs.getString("lastName"), rs.getString("password"), rs.getString("email"),
                        rs.getString("phoneNumber"), rs.getDate("CreatedDate"), rs.getString("Gender"),
                        rs.getString("Avatar"), rs.getInt("Age"), ro.getByRoleID(rs.getInt("roleId")),
                        rs.getBoolean("status"));
                listAllUser.add(u);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return listAllUser;
    }

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

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
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
        } finally {
            closeResources();
        }
    }

    public User getByID(int id) {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                RoleDAO ro = new RoleDAO();
                User u = new User(rs.getInt("userId"),
                        rs.getString("userName"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getDate("CreatedDate"),
                        rs.getString("Gender"),
                        rs.getString("Avatar"),
                        rs.getInt("Age"),
                        ro.getByRoleID(rs.getInt("roleId")),
                        rs.getBoolean("status"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return null;
    }

    public User getFromResultSet(ResultSet rs) throws SQLException {
        RoleDAO roleDAO = new RoleDAO();
        Role role = roleDAO.getByRoleID(rs.getInt("RoleID"));
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
        user.setRole(role);
        user.setStatus(rs.getBoolean("Status"));
        return user;
    }

    public List<User> findAllNonAdminAccounts(int page, int pageSize) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE RoleID != ? ORDER BY UserID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;\n";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setObject(1, 1);
            st.setObject(2, (page - 1) * pageSize);
            st.setObject(3, pageSize);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    users.add(getFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error finding non admin accounts: " + e.getMessage());
        } finally {
            closeResources();
        }
        return users;
    }

    public int getTotalNonAdminAccount() {
        String sql = "SELECT COUNT(*) FROM Users WHERE RoleID != ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, 1);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("error finding non admin accounts: " + e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    public User findById(int id) {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return getFromResultSet(rs);
                }
            } catch (SQLException e) {
                System.out.println("User not exist: " + e.getMessage());
            }
        } catch (SQLException e) {
            System.out.println("Error finding user: " + e.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }

    public boolean deactiveAccount(int id) {
        String sql = "UPDATE Users SET Status = 0 WHERE UserID = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            int affectedRow = st.executeUpdate();
            return affectedRow > 0;
        } catch (SQLException e) {
            System.out.println("Error deactivating user: " + e.getMessage());
        } finally {
            closeResources();
        }
        return false;
    }

    public boolean updateUser(User user) {
        String sql = "\n" +
                "UPDATE [dbo].[Users]\n" +
                "      Set[UserName] = ?\n" +
                "      ,[FirstName] = ?\n" +
                "      ,[LastName] = ?\n" +
                "      ,[Email] = ?\n" +
                "      ,[PhoneNumber] =?\n" +
                "      ,[Gender] = ?\n" +
                "      ,[Avatar] = ?\n" +
                " WHERE UserID = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getUserName());
            st.setString(2, user.getFirstName());
            st.setString(3, user.getLastName());
            st.setString(4, user.getEmail());
            st.setString(5, user.getPhoneNumber());
            st.setObject(6, user.getGender());
            st.setString(7, user.getAvatar());
            st.setInt(8, user.getUserId());

            int rowsUpdated = st.executeUpdate();
            System.out.println("update user");
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating user account: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    public List<User> findUserByFilter(String gender, String status, String role, String search, int page, int pageSize) {
        List<User> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Users WHERE RoleID != 1"); // Admin RoleID = 1
        List<Object> params = new ArrayList<>();

        // Kiểm tra và thêm điều kiện role
        if (role != null && !role.isEmpty()) {
            sql.append(" AND RoleID = ?");
            params.add(Integer.parseInt(role));
        }

        // Kiểm tra và thêm điều kiện gender
        if (gender != null && !gender.isEmpty()) {
            sql.append(" AND Gender = ?");
            params.add(gender);
        }

        // Kiểm tra và thêm điều kiện status
        if (status != null && !status.isEmpty()) {
            sql.append(" AND Status = ?");
            params.add(Boolean.parseBoolean(status)); // Chuyển string sang boolean
        }

        // Kiểm tra và thêm điều kiện search
        if (search != null && !search.isEmpty()) {
            sql.append(" AND (FirstName LIKE ? OR LastName LIKE ? OR Email LIKE ?)");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Thêm phần phân trang
        sql.append(" ORDER BY UserID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql.toString());
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }

            System.out.println("Executing SQL: " + sql.toString()); // Debug
            System.out.println("Parameters: " + params); // Debug

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                users.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error finding user: " + e.getMessage());
            e.printStackTrace(); // In stack trace để debug
        } finally {
            closeResources();
        }
        return users;
    }

    public int getTotalUserByFiler(String gender, String status, String role, String search) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Users WHERE RoleID != 1");
        List<Object> params = new ArrayList<>();

        // Kiểm tra và thêm điều kiện role
        if (role != null && !role.isEmpty()) {
            sql.append(" AND RoleID = ?");
            params.add(Integer.parseInt(role));
        }

        // Kiểm tra và thêm điều kiện gender
        if (gender != null && !gender.isEmpty()) {
            sql.append(" AND Gender = ?");
            params.add(gender);
        }

        // Kiểm tra và thêm điều kiện status
        if (status != null && !status.isEmpty()) {
            sql.append(" AND Status = ?");
            params.add(Boolean.parseBoolean(status));
        }

        // Kiểm tra và thêm điều kiện search
        if (search != null && !search.isEmpty()) {
            sql.append(" AND (FirstName LIKE ? OR LastName LIKE ? OR Email LIKE ?)");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql.toString());
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }

            System.out.println("Count SQL: " + sql.toString()); // Debug
            System.out.println("Count Parameters: " + params); // Debug

            ResultSet rs = st.executeQuery(); // Sử dụng executeQuery thay vì execute
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting users: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    public User getUserByName(String username, String email) {
        String sql = "select*from Users where Username =? or Email =?";
        try {
            connection = getConnection();
            RoleDAO ro = new RoleDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User(rs.getInt("userId"), username, rs.getString("firstName"), rs.getString("lastName"),
                        rs.getString("password"), rs.getString("email"), rs.getString("phoneNumber"),
                        rs.getDate("CreatedDate"), rs.getString("Gender"), rs.getString("Avatar"),
                        rs.getInt("Age"), ro.getByRoleID(rs.getInt("roleId")), rs.getBoolean("status"));
                System.out.println(u.getUserId());
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return null;
    }

    public static void main(String[] args) {
        System.out.println(new UserDAO().checkAuthen("customer01", "Minh@123456789"));
    }
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try {
            RoleDAO roleDAO = new RoleDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User user = new User(
                        rs.getInt("userId"),
                        rs.getString("userName"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phoneNumber"),
                        rs.getDate("CreatedDate"),
                        rs.getString("Gender"),
                        rs.getString("Avatar"),
                        rs.getInt("Age"),
                        roleDAO.getByRoleID(rs.getInt("roleId")),
                        rs.getBoolean("status")
                );
                System.out.println("getUserByEmail: Found user with ID " + user.getUserId());
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Error getting user by email: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

}
