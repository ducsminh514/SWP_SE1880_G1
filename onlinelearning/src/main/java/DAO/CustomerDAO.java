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

            }

            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return listExpert;
    }

    public Expert getByID(int id) {
        ArrayList<Expert> list = getAll();
        for (Expert e : list) {
            if (e.getExpertId() == id) {
                return e;
            }
        }
        return null;
    }
}
