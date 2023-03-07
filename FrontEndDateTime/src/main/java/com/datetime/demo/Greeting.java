package com.datetime.demo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;

//@RequiredArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class Greeting {

//    @JsonProperty("isSet") for when json variable != java variable
    private long id;
    private @NonNull String content;

    public Greeting(long id, String content) {
        this.id = id;
        this.content = content;
    }
}
