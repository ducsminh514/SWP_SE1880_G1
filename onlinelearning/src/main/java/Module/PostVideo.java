package Module;

import java.util.Date;

public class PostVideo {
    private int postVideoId;
    private Post post ;
    private String videoUrl ;
    private Date createDate ;
    private String note ;
    public PostVideo() {
    }

    public PostVideo(int postVideoId, Post post, String videoUrl, Date createDate, String note) {
        this.postVideoId = postVideoId;
        this.post = post;
        this.videoUrl = videoUrl;
        this.createDate = createDate;
        this.note = note;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getPostVideoId() {
        return postVideoId;
    }

    public void setPostVideoId(int postVideoId) {
        this.postVideoId = postVideoId;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
