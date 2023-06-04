package com.java4.popcorn;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PageController {

    @RequestMapping("/")
    public String goHome(){
        return "index";
    }

    @RequestMapping("/CloseTheater")
    public String goCloseTheater(){
        return "CloseTheater";
    }

}
