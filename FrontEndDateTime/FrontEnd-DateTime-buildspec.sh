#/bin/bash -ve

echo ***PRIVATE*** Build started on `date`...
echo Building the Docker image...
LOCAL_PRIVATE_REPOSITORY_NAME=frontenddatetime
DOCKER_PRIVATE_REPOSITORY_NAME=dushyant8858/frontenddatetime
COMMIT_HASH=$(git rev-parse --short=6 HEAD)


echo ******** Building form ARCH=arm64v8 ********
# docker build -t $LOCAL_PRIVATE_REPOSITORY_NAME:latest-arm64v8 --build-arg ARCH=arm64v8 --build-arg server_port=80 --build-arg rest_hostname=backendgreeting.backendgreeting --build-arg rest_port=80 --no-cache .
docker build -t $LOCAL_PRIVATE_REPOSITORY_NAME:latest-arm64v8 --build-arg ARCH=arm64v8 --build-arg server_port=80 --build-arg rest_hostname=backendgreeting.backendgreeting --build-arg rest_port=80 .
docker tag $LOCAL_PRIVATE_REPOSITORY_NAME:latest-arm64v8 $DOCKER_PRIVATE_REPOSITORY_NAME:latest-arm64v8
docker tag $LOCAL_PRIVATE_REPOSITORY_NAME:latest-arm64v8 $DOCKER_PRIVATE_REPOSITORY_NAME:$COMMIT_HASH-arm64v8

echo ******** Pushing form ARCH=arm64v8 ********
docker push $DOCKER_PRIVATE_REPOSITORY_NAME:latest-arm64v8
docker push $DOCKER_PRIVATE_REPOSITORY_NAME:$COMMIT_HASH-arm64v8
echo ***PRIVATE*** Build completed on `date`...

echo ******** Building form ARCH=amd64 ********
# docker build -t $LOCAL_PRIVATE_REPOSITORY_NAME:latest-amd64 --build-arg ARCH=amd64 --build-arg server_port=80 --build-arg rest_hostname=backendgreeting.backendgreeting --build-arg rest_port=80 --no-cache .
docker build -t $LOCAL_PRIVATE_REPOSITORY_NAME:latest-amd64 --build-arg ARCH=amd64 --build-arg server_port=80 --build-arg rest_hostname=backendgreeting.backendgreeting --build-arg rest_port=80 .
docker tag $LOCAL_PRIVATE_REPOSITORY_NAME:latest-amd64 $DOCKER_PRIVATE_REPOSITORY_NAME:latest-amd64
docker tag $LOCAL_PRIVATE_REPOSITORY_NAME:latest-amd64 $DOCKER_PRIVATE_REPOSITORY_NAME:$COMMIT_HASH-amd64

echo ******** Pushing form ARCH=amd64 ********
docker push $DOCKER_PRIVATE_REPOSITORY_NAME:latest-amd64
docker push $DOCKER_PRIVATE_REPOSITORY_NAME:$COMMIT_HASH-amd64



echo ***PRIVATE*** Build completed on `date`...
# Creating Docker Manifest for PRIVATE Docker Registry
echo ******** Creating Docker Manifest for PRIVATE Docker Registry ********
docker manifest create $DOCKER_PRIVATE_REPOSITORY_NAME:latest --amend $DOCKER_PRIVATE_REPOSITORY_NAME:latest-amd64 --amend $DOCKER_PRIVATE_REPOSITORY_NAME:latest-arm64v8
docker manifest create $DOCKER_PRIVATE_REPOSITORY_NAME:$COMMIT_HASH --amend $DOCKER_PRIVATE_REPOSITORY_NAME:$COMMIT_HASH-amd64 --amend $DOCKER_PRIVATE_REPOSITORY_NAME:$COMMIT_HASH-arm64v8
   
echo ******** FINALLY Pushing Docker Manifest ********
docker manifest push $DOCKER_PRIVATE_REPOSITORY_NAME:latest

docker manifest push $DOCKER_PRIVATE_REPOSITORY_NAME:$COMMIT_HASH

echo CodeBuild completed on `date`

