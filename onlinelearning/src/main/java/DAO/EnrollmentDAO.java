package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import  Module.Enrollment;
import  Module.Customer;
import  Module.Course;
public class EnrollmentDAO extends DBContext {
    public List<Integer> getAllEnrollmentIDsByCustomerID (int id){
        List <Integer> list = new ArrayList<>();
        String sql = "SELECT EnrollmentID FROM Enrollments where CustomerID= ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1,id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                list.add(rs.getInt("EnrollmentID"));
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }
    public List<Integer> getAllCourseIDsByCustomerID (int id){
        List <Integer> list = new ArrayList<>();
        String sql = "SELECT CourseID FROM Enrollments where CustomerID= ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1,id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                list.add(rs.getInt("CourseID"));
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }
    public List<Enrollment>getAllEnrollmentsByCustomerID(int id){
        List<Enrollment> enrollments = new ArrayList<>();
        List<Integer> enrollmentIDs = getAllEnrollmentIDsByCustomerID(id);

        String sql = "SELECT * FROM Enrollments WHERE EnrollmentID = ?";

        try {
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
                rs.close();
            }
            st.close();
        } catch (SQLException e) {
            System.err.println(e);
        }

        return enrollments;
    }
    public static void main(String[] args) {
        EnrollmentDAO ed= new EnrollmentDAO();
        int a = 2;
        List<Integer> courseIds = ed.getAllCourseIDsByCustomerID(a);

        // In ra danh sách CourseIDs cho CustomerID = 4
        System.out.println("Course IDs for CustomerID " + a + ": ");
        for (Integer courseId : courseIds) {
            System.out.println(courseId);
        }
    }
}
