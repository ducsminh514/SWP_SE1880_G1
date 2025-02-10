package Module;

import java.util.Date;

public class Sale {
    private int saleId ;
    private User user ;
    private int experienceYear ;

    public Sale() {
    }

    public Sale(int saleId, User user, int experienceYear) {
        this.saleId = saleId;
        this.user = user;
        this.experienceYear = experienceYear;
    }

    public int getSaleId() {
        return saleId;
    }

    public void setSaleId(int saleId) {
        this.saleId = saleId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getExperienceYear() {
        return experienceYear;
    }

    public void setExperienceYear(int experienceYear) {
        this.experienceYear = experienceYear;
    }
}
