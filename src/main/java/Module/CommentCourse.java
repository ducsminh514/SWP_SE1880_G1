package Module;

import java.util.ArrayList;
import java.util.Date;

public class CommentCourse {
    private int commentCourseId ;
    private int parentId ;
    private Course course ;
    private User user ;
    private String content ;
    private Date createDate ;
    private ArrayList<CommentCourse> children ;

    public CommentCourse() {
        this.children = new ArrayList<>() ;
    }

    public CommentCourse(int commentCourseId, int parentId, Course course, User user, String content, Date createDate, ArrayList<CommentCourse> children) {
        this.commentCourseId = commentCourseId;
        this.parentId = parentId;
        this.course = course;
        this.user = user;
        this.content = content;
        this.createDate = createDate;
        this.children = children;
    }
    public void addChild(CommentCourse c){
        this.children.add(c) ;
    }

    public int getCommentCourseId() {
        return commentCourseId;
    }

    public void setCommentCourseId(int commentCourseId) {
        this.commentCourseId = commentCourseId;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
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

    public ArrayList<CommentCourse> getChildren() {
        return children;
    }

    public void setChildren(ArrayList<CommentCourse> children) {
        this.children = children;
    }
}
