package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public interface GenericDAO<T> {
    public List<T> findAll();

    public boolean update(T t);

    public boolean delete(T t);

    public int insert(T t);

    public T getFromResultSet(ResultSet resultSet) throws SQLException;
}
