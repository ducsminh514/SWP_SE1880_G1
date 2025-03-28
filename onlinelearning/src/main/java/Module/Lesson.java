package Module;

import java.util.Date;

public class Lesson {
    private int lessonId;
    private int subjectId;
    private String lessonName;
    private String content;
    private int duration;
    private int orderNo;
    private Boolean statusLesson;
    private Date createdDate;
    private String type;
    private Date updateDate;
    private boolean completed;

    public Lesson() {
    }

    public Lesson(int lessonId, int subjectId, String lessonName, String content, 
                 int duration, int orderNo, Boolean statusLesson, Date createdDate, 
                 String type, Date updateDate) {
        this.lessonId = lessonId;
        this.subjectId = subjectId;
        this.lessonName = lessonName;
        this.content = content;
        this.duration = duration;
        this.orderNo = orderNo;
        this.statusLesson = statusLesson;
        this.createdDate = createdDate;
        this.type = type;
        this.updateDate = updateDate;
        this.completed = false;
    }

    // Getters and Setters
    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getLessonName() {
        return lessonName;
    }

    public void setLessonName(String lessonName) {
        this.lessonName = lessonName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public Boolean getStatusLesson() {
        return statusLesson;
    }

    public void setStatusLesson(Boolean statusLesson) {
        this.statusLesson = statusLesson;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }
}
