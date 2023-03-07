FROM maven:3.6.3-openjdk-11 as BUILDER
# FROM maven:3.6.3-openjdk-8 as BUILDER

# RUN COPY ADD create layers
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

# FROM openjdk:8-jdk-alpine as PRODUCTION
FROM openjdk:11-jre-slim as PRODUCTION

ARG server_port=80
ARG rest_hostname=backendgreeting.backendgreeting
ARG rest_port=8080

ENV SERVER_PORT=${server_port}
ENV REST_HOSTNAME=${rest_hostname}
ENV REST_PORT=${rest_port}

COPY --from=BUILDER /home/app/target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/frontenddatetime-demo.jar
EXPOSE ${server_port}
ENTRYPOINT java -Dsome.prop=MyAppIsPassed -Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar /usr/local/lib/frontenddatetime-demo.jar

# docker build -t frontenddatetime:latest --build-arg server_port=80 --build-arg rest_hostname=backendgreeting.backendgreeting --build-arg rest_port=80 --no-cache .
# docker rm frontenddatetime && docker run -itd --network=java-mvn -p 80:80 --name frontenddatetime frontenddatetime
# docker tag frontenddatetime:latest dushyant8858/frontenddatetime:latest
# docker push dushyant8858/frontenddatetime:latest

# aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 111xxxxxx111.dkr.ecr.us-east-1.amazonaws.com/pt-portal
