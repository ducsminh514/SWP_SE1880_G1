package Module;

public class Answer {

    private int answerId ;
    private Question question;
    private String content ;
    private boolean correct ;

    public Answer(int answerId, Question question, String content, boolean correct) {
        this.answerId = answerId;
        this.question = question;
        this.content = content;
        this.correct = correct;
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isCorrect() {
        return correct;
    }

    public void setCorrect(boolean correct) {
        this.correct = correct;
    }

}
