package com.java4.popcorn.database.theater;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class TheaterDAO {

    @Autowired
    SqlSessionTemplate my;

    public List<TheaterVO> selectAllTheaterCode(){
        try {
            return my.selectList("TheaterDAO.selectAllTheater");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<String> selectAllRegion(){
        return my.selectList("TheaterDAO.selectAllRegion");
    }

    public List<TheaterVO> selectTheaterByRegion(String region){
        try {
            Map<String, String> map = new HashMap<>();
            map.put("theater_region", region);
            return my.selectList("TheaterDAO.selectTheatersByRegion", map);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public TheaterVO selectTheaterByCompanyAndId(String company, String id){
        Map<String, String> map = new HashMap<>();
        map.put("theater_company", company);
        map.put("theater_id", id);
        return my.selectOne("TheaterDAO.selectTheaterByCompanyAndId", map);
    }

    public void updateCoordinates(String company, String id, double coord_x, double coord_y){
        Map<String, Object> map = new HashMap<>();
        map.put("coord_x", coord_x);
        map.put("coord_y", coord_y);
        map.put("theater_company", company);
        map.put("theater_id", id);
        my.update("TheaterDAO.updateTheaterCoordinates", map);
    }

}