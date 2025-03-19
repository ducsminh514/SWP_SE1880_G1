package DAO;

import dal.DBContext;
import Module.Question;
import org.apache.http.protocol.RequestTargetHost;
import Module.CourseType;
import Module.QuestionType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import Module.QuestionImage;
import Module.Subject;
import Module.*;
public class QuestionDAO extends DBContext implements GenericDAO<Question> {


    @Override
    public List<Question> findAll() {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM Question";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Question question = getFromResultSet(rs);
                if (question != null) {
                    questions.add(question);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }


    @Override
    public int insert(Question question) {
        return 0;
    }

    @Override
    public boolean delete(Question question) {
        return false;
    }

    @Override
    public boolean update(Question question) {
        String sql = "UPDATE Question SET "
                + "Content = ?, Level = ?, SubjectId = ?, Mark = ?, "
                + "QuestionTypeID = ?, IsActive = ?, UpdateAt = GETDATE(), Mp3 = ? "
                + "WHERE QuestionID = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, question.getContent());
            st.setInt(2, question.getLevel());
            st.setInt(3, question.getSubject().getSubjectId());
            st.setInt(4, question.getMark());
            st.setInt(5, question.getQuestionType().getQuestionTypeId());
            st.setBoolean(6, question.isStatus());
            st.setString(7, question.getMp3());
            st.setInt(8, question.getQuestionId());

            int affectedRows = st.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public List<Question> getQuestionByFilter(String search, String subject, String level, String status, int page, int pageSize) {
        List<Question> questions = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Question Where 1=1");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.isEmpty()) {
            sql.append(" AND Content like ?");
            params.add("%" + search + "%");
        }
        if (subject != null && !subject.isEmpty()) {
            sql.append(" AND SubjectId = ?");
            params.add(subject);
        }
        if (level != null && !level.isEmpty()) {
            sql.append(" AND Level = ?");
            params.add(level);
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND IsActive = ?");
            params.add(status);
        }

        // Phần ORDER BY, OFFSET, FETCH NEXT
        sql.append(" ORDER BY QuestionID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);
        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Question question = getFromResultSet(rs);
                if (question != null) {
                    questions.add(question);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return questions;
    }
    public int getTotalQuestionByFilter(String search, String subject, String level, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Question WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (search != null && !search.isEmpty()) {
            sql.append(" AND Content LIKE ?");
            params.add("%" + search + "%");
        }
        if (subject != null && !subject.isEmpty()) {
            sql.append(" AND SubjectId = ?");
            params.add(subject);
        }
        if (level != null && !level.isEmpty()) {
            sql.append(" AND Level = ?");
            params.add(level);
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND IsActive = ?");
            params.add(status);
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public Question getFromResultSet(ResultSet resultSet) throws SQLException {
        CourseTypeDAO courseTypeDao = new CourseTypeDAO();
        CourseType ct = courseTypeDao.getByID(resultSet.getInt("SubjectId"));

        QuestionTypeDAO questionTypeDao = new QuestionTypeDAO();
        QuestionType qt = questionTypeDao.getQuestionTypeById(resultSet.getInt("QuestionTypeID"));

        QuestionImageDAO questionImageDao = new QuestionImageDAO();
        List<QuestionImage> questionImageList = questionImageDao.getImageByQuestionImage(resultSet.getInt("QuestionImageID"));

        SubjectDAO subjectDao = new SubjectDAO();
        Subject subject = subjectDao.getSubjectById(resultSet.getInt("SubjectId"));

        Question question = new Question();

        question.setQuestionId(resultSet.getInt("QuestionID"));
        question.setContent(resultSet.getString("Content"));
        question.setLevel(resultSet.getInt("Level"));
        question.setSubject(subject);
        question.setMark(resultSet.getInt("Mark"));
        question.setQuestionType(qt);
        question.setStatus(resultSet.getBoolean("IsActive"));
        question.setCreateTime(resultSet.getDate("CreatedAt"));
        question.setUpdateTime(resultSet.getDate("UpdatedAt"));
        question.setQuestionImage(questionImageList);
        question.setMp3(resultSet.getString("Mp3"));
        return question;
    }


    public int getQuestionCountByQuizId(int quizId) {
        String sql = "SELECT COUNT(*) AS NumberOfQuestions FROM QuizQuestions WHERE QuizQuestionID = ?";
        int questionCount = 0;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                questionCount = rs.getInt("NumberOfQuestions");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questionCount;
    }
    public ArrayList<Question>getQuestion(int quizId){
        ArrayList<Question> listQuestion = new ArrayList<>();
        String sql = "SELECT q.*, qq.SortOrder FROM Question q "
                + "JOIN QuizQuestions qq ON q.QuestionId = qq.QuestionId "
                + "WHERE qq.QuizQuestionID = ? "
                ;
        QuestionTypeDAO qtd= new QuestionTypeDAO();
        try{
            QuestionDAO qd= new QuestionDAO();
            PreparedStatement pre = connection.prepareStatement(sql);

                pre.setInt(1,quizId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Question c= new Question();
                c.setQuestionId(rs.getInt("QuestionID"));
                c.setContent(rs.getString("Content"));
                c.setMp3(rs.getString("Mp3"));
                c.setQuestionImage(qd.listImage(rs.getInt("QuestionImageID")));
                c.setLevel(rs.getInt("Level"));
                c.setMark(rs.getInt("Mark"));
                c.setQuestionType(qtd.getQuestionTypeById(rs.getInt("QuestionTypeId")));
                listQuestion.add(c);

            }
            return listQuestion ;
        }catch (SQLException e){
            System.out.println(e);
            System.out.println("getQuestion");
        }
        return null;
    }
    public ArrayList<QuestionImage>listImage(int id){
        ArrayList<QuestionImage>list= new ArrayList<>() ;
        String sql = "Select * from QuestionImages where QuestionImageID=? ";
        try{
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1,id);
            ResultSet rs = pre.executeQuery();
            while(rs.next()){
                QuestionImage q= new QuestionImage();
                q.setImageId(rs.getInt("ImageID"));
                q.setImageTitle(rs.getString("ImageTitle"));
                q.setQuestionImangeId(rs.getInt("QuestionImageID"));
                list.add(q);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public ArrayList<QuestionAnswer> getAnswer(int id) {
        ArrayList<QuestionAnswer> list = new ArrayList<>();
        String sql = "SELECT a.* FROM QuestionAnswer a "
                + "JOIN Question q ON q.QuestionId = a.QuestionId "
                + "JOIN QuizQuestions qq ON qq.QuestionId = q.QuestionId "
                + "WHERE qq.QuizQuestionID = ? "
                + "ORDER BY a.SortOrder ASC";

        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            // Set the parameter for QuizQuestionID
            pre.setInt(1, id);

            // Execute the query
            ResultSet rs = pre.executeQuery();

            // Iterate over the result set
            while (rs.next()) {
                QuestionAnswer qa = new QuestionAnswer();
                qa.setCorrect(rs.getBoolean("IsCorrect"));
                qa.setAnswerId(rs.getInt("AnswerID"));
                qa.setSortOrder(rs.getInt("SortOrder"));
                qa.setContent(rs.getString("Content"));
                qa.setQuestionId(rs.getInt("QuestionID"));
                list.add(qa);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching answers: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException(e); // Optional: Can add custom error handling
        }
        return list;
    }


    public Question getQuestionById(int id){
        String sql = "select * from Questions where Id=?";
        Question Question = new Question();
        QuestionTypeDAO qtd= new QuestionTypeDAO();
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                Question.setQuestionId(rs.getInt("Id"));
                Question.setQuestionType(qtd.getQuestionTypeById(rs.getInt("QuestionTypeId")));
                Question.setMark(rs.getInt("Mark"));
                Question.setLevel(rs.getInt("Level"));
                Question.setStatus(rs.getBoolean("IsActive"));
                Question.setCreateTime(rs.getDate("CreatedAt"));
                Question.setUpdateTime(rs.getDate("UpdatedAt"));
                return Question;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    private int getTotalMark(int quizId) {
        String sql ="SELECT TotalMark FROM Quiz WHERE Id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, quizId);
            ResultSet rs = st.executeQuery();
            return rs.next() ? rs.getInt("TotalMark") : 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
    public void saveQuizResultDetails(List<QuizResultDetail> resultDetails){
        String sql = "INSERT INTO QuizResultDetail (QuizAttendID, QuestionID, ChooseOptionID, AnswerText, IsCorrect) "
                + "VALUES (?, ?, ?, ?, ?)";
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            for (QuizResultDetail detail : resultDetails) {
                // Cài đặt các tham số cho câu trả lời
                st.setInt(1, detail.getQuizAttendID());  // QuizAttendID
                st.setInt(2, detail.getQuestionID());    // QuestionID
                st.setInt(3, detail.getChooseOptionID()); // ChooseOptionID
                st.setString(4, detail.getAnswerText());  // AnswerText
                st.setBoolean(5, detail.isCorrect());     // IsCorrect

                st.addBatch();  // Thêm vào batch
            }
            st.executeBatch();
        }catch (SQLException e) { e.printStackTrace(); }
    }
    public void saveQuizResultDetailImages(List<QuizResultDetailImage> resultImages){
        String sql = "INSERT INTO QuizResultDetailImage (ImageQuizID, Title) "
                + "VALUES (?, ?)";
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            for (QuizResultDetailImage imageDetail : resultImages) {
                // Cài đặt các tham số cho câu trả lời
                st.setInt(1, imageDetail.getImageQuizID());  // ImageQuizID (ID của câu trả lời)
                st.setString(2, imageDetail.getTitle());     // Title (đường dẫn hoặc tên tệp hình ảnh)

                st.addBatch();  // Thêm vào batch
            }
            st.executeBatch();
        }catch (SQLException e) { e.printStackTrace(); }
    }
    public int findQuizAttendIDbyQuizQuestionID(int id){
        String sql = "SELECT qa.QuizAttendID FROM QuizAttend qa JOIN LessonQuiz lq ON qa.LessonQuizID = lq.LessonQuizID JOIN QuizQuestions qq ON lq.LessonQuizID = qq.LessonQuizID WHERE qq.QuizQuestionID =?"
               ;
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1,id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                return rs.getInt("QuizAttendID");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return 0;
    }

    public LessonQuiz takeLessonQuizByQuizQuestionID(int id){
        String sql = "Select lq.* from LessonQuiz lq Join QuizQuestions qq on qq.LessonQuizID=lq.LessonQuizID where qq.QuizQuestionID=?"
               ;
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            LessonQuiz lessonQuiz= new LessonQuiz();
            if(rs.next()){
               lessonQuiz.setTimeLimit(rs.getInt("TimeLimit"));
               lessonQuiz.setLessonQuizID(rs.getInt("LessonQuizID"));
               lessonQuiz.setImageUrl(rs.getString("ImageUrl"));
               lessonQuiz.setAttemptAllowed(rs.getInt("AttemptAllowed"));
               lessonQuiz.setMp3Url(rs.getString("Mp3Url"));
                return lessonQuiz;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    public void saveUserAnswers(int userId, int quizId, HashMap<Integer, Integer> answers) {
        String sqlQuizResult = "INSERT INTO QuizResults (UserID, QuizId, QuizDate, NumberOfQuestion, NumberOfCorrect, Mark) VALUES (?, ?, NOW(), ?, 0, 0)";
        String sqlQuizDetail = "INSERT INTO QuizResultDetails (QuizResultId, QuestionId, ChooseOptionId) VALUES (?, ?, ?)";
        String sqlCorrectCheck = "SELECT IsCorrect FROM Options WHERE Id = ?";

        try {
            // Assuming `connection` is already initialized elsewhere in the class
            connection.setAutoCommit(false);

            // 1️⃣ - Create a new record in QuizResults
            try (PreparedStatement qr = connection.prepareStatement(sqlQuizResult, PreparedStatement.RETURN_GENERATED_KEYS)) {
                qr.setInt(1, userId);
                qr.setInt(2, quizId);
                qr.setInt(3, answers.size());
                qr.executeUpdate();

                ResultSet rs = qr.getGeneratedKeys();
                int quizResultId = rs.next() ? rs.getInt(1) : 0;
                rs.close();

                // 2️⃣ - Insert answers into QuizResultDetails
                try (PreparedStatement qd = connection.prepareStatement(sqlQuizDetail)) {
                    int correctCount = 0;

                    for (Integer questionId : answers.keySet()) {
                        int optionId = answers.get(questionId);

                        qd.setInt(1, quizResultId);
                        qd.setInt(2, questionId);
                        qd.setInt(3, optionId);
                        qd.addBatch();

                        // 3️⃣ - Check if the answer is correct
                        try (PreparedStatement cc = connection.prepareStatement(sqlCorrectCheck)) {
                            cc.setInt(1, optionId);
                            ResultSet rsCorrect = cc.executeQuery();

                            if (rsCorrect.next() && rsCorrect.getBoolean("IsCorrect")) {
                                correctCount++;
                            }
                            rsCorrect.close();
                        }
                    }

                    qd.executeBatch();

                    // 4️⃣ - Update the quiz result with the correct count and score
                    int totalMark = getTotalMark(quizId);
                    double score = ((double) correctCount / answers.size()) * totalMark;

                    String sqlUpdateResult = "UPDATE QuizResults SET NumberOfCorrect = ?, Mark = ? WHERE Id = ?";
                    try (PreparedStatement psUpdateResult = connection.prepareStatement(sqlUpdateResult)) {
                        psUpdateResult.setInt(1, correctCount);
                        psUpdateResult.setDouble(2, score);
                        psUpdateResult.setInt(3, quizResultId);
                        psUpdateResult.executeUpdate();
                    }
                }

                connection.commit();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            throw new RuntimeException(e);
        }
    }
    public int GetMarkfromQuestion(int id){
        String sql = "select q.Mark from Question q where q.QuestionID=?"
                ;
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                return rs.getInt("Mark");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }
    public static void main(String[] args) {
        QuestionDAO questionDAO = new QuestionDAO();

        int quizId = 1;  // ID của quiz bạn muốn truy vấn
        int a= questionDAO.getQuestionCountByQuizId(quizId);
        LessonQuiz lessonQuiz = questionDAO.takeLessonQuizByQuizQuestionID(1);  // Giả sử id là 1

        // Hiển thị kết quả
        if (lessonQuiz != null) {
            System.out.println("Lesson Quiz ID: " + lessonQuiz.getLessonQuizID());
            System.out.println("Time Limit: " + lessonQuiz.getTimeLimit());
            System.out.println("Image URL: " + lessonQuiz.getImageUrl());
            System.out.println("Attempt Allowed: " + lessonQuiz.getAttemptAllowed());
            System.out.println("MP3 URL: " + lessonQuiz.getMp3Url());
        } else {
            System.out.println("No LessonQuiz found for the given QuizQuestionID.");
        }
    }
    public void updateTotalScore(int quizAttendID, int totalScore) {
        String sql = "UPDATE QuizAttend SET Score = ? WHERE QuizAttendID = ?";
        try  {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, totalScore);  // Cập nhật điểm số
            st.setInt(2, quizAttendID);  // Cập nhật cho QuizAttendID cụ thể
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }





}
