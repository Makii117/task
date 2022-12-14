FROM maven:3.8.6-openjdk-18 as maven

RUN mkdir -p /data
WORKDIR /data
RUN git clone https://github.com/kkenan/basic-microservices.git 
WORKDIR /data/basic-microservices/spring-boot-app/
RUN mvn clean package

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=maven /data/basic-microservices/spring-boot-app/target/spring-boot-app-1.0-SNAPSHOT.jar /app/
COPY --from=maven /data/basic-microservices/spring-boot-app/src/main/resources/application.yml /app/

RUN sed -i 's+jdbc:postgresql://localhost:5432/demodb+jdbc:postgresql://db:5432/demodb+g' application.yml

RUN sed -i 's+http://localhost:8081/+http://frontend:8081/+g' application.yml

ENV PORT=8080

EXPOSE 8080

ENTRYPOINT ["java","-jar","spring-boot-app-1.0-SNAPSHOT.jar","--spring.config.location=application.yml"]
