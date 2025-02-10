package Module;

import java.util.Date;

public class Enrollment {
    private int enrollmentId;
    private Course course;
    private Customer customer ;
    private Date enrollDate ;
    private float processPercentage ;
    private boolean status ;
    private String payCode ;

    public Enrollment() {
    }

    public Enrollment(int enrollmentId, Course course, Customer customer, Date enrollDate, float processPercentage, boolean status, String payCode) {
        this.enrollmentId = enrollmentId;
        this.course = course;
        this.customer = customer;
        this.enrollDate = enrollDate;
        this.processPercentage = processPercentage;
        this.status = status;
        this.payCode = payCode;
    }

    public int getEnrollmentId() {
        return enrollmentId;
    }

    public void setEnrollmentId(int enrollmentId) {
        this.enrollmentId = enrollmentId;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Date getEnrollDate() {
        return enrollDate;
    }

    public void setEnrollDate(Date enrollDate) {
        this.enrollDate = enrollDate;
    }

    public float getProcessPercentage() {
        return processPercentage;
    }

    public void setProcessPercentage(float processPercentage) {
        this.processPercentage = processPercentage;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getPayCode() {
        return payCode;
    }

    public void setPayCode(String payCode) {
        this.payCode = payCode;
    }
}
