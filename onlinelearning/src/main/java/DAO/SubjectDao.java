import dal.DBContext;
import Module.Subject;

public class SubjectDao extends  DBContext {

    public void Subject getSubjectByID(int subjectId) {
        String sql = "select * from Subjects where SubjectId = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setInt(1, subjectId);
            ResultSet rs = pre.executeQuery();
            //run
            if (rs.next()) {
                Subject subject = new Subject(rs.getInt("subjectId"), rs.getInt("ownerId"), rs.getInt("numberLesson"), rs.getString("courseName"), rs.getString("description"), rs.getString("image"));
                return subject;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int updateSubject(Subjects subject, int subjectId) {
        int n = 0;
        String sql = "update Subjects set SubjectName = ?, categoryId = ?, ownerId = ?, numberLesson = ?, description = ?, image = ? where SubjectId = ?";
        try {
            PreparedStatement pre = connect.prepareStatement(sql);
            pre.setString(1, course.getCourseName());
            pre.setInt(2, course.getCategoryId());
            pre.setInt(3, course.getOwnerId());
            pre.setInt(4, course.getNumberLesson());
            pre.setString(5, course.getDescription());
            pre.setString(6, course.getImage());
            pre.setInt(7, subjectId);
            //run
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return n;
    }
}