# ---------- DD Local ---------- #

docker build -t datetime:local --build-arg server_port=8083 --build-arg rest_hostname=$(docker inspect greeting --format '{{.NetworkSettings.IPAddress}}') --build-arg rest_port=8084 --no-cache .

docker build -t datetime:local --build-arg server_port=8083 --build-arg rest_hostname=$(docker inspect greeting --format '{{.NetworkSettings.IPAddress}}') --build-arg rest_port=8084 .
docker stop datetime && docker rm datetime 
docker run -d -p 8083:8083 --name datetime datetime:local


curl http://localhost:8083/currentdatetime
curl http://localhost:8083/currentdatetime/greeting


docker logs -f datetime
docker exec -it datetime sh 
apk add curl 


docker system df
docker system prune --all


git add .
git commit -m "Added withSDcfn."
git push

# ---------- DD Local ---------- #

# Access Logs https://github.com/jochenchrist/spring-boot-access-logs-demo/tree/master/src





