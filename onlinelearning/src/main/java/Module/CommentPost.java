package Module;

import java.util.ArrayList;
import java.util.Date;

public class CommentPost {
    private int commentPostId ;
    private int parentId ;
    private Post post ;
    private User user ;
    private String content ;
    private Date createDate ;
    private ArrayList<CommentPost> children ;
    public CommentPost() {
        this.children = new ArrayList<>();
    }

    public CommentPost(int commentPostId, int parentId, Post post, User user, String content, Date createDate, ArrayList<CommentPost> children) {
        this.commentPostId = commentPostId;
        this.parentId = parentId;
        this.post = post;
        this.user = user;
        this.content = content;
        this.createDate = createDate;
        this.children = new ArrayList<>();
    }

    public void addChild(CommentPost c){
        this.children.add(c) ;
    }

    public ArrayList<CommentPost> getChildren() {
        return children;
    }

    public void setChildren(ArrayList<CommentPost> children) {
        this.children = children;
    }

    public int getCommentPostId() {
        return commentPostId;
    }

    public void setCommentPostId(int commentPostId) {
        this.commentPostId = commentPostId;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
