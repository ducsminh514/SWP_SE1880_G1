package Controller.ForTransaction;

import DAO.CourseDAO;
import DAO.CustomerDAO;
import DAO.EnrollmentDAO;
import DAO.PriceCourseDAO;
import DAO.UserDAO;
import Module.Course;
import Module.Customer;
import Module.PriceCourse;
import Module.Role;
import Module.User;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ExpressCheckoutServlet", urlPatterns = {"/express-checkout"})
public class ExpressCheckoutServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ExpressCheckoutServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get course and price package info to display in the checkout form
        String courseIdParam = request.getParameter("courseId");
        String pricePackageIdParam = request.getParameter("pricePackageId");
        System.out.println("couse2: "+courseIdParam);
        System.out.println("price2: "+pricePackageIdParam);
        if (courseIdParam == null || pricePackageIdParam == null) {
            response.sendRedirect("home");
            return;
        }

        try {
            int courseId = Integer.parseInt(courseIdParam);
            int pricePackageId = Integer.parseInt(pricePackageIdParam);

            CourseDAO courseDAO = new CourseDAO();
            PriceCourseDAO pricePackageDAO = new PriceCourseDAO();

            Course course = courseDAO.getById(courseId);
            PriceCourse pricePackage = pricePackageDAO.getById(pricePackageId);

            if (course == null || pricePackage == null) {
                response.sendRedirect("home");
                return;
            }

            // Set attributes for the checkout page
            request.setAttribute("course", course);
            request.setAttribute("pricePackage", pricePackage);

            // Thêm thông báo về tính năng checkout nhanh
            request.setAttribute("expressCheckoutMessage", "Complete your purchase without registration. A new account will be created automatically for you.");

            // Forward to checkout page
            request.getRequestDispatcher("Transaction/express-checkout.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid course or price package ID", e);
            response.sendRedirect("home");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");
        String courseIdParam = request.getParameter("courseId");
        String pricePackageIdParam = request.getParameter("pricePackageId");

        // Validation
        if (firstName == null || lastName == null || email == null ||
            phoneNumber == null || gender == null ||
            courseIdParam == null || pricePackageIdParam == null) {

            request.setAttribute("error", "All required fields must be filled");
            doGet(request, response);
            return;
        }

        try {
            // Parse IDs
            int courseId = Integer.parseInt(courseIdParam);
            int pricePackageId = Integer.parseInt(pricePackageIdParam);

            // Get DAO instances
            UserDAO userDAO = new UserDAO();
            CourseDAO courseDAO = new CourseDAO();
            PriceCourseDAO pricePackageDAO = new PriceCourseDAO();

            // Check if user already exists
            User existingUser = userDAO.getUserByName(email, email);
            HttpSession session = request.getSession();

            if (existingUser != null) {
                // User exists - redirect to login
                session.setAttribute("checkoutCourseId", courseId);
                session.setAttribute("checkoutPricePackageId", pricePackageId);
                session.setAttribute("checkoutEmail", email);
                session.setAttribute("redirectUrl", "payment");
                // Set message for login page
                request.setAttribute("message", "Please log in to complete your purchase");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Get course and price package info
            Course course = courseDAO.getById(courseId);
            PriceCourse pricePackage = pricePackageDAO.getById(pricePackageId);

            if (course == null || pricePackage == null) {
                request.setAttribute("error", "Invalid course or price package");
                doGet(request, response);
                return;
            }

            // Create username from email
            String username = generateUsernameFromEmail(email);

            // Generate password if not provided
            if (password == null || password.trim().isEmpty()) {
                password = generateRandomPassword();
            }

            // Create new user
            Role userRole = new Role(2, "Customer"); // Assume 2 is the ID for regular users
            String avatar = "https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg";
            int age = 18; // Default age
            boolean status = false; // Not verified yet

            User newUser = new User(username, firstName, lastName, password, email, phoneNumber, gender, avatar, age, userRole, status);
            int userId = userDAO.insertUser2(newUser);

            if (userId > 0) {
                // Create customer record
                CustomerDAO customerDAO = new CustomerDAO();
                User userWithId = new User(userId);
                Customer newCustomer = new Customer("Student", "Beginner", userWithId);
                customerDAO.insertUser1(newCustomer);

                // Store info in session for payment
                session.setAttribute("checkoutCourseId", courseId);
                session.setAttribute("checkoutPricePackageId", pricePackageId);
                session.setAttribute("checkoutEmail", email);
                // Send welcome email with account details
                try {
                    sendAccountDetailsEmail(email, username, password);
                } catch (MessagingException e) {
                    LOGGER.log(Level.WARNING, "Failed to send account details email", e);
                }
                // Redirect to payment
                request.getRequestDispatcher("payment").forward(request,response);
            } else {
                request.setAttribute("error", "Failed to create account. Please try again.");
                doGet(request, response);
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid course or price package ID", e);
            request.setAttribute("error", "Invalid course or price package selection");
            doGet(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing checkout", e);
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            doGet(request, response);
        }
    }

    private String generateUsernameFromEmail(String email) {
        // Extract username part from email
        String username = email.split("@")[0];

        // Remove special characters
        username = username.replaceAll("[^a-zA-Z0-9]", "");

        // Add random suffix to ensure uniqueness
        SecureRandom random = new SecureRandom();
        int suffix = random.nextInt(1000);

        return username + suffix;
    }

    private String generateRandomPassword() {
        String upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerChars = "abcdefghijklmnopqrstuvwxyz";
        String numbers = "0123456789";
        String specialChars = "!@#$%^&*()_-+=<>?";
        String allChars = upperChars + lowerChars + numbers + specialChars;

        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();

        // Ensure at least one character from each category
        password.append(upperChars.charAt(random.nextInt(upperChars.length())));
        password.append(lowerChars.charAt(random.nextInt(lowerChars.length())));
        password.append(numbers.charAt(random.nextInt(numbers.length())));
        password.append(specialChars.charAt(random.nextInt(specialChars.length())));

        // Fill the rest of the password
        for (int i = 0; i < 8; i++) {
            password.append(allChars.charAt(random.nextInt(allChars.length())));
        }

        // Shuffle the password characters
        char[] passwordArray = password.toString().toCharArray();
        for (int i = 0; i < passwordArray.length; i++) {
            int j = random.nextInt(passwordArray.length);
            char temp = passwordArray[i];
            passwordArray[i] = passwordArray[j];
            passwordArray[j] = temp;
        }

        return new String(passwordArray);
    }

    private void sendAccountDetailsEmail(String email, String username, String password) throws MessagingException {
        final String from = "duynthe180374@fpt.edu.vn";  // Use your system email
        final String appPassword = "bftxjjzagtmxotjm";  // Use your app password
        
        // Thiết lập properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.debug", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        // Ensure proper classloader for Jakarta Mail
        Thread.currentThread().setContextClassLoader(Session.class.getClassLoader());
        
        // Create Session with a simple Authenticator
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, appPassword);
            }
        });

        // Enable session debugging
        session.setDebug(true);
        
        try {
            // Create a MimeMessage
            MimeMessage message = new MimeMessage(session);
            
            // Set From
            message.setFrom(new InternetAddress(from));
            
            // Set To
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            
            // Set Subject
            message.setSubject("Your EduChamp Account Details");
            
            // Prepare email content
            String emailContent =
                    "<html>" +
                    "<head>" +
                    "<style>" +
                    "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                    ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                    ".header { background-color: #f7b205; color: white; padding: 20px; text-align: center; }" +
                    ".content { padding: 20px; background-color: #f9f9f9; }" +
                    ".credentials { background-color: #ffffff; padding: 15px; margin: 15px 0; border-radius: 5px; border-left: 4px solid #f7b205; }" +
                    ".footer { text-align: center; margin-top: 20px; font-size: 12px; color: #777; }" +
                    "</style>" +
                    "</head>" +
                    "<body>" +
                    "<div class='container'>" +
                    "<div class='header'>" +
                    "<h1>Welcome to EduChamp!</h1>" +
                    "</div>" +
                    "<div class='content'>" +
                    "<p>Hello,</p>" +
                    "<p>Thank you for choosing EduChamp. Your account has been created successfully.</p>" +
                    "<p>Here are your account details:</p>" +
                    "<div class='credentials'>" +
                    "<p><strong>Username:</strong> " + username + "</p>" +
                    "<p><strong>Password:</strong> " + password + "</p>" +
                    "</div>" +
                    "<p>Please keep these details secure. You can use them to log in to your account and access your courses.</p>" +
                    "<p>To verify your email and fully activate your account, please click on the link below:</p>" +
                    "<p><a href='http://localhost:8080/online/verify2?email=" + email + "'>Verify Your Email</a></p>" +
                    "<p>If you have any questions, please don't hesitate to contact our support team.</p>" +
                    "<p>Best regards,<br>The EduChamp Team</p>" +
                    "</div>" +
                    "<div class='footer'>" +
                    "<p>This is an automated email. Please do not reply to this message.</p>" +
                    "</div>" +
                    "</div>" +
                    "</body>" +
                    "</html>";
            
            // Set HTML content
            message.setContent(emailContent, "text/html; charset=utf-8");
            
            // Send message
            System.out.println("Sending email to: " + email);
            Transport.send(message);
            System.out.println("Email sent successfully!");
            
        } catch (MessagingException e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
}