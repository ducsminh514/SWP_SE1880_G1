package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.Marketing;
public class MarketingDAO extends DBContext {
    public ArrayList<Marketing> getAll() {
        String sql = "select * from Marketing";
        ArrayList<Marketing> listMarketing = new ArrayList<>();
        UserDAO uDAO = new UserDAO();
        try {
            connection = getConnection();
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
        } finally {
            closeResources();
        }
        return listMarketing;
    }

    public Marketing getByID(int id) {
        String sql = "SELECT * FROM Marketing WHERE MarketingID = ?";
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                Marketing m = new Marketing();
                m.setMarketingId(rs.getInt("MarketingID"));
                m.setExperienceYear(rs.getInt("ExperienceYears"));

                // Lấy thông tin User từ bảng Users
                int userId = rs.getInt("UserID");
                UserDAO ud = new UserDAO();
                m.setUser(ud.getByID(userId));

                return m;
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            closeResources();
        }
        return null;
    }
    

}
