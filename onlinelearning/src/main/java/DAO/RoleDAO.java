package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import Module.Role;

public class RoleDAO extends DBContext {
    public Role getByRoleID(int id) {
    String sql = "select * from Role where RoleID=?";

        Role role = new Role();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
               role.setRoleId(rs.getInt("roleId"));
               role.setRoleName(rs.getString("roleName"));

            }

        } catch (SQLException e) {
            System.out.println("ngu");
        }
        return role;
    }





}
