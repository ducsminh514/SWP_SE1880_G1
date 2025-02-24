package Module;

public class QuizzQuestion {
    private int quizzQuestionId;
    private int questionId;
    private int sortOrder;
    private int quizId;

    public QuizzQuestion(int quizzQuestionId) {
        this.quizzQuestionId = quizzQuestionId;
    }
    public QuizzQuestion() {
    }

    public QuizzQuestion(int quizzQuestionId, int questionId, int sortOrder, int quizId) {
        this.quizzQuestionId = quizzQuestionId;
        this.questionId = questionId;
        this.sortOrder = sortOrder;
        this.quizId = quizId;
    }

    public int getQuizzQuestionId() {
        return quizzQuestionId;
    }

    public void setQuizzQuestionId(int quizzQuestionId) {
        this.quizzQuestionId = quizzQuestionId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }
}
