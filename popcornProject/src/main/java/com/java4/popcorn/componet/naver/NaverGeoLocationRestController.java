package com.java4.popcorn.componet.naver;

import com.java4.popcorn.componet.DistanceCalculator;
import com.java4.popcorn.database.theater.TheaterDAO;
import com.java4.popcorn.database.theater.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
public class NaverGeoLocationRestController {

    @Autowired
    DistanceCalculator distanceCalculator;
    @Autowired
    TheaterDAO theaterDAO;

    @RequestMapping(value = "/calcDistance", produces = "text/html;charset=UTF-8")
    public String calcDistance(@RequestParam Double latitude, @RequestParam Double longitude){
        try {
            System.out.println(latitude + " " + longitude);

            List<TheaterVO> vos = theaterDAO.selectAllTheaterCode();


            Map<String, Double> map = new TreeMap<>();

            StringBuilder sb = new StringBuilder();
            for (TheaterVO vo : vos) {
                map.put(vo.getTheater_name(), distanceCalculator.calculateDistance(latitude, longitude, vo.getCoord_y(), vo.getCoord_x()));
                map.put(vo.getTheater_name(), distanceCalculator.calculateDistance(latitude, longitude, vo.getCoord_y(), vo.getCoord_x()));
            }

            List<Map.Entry<String, Double>> list = new ArrayList<>(map.entrySet());
            list.sort((o1, o2) -> -1 * Double.compare(o1.getValue(), o2.getValue()));

            list.forEach(entry -> {
                sb.append(entry.getKey()).append(" ").append(entry.getValue()).append("<br>");
            });

            return sb.toString();
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

}
