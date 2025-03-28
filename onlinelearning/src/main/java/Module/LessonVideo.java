package Module;

/**
 * Model class representing video-based lesson content.
 */
public class LessonVideo {
    private int lessonId;
    private String videoUrl;
    private int videoDuration;
    private String transcript;
    private boolean downloadAllowed;
    
    public LessonVideo() {
    }
    
    public LessonVideo(int lessonId, String videoUrl, int videoDuration, String transcript, boolean downloadAllowed) {
        this.lessonId = lessonId;
        this.videoUrl = videoUrl;
        this.videoDuration = videoDuration;
        this.transcript = transcript;
        this.downloadAllowed = downloadAllowed;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public int getVideoDuration() {
        return videoDuration;
    }

    public void setVideoDuration(int videoDuration) {
        this.videoDuration = videoDuration;
    }

    public String getTranscript() {
        return transcript;
    }

    public void setTranscript(String transcript) {
        this.transcript = transcript;
    }

    public boolean isDownloadAllowed() {
        return downloadAllowed;
    }

    public void setDownloadAllowed(boolean downloadAllowed) {
        this.downloadAllowed = downloadAllowed;
    }
    
    @Override
    public String toString() {
        return "LessonVideo{" +
                "lessonId=" + lessonId +
                ", videoUrl='" + videoUrl + '\'' +
                ", videoDuration=" + videoDuration +
                ", transcript='" + transcript + '\'' +
                ", downloadAllowed=" + downloadAllowed +
                '}';
    }
} 