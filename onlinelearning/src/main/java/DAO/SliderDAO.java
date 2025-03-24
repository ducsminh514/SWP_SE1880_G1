package DAO;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Module.Slider ;
public class SliderDAO extends DBContext {
    public ArrayList<Slider> getAll(){
        String sql = "select * from Sliders" ;
        ArrayList<Slider> listSlider = new ArrayList<>() ;
        try{
            PreparedStatement pre = connection.prepareStatement(sql) ;
            ResultSet rs = pre .executeQuery();
            MarketingDAO mDAO = new MarketingDAO();
            while(rs.next()){
                Slider s = new Slider();
                s.setSlideId(rs.getInt("SliderID"));
                s.setSlideUrl(rs.getString("Slider_url"));
                s.setBackLink(rs.getString("backLink"));
                s.setImage(rs.getString("Image"));
                s.setDescription(rs.getString("Description"));
                s.setShow(rs.getBoolean("isShow"));
                s.setStatus(rs.getBoolean("Status"));
                s.setCreateDate(rs.getDate("CreateDate"));
                s.setUpdateDate(rs.getDate("UpdateDate"));
                s.setTitle(rs.getString("Title"));
                s.setMarketing(mDAO.getByID(rs.getInt("MarketingID")));
                listSlider.add(s) ;
            }
            return listSlider ;
        }catch(SQLException e){
            System.out.println(e);
        }
        return listSlider ;
    }
}
