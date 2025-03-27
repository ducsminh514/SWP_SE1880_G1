package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.Marketing ;
public class MarketingDAO extends DBContext {
    public ArrayList<Marketing> getAll() {
        String sql = "select * from Marketing";
        ArrayList<Marketing> listMarketing = new ArrayList<>();
        UserDAO uDAO = new UserDAO();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Marketing m = new Marketing();
                m.setMarketingId(rs.getInt("MarketingID"));
                m.setUser(uDAO.getByID(rs.getInt("UserID")));
                m.setExperienceYear(rs.getInt("ExperienceYears"));
                listMarketing.add(m);
            }

            return listMarketing;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listMarketing;
    }

    public Marketing getByID(int id) {
        String sql ="Select * from Marketing where MarketingID =?";
        UserDAO uDAO = new UserDAO();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1,id);
            ResultSet rs = pre.executeQuery();
            Marketing m = new Marketing();
            while (rs.next()) {
                m.setMarketingId(rs.getInt("MarketingID"));
                m.setUser(uDAO.getByID(rs.getInt("UserID")));
                m.setExperienceYear(rs.getInt("ExperienceYears"));
            }

            return m;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}
