package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.Marketing ;
public class MarketingDAO extends DBContext {
    public ArrayList<Marketing> getAll() {
        String sql = "select * from Experts";
        ArrayList<Marketing> listMarketing = new ArrayList<>();
        UserDAO uDAO = new UserDAO();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Marketing m = new Marketing();
                m.setMarketingId(rs.getInt("MarketingID"));
                m.setUser(uDAO.getUserByID(rs.getInt("UserID")));
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
        ArrayList<Marketing> list = getAll();
        for(Marketing m : list){
            if(m.getMarketingId() == id){
                return m;
            }
        }
        return null;
    }
}
