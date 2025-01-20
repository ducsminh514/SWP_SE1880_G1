package Module;

import java.util.Date;

public class Enrollment {
    private int enrollmentId;
    private Course course;
    private Customer customer ;
    private Date enrollDate ;

    public Enrollment(int enrollmentId, Course course, Customer customer, Date enrollDate) {
        this.enrollmentId = enrollmentId;
        this.course = course;
        this.customer = customer;
        this.enrollDate = enrollDate;
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
}
