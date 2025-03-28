package Module;

public class QuizzQuestion {
    private int quizQuestionId;
    private int questionId;
    private int sortOrder;
    private int lessonQuizId;

    public QuizzQuestion(int quizQuestionId) {
        this.quizQuestionId = quizQuestionId;
    }
    public QuizzQuestion() {
    }

    public QuizzQuestion(int quizQuestionId, int questionId, int sortOrder, int lessonQuizId) {
        this.quizQuestionId = quizQuestionId;
        this.questionId = questionId;
        this.sortOrder = sortOrder;
        this.lessonQuizId = lessonQuizId;
    }

    public int getQuizQuestionId() {
        return quizQuestionId;
    }

    public void setQuizQuestionId(int quizQuestionId) {
        this.quizQuestionId = quizQuestionId;
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

    public int getLessonQuizId() {
        return lessonQuizId;
    }

    public void setLessonQuizId(int lessonQuizId) {
        this.lessonQuizId = lessonQuizId;
    }
}
