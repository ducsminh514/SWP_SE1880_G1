/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package subjectlessons;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class AddLesssonDTO {
    private int subjectID;
    private String lessonName;
    private String content;
    private int duration;
    private int orderNo;
    private boolean statusLesson;
    private String videoUrl;
    private Date createdDate;

    public AddLesssonDTO (int subjectID, String lessonName, String content, int duration, int orderNo, boolean statusLesson, String videoUrl, Date createdDate) {
        this.subjectID = subjectID;
        this.lessonName = lessonName;
        this.content = content;
        this.duration = duration;
        this.orderNo = orderNo;
        this.statusLesson = statusLesson;
        this.videoUrl = videoUrl;
        this.createdDate = createdDate;
    }

    public int getSubjectID() { return subjectID; }
    public void setSubjectID(int subjectID) { this.subjectID = subjectID; }
    public String getLessonName() { return lessonName; }
    public void setLessonName(String lessonName) { this.lessonName = lessonName; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }
    public int getOrderNo() { return orderNo; }
    public void setOrderNo(int orderNo) { this.orderNo = orderNo; }
    public boolean isStatusLesson() { return statusLesson; }
    public void setStatusLesson(boolean statusLesson) { this.statusLesson = statusLesson; }
    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}
