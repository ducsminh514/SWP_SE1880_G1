package Module;

public class Options {
    private int optionId;
    private String name;
    private String content;
    private boolean isCorrect;
    private Question question;

    public Options(int optionId, String name, String content, boolean isCorrect, Question question) {
        this.optionId = optionId;
        this.name = name;
        this.content = content;
        this.isCorrect = isCorrect;
        this.question = question;
    }

    public Options() {
    }

    public int getOptionId() {
        return optionId;
    }

    public void setOptionId(int optionId) {
        this.optionId = optionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isCorrect() {
        return isCorrect;
    }

    public void setCorrect(boolean correct) {
        isCorrect = correct;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }
}
