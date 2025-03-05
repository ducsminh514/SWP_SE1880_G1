package DAO;

import dal.DBContext;
import Module.Subject;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class SubjectDAO extends DBContext implements GenericDAO<Subject> {

    @Override
    public List<Subject> findAll() {
        return List.of();
    }


    @Override
    public int insert(Subject subject) {
        return 0;
    }

    @Override
    public boolean delete(Subject subject) {
        return false;
    }

    @Override
    public boolean update(Subject subject) {
        return false;
    }

    @Override
    public Subject getFromResultSet(ResultSet resultSet) throws SQLException {
        return null;
    }

    public Subject getSubjectById(int id){
        return null;
    }

}
