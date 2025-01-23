package Module;

import java.util.Date;

public class Subject {
    private int subjectId ;
    private Course course ;
    private String subjectName ;
    private String description ;
    private int orderNo ;
    private Date createDate ;

    public Subject(int subjectId, Course course, String subjectName, String description, int orderNo, Date createDate) {
        this.subjectId = subjectId;
        this.course = course;
        this.subjectName = subjectName;
        this.description = description;
        this.orderNo = orderNo;
        this.createDate = createDate;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

}

