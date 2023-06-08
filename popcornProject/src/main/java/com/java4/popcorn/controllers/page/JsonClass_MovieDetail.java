package com.java4.popcorn.controllers.page;

import lombok.Data;

import java.util.List;

@Data
public class JsonClass_MovieDetail {

    String my_title;
    String docid;
    String kobis_movieCd;
    List<String> detail_urls;
    List<String> posters;

}
