package Module;

public class PriceCourse {
    private int priceId ;
    private Course course ;
    private String priceCourseName ;
    private int accessDuration ;
    private float price ;
    private float salePrice ;
    private boolean status ;
    private String description ;

    public PriceCourse() {
    }

    public PriceCourse(int priceId, Course course, String priceCourseName, int accessDuration, float price, float salePrice, boolean status, String description) {
        this.priceId = priceId;
        this.course = course;
        this.priceCourseName = priceCourseName;
        this.accessDuration = accessDuration;
        this.price = price;
        this.salePrice = salePrice;
        this.status = status;
        this.description = description;
    }

    public int getPriceId() {
        return priceId;
    }

    public void setPriceId(int priceId) {
        this.priceId = priceId;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getPriceCourseName() {
        return priceCourseName;
    }

    public void setPriceCourseName(String priceCourseName) {
        this.priceCourseName = priceCourseName;
    }

    public int getAccessDuration() {
        return accessDuration;
    }

    public void setAccessDuration(int accessDuration) {
        this.accessDuration = accessDuration;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public float getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(float salePrice) {
        this.salePrice = salePrice;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
