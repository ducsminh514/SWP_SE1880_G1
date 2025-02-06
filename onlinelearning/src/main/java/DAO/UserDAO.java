package DAO;

import Module.User;
import Module.Role;
import dal.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static java.sql.DriverManager.getConnection;

public class UserDAO extends DBContext implements GenericDAO<User> {
    @Override
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

        String sql = "UPDATE Users SET "
                + "FirstName = ?, "
                + "LastName = ?, "
                + "Gender = ?, "
                + "Email = ?, "
                + "PhoneNumber = ?, "
                + "RoleID = ?, "
                + "Status = ? "
                + "WHERE UserID = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setString(1, user.getFirstName());
            st.setString(2, user.getLastName());
            st.setBoolean(3, user.isGender());
            st.setString(4, user.getEmail());
            st.setString(5, user.getPhoneNumber());
            st.setInt(6, user.getRole().getRoleId());
            st.setBoolean(7, user.isStatus());
            st.setInt(8, user.getUserId());

            int affectedRows = st.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("err when update from dao: " + ex.getMessage());
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
            st.setObject(8, user.isGender());
            st.setObject(9, user.getAvatar());
            st.setObject(10, user.getAge());
            st.setInt(11, user.getRole().getRoleId());
            st.setObject(12, user.isStatus());

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
        }
    }

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
        user.setGender(rs.getBoolean("Gender"));
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
            st.setObject(2, (page - 1) * pageSize);
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
        try {
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
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return getFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error finding user: " + e.getMessage());
        }
        return null;
    }

    public boolean deactiveAccount(int id) {
        String sql = "UPDATE Users SET Status = 0 WHERE UserID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            int affectedRow = st.executeUpdate();
            return affectedRow > 0;

        } catch (SQLException e) {
            System.out.println("Error deactivating user: " + e.getMessage());
        }
        return false;
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
            params.add(Integer.parseInt(gender)); // Chuyển string sang int vì Gender là bit
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
            params.add(Integer.parseInt(gender));
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
            e.printStackTrace(); // In stack trace để debug
        }
        return 0;
    }
}
