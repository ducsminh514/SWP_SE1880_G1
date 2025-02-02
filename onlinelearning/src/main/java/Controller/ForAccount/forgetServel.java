package Controller.ForAccount;

import java.io.IOException;
import java.io.PrintWriter;

import DAO.UserDAO;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Properties;
import java.util.Random;

@WebServlet(name = "forgetServel", urlPatterns = {"/forget"})
public class forgetServel extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet </title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet  at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        if (isValidEmail(email)) {
            String otp = generateOTP();
            UserDAO d= new UserDAO();
            boolean emailSent = sendOTPEmail(email, otp);
            if (emailSent) {
                request.setAttribute("otp", otp);
                request.setAttribute("email", email);
                request.getRequestDispatcher("verification.jsp").forward(request, response);
            } else {
                response.getWriter().println("Failed to send OTP. Please try again.");
            }
        } else {
            response.getWriter().println("Invalid email address.");
        }
    }
    private boolean isUserExistByEmail(String email){
        UserDAO ud = new UserDAO();
        return ud.existUserByEmail(email);
    }
    private boolean isValidEmail(String email) {
        return email != null && !email.isEmpty() && isUserExistByEmail(email);
    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
    private boolean sendOTPEmail(String to, String otp) {
        final String from = "duynthe180374@fpt.edu.vn";
        final  String password = "bftxjjzagtmxotjm";

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

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Your OTP Code");
            message.setText("Your OTP code is: " + otp);

            Transport.send(message);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}


