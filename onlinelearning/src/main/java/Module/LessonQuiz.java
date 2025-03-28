package Module;

public class LessonQuiz {
    private int LessonQuizID;
    private Lesson lesson;
    private int PassPercentage;
    private int TimeLimit;
    private int AttemptAllowed;
    private boolean Status;
    private String ImageUrl;
    private String Mp3Url;

    public LessonQuiz() {
    }

    public int getLessonQuizID() {
        return LessonQuizID;
    }

    public void setLessonQuizID(int lessonQuizID) {
        LessonQuizID = lessonQuizID;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    public int getPassPercentage() {
        return PassPercentage;
    }

    public void setPassPercentage(int passPercentage) {
        PassPercentage = passPercentage;
    }

    public int getTimeLimit() {
        return TimeLimit;
    }

    public void setTimeLimit(int timeLimit) {
        TimeLimit = timeLimit;
    }

    public int getAttemptAllowed() {
        return AttemptAllowed;
    }

    public void setAttemptAllowed(int attemptAllowed) {
        AttemptAllowed = attemptAllowed;
    }

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean status) {
        Status = status;
    }

    public String getImageUrl() {
        return ImageUrl;
    }

    public void setImageUrl(String imageUrl) {
        ImageUrl = imageUrl;
    }

    public String getMp3Url() {
        return Mp3Url;
    }

    public void setMp3Url(String mp3Url) {
        Mp3Url = mp3Url;
    }
}
