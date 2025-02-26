/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Administrator
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            // Edit URL , username, password to authenticate with your MS SQL Server
            String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP391;encrypt=false";
            String username = "sa";
            String password = "123";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
    }
    public ResultSet getData(String sql) {
        ResultSet rs = null;
        try {
            Statement state = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            rs = state.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }

    public int getTotalRecord(String sql) {
        int countPage = 0;
        ResultSet rs = this.getData(sql);
        try {
            while (rs.next()) {
                countPage++;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return countPage;
    }

    public static void main(String[] args) {
        DBContext db = new DBContext();
        System.out.println(db.connection);
    }
}

