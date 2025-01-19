/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Module.User;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Acer
 */
public class UserDAO extends DBContext {

    public User getUserByID(int id) {

        String sql = "select*from Users where UserID =?;";
        try {
            RoleDAO ro = new RoleDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
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
                System.out.println(u.getUserId());
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return null;
    }
}
