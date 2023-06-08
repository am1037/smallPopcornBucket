package com.java4.popcorn;

import com.java4.popcorn.component.line.message.LineAPI;
import com.java4.popcorn.component.line.message.WebhookData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LineController {

    @Autowired
    LineAPI lineAPI;

    String url = "https://a423-115-137-12-120.ngrok-free.app/popcornProject_war_exploded/";

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    //webhook
    @RequestMapping("/lineWebhook")
    public void lineWebhook(@RequestBody String body){
        WebhookData webhookData = new WebhookData(body);

        if(webhookData.getText().contains("!")){
            lineAPI.sendMessage(url+"?lineId="+webhookData.getUserId(), webhookData.getUserId());
            System.out.println(webhookData);
        }

    }


    //send message


}
