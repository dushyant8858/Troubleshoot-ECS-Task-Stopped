# ---------- DD Local ---------- #

# docker build -t backendgreeting:local --build-arg server_port=8080 --no-cache .


docker build -t backendgreeting:local --build-arg server_port=8080 .
docker stop backendgreeting && docker rm backendgreeting 
sleep 5
docker run -d -p 8080:8080 --name backendgreeting backendgreeting:local

sleep 5

curl -s http://localhost:8080/backendgreeting | jq .


# docker logs -f backendgreeting
# docker exec -it backendgreeting sh 
# apk add curl 


# docker system df
# docker system prune --all


# git add .
# git commit -m "Removed .DS_Store"
# git push

# # ---------- DD Local ---------- #

# # Access Logs https://github.com/jochenchrist/spring-boot-access-logs-demo/tree/master/src




# docker stop backendgreeting && docker rm backendgreeting
# docker build -t backendgreeting:local --build-arg server_port=8080 .
# docker stop backendgreeting && docker rm backendgreeting 
# docker run -d -p 80:80 --name backendgreeting backendgreeting:local
# docker logs -f backendgreeting

