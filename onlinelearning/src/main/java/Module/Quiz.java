package Module;

import java.util.Date;

public class Quiz {
    private int quizId ;
    private boolean quizType;
    private String quizName ;
    private int time ;
    private String title ;
    private Date createDate ;
    private Date updateDate ;
    private String level ;
    private float averageMark ;

    public Quiz() {
    }

    public Quiz(int quizId, boolean quizType, String quizName, int time, String title, Date createDate, Date updateDate, String level, float averageMark) {
        this.quizId = quizId;
        this.quizType = quizType;
        this.quizName = quizName;
        this.time = time;
        this.title = title;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.level = level;
        this.averageMark = averageMark;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public boolean isQuizType() {
        return quizType;
    }

    public void setQuizType(boolean quizType) {
        this.quizType = quizType;
    }

    public String getQuizName() {
        return quizName;
    }

    public void setQuizName(String quizName) {
        this.quizName = quizName;
    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public float getAverageMark() {
        return averageMark;
    }

    public void setAverageMark(float averageMark) {
        this.averageMark = averageMark;
    }
}
