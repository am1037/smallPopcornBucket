package com.java4.popcorn.database.alarm;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class AlarmDAO {
    @Autowired
    SqlSessionTemplate my;

    /*
    <select id="getAlarmList" resultType="com.java4.popcorn.database.alarm.AlarmVO">
        SELECT * FROM popcorn.alarm
    </select>

    <insert id="insertAlarm" parameterType="com.java4.popcorn.database.alarm.AlarmVO">
        INSERT INTO popcorn.alarm (lineId, movieCd, theater_company, theater_id) VALUES (#{lineId}, #{movieCd}, #{theater_company}, #{theater_id})
    </insert>

<!--select One-->
    <select id="selectAlarm" resultType="com.java4.popcorn.database.alarm.AlarmVO">
        SELECT * FROM popcorn.alarm WHERE lineId = #{lineId} AND movieCd = #{movieCd} AND theater_company = #{theater_company} AND theater_id = #{theater_id}
    </select>

<!--select by lineId-->
    <select id="selectAlarmByLineId" resultType="com.java4.popcorn.database.alarm.AlarmVO">
        SELECT * FROM popcorn.alarm WHERE lineId = #{lineId}
    </select>

    <delete id="deleteAlarm" parameterType="com.java4.popcorn.database.alarm.AlarmVO">
        DELETE FROM popcorn.alarm WHERE lineId = #{lineId} AND movieCd = #{movieCd} AND theater_company = #{theater_company} AND theater_id = #{theater_id}
    </delete>
     */

    public int insertAlarm(AlarmVO alarmVO) {
        return my.insert("AlarmDAO.insertAlarm", alarmVO);
    }

    public AlarmVO selectAlarm(AlarmVO alarmVO) {
        return my.selectOne("AlarmDAO.selectAlarm", alarmVO);
    }

    public List<AlarmVO> selectAlarmByLineId(String lineId) {
        return my.selectList("AlarmDAO.selectAlarmByLineId", lineId);
    }

    public int deleteAlarm(AlarmVO alarmVO) {
        return my.delete("AlarmDAO.deleteAlarm", alarmVO);
    }

    public List<AlarmVO> getAlarmList() {
        return my.selectList("AlarmDAO.getAlarmList");
    }

}
