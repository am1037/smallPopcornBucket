package com.java4.popcorn.controllers.page;

import lombok.Data;

import java.util.List;

@Data
public class JsonClass_MoviePercentDetail {
    String startDate;
    String endDate;
    String movieCd;
    //전국기준
    List<Double> percentages;
}
