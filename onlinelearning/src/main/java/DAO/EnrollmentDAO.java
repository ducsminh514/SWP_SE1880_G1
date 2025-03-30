package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import  Module.Enrollment;
import  Module.Customer;
import  Module.Course;
public class EnrollmentDAO extends DBContext {
    public int totalEnrollment (int courseId){
        int total =0 ;
        String sql = "DECLARE @CourseID INT;\n" +
                "SET @CourseID = ?;\n" +
                "\n" +
                "SELECT COUNT(DISTINCT CustomerID) \n" +
                "FROM Enrollments \n" +
                "WHERE CourseID = @CourseID;\n";
        try{
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql) ;
            pre.setInt(1,courseId);
            Enrollment e = new Enrollment();
            ResultSet rs = pre.executeQuery();
            if(rs.next()){
                total = rs.getInt(1);
            }
        }catch(SQLException e){
            System.out.println(e);
        } finally {
            closeResources();
        }
        return total;
    }
    public List<Integer> getAllEnrollmentIDsByCustomerID (int id){
        List <Integer> list = new ArrayList<>();
        String sql = "SELECT EnrollmentID FROM Enrollments where CustomerID= ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1,id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                list.add(rs.getInt("EnrollmentID"));
            }
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            closeResources();
        }
        return list;
    }
    public List<Integer> getAllCourseIDsByCustomerID (int id){
        List <Integer> list = new ArrayList<>();
        String sql = "SELECT CourseID FROM Enrollments where CustomerID= ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1,id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                list.add(rs.getInt("CourseID"));
            }
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            closeResources();
        }
        return list;
    }
    public List<Enrollment>getAllEnrollmentsByCustomerID(int id){
        List<Enrollment> enrollments = new ArrayList<>();
        List<Integer> enrollmentIDs = getAllEnrollmentIDsByCustomerID(id);

        String sql = "SELECT * FROM Enrollments WHERE EnrollmentID = ?";

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);

            for (Integer enrollmentID : enrollmentIDs) {
                st.setInt(1, enrollmentID);
                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    Enrollment enrollment = new Enrollment();
                    enrollment.setEnrollmentId(rs.getInt("EnrollmentID"));
                    enrollment.setEnrollDate(rs.getDate("enrollDate"));
                    enrollment.setProcessPercentage(rs.getString("Process_Percentage"));
                    enrollment.setStatus(rs.getBoolean("Status"));
                    enrollment.setPayCode(rs.getString("Pay_Code"));
                    int customerId = rs.getInt("CustomerID");
                    CustomerDAO csd= new CustomerDAO();
                    Customer customer = csd.getCustomerById(customerId);
                    enrollment.setCustomer(customer);
                    int courseId = rs.getInt("CourseID");
                    CourseDAO cd= new CourseDAO();
                    Course course = cd.getCourseById(courseId);
                    enrollment.setCourse(course);

                    enrollments.add(enrollment);
                }
            }
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            closeResources();
        }

        return enrollments;
    }

    public boolean updateProgress(int userId, int courseId, String progressPercentage) {
        String sql = "UPDATE Enrollments SET Process_Percentage = ? WHERE CustomerID = ? AND CourseID = ?";
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, progressPercentage);
            st.setInt(2, userId);
            st.setInt(3, courseId);

            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating enrollment progress: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }
    public int insertEnrollment(int customerID, int courseID, Date enrollDate, int pricePackageID, String payCode) {
        String sql = "INSERT INTO Enrollments (CustomerID, CourseID, enrollDate, Process_Percentage, Status, Pay_Code, PricePackageID) " +
                "VALUES (?, ?, ?, '0%', 1, ?, ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            st.setInt(1, customerID);
            st.setInt(2, courseID);

            // Convert Java util.Date to SQL Date
            java.sql.Date sqlDate = new java.sql.Date(enrollDate.getTime());
            st.setDate(3, sqlDate);

            st.setString(4, payCode);
            st.setInt(5, pricePackageID);

            int affectedRows = st.executeUpdate();

            if (affectedRows == 0) {
                return -1;
            }

            try (ResultSet generatedKeys = st.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    return -1;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error inserting enrollment: " + e.getMessage());
            e.printStackTrace();
            return -1;
        }
    }
    
}
