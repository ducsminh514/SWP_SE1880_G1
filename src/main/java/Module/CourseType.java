package Module;

public class CourseType {
    private int courseTypeId ;
    private String courseTypeName ;

    public CourseType() {
    }
    public CourseType(int courseTypeId, String courseTypeName) {
        this.courseTypeId = courseTypeId;
        this.courseTypeName = courseTypeName;
    }

    public int getCourseTypeId() {
        return courseTypeId;
    }

    public void setCourseTypeId(int courseTypeId) {
        this.courseTypeId = courseTypeId;
    }

    public String getCourseTypeName() {
        return courseTypeName;
    }

    public void setCourseTypeName(String courseTypeName) {
        this.courseTypeName = courseTypeName;
    }
}
