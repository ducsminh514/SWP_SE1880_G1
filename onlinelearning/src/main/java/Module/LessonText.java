package Module;

/**
 * Model class representing text-based lesson content.
 */
public class LessonText {
    private int lessonId;
    private String content;
    
    public LessonText() {
    }
    
    public LessonText(int lessonId, String content) {
        this.lessonId = lessonId;
        this.content = content;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
    @Override
    public String toString() {
        return "LessonText{" +
                "lessonId=" + lessonId +
                ", content='" + content + '\'' +
                '}';
    }
} 