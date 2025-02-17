package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import  Module.User;
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
                c.setUser(uDAO.getUserByID(rs.getInt("UserID")));
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
    public int GetIDCustomerByID(int iduser){
        int customerID = -1;
        String sql = "SELECT * FROM Customers WHERE UserID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1,iduser);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                customerID = rs.getInt("CustomerID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customerID;
    }

        public static void main(String[] args) {
          CustomerDAO cdao= new CustomerDAO();
          String a = "hihi";
          User c= new User(2);
          Customer ab = new Customer(a,a,c);
          cdao.insertUser1(ab);
    }
public void insertUser1(Customer c) {
    String sql = "INSERT INTO Customers (SocialRole, LevelOfEnglish, UserID) VALUES (?, ?, ?)";
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1,c.getSocialRole());
        st.setString(2,c.getLevelOfEnglish());
        st.setInt(3,c.getUser().getUserId());
        st.executeUpdate();

    } catch (SQLException e) {
        System.out.println(e);
    }
}
}
