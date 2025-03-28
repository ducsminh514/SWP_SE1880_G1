package Module;

public class PostContent {
    private int contentId ;
    private Post post ;
    private String contentType ;
    private String content;
    private String note ;
    private int orderIndex ;

    public PostContent() {
    }

    public PostContent(int contentId, Post post, String contentType, String content, String note, int orderIndex) {
        this.contentId = contentId;
        this.post = post;
        this.contentType = contentType;
        this.content = content;
        this.note = note;
        this.orderIndex = orderIndex;
    }

    public int getContentId() {
        return contentId;
    }

    public void setContentId(int contentId) {
        this.contentId = contentId;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getOrderIndex() {
        return orderIndex;
    }

    public void setOrderIndex(int orderIndex) {
        this.orderIndex = orderIndex;
    }
}
