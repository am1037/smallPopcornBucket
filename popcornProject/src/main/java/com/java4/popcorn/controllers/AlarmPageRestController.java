package com.java4.popcorn.controllers;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.java4.popcorn.database.alarm.AlarmDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AlarmPageRestController {
    @Autowired
    AlarmDAO alarmDAO;

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

}
