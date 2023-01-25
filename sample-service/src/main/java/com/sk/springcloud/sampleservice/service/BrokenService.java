package com.sk.springcloud.sampleservice.service;

import org.springframework.cloud.client.circuitbreaker.ReactiveCircuitBreaker;
import org.springframework.cloud.client.circuitbreaker.ReactiveCircuitBreakerFactory;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

@Service
public class BrokenService {

    private final ReactiveCircuitBreaker circuitBreaker;


    public BrokenService(ReactiveCircuitBreakerFactory circuitBreakerFactory) {
        this.circuitBreaker = circuitBreakerFactory.create("brokenService");
    }

    private String getDataThatCanFail() {
        if(1 == 1) {
            throw new RuntimeException("This is a test exception");
        }
        return "Data returned from broken service";
    }

    private String fallback() {
        return "Return fallback data :)";
    }

    public Mono<String> getDataWithCircuitBreaker() {
        return circuitBreaker.run(
                Mono.create(monoSink -> monoSink.success(getDataThatCanFail())),
                throwable -> Mono.just(fallback()));

    }
}
