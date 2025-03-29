package DAO;

import Module.Order;
import Module.Customer;
import Module.PriceCourse;
import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * DAO class for handling Order database operations
 */
public class OrderDAO extends DBContext {

    /**
     * Thêm đơn hàng mới vào cơ sở dữ liệu
     * 
     * @param order Đối tượng Order cần thêm
     * @return ID của đơn hàng được thêm vào, -1 nếu thất bại
     */
    public int insertOrder(Order order) {
        String sql = "INSERT INTO Orders (OrderCode, PriceID, CustomerID, " +
                     "Amount, TransactionCode, OrderDate, Status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            st.setString(1, order.getOrderCode());
            
            if (order.getPricePackage() != null) {
                st.setInt(2, order.getPricePackage().getPriceId());
            } else {
                st.setNull(2, java.sql.Types.INTEGER);
            }
            
            if (order.getCustomer() != null) {
                st.setInt(3, order.getCustomer().getCustomerId());
            } else {
                st.setNull(3, java.sql.Types.INTEGER);
            }
            
            st.setDouble(4, order.getAmount());
            st.setString(5, order.getTransactionCode());
            
            // Convert Java util.Date to SQL Timestamp
            st.setTimestamp(6, new Timestamp(order.getOrderDate().getTime()));
            
            st.setString(7, order.getStatus()); // true = SUCCESS, false = PENDING
            
            int affectedRows = st.executeUpdate();
            
            if (affectedRows == 0) {
                return -1;
            }
            
            try (ResultSet generatedKeys = st.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    return -1;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error inserting order: " + e.getMessage());
            e.printStackTrace();
            return -1;
        }
    }
    
    /**
     * Cập nhật mã giao dịch và trạng thái đơn hàng
     * 
     * @param orderId ID của đơn hàng cần cập nhật
     * @param transactionCode Mã giao dịch mới
     * @param status Trạng thái mới (true = SUCCESS, false = PENDING)
     * @return true nếu cập nhật thành công, false nếu thất bại
     */
    public boolean updateOrderTransaction(int orderId, String transactionCode, String status) {
        String sql = "UPDATE Orders SET TransactionCode = ?, Status = ? WHERE OrderID = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, transactionCode);
            st.setString(2, status);
            st.setInt(3, orderId);
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating order transaction: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Lấy đơn hàng theo ID
     * 
     * @param orderId ID của đơn hàng cần lấy
     * @return Đối tượng Order, null nếu không tìm thấy
     */
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting order by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Lấy đơn hàng theo mã đơn hàng
     * 
     * @param orderCode Mã đơn hàng cần tìm
     * @return Đối tượng Order, null nếu không tìm thấy
     */
    public Order getOrderByCode(String orderCode) {
        String sql = "SELECT * FROM Orders WHERE OrderCode = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, orderCode);
            
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting order by code: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Lấy tất cả đơn hàng của một khách hàng
     * 
     * @param customerId ID của khách hàng
     * @return Danh sách đơn hàng
     */
    public List<Order> getOrdersByCustomer(int customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE CustomerID = ? ORDER BY OrderDate DESC";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerId);
            
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting orders by customer: " + e.getMessage());
            e.printStackTrace();
        }
        
        return orders;
    }
    
    /**
     * Lấy tất cả đơn hàng của một gói giá
     * 
     * @param priceId ID của gói giá
     * @return Danh sách đơn hàng
     */
    public List<Order> getOrdersByPricePackage(int priceId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE PriceID = ? ORDER BY OrderDate DESC";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, priceId);
            
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting orders by price package: " + e.getMessage());
            e.printStackTrace();
        }
        
        return orders;
    }
    
    /**
     * Lấy tất cả đơn hàng thành công
     * 
     * @return Danh sách đơn hàng thành công
     */
    public List<Order> getSuccessfulOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE Status = 1 ORDER BY OrderDate DESC";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting successful orders: " + e.getMessage());
            e.printStackTrace();
        }
        
        return orders;
    }
    
    /**
     * Chuyển đổi ResultSet thành đối tượng Order
     * 
     * @param rs ResultSet chứa dữ liệu đơn hàng
     * @return Đối tượng Order
     * @throws SQLException Nếu có lỗi khi truy cập dữ liệu
     */
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        
        order.setOrderId(rs.getInt("OrderID"));
        order.setOrderCode(rs.getString("OrderCode"));
        
        // Lấy thông tin gói giá
        int priceId = rs.getInt("PriceID");
        if (!rs.wasNull()) {
            PriceCourseDAO priceCourseDAO = new PriceCourseDAO();
            PriceCourse pricePackage = priceCourseDAO.getById(priceId);
            order.setPricePackage(pricePackage);
        }
        
        // Lấy thông tin khách hàng
        int customerId = rs.getInt("CustomerID");
        if (!rs.wasNull()) {
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerById(customerId);
            order.setCustomer(customer);
        }
        
        order.setAmount(rs.getDouble("Amount"));
        order.setTransactionCode(rs.getString("TransactionCode"));
        
        // Chuyển đổi từ Timestamp sang Date
        Timestamp orderDateTimestamp = rs.getTimestamp("OrderDate");
        if (orderDateTimestamp != null) {
            order.setOrderDate(new Date(orderDateTimestamp.getTime()));
        }
        
        order.setStatus(rs.getString("Status"));

        
        return order;
    }
    
    /**
     * Đếm số lượng đơn hàng thành công cho một gói giá
     * 
     * @param priceId ID của gói giá
     * @return Số lượng đơn hàng thành công
     */
    public int getSuccessfulOrderCountForPricePackage(int priceId) {
        String sql = "SELECT COUNT(*) FROM Orders WHERE PriceID = ? AND Status = 1";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, priceId);
            
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting order count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    /**
     * Xóa đơn hàng theo ID
     * 
     * @param orderId ID của đơn hàng cần xóa
     * @return true nếu xóa thành công, false nếu thất bại
     */
    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM Orders WHERE OrderID = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting order: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
} 