package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Module.Customer;
import dal.DBContext;

public class CustomerDAO extends DBContext {
    public ArrayList<Customer> getAll() {
        String sql = "select * from Customers";
        ArrayList<Customer> listCustomer = new ArrayList<>();
        UserDAO uDAO = new UserDAO();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerId(rs.getInt("CustomerID"));
                c.setSocialRole(rs.getString("SocialRole"));
                c.setLevelOfEnglish(rs.getString("LevelOfEnglish"));
                c.setUser(uDAO.getByID(rs.getInt("UserID")));
                listCustomer.add(c) ;
            }
            return listCustomer ;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listCustomer;
    }

    public Customer getByID(int id) {
        ArrayList<Customer> list = getAll();
        for (Customer e : list) {
            if (e.getCustomerId() == id) {
                return e;
            }
        }
        return null;
    }
}
