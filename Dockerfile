FROM maven:3.8.5-openjdk-18-slim AS build

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN mvn package 

FROM openjdk:18-jdk-slim

EXPOSE 8080

ARG JAR_FILE=spring-boot-ecs.jar

WORKDIR /opt/app

COPY --from=build /usr/src/app/target/${JAR_FILE} /opt/app/

ENTRYPOINT ["java","-jar","spring-boot-ecs.jar"]
