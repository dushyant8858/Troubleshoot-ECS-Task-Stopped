package com.datetime.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
//@Path("/")
public class DateTimeController {

    @Autowired
    private RestRetriever restRetriever;

//    These paths are case-sensitive it appears
    @RequestMapping(value = "/currentdatetime", method = RequestMethod.GET)
    public String currentDate() {
        return java.time.LocalDateTime.now().toString();
    }

    @RequestMapping(value = "/currentdatetime/greeting", method = RequestMethod.GET)
    public Greeting currentDateGreeting(@RequestParam(value = "name", defaultValue = "World") String name) {
        return restRetriever.getGreeting(name);
    }


}