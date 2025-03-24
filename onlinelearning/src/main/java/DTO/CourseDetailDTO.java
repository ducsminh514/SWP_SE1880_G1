package DTO;
import Module.Course ;
public class CourseDetailDTO {
    private Course course ;
    private float rating ;
    private float lowestSalePrice ;
    private int totalEnrollment ;
    private float originalPrice ;

    public CourseDetailDTO() {
    }

    public CourseDetailDTO(Course course, float rating, float lowestSalePrice, int totalEnrollment, float originalPrice) {
        this.course = course;
        this.rating = rating;
        this.lowestSalePrice = lowestSalePrice;
        this.totalEnrollment = totalEnrollment;
        this.originalPrice = originalPrice;
    }

    public CourseDetailDTO(Course course, float rating, int totalEnrollment) {
        this.course = course;
        this.rating = rating;
        this.totalEnrollment = totalEnrollment;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public float getLowestSalePrice() {
        return lowestSalePrice;
    }

    public void setLowestSalePrice(float lowestSalePrice) {
        this.lowestSalePrice = lowestSalePrice;
    }

    public int getTotalEnrollment() {
        return totalEnrollment;
    }

    public void setTotalEnrollment(int totalEnrollment) {
        this.totalEnrollment = totalEnrollment;
    }

    public float getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(float originalPrice) {
        this.originalPrice = originalPrice;
    }
}
