FROM maven:3.8.6-openjdk-18 as maven

RUN mkdir -p /data
WORKDIR /data
RUN git clone https://github.com/kkenan/basic-microservices.git 
WORKDIR /data/basic-microservices/spring-boot-app/
RUN mvn dependency:copy-dependencies
RUN mvn package

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=maven /data/basic-microservices/spring-boot-app/target/spring-boot-app-1.0-SNAPSHOT.jar /app/
COPY --from=maven /data/basic-microservices/spring-boot-app/src/main/resources/application.yml /app/


ENV PORT=8080
   
EXPOSE 8080

ENTRYPOINT ["java","-jar","spring-boot-app-1.0-SNAPSHOT.jar","--spring.config.location=file:application.yml"]
