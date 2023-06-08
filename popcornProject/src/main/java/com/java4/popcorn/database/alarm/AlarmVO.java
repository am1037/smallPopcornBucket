package com.java4.popcorn.database.alarm;

import lombok.Data;

@Data
public class AlarmVO {

    public AlarmVO() {
    }

    public AlarmVO(String lineId, String movieCd, String theater_company, String theater_id) {
        this.lineId = lineId;
        this.movieCd = movieCd;
        this.theater_company = theater_company;
        this.theater_id = theater_id;
    }

    String lineId;
    String movieCd;
    String theater_company;
    String theater_id;

}
