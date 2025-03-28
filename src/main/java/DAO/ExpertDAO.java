package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.Expert;
public class ExpertDAO extends DBContext {
    public ArrayList<Expert> getAll() {
        String sql = "select * from Experts";
        ArrayList<Expert> listExpert = new ArrayList<>();
        UserDAO uDAO = new UserDAO();
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
               Expert e = new Expert();
               e.setExpertId(rs.getInt("ExpertID"));
               e.setBio(rs.getString("Bio"));
               e.setExperienceYear(rs.getInt("ExperienceYears"));
               e.setProfileImage(rs.getString("ProfileImage"));
               e.setUser(uDAO.getByID(rs.getInt("UserID")));
               listExpert.add(e);
            }

            return listExpert;
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return listExpert;
    }

    public Expert getByID(int id) {
        String sql = "select * from Experts where ExpertID = ?";
        UserDAO uDAO = new UserDAO();
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                Expert e = new Expert();
                e.setExpertId(rs.getInt("ExpertID"));
                e.setBio(rs.getString("Bio"));
                e.setExperienceYear(rs.getInt("ExperienceYears"));
                e.setProfileImage(rs.getString("ProfileImage"));
                e.setUser(uDAO.getByID(rs.getInt("UserID")));
                return e;
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return null;
    }
    

}
