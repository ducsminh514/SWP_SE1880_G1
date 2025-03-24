package Module;

import java.util.Date;

/**
 * Model class representing a lesson completion record.
 * This tracks when a user completes a specific lesson.
 */
public class LessonCompletion {
    private int completionId;
    private int lessonId;
    private int userId;
    private Date completionDate;
    
    public LessonCompletion() {
    }
    
    public LessonCompletion(int completionId, int lessonId, int userId, Date completionDate) {
        this.completionId = completionId;
        this.lessonId = lessonId;
        this.userId = userId;
        this.completionDate = completionDate;
    }

    public int getCompletionId() {
        return completionId;
    }

    public void setCompletionId(int completionId) {
        this.completionId = completionId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(Date completionDate) {
        this.completionDate = completionDate;
    }
    
    @Override
    public String toString() {
        return "LessonCompletion{" +
                "completionId=" + completionId +
                ", lessonId=" + lessonId +
                ", userId=" + userId +
                ", completionDate=" + completionDate +
                '}';
    }
} 