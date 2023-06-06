package com.java4.popcorn.database.screen;

import lombok.Data;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class ScreenDAO {
    final
    SqlSessionTemplate my;

    public ScreenDAO(SqlSessionTemplate my) {
        this.my = my;
    }

    public List<String> selectAllTitle() {
        return my.selectList("ScreenDAO.selectAllTitle");
    }

    public List<String> selectDistinctMovieIdByDate(String date){
        return my.selectList("ScreenDAO.selectDistinctMovieIdByDate", date);
    }

    public List<ScreenVO> selectByMovieId(String movieId) {
        try {
            Map<String, String> map = new HashMap<>();
            map.put("movie_docid", movieId);
            return my.selectList("ScreenDAO.selectByDate", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<ScreenVO> selectByTheater(String theater_id) {
        try {
            Map<String, String> map = new HashMap<>();
            map.put("theater_id", theater_id);
            return my.selectList("ScreenDAO.selectByTheater", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<ScreenVO> selectByDate(String date) {
        try {
            Map<String, String> map = new HashMap<>();
            map.put("date", date);
            return my.selectList("ScreenDAO.selectByDate", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<ScreenVO> selectByTheaterAndDate(String theater, String date){
        try {
            Map<String, String> map = new HashMap<>();
            map.put("theater_id", theater);
            map.put("date", date);
            return my.selectList("ScreenDAO.selectByTheaterAndDate", map);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public List<ScreenVO> selectByMovieIdAndDate(String movie, String day) {
        Map<String, String> map = new HashMap<>();
        map.put("movie_docid", movie);
        map.put("date", day);
        return my.selectList("ScreenDAO.selectByMovieIdAndDate", map);
    }

    public List<ScreenVO> selectByMovieIdAndTheater(String movie, String theater) {
        Map<String, String> map = new HashMap<>();
        map.put("theater_id", theater);
        map.put("movie_docid", movie);
        return my.selectList("ScreenDAO.selectByMovieIdAndTheater", map);
    }

    public List<ScreenVO> selectByMovieIdAndTheaterAndDate(String movie, String theater, String day) {
        Map<String, String> map = new HashMap<>();
        map.put("theater_id", theater);
        map.put("date", day);
        map.put("movie_docid", movie);
        return my.selectList("ScreenDAO.selectByMovieIdAndTheaterAndDate", map);
    }

    public Map<String, List<ScreenVO>> toMapByMovieId(List<ScreenVO> list){
        Map<String, List<ScreenVO>> map = new HashMap<>();
        list.forEach(v -> {
            map.putIfAbsent(v.getMovie_docid(), new ArrayList<>());
            map.get(v.getMovie_docid()).add(v);
        });
        return map;
    }

    public Map<String, List<ScreenVO>> toMapByTheater(List<ScreenVO> list){
        Map<String, List<ScreenVO>> map = new HashMap<>();
        list.forEach(v -> {
            map.putIfAbsent(v.getTheater_id(), new ArrayList<>());
            map.get(v.getMovie_docid()).add(v);
        });
        return map;
    }

    public Map<String, List<ScreenVO>> toMapByDate(List<ScreenVO> list){
        Map<String, List<ScreenVO>> map = new HashMap<>();
        list.forEach(v -> {
            map.putIfAbsent(v.getDate(), new ArrayList<>());
            map.get(v.getMovie_docid()).add(v);
        });
        return map;
    }
}
