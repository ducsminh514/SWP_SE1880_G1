package Module;

import java.util.Date;
public class ReviewPost {
    private int reviewPostId ;
    private Post post ;
    private Customer customer ;
    private float rating ;
    private String comment ;
    private Date reviewDate ;
    private boolean status ;

    public ReviewPost() {
    }

    public ReviewPost(int reviewPostId, Post post, Customer customer, float rating, String comment, Date reviewDate, boolean status) {
        this.reviewPostId = reviewPostId;
        this.post = post;
        this.customer = customer;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.status = status;
    }

    public int getReviewPostId() {
        return reviewPostId;
    }

    public void setReviewPostId(int reviewPostId) {
        this.reviewPostId = reviewPostId;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
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
}
