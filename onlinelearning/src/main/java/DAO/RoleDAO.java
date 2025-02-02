package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import Module.Role;

public class RoleDAO extends DBContext {
    public Role getByRoleID(int id) {
    String sql = "select * from Roles where RoleID=?";

        Role role = new Role();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
               role.setRoleId(rs.getInt("roleId"));
               role.setRoleName(rs.getString("roleName"));
               System.out.println("getByRoleID");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return role;
    }
//    public static void main(String[] args) {
//        RoleDAO r= new RoleDAO();
//        r.getByRoleID(2);
//    }




}
