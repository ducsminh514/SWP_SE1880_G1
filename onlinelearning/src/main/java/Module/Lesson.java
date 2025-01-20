package Module;

import java.util.Date;

public class Lesson {
    private int lessonId;
    private Subject subject ;
    private String lessonName ;
    private String content ;
    private int duration ;
    private int orderNo ;
    private boolean status ;
    private String video_url ;
    private Date createDate ;
    private String description ;

    public Lesson(int lessonId, Subject subject, String lessonName, String content, int duration, int orderNo, boolean status, String video_url, Date createDate, String description) {
        this.lessonId = lessonId;
        this.subject = subject;
        this.lessonName = lessonName;
        this.content = content;
        this.duration = duration;
        this.orderNo = orderNo;
        this.status = status;
        this.video_url = video_url;
        this.createDate = createDate;
        this.description = description;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getVideo_url() {
        return video_url;
    }

    public void setVideo_url(String video_url) {
        this.video_url = video_url;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
