package com.java4.popcorn.componet.naver;

import com.java4.popcorn.database.theater.TheaterDAO;
import com.java4.popcorn.database.theater.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class NaverMapRestController {
    @Autowired
    TheaterDAO theaterDAO;
    @Autowired
    NaverAPI naverAPI;

    @RequestMapping("/naverMap")
    public String crawlingAllTheaterCodes(@RequestParam String address) throws Exception{
        return naverAPI.byAddress(address);
    }

    @RequestMapping("/coordUpdateAll")
    public String coordUpdate(Model model) throws Exception{
        StringBuilder sb = new StringBuilder();
        List<TheaterVO> vos = theaterDAO.selectAllTheaterCode();
        for(TheaterVO vo : vos){
            Double[] coords = naverAPI.getCoordinate(vo.getTheater_location());
            if(coords != null){
                theaterDAO.updateCoordinates(vo.getTheater_company(), vo.getTheater_id(), coords[0], coords[1]);
                sb.append(vo.getTheater_company() + " " + vo.getTheater_id() + " " + coords[0] + " " + coords[1] + "\n");
            }
        }
        return sb.toString();
    }

    @RequestMapping("/coordUpdateOne")
    public String coordUpdateOne(@RequestParam String company, @RequestParam String id,
                                 Model model) throws Exception{
        StringBuilder sb = new StringBuilder();
        TheaterVO vo = theaterDAO.selectTheaterByCompanyAndId(company, id);
            Double[] coords = naverAPI.getCoordinate(vo.getTheater_location());
            if(coords != null){
                theaterDAO.updateCoordinates(vo.getTheater_company(), vo.getTheater_id(), coords[0], coords[1]);
                sb.append(vo.getTheater_company() + " " + vo.getTheater_id() + " " + coords[0] + " " + coords[1] + "\n");
            }
        return sb.toString();
    }

}
