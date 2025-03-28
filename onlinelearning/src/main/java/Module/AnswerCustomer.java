package Module;

public class AnswerCustomer {
    private int answerCustomer ;
    private Answer answer;
    private Customer customer;
    private Quiz quiz ;

    public AnswerCustomer(int answerCustomer, Answer answer, Customer customer, Quiz quiz) {
        this.answerCustomer = answerCustomer;
        this.answer = answer;
        this.customer = customer;
        this.quiz = quiz;
    }

    public int getAnswerCustomer() {
        return answerCustomer;
    }

    public void setAnswerCustomer(int answerCustomer) {
        this.answerCustomer = answerCustomer;
    }

    public Answer getAnswer() {
        return answer;
    }

    public void setAnswer(Answer answer) {
        this.answer = answer;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }
}
