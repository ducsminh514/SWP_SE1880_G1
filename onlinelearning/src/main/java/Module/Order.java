package Module;

import java.util.Date;

/**
 * Lớp Order để lưu trữ thông tin giao dịch thanh toán
 */
public class Order {
    private int orderId;
    private String orderCode;
    private PriceCourse pricePackage;
    private Customer customer;
    private double amount;
    private String transactionCode;
    private Date orderDate;
    private String status; // true = SUCCESS, false = PENDING


    public Order() {
    }

    public Order(int orderId, String orderCode, PriceCourse pricePackage, Customer customer, double amount, String transactionCode, Date orderDate, String status) {
        this.orderId = orderId;
        this.orderCode = orderCode;
        this.pricePackage = pricePackage;
        this.customer = customer;
        this.amount = amount;
        this.transactionCode = transactionCode;
        this.orderDate = orderDate;
        this.status = status;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public PriceCourse getPricePackage() {
        return pricePackage;
    }

    public void setPricePackage(PriceCourse pricePackage) {
        this.pricePackage = pricePackage;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
