package Module;

public class QuizResultDetail {
    private int QuizResultDetailID;
    private int QuizAttendID;
    private int QuestionID;
    private int ChooseOptionID;
    private boolean IsCorrect;
    private String AnswerText;
    private int ImageQuizID;

    public QuizResultDetail() {
    }

    public QuizResultDetail(int quizResultDetailID, int quizAttendID, int questionID, int chooseOptionID, boolean isCorrect, String answerText, int imageQuizID) {
        QuizResultDetailID = quizResultDetailID;
        QuizAttendID = quizAttendID;
        QuestionID = questionID;
        ChooseOptionID = chooseOptionID;
        IsCorrect = isCorrect;
        AnswerText = answerText;
        ImageQuizID = imageQuizID;
    }

    public int getQuizResultDetailID() {
        return QuizResultDetailID;
    }

    public void setQuizResultDetailID(int quizResultDetailID) {
        QuizResultDetailID = quizResultDetailID;
    }

    public int getQuizAttendID() {
        return QuizAttendID;
    }

    public void setQuizAttendID(int quizAttendID) {
        QuizAttendID = quizAttendID;
    }

    public int getQuestionID() {
        return QuestionID;
    }

    public void setQuestionID(int questionID) {
        QuestionID = questionID;
    }

    public int getChooseOptionID() {
        return ChooseOptionID;
    }

    public void setChooseOptionID(int chooseOptionID) {
        ChooseOptionID = chooseOptionID;
    }

    public boolean isCorrect() {
        return IsCorrect;
    }

    public void setCorrect(boolean correct) {
        IsCorrect = correct;
    }

    public String getAnswerText() {
        return AnswerText;
    }

    public void setAnswerText(String answerText) {
        AnswerText = answerText;
    }

    public int getImageQuizID() {
        return ImageQuizID;
    }

    public void setImageQuizID(int imageQuizID) {
        ImageQuizID = imageQuizID;
    }
}
