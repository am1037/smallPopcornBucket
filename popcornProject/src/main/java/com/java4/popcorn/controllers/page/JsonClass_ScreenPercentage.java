package com.java4.popcorn.controllers.page;

import com.java4.popcorn.database.screen.ScreenVO;
import com.java4.popcorn.database.theater.TheaterVO;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class JsonClass_ScreenPercentage {
    TheaterVO theater;
    List<String> order;
    Map<String, String> movieTitleMap;
    Map<String, Double> screensPercentageMap; //movieCd : percentage
}
