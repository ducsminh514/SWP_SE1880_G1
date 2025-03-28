package Module;

import java.util.Date;

public class PostImage {
    private int postImageId ;
    private Post post ;
    private String imageUrl ;
    private Date createDate ;
    private String note ;
    public PostImage() {
    }

    public PostImage(int postImageId, Post post, String imageUrl, Date createDate, String note) {
        this.postImageId = postImageId;
        this.post = post;
        this.imageUrl = imageUrl;
        this.createDate = createDate;
        this.note = note;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getPostImageId() {
        return postImageId;
    }

    public void setPostImageId(int postImageId) {
        this.postImageId = postImageId;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
