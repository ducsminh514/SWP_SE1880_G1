package Module;

public class Expert {
    private int expertId ;
    private String bio;
    private int experienceYear ;
    private String profileImage ;
    private User user ;

    public Expert(int expertId, String bio, int experienceYear, String profileImage, User user) {
        this.expertId = expertId;
        this.bio = bio;
        this.experienceYear = experienceYear;
        this.profileImage = profileImage;
        this.user = user;
    }

    public Expert() {
    }

    public int getExpertId() {
        return expertId;
    }

    public void setExpertId(int expertId) {
        this.expertId = expertId;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public int getExperienceYear() {
        return experienceYear;
    }

    public void setExperienceYear(int experienceYear) {
        this.experienceYear = experienceYear;
    }

    public String getProfileImage() {
        return profileImage;
    }

    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
