package Module;

import java.util.Date;

public class ReviewLesson {
    private int reviewLessonId ;
    private Lesson lesson ;
    private Customer customer ;
    private String comment ;
    private Date reviewDate ;
    private boolean status ;
    private String reviewFeedback ;

    public ReviewLesson() {
    }

    public ReviewLesson(int reviewLessonId, Lesson lesson, Customer customer, String comment, Date reviewDate, boolean status, String reviewFeedback) {
        this.reviewLessonId = reviewLessonId;
        this.lesson = lesson;
        this.customer = customer;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.status = status;
        this.reviewFeedback = reviewFeedback;
    }

    public int getReviewLessonId() {
        return reviewLessonId;
    }

    public void setReviewLessonId(int reviewLessonId) {
        this.reviewLessonId = reviewLessonId;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
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
