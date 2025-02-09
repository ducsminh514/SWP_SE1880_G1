import Module.Setting;
import java.sql.*;
import dal.DBContext;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

package DAO;

public class SettingDAO {
    public List<Setting> findSettingWithFilter(String typeFilter, String statusFilter, String searchFilter, int page, int pageSize) {
        List<Setting> settingList = new ArrayList<Setting>();
        StringBuilder sql = new StringBuilder("Select * From Setting Where 1=1");
        List<Object> params = new ArrayList<>();
        if(typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" And type = ?");
            params.add(typeFilter);
        }
        if(statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" and status = ?");
            params.add(Boolean.parseBoolean(statusFilter));
        }
        if(searchFilter != null && !searchFilter.isEmpty()) {
            sql.append(" and (value like ? or type like ?)");
            params.add(searchFilter);
            params.add(searchFilter);
        }

        sql.append(" ORDER BY UserID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try{
            PreparedStatement st = connection.;
        }
    }
}
