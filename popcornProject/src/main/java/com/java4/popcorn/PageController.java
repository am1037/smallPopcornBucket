package com.java4.popcorn;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class PageController {
    @Autowired
    MyServices myServices;

    @RequestMapping("/")
    public String goHome(){
        return "index";
    }

    @RequestMapping("/res")
    public String goRes(){
        return "res";
    }

    @RequestMapping("/movieDetail")
    public String goMovieDetail(HttpServletRequest request,
                                Model model,
                                @RequestParam String id){
        //get screen status of screens of a movie
        //time : designated dates
        //provide what??

        //request.getSession().getAttribute("theater").toString();

        List<Double> list = myServices.getScreenPercentageFromUntil(id, "20200101", "20200131");
        model.addAttribute("id", id);
        return "movie/movieDetail";
    }

    @RequestMapping("/CloseTheater")
    public String goCloseTheater(){
        return "CloseTheater";
    }

}
