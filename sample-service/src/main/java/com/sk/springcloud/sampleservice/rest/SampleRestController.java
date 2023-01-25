package com.sk.springcloud.sampleservice.rest;

import com.sk.springcloud.sampleservice.service.BrokenService;
import jakarta.ws.rs.PathParam;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
public class SampleRestController {


    private BrokenService brokenService;

    public SampleRestController(BrokenService brokenService) {
        this.brokenService = brokenService;
    }

    @GetMapping(path="/api/v1/hello", produces = "application/json")
    public String getSample() {
        return "Hello World!";
    }

    @GetMapping("/api/v1/user")
    public String getSample2(@PathParam("name") String name) {
        return String.format("Hello %s %s", name, "!");
    }

    @GetMapping("/api/v1/test-broken-service")
    public Mono<String> getSample2() {
        return brokenService.getDataWithCircuitBreaker();
    }
}
