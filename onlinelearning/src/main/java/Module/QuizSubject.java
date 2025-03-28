package Module;

public class QuizSubject {
    private int quizSubjectId ;
    private Subject subject;
    private Quiz quiz ;

    public QuizSubject(int quizSubjectId, Subject subject, Quiz quiz) {
        this.quizSubjectId = quizSubjectId;
        this.subject = subject;
        this.quiz = quiz;
    }

    public int getQuizSubjectId() {
        return quizSubjectId;
    }

    public void setQuizSubjectId(int quizSubjectId) {
        this.quizSubjectId = quizSubjectId;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }
}
