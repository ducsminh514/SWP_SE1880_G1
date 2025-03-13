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
        question.setCreateTime(resultSet.getDate("CreateAt"));
        question.setUpdateTime(resultSet.getDate("UpdateAt"));
        question.setQuestionImage(questionImageList);
        question.setMp3(resultSet.getString("Mp3"));
        return question;
    }

    public static void main(String[] args) {
        QuestionDAO questionDAO = new QuestionDAO();
        List<Question> q = questionDAO.findAll();
        for (int i = 0; i < q.size(); i++) {
            System.out.println(q.get(i).toString());
        }
    }
}
