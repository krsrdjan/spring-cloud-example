package com.sk.springcloud.dockermodule;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@EnableDiscoveryClient
@RestController
public class DockerModuleApplication {

	public static void main(String[] args) {
		SpringApplication.run(DockerModuleApplication.class, args);
	}

	@GetMapping("/api/v1/docker")
	public String getDockerInfo() {
		return "Hello from Docker Module! Running on port 8080";
	}

	@GetMapping("/health")
	public String getHealth() {
		return "Docker Module is healthy!";
	}
}
