docker build -t greeting:latest --build-arg server_port=8085 --no-cache .
docker run -itd --network=java-mvn -p 8085:8085 --name greeting greeting

docker build -t datetime:latest --build-arg rest_hostname=greeting --build-arg rest_port=8085 --no-cache .
docker run -itd --network=java-mvn -p 8083:8083 --name datetime datetime

---

# ENTRYPOINT works
#ENTRYPOINT ["java", "-jar", "/usr/local/lib/datetime-demo.jar"]

# Error: Could not find or load main class .usr.local.lib.datetime-demo.jar
# ENTRYPOINT ["java", "-Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar", "/usr/local/lib/datetime-demo.jar"]

# Error: Could not find or load main class server.port=${SERVER_PORT} rest.hostname=${REST_HOSTNAME} rest.port=${REST_PORT} -jar
# ENTRYPOINT ["java", "server.port=${SERVER_PORT} rest.hostname=${REST_HOSTNAME} rest.port=${REST_PORT} -jar", "/usr/local/lib/datetime-demo.jar"]

#================== MyApp==================
#================== ==================
#================== ==================
#ENTRYPOINT java -Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar /usr/local/lib/datetime-demo.jar

# works
#================== MyAppIsPassed==================
#================== greeting3==================
#================== 80823==================
ENTRYPOINT java -Dsome.prop=MyAppIsPassed -Dserver.port=${SERVER_PORT} -Drest.hostname=${REST_HOSTNAME} -Drest.port=${REST_PORT} -jar /usr/local/lib/datetime-demo.jar

--

# RUN COPY ADD create layers

# ARG can be set during docker build, eg:
# docker build -t datetime:latest --build-arg REST_HOSTNAME=greeting  --build-arg REST_PORT=8082 .
# If receiving from Gitlab/Github, use ${variablename}
# docker build -t datetime:latest --build-arg REST_HOSTNAME=${REST_HOSTNAME}  --build-arg REST_PORT=${REST_PORT} .
# Leave empty as ARG REST_HOSTNAME=
# or with an overridable default as ARG REST_HOSTNAME=localhost
ARG server_port=8083
ARG rest_hostname=localhost
ARG rest_port=8082

# ENV can be set from ARGs
ENV SERVER_PORT=${server_port}
ENV REST_HOSTNAME=${rest_hostname}
ENV REST_PORT=${rest_port}
