package Module;

import java.util.Date;
import Module.Marketing ;
import Module.CategoryBlog ;
public class Post {
     private int postId ;
     private Marketing marketing;
     private String title ;
     private String content ;
     private String thumbnail;
     private Date createDate ;
     private Date updateDate ;
     private boolean status ;
     private String postFile ;
     private CategoryBlog categoryBlog ;

    public Post() {
    }

    public Post(int postId, Marketing marketing, String title, String content, String thumbnail, Date createDate, Date updateDate, boolean status, String postFile, CategoryBlog categoryBlog) {
        this.postId = postId;
        this.marketing = marketing;
        this.title = title;
        this.content = content;
        this.thumbnail = thumbnail;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.status = status;
        this.postFile = postFile;
        this.categoryBlog = categoryBlog;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public Marketing getMarketing() {
        return marketing;
    }

    public void setMarketing(Marketing marketing) {
        this.marketing = marketing;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getPostFile() {
        return postFile;
    }

    public void setPostFile(String postFile) {
        this.postFile = postFile;
    }

    public CategoryBlog getCategoryBlog() {
        return categoryBlog;
    }

    public void setCategoryBlog(CategoryBlog categoryBlog) {
        this.categoryBlog = categoryBlog;
    }
}
