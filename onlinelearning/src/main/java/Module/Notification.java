package Module;

import java.util.Date;

public class Notification {
    private int notificationId;
    private User user;
    private String message ;
    private Date messageDate ;

    public Notification() {
    }

    public Notification(int notificationId, User user, String message, Date messageDate) {
        this.notificationId = notificationId;
        this.user = user;
        this.message = message;
        this.messageDate = messageDate;
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getMessageDate() {
        return messageDate;
    }

    public void setMessageDate(Date messageDate) {
        this.messageDate = messageDate;
    }
}
