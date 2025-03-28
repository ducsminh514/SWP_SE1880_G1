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
import java.util.List;
import Module.QuestionImage;
import Module.Subject;
import Module.*;

public class QuestionDAO extends DBContext implements GenericDAO<Question> {

    @Override
    public List<Question> findAll() {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM Question";
        try {
            connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question question = getFromResultSet(rs);
                if (question != null) {
                    questions.add(question);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
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

        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
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
        } finally {
            closeResources();
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
            connection = getConnection();
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
            System.out.println("Error getting filtered questions: " + e.getMessage());
        } finally {
            closeResources();
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
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting questions: " + e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    public Question getFromResultSet(ResultSet resultSet) throws SQLException {
        QuestionTypeDAO questionTypeDao = new QuestionTypeDAO();
        QuestionType qt = questionTypeDao.getQuestionTypeById(resultSet.getInt("QuestionTypeID"));

        QuestionImageDAO questionImageDao = new QuestionImageDAO();
        List<QuestionImage> questionImageList = questionImageDao.getImageByQuestionId(resultSet.getInt("QuestionID"));

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
        question.setCreateTime(resultSet.getDate("CreateAt"));
        question.setUpdateTime(resultSet.getDate("UpdateAt"));
        question.setQuestionImage(questionImageList);
        question.setMp3(resultSet.getString("Mp3"));
        question.setLessonQuizId(resultSet.getInt("LessonQuizID"));
        return question;
    }

    public Question GetQuestionById(int id) {
        String sql = "SELECT [QuestionID]\n" +
                "      ,[Content]\n" +
                "      ,[Level]\n" +
                "      ,[SubjectId]\n" +
                "      ,[Mark]\n" +
                "      ,[QuestionTypeID]\n" +
                "      ,[IsActive]\n" +
                "      ,[CreateAt]\n" +
                "      ,[UpdateAt]\n" +
                "      ,[Mp3]\n" +
                "  FROM [dbo].[Question]\n" +
                "  WHERE QuestionID = ?";
        Question question = new Question();
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                question = getFromResultSet(rs);
                return question;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }

    public int getQuestionCountByQuizId(int quizId) {
        String sql = "SELECT COUNT(*) AS NumberOfQuestions FROM QuizQuestions WHERE LessonQuizID = ?";
        int questionCount = 0;

        try {
            connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, quizId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                questionCount = rs.getInt("NumberOfQuestions");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return questionCount;
    }

    public ArrayList<Question> getQuestion(int quizId) {
        ArrayList<Question> listQuestion = new ArrayList<>();
        String sql = "SELECT q.*, qq.SortOrder FROM Question q "
                + "JOIN QuizQuestions qq ON q.QuestionId = qq.QuestionId "
                + "JOIN LessonQuiz lq ON qq.LessonQuizID = lq.LessonQuizID "
                + "WHERE lq.LessonQuizID = ? ";
        QuestionTypeDAO qtd = new QuestionTypeDAO();
        try {
            connection = getConnection();
            QuestionDAO qd = new QuestionDAO();
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, quizId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Question c = new Question();
                c.setQuestionId(rs.getInt("QuestionID"));
                c.setContent(rs.getString("Content"));
                c.setMp3(rs.getString("Mp3"));
                //c.setQuestionImage(qd.listImage(rs.getInt("ImageID")));
                c.setLevel(rs.getInt("Level"));
                c.setMark(rs.getInt("Mark"));
                c.setQuestionType(qtd.getQuestionTypeById(rs.getInt("QuestionTypeId")));
                listQuestion.add(c);
            }
            return listQuestion;
        } catch (SQLException e) {
            System.out.println(e);
            System.out.println("getQuestion");
        } finally {
            closeResources();
        }
        return null;
    }

    public ArrayList<QuestionImage> listImage(int id) {
        ArrayList<QuestionImage> list = new ArrayList<>();
        String sql = "Select * from QuestionImages where QuestionImageID=? ";
        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                QuestionImage q = new QuestionImage();
                q.setImageId(rs.getInt("ImageID"));
                q.setImageTitle(rs.getString("ImageTitle"));
                q.setQuestionImangeId(rs.getInt("QuestionImageID"));
                list.add(q);
            }
            return list;
        } catch (SQLException e) {
            System.out.println("Error listing images: " + e.getMessage());
        } finally {
            closeResources();
        }
        return list;
    }

    public ArrayList<QuestionAnswer> getAnswer(int id) {
        ArrayList<QuestionAnswer> list = new ArrayList<>();
        String sql = "SELECT a.* FROM QuestionAnswer a "
                + "JOIN Question q ON q.QuestionId = a.QuestionId "
                + "JOIN QuizQuestions qq ON qq.QuestionId = q.QuestionId "
                + "JOIN LessonQuiz lq ON qq.LessonQuizID = lq.LessonQuizID "
                + "WHERE lq.LessonQuizID = ? "
                + "ORDER BY a.SortOrder ASC";

        try {
            connection = getConnection();
            PreparedStatement pre = connection.prepareStatement(sql);
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
        } finally {
            closeResources();
        }
        return list;
    }

    public Question getQuestionById(int id) {
        String sql = "select * from Questions where Id=?";
        Question Question = new Question();
        QuestionTypeDAO qtd = new QuestionTypeDAO();
        try {
            connection = getConnection();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
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
        } finally {
            closeResources();
        }
        return null;
    }
    
    public LessonQuiz takeLessonQuizByID(int id){
        String sql = "Select lq.* from LessonQuiz lq where lq.LessonQuizID=?";
        try {
            connection = getConnection();
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
        } finally {
            closeResources();
        }
        return null;
    }
    
    // Thêm phương thức closeResources() để đóng các tài nguyên
   
    // Add this new method to get questions by quiz ID
    public List<Question> getByQuizId(int quizId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM Question where LessonQuizID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setObject(1, quizId);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Question question = getFromResultSet(resultSet);
                if (question != null) {
                    questions.add(question);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error getting questions by quiz ID: " + e.getMessage());
        } finally {
            closeResources();
        }
        return questions;
    }

    public static void main(String[] args) {
        QuestionDAO questionDAO = new QuestionDAO();
        List<Question> questions = questionDAO.getByQuizId(1);
        System.out.println(questions);
    }
}

