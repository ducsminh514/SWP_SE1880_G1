package dal;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBContext {
    private static HikariDataSource dataSource;
    protected Connection connection;

    public DBContext() {
        try {
            if (dataSource == null) { // Chỉ khởi tạo pool một lần
                HikariConfig config = new HikariConfig();
                config.setJdbcUrl("jdbc:sqlserver://localhost:1433;databaseName=SWP5");
                config.setUsername("sa");
                config.setPassword("123");
                config.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                config.setMaximumPoolSize(1000); // Số kết nối tối đa trong pool
                dataSource = new HikariDataSource(config);
            }
            // Lấy Connection từ pool và gán cho biến instance
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Getter để DAO lấy Connection
    public Connection getConnection() {
        return connection;
    }

    // Phương thức để đóng Connection nếu cần (tùy chọn)
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close(); // Trả Connection về pool
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}

