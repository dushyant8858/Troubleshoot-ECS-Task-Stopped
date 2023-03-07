ARG ARCH=

FROM ${ARCH}/maven:3.6.3-openjdk-11 as BUILDER
# FROM ${ARCH}/maven:3.6.3-openjdk-8 as BUILDER

# RUN COPY ADD create layers
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

# FROM ${ARCH}/openjdk:8-jdk-alpine as PRODUCTION
FROM ${ARCH}/openjdk:11-jre-slim as PRODUCTION

ARG server_port=8080

ENV SERVER_PORT=${server_port}

COPY --from=BUILDER /home/app/target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/backendgreeting-demo.jar
EXPOSE ${server_port}
# ENTRYPOINT ["java","-jar","/usr/local/lib/backendgreeting-demo.jar"]
# ENTRYPOINT java -Xmx1024m -Xms1024m -Dsome.prop=MyAppIsPassed -Dserver.port=${SERVER_PORT} -jar /usr/local/lib/backendgreeting-demo.jar
ENTRYPOINT java -Dsome.prop=MyAppIsPassed -Dserver.port=${SERVER_PORT} -jar /usr/local/lib/backendgreeting-demo.jar

# docker build -t backendgreeting:latest --build-arg server_port=8080 --no-cache .
# docker rm backendgreeting && docker run -itd --network=java-mvn -p 8080:8080 --name backendgreeting backendgreeting
# docker tag backendgreeting:latest dushyant8858/backendgreeting:latest
# docker push dushyant8858/backendgreeting:latest

# aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 111xxxxxx111.dkr.ecr.us-east-1.amazonaws.com/pt-portal
