package jav.dal;

import jav.DBContext;
import jav.model.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAO extends DBContext {
    public User checkAuthen(String username, String password) {
        String sql = "select * from Users where (Username=? or Email=?) and Password=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, username);
            st.setString(3, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User();
                return u;
            }
        } catch (SQLException e) {
        }
        return null;
    }
}
