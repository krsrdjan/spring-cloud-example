package com.sk.springcloud.samplemodule;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class SampleModuleApplication {

	public static void main(String[] args) {
		SpringApplication.run(SampleModuleApplication.class, args);
	}

}
