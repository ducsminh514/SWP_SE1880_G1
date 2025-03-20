package DAO;

import dal.DBContext;
import Module.LessonQuiz;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class LessonQuizDAO extends DBContext implements GenericDAO<LessonQuiz> {

    @Override
    public List<LessonQuiz> findAll() {
        return List.of();
    }

    @Override
    public LessonQuiz getFromResultSet(ResultSet resultSet) throws SQLException {
        return null;
    }

    @Override
    public int insert(LessonQuiz lessonQuiz) {
        return 0;
    }

    @Override
    public boolean delete(LessonQuiz lessonQuiz) {
        return false;
    }

    @Override
    public boolean update(LessonQuiz lessonQuiz) {
        return false;
    }
}
