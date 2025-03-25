package Module;

import java.util.Date;

public class QuizAttend {
    private int QuizAttendID;
    private User user;
    private LessonQuiz lessonQuiz;
    private double score;
    private boolean passed;
    private Date StartTime;
    private Date EndTime;

    public QuizAttend() {
    }

    public int getQuizAttendID() {
        return QuizAttendID;
    }

    public void setQuizAttendID(int quizAttendID) {
        QuizAttendID = quizAttendID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LessonQuiz getLessonQuiz() {
        return lessonQuiz;
    }

    public void setLessonQuiz(LessonQuiz lessonQuiz) {
        this.lessonQuiz = lessonQuiz;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public boolean isPassed() {
        return passed;
    }

    public void setPassed(boolean passed) {
        this.passed = passed;
    }

    public Date getStartTime() {
        return StartTime;
    }

    public void setStartTime(Date startTime) {
        StartTime = startTime;
    }

    public Date getEndTime() {
        return EndTime;
    }

    public void setEndTime(Date endTime) {
        EndTime = endTime;
    }
}
