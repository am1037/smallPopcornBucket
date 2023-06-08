package com.java4.popcorn.component.line.message;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.java4.popcorn.component.line.message.temp.Event;
import lombok.Data;

import java.util.List;
@Data
public class WebhookData {

    private String destination;
    private List<Event> events;

    public WebhookData() {
    }

    public String getText(){
        return events.get(0).getMessage().getText();
    }

    public String getUserId(){
        return events.get(0).getSource().getUserId();
    }

    public WebhookData(String str){
        ObjectMapper om = new ObjectMapper();
        try {
            WebhookData wd = om.readValue(str, WebhookData.class);
            destination = wd.getDestination();
            events = wd.getEvents();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // getters and setters
}
