package Controller.ForAccount;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.regex.Pattern;

import DAO.UserDAO;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Module.User;
import Module.Role;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
        String name= request.getParameter("name");
        String firstName= request.getParameter("firstName");
        String lastName= request.getParameter("lastName");
        String phoneNumber= request.getParameter("phoneNumber");
        String gender=request.getParameter("gender");
        String age_raw= request.getParameter("age");
        String email= request.getParameter("email");
        String password= request.getParameter("password");
        String confirmPassword= request.getParameter("confirmPassword");
        String passwordPattern = "^(?=.*[A-Z])(?=.*[\\W_]).{3,}$";
        boolean isValid = Pattern.matches(passwordPattern, password);
        UserDAO ud= new UserDAO();
        int id = 0, age = 0;
        User find= ud.getUserByName(name,email);
        if (age_raw.equalsIgnoreCase("-1")) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Your age is empty!");
            response.sendRedirect("register");
        }
        if (gender.equalsIgnoreCase("-1")) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Your gender is empty!");
            response.sendRedirect("register");
        }
        if (!(confirmPassword.equals(password))) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Your pass is not match");
            response.sendRedirect("register");
        }
        if (!isValid) {
            request.setAttribute("error", "Password must contain at least 1 uppercase letter and 1 special character.");
            response.sendRedirect("register");
        }

        try {
            age = Integer.parseInt(age_raw);
            if (find == null) {
                for (int i = 0; i < 999; i++) {
                    if (ud.getUserByID(i) == null) {
                        id = i;
                        break;
                    }
                }
                //add
                Role newRole=  new Role(2,"User");
                byte a =0;
                User newU = new User(name,firstName,lastName,password,email,phoneNumber,age,newRole);
                ud.insert(newU);
                sendVerificationEmail(email);
                request.setAttribute("notication", "ARegistration successful! Please check your email for verification.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("error", "The email address or user name you entered already exist!");
                response.sendRedirect("register");
            }
        } catch (Exception e) {
                System.out.println(e);
        }

    }

    private void sendVerificationEmail(String email) {
        final String from = "duynthe180374@fpt.edu.vn"; // Your Gmail address
        final  String password = "bftxjjzagtmxotjm"; // Your Gmail password (use App Passwords for security)

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
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Verify your account!!!!!!!!");
            message.setText("Click here to verify your account: http://localhost:8080/verify2?email=" + email);

            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

