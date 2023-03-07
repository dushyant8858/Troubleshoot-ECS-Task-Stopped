package com.datetime.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class RestRetriever {
    private final MyBean mybean;

    @Autowired
    public RestRetriever(MyBean mybean) {
        this.mybean = mybean;
    }

    public Greeting getGreeting(String name) {
        String prop = mybean.getProp();
        String restHostname = mybean.getRestHostname();
        String restPort = mybean.getRestPort();

        System.out.println("some.prop injected: " + prop);
        System.out.println("REST address: " + restHostname + ":" + restPort);

        final String uri = String.format("http://" + restHostname + ":" + restPort + "/backendgreeting?name=%s", name);

        RestTemplate restTemplate = new RestTemplate();
        Greeting greeting = restTemplate.getForObject(uri, Greeting.class);

        System.out.println(greeting.getContent());
        return greeting;
    }
}
