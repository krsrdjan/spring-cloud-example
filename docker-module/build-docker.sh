#!/usr/bin/env bash

./gradlew bootJar
docker build -t my-sprintboot-docker .
docker run -p 8080:8080 docker.io/library/my-sprintboot-docker
