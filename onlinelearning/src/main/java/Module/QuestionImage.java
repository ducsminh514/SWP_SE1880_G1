package Module;

public class QuestionImage {
    private int imageId;
    private String imageTitle;
    private String imageURL;
    private int questionImangeId;

    public QuestionImage() {
    }

    public QuestionImage(int imageId, String imageTitle, int questionImangeId) {
        this.imageId = imageId;
        this.imageTitle = imageTitle;
        this.questionImangeId = questionImangeId;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public String getImageTitle() {
        return imageTitle;
    }

    public void setImageTitle(String imageTitle) {
        this.imageTitle = imageTitle;
    }

    public int getQuestionImangeId() {
        return questionImangeId;
    }

    public void setQuestionImangeId(int questionImangeId) {
        this.questionImangeId = questionImangeId;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
}
