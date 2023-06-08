package com.java4.popcorn.controllers;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.java4.popcorn.database.alarm.AlarmDAO;
import com.java4.popcorn.database.alarm.AlarmVO;
import com.java4.popcorn.database.movie.mapping.MovieMappingDAO;
import com.java4.popcorn.database.theater.TheaterDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AlarmPageRestController {
    @Autowired
    AlarmDAO alarmDAO;
    @Autowired
    MovieMappingDAO movieMappingDAO;
    @Autowired
    TheaterDAO theaterDAO;

    @RequestMapping("/alarm/getAlarmList")
    public String alarmList(@RequestParam String lineId){
        alarmDAO.selectAlarmByLineId(lineId);
        ObjectMapper om = new ObjectMapper();
        try {
            return om.writeValueAsString(alarmDAO.selectAlarmByLineId(lineId));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @RequestMapping("/alarm/insertAlarm")
    public String insertAlarm(@RequestParam String lineId,
                              @RequestParam String theaterId,
                              @RequestParam String movieId){
        String[] theaterIdSplit = theaterId.split("_");
        AlarmVO alarmVO = new AlarmVO(lineId, movieId, theaterIdSplit[1], theaterIdSplit[0]);
        int a = alarmDAO.insertAlarm(alarmVO);
        return "{ result : " + a + " }";
    }
    @RequestMapping("/alarm/deleteAlarm")
    public String deleteAlarm(@RequestParam String lineId,
                              @RequestParam String theaterId,
                              @RequestParam String movieId,
                              @RequestParam String theaterCompany){
        AlarmVO alarmVO = new AlarmVO(lineId, movieId, theaterCompany, theaterId);
        int a = alarmDAO.deleteAlarm(alarmVO);
        return "{ result : " + a + " }";
    }

}
