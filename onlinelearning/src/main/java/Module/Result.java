package Module;

import java.util.Date;

public class Result {
    private int resultId;
    private Quiz quiz ;
    private Customer customer ;
    private float score ;
    private Date submitDate ;

    public Result(int resultId, Quiz quiz, Customer customer, float score, Date submitDate) {
        this.resultId = resultId;
        this.quiz = quiz;
        this.customer = customer;
        this.score = score;
        this.submitDate = submitDate;
    }

    public int getResultId() {
        return resultId;
    }

    public void setResultId(int resultId) {
        this.resultId = resultId;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public Date getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(Date submitDate) {
        this.submitDate = submitDate;
    }
}
