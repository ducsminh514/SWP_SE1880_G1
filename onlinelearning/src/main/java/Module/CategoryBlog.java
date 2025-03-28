package Module;

public class CategoryBlog {
    private int categoryBlogId;
    private String categoryBlogName ;

    public CategoryBlog() {
    }

    public CategoryBlog(int categoryBlogId, String categoryBlogName) {
        this.categoryBlogId = categoryBlogId;
        this.categoryBlogName = categoryBlogName;
    }

    public int getCategoryBlogId() {
        return categoryBlogId;
    }

    public void setCategoryBlogId(int categoryBlogId) {
        this.categoryBlogId = categoryBlogId;
    }

    public String getCategoryBlogName() {
        return categoryBlogName;
    }

    public void setCategoryBlogName(String categoryBlogName) {
        this.categoryBlogName = categoryBlogName;
    }
}
