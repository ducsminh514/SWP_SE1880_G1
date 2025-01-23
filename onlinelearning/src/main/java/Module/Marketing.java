package Module;

public class Marketing {
      private int marketingId ;
      private User user;
      private int experienceYear ;

    public Marketing(int marketingId, User user, int experienceYear) {
        this.marketingId = marketingId;
        this.user = user;
        this.experienceYear = experienceYear;
    }

    public int getMarketingId() {
        return marketingId;
    }

    public void setMarketingId(int marketingId) {
        this.marketingId = marketingId;
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
