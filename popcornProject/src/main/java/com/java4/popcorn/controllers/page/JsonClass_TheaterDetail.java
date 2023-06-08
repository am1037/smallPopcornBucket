package com.java4.popcorn.controllers.page;

import lombok.Data;

@Data
public class JsonClass_TheaterDetail {

    String theater_company;
    String theater_id;
    String theater_name;
    String theater_location;
    String theater_region;

    Double coord_x;
    Double coord_y;

}