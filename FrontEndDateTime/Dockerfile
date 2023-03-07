# FROM maven:3.6.3-openjdk-11 as BUILDER
FROM maven:3.6.3-openjdk-8 as BUILDER

COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:8-jdk-alpine as PRODUCTION
# FROM openjdk:11-jre-slim

ARG server_port=8083
ARG rest_hostname=greeting.greeting
ARG rest_port=8084

ENV SERVER_PORT=${server_port}
ENV REST_HOSTNAME=${rest_hostname}
ENV REST_PORT=${rest_port}

COPY --from=BUILDER /home/app/target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/datetime-demo.jar
EXPOSE ${server_port}
ENTRYPOINT java -Dsome.prop=MyAppIsPassed -Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar /usr/local/lib/datetime-demo.jar

# docker build -t datetime:withSDcfn --build-arg server_port=8083 --build-arg rest_hostname=Greeting.Greeting --build-arg rest_port=8084 .
# docker build -t datetime:latest --build-arg server_port=8083 --build-arg rest_hostname=greeting --build-arg rest_port=8084 --no-cache .
# docker rm datetime && docker run -itd --network=java-mvn -p 8083:8083 --name datetime datetime
# docker tag datetime:latest 275xxxxxx462.dkr.ecr.us-east-1.amazonaws.com/datetime:latest
# docker push 275xxxxxx462.dkr.ecr.us-east-1.amazonaws.com/datetime:latest

# aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 275xxxxxx462.dkr.ecr.us-east-1.amazonaws.com/pt-portal
