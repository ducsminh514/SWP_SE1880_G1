package Module;

import java.sql.Date;
import java.util.List;
import Module.CourseType;
import Module.QuestionType;


public class Question {
    private int questionId;
    private String content;
    private int level;
    private Subject subject;
    private int mark;
    private QuestionType questionType;
    private boolean status;
    private Date createTime;
    private Date updateTime;
    private List<QuestionImage> questionImage;
    private int lessonQuizId;
    private String mp3;

    public Question() {
    }

    public Question(int questionId, String content, int level, Subject subject, int mark,
     QuestionType questionType, boolean status, Date createTime, Date updateTime,
      List<QuestionImage> questionImage, String mp3, int lessonQuizId) {
        this.questionId = questionId;
        this.content = content;
        this.level = level;
        this.subject = subject;
        this.mark = mark;
        this.questionType = questionType;
        this.status = status;
        this.createTime = createTime;
        this.updateTime = updateTime;
        this.questionImage = questionImage;
        this.mp3 = mp3;
        this.lessonQuizId = lessonQuizId;
    }

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

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public int getMark() {
        return mark;
    }

    public void setMark(int mark) {
        this.mark = mark;
    }

    public QuestionType getQuestionType() {
        return questionType;
    }

    public void setQuestionType(QuestionType questionType) {
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

    public List<QuestionImage> getQuestionImage() {
        return questionImage;
    }

    public void setQuestionImage(List<QuestionImage> questionImage) {
        this.questionImage = questionImage;
    }

    public String getMp3() {
        return mp3;
    }

    public void setMp3(String mp3) {
        this.mp3 = mp3;
    }

    public int getLessonQuizId() {
        return lessonQuizId;
    }
    
    public void setLessonQuizId(int lessonQuizId) {
        this.lessonQuizId = lessonQuizId;
    }
}
