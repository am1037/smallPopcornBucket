package com.java4.popcorn.database.theater;

import lombok.Data;
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

    public Map<String, TheaterVO> selectAllTheaterCode(){
        try {
            List<TheaterVO> list = my.selectList("TheaterDAO.selectAllTheater");
            Map<String, TheaterVO> theaterMap = new HashMap<>();
            for(TheaterVO vo : list){
                theaterMap.put(vo.getTheater_id() + "_" + vo.getTheater_company(), vo);
            }
            return theaterMap;
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

    public TheaterVO selectByTheaterId(String theaterId) {
        //나중에 새 sql 짜세요!!
        if(theaterId.length()>4) return my.selectOne("TheaterDAO.selectByTheaterId", theaterId.substring(0,4));
        return my.selectOne("TheaterDAO.selectByTheaterId", theaterId);
    }
}
