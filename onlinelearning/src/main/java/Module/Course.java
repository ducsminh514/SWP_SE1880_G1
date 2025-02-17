package Module;

import java.util.Date;

public class Course {
    private int courseId ;
    private CourseType courseType ;
    private String courseName;
    private  String description ;
    private Date createDate ;
    private float price ;
    private String title ;
    private String thumbnail ;
    private boolean status ;
    private Expert expert ;

    public Course() {
    }

    public Course(int courseId, CourseType courseType, String courseName, String description, Date createDate, float price, String title, String thumbnail, boolean status, Expert expert) {
        this.courseId = courseId;
        this.courseType = courseType;
        this.courseName = courseName;
        this.description = description;
        this.createDate = createDate;
        this.price = price;
        this.title = title;
        this.thumbnail = thumbnail;
        this.status = status;
        this.expert = expert;
    }

    public Course(int courseId, CourseType courseType, String courseName, String description, String title, String thumbnail) {
        this.courseId = courseId;
        this.courseType = courseType;
        this.courseName = courseName;
        this.description = description;
        this.title = title;
        this.thumbnail = thumbnail;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public CourseType getCourseType() {
        return courseType;
    }

    public void setCourseType(CourseType courseType) {
        this.courseType = courseType;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Expert getExpert() {
        return expert;
    }

    public void setExpert(Expert expert) {
        this.expert = expert;
    }
}
