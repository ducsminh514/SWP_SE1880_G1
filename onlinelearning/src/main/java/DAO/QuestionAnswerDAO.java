package DAO;

import dal.DBContext;
import Module.QuestionAnswer;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class QuestionAnswerDAO extends DBContext implements GenericDAO<QuestionAnswer> {
    @Override
    public List<QuestionAnswer> findAll() {
        return List.of();
    }

    @Override
    public QuestionAnswer getFromResultSet(ResultSet resultSet) throws SQLException {
        return null;
    }

    @Override
    public int insert(QuestionAnswer questionAnswer) {
        return 0;
    }

    @Override
    public boolean delete(QuestionAnswer questionAnswer) {
        return false;
    }

    @Override
    public boolean update(QuestionAnswer questionAnswer) {
        return false;
    }
}
