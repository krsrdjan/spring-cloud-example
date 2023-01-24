package com.sk.springcloud.sampleservice.rest;

import jakarta.ws.rs.PathParam;
import org.springframework.web.bind.annotation.*;

@RestController
public class SampleRestController {

    @GetMapping(path="/api/v1/hello", produces = "application/json")
    public String getSample() {
        return "Hello World!";
    }

    @GetMapping("/api/v1/user")
    public String getSample2(@PathParam("name") String name) {
        return String.format("Hello %s %s", name, "!");
    }
}
