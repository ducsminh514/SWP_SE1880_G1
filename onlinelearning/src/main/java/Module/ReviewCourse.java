package Module;

import java.util.Date;

public class ReviewCourse {
    private int reviewCourseId ;
    private Course course ;
    private Customer customer ;
    private float rating ;
    private String comment ;
    private Date reviewDate ;
    private boolean status ;
    private String reviewFeedback ;

    public ReviewCourse() {
    }

    public ReviewCourse(int reviewCourseId, Course course, Customer customer, float rating, String comment, Date reviewDate, boolean status, String reviewFeedback) {
        this.reviewCourseId = reviewCourseId;
        this.course = course;
        this.customer = customer;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.status = status;
        this.reviewFeedback = reviewFeedback;
    }

    public int getReviewCourseId() {
        return reviewCourseId;
    }

    public void setReviewCourseId(int reviewCourseId) {
        this.reviewCourseId = reviewCourseId;
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

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getReviewFeedback() {
        return reviewFeedback;
    }

    public void setReviewFeedback(String reviewFeedback) {
        this.reviewFeedback = reviewFeedback;
    }
}
