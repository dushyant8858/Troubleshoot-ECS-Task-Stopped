package com.datetime.demo;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@Getter
public class MyBean {

    private final String prop;
    private String restHostname;
    private String restPort;

    @Autowired
    public MyBean(
            @Value("${some.prop}") String prop,
            @Value("${rest.hostname}") String restHostname,
            @Value("${rest.port}") String restPort
    ) {
        this.prop = prop;
        this.restHostname = restHostname;
        this.restPort = restPort;

        System.out.println("\n");
        System.out.println("================== " + prop + " ================== ");
        System.out.println("================== " + restHostname + " ================== ");
        System.out.println("================== " + restPort + " ================== ");
        System.out.println("\n");
    }
}

