package com.java4.popcorn.controllers.page;

import com.java4.popcorn.database.theater.TheaterVO;
import lombok.Data;

import java.util.List;

@Data
public class JsonClass_TheaterPaging {

    List<TheaterVO> list;
    int pageNumber;
    int pageSize;
    int totalTheaterNumber;
    int totalPageNumber;

}
