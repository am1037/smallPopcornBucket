package com.java4.popcorn.component.scheduler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class MyScheduler {
    private static final Logger logger = LoggerFactory.getLogger(MyScheduler.class);
    //@Scheduled(cron = "0/10 * * * * *")
    public void autoUpdate() throws Exception {
        logger.info(new Date() + "스케쥴러 실행");
    }

}
