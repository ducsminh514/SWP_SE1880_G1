package dal;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBContext1 {
    private static final String SERVER_NAME = "localhost";
    private static final String DATABASE_NAME = "SWP10";
    private static final String USERNAME = "sa";

    private static final String PASSWORD = "123456";

    private static final int PORT = 1433;

    private static HikariDataSource dataSource;

    static {
        try {
            // Đảm bảo driver được đăng ký (không bắt buộc với driver mới, nhưng thêm để chắc chắn)
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl("jdbc:sqlserver://" + SERVER_NAME + ":" + PORT + ";databaseName=" + DATABASE_NAME);
            config.setUsername(USERNAME);
            config.setPassword(PASSWORD);

            // Tắt mã hóa SSL hoặc bật trustServerCertificate nếu không dùng SSL
            config.addDataSourceProperty("encrypt", "false");
            config.addDataSourceProperty("trustServerCertificate", "true");

            // Cấu hình pool
            config.setMinimumIdle(5);
            config.setMaximumPoolSize(100);
            config.setConnectionTimeout(30000); // 30 giây
            config.setIdleTimeout(600000);      // 10 phút
            config.setMaxLifetime(1800000);     // 30 phút

            // Khởi tạo DataSource
            dataSource = new HikariDataSource(config);
            System.out.println("DataSource initialized successfully!");
        } catch (Exception e) {
            System.err.println("Failed to initialize DataSource: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource is not initialized. Check logs for initialization errors.");
        }
        return dataSource.getConnection();
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}