# ---------- DD Local ---------- #

# docker build -t frontenddatetime:local --build-arg server_port=80 --build-arg rest_hostname=$(docker inspect backendgreeting --format '{{.NetworkSettings.IPAddress}}') --build-arg rest_port=8080 --no-cache .

docker build -t frontenddatetime:local --build-arg server_port=80 --build-arg rest_hostname=$(docker inspect backendgreeting --format '{{.NetworkSettings.IPAddress}}') --build-arg rest_port=8080 .
docker stop frontenddatetime && docker rm frontenddatetime 
sleep 5
docker run -d -p 80:80 --name frontenddatetime frontenddatetime:local

sleep 5

curl -s http://localhost:80/frontenddatetime | jq .
curl -s http://localhost:80/frontenddatetime/backendgreeting | jq . 


# docker logs -f frontenddatetime
# docker exec -it frontenddatetime sh 
# apk add curl 


# docker system df
# docker system prune --all


# git add .
# git commit -m "Added withSDcfn."
# git push

# ---------- DD Local ---------- #

# Access Logs https://github.com/jochenchrist/spring-boot-access-logs-demo/tree/master/src





