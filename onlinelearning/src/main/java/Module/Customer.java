package Module;

public class Customer {
    private int customerId ;
    private User user ;
    private String socialRole ;
    private String levelOfEnglish ;

    public Customer(int customerId, User user, String socialRole, String levelOfEnglish) {
        this.customerId = customerId;
        this.user = user;
        this.socialRole = socialRole;
        this.levelOfEnglish = levelOfEnglish;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getSocialRole() {
        return socialRole;
    }

    public void setSocialRole(String socialRole) {
        this.socialRole = socialRole;
    }

    public String getLevelOfEnglish() {
        return levelOfEnglish;
    }

    public void setLevelOfEnglish(String levelOfEnglish) {
        this.levelOfEnglish = levelOfEnglish;
    }
}
