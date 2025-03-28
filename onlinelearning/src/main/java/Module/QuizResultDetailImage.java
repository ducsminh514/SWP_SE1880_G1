package Module;

public class QuizResultDetailImage {
    private int ImageID;
    private int ImageQuizID;
    private String Title;

    public QuizResultDetailImage() {
    }

    public QuizResultDetailImage(int imageID, int imageQuizID, String title) {
        ImageID = imageID;
        ImageQuizID = imageQuizID;
        Title = title;
    }

    public int getImageID() {
        return ImageID;
    }

    public void setImageID(int imageID) {
        ImageID = imageID;
    }

    public int getImageQuizID() {
        return ImageQuizID;
    }

    public void setImageQuizID(int imageQuizID) {
        ImageQuizID = imageQuizID;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }
}
