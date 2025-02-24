package Module;

import java.sql.Date;
import java.util.List;
import Module.CourseType;
public class Question {
    private int questionId;
    private String content;
    private int level;
    private CourseType courseType;
    private int mark;
    private int questionType;
    private boolean status;
    private Date createTime;
    private Date updateTime;

    public Question(int questionId, String content, int level, CourseType courseType, int mark, int questionType, boolean status, Date createTime, Date updateTime) {
        this.questionId = questionId;
        this.content = content;
        this.level = level;
        this.courseType = courseType;
        this.mark = mark;
        this.questionType = questionType;
        this.status = status;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    public Question(int id) {
        this.questionId = id;
    }
    public Question() {}

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public CourseType getCourseType() {
        return courseType;
    }

    public void setCourseType(CourseType courseType) {
        this.courseType = courseType;
    }

    public int getMark() {
        return mark;
    }

    public void setMark(int mark) {
        this.mark = mark;
    }

    public int getQuestionType() {
        return questionType;
    }

    public void setQuestionType(int questionType) {
        this.questionType = questionType;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "Question{" +
                "questionId=" + questionId +
                ", content='" + content + '\'' +
                ", level=" + level +
                ", courseType=" + courseType +
                ", mark=" + mark +
                ", questionType=" + questionType +
                ", status=" + status +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
