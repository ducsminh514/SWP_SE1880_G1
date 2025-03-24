package DAO;

import Module.Setting;
import dal.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SettingDAO extends DBContext implements GenericDAO<Setting> {

    public Setting getSettingById(String settingId) {
        Setting setting  = new Setting();
        String sql = "\n" +
                "SELECT [settingID]\n" +
                "      ,[type]\n" +
                "      ,[value]\n" +
                "      ,[order]\n" +
                "      ,[status]\n" +
                "      ,[createdAt]\n" +
                "      ,[updatedAt]\n" +
                "      ,[description]\n" +
                "  FROM [dbo].[Setting] where settingID = ?\n";
        try(PreparedStatement st = connection.prepareStatement(sql)){
            st.setString(1, settingId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
               setting = getFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return setting;
    }

    public List<Setting> findSettingWithFilter(String typeFilter, String statusFilter, String searchFilter, int page, int pageSize) {
        List<Setting> settingList = new ArrayList<Setting>();
        StringBuilder sql = new StringBuilder("Select * From Setting Where 1=1");
        List<Object> params = new ArrayList<>();
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" And type = ?");
            params.add(typeFilter);
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" and status = ?");
            params.add(Boolean.parseBoolean(statusFilter));
        }
        if (searchFilter != null && !searchFilter.isEmpty()) {
            sql.append(" and (value like ? or type like ?)");
            params.add("%" + searchFilter + "%");
            params.add("%" + searchFilter + "%");

        }

        sql.append(" ORDER BY [settingID] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                settingList.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return settingList;
    }

    @Override
    public List<Setting> findAll() {
        List<Setting> settingList = new ArrayList<>();
        String sql = "SELECT * FROM Setting";
        try (
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                settingList.add(getFromResultSet(rs));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return settingList;    }

    @Override
    public Setting getFromResultSet(ResultSet resultSet) throws SQLException {
        Setting setting = new Setting();
        setting.setSettingId(resultSet.getInt("SettingID"));
        setting.setType(resultSet.getString("Type"));
        setting.setValue(resultSet.getString("Value"));
        setting.setOrder(resultSet.getInt("Order"));
        setting.setStatus(resultSet.getBoolean("Status"));
        setting.setCreatedAt(resultSet.getString("CreatedAt"));
        setting.setUpdatedAt(resultSet.getString("UpdatedAt"));
        setting.setDescription(resultSet.getString("Description"));
        return setting;
    }

    @Override
    public int insert(Setting setting) {
        String sql = "INSERT INTO [dbo].[Setting]\n" +
                "           ([type]\n" +
                "           ,[value]\n" +
                "           ,[order]\n" +
                "           ,[status]\n" +
                "           ,[createdAt]\n" +
                "           ,[updatedAt]\n" +
                "           ,[description])\n" +
                "     VALUES\n" +
                "           (?,?,?,?,?,?,?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setObject(1, setting.getType());
            st.setObject(2, setting.getValue());
            st.setObject(3, setting.getOrder());
            st.setObject(4, setting.isStatus());
            st.setTimestamp(5, Timestamp.valueOf(setting.getCreatedAt()));
            st.setTimestamp(6, Timestamp.valueOf(setting.getUpdatedAt()));
            st.setObject(7, setting.getDescription());

            int affectedRows = st.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = st.getGeneratedKeys();
                if (rs.next()) { // Lấy khóa tự tăng sau khi insert thành công
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    @Override
    public boolean delete(Setting setting) {
        String sql = "UPDATE [Setting] SET status = 0 WHERE settingID = ?";
        try{
            PreparedStatement st = connection.prepareStatement(sql);
            st.setObject(1,setting.getSettingId());
            int rowEffect = st.executeUpdate();
            if(rowEffect > 0){
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Deactive Fail: " + e.getMessage());
        }
        return false;
    }

    @Override
    public boolean update(Setting setting) {
        String sql  = "UPDATE [dbo].[Setting]\n" +
                "   SET [type] = ?\n" +
                "      ,[value] = ?\n" +
                "      ,[order] =?\n" +
                "      ,[status] = ?\n" +
                "      ,[createdAt] = ?\n" +
                "      ,[updatedAt] = ?\n" +
                "      ,[description] = ?\n" +
                " WHERE settingID = ?";
        try( PreparedStatement st = connection.prepareStatement(sql)){
            st.setObject(1,setting.getType());
            st.setObject(2,setting.getValue());
            st.setObject(3,setting.getOrder());
            st.setObject(4,setting.isStatus());
            st.setObject(5,setting.getCreatedAt());
            st.setObject(6,setting.getUpdatedAt());
            st.setObject(7,setting.getDescription());
            st.setObject(8,setting.getSettingId());
            int affectedRows = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating new setting failed, no rows affected.");
            }
            return true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public int getTotalSettingByFilter(String typeFilter, String statusFilter, String searchFilter) {
        StringBuilder sql = new StringBuilder("Select COUNT(*) From Setting Where 1=1");
        List<Object> params = new ArrayList<>();
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" And type = ?");
            params.add(typeFilter);
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" and status = ?");
            params.add(Boolean.parseBoolean(statusFilter));
        }
        if (searchFilter != null && !searchFilter.isEmpty()) {
            sql.append(" and (value like ? or type like ?)");
            params.add(searchFilter);
            params.add(searchFilter);
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
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public static void main(String[] args) {
        SettingDAO dao = new SettingDAO();
        List<Setting> settingList = dao.findSettingWithFilter("user",null,null,1,3);
        System.out.println(settingList.toString());
    }
}
