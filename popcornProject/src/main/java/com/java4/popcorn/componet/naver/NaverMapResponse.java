package com.java4.popcorn.componet.naver;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class NaverMapResponse {

    List<address> addresses;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    static class address {
        String roadAddress;
        String jibunAddress;
        String englishAddress;
        Double x;
        Double y;
        String distance;
    }
}
