package Module;

/**
 * Model class representing file-based lesson content.
 */
public class LessonFile {
    private int lessonId;
    private String fileUrl;
    private String fileType;
    private int fileSize;
    
    public LessonFile() {
    }
    
    public LessonFile(int lessonId, String fileUrl, String fileType, int fileSize) {
        this.lessonId = lessonId;
        this.fileUrl = fileUrl;
        this.fileType = fileType;
        this.fileSize = fileSize;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public int getFileSize() {
        return fileSize;
    }

    public void setFileSize(int fileSize) {
        this.fileSize = fileSize;
    }
    
    @Override
    public String toString() {
        return "LessonFile{" +
                "lessonId=" + lessonId +
                ", fileUrl='" + fileUrl + '\'' +
                ", fileType='" + fileType + '\'' +
                ", fileSize=" + fileSize +
                '}';
    }
} 