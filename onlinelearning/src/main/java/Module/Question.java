package Module;

public class Question {
    private int questionId ;
    private Quiz quiz ;
    private int orderNo ;
    private String content ;
    private String level ;
    private boolean isMultipleChoice ;

    public Question(int questionId, Quiz quiz, int orderNo, String content, String level, boolean isMultipleChoice) {
        this.questionId = questionId;
        this.quiz = quiz;
        this.orderNo = orderNo;
        this.content = content;
        this.level = level;
        this.isMultipleChoice = isMultipleChoice;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public boolean isMultipleChoice() {
        return isMultipleChoice;
    }

    public void setMultipleChoice(boolean multipleChoice) {
        isMultipleChoice = multipleChoice;
    }
}
