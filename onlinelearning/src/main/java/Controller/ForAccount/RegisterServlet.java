package Controller.ForAccount;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;
import java.util.regex.Pattern;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Module.User;
import Module.Role;
import DAO.UserDAO;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RegisterServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String ageRaw = request.getParameter("age");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        //String passwordPattern = "^(?=.*[A-Z])(?=.*[\\W_]).{6,}$";
        //boolean isValidPassword = Pattern.matches(passwordPattern, password);

        UserDAO userDAO = new UserDAO();
        int age;

        try {
            age = Integer.parseInt(ageRaw);
            if (age <= 0) {
                request.setAttribute("error", "Invalid age! Please enter a positive number.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Age must be a valid number.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (gender == null || gender.equals("-1")) {
            request.setAttribute("error", "Please select your gender.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

//        if (!isValidPassword) {
//            request.setAttribute("error", "Password must contain at least 1 uppercase letter and 1 special character.");
//            request.getRequestDispatcher("register.jsp").forward(request, response);
//            return;
//        }

        try {
            User existingUser = userDAO.getUserByName(name, email);
            if (existingUser != null) {
                request.setAttribute("error", "The email address or username already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            Role userRole = new Role(2, "User");
            boolean a= false;
            String avatar= null;
            User newUser = new User(name, firstName, lastName, password, email, phoneNumber, gender,avatar,age , userRole,a);
            userDAO.insertUser1(newUser);

            sendVerificationEmail(email);

            request.setAttribute("notication", "Registration successful! Please check your email for verification.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Email sending failed: {0}", e.getMessage());
            request.setAttribute("error", "Failed to send verification email. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error: {0}", e.getMessage());
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private void sendVerificationEmail(String email) throws MessagingException {
        final String from = "duynthe180374@fpt.edu.vn";
        final String password = "bftxjjzagtmxotjm";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new jakarta.mail.Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, password);
                    }
                });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("Verify your account");
        message.setText("Click here to verify your account: http://localhost:8080/onlinelearning/verify2?email=" + email);

        Transport.send(message);
    }
}
