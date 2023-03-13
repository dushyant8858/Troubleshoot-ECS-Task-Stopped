Why my ECS task Stopped?
===
Lab to understand why ECS task are Stopped?

1. Clone this repository on your local machine
```
git clone https://github.com/dushyant8858/Troubleshoot-ECS-Task-Stopped.git

cd Troubleshoot-ECS-Task-Stopped
ls -l
```

2. Make sure you have AWS CLI installed if not follow [Installing or updating the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

3. Deploy the networking required to perform the lab
```
aws cloudformation create-stack --template-body file://PLM-VPC/Fixed_PLM-VPC.yaml --region us-west-2 --tags Key=Cost,Value=PLM Key=MinorCost,Value=PLM-VPC --stack-name PLM-VPC
```

4. Deploy ECS Infra
```
aws cloudformation create-stack --template-body file://PLM-ECS-Infra/Fixed_ECS-Cluster-Service.yaml --capabilities CAPABILITY_IAM --region us-west-2 --tags Key=Cost,Value=PLM-ECS --stack-name PLM-ECS
```

5. Time to break the ECS environment to troubleshoot Lab 1, 2 and 3  
```
sh PLM-ECS-Infra/PLM-ECS-Lab-1-2-3-script.sh 
```
## 1. PLM1TaskStoppedByUser 
```
################################################################################################
:::PLM Lab 1::: Troubleshoot ECS Service: PLM-ECS-PLM1TaskStoppedByUserECSService-KAFp3WQml0sc
################################################################################################

ECS_CLUSTER_NAME = PLM-ECS-PLMEcsCluster-9nwxPSs3hmRM
PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME = PLM-ECS-PLM1TaskStoppedByUserECSService-KAFp3WQml0sc

Whyyyyyyy my ECS Task 2a44eebd7b7e4b3dbb4f62aa8ac5bdff was "STOPPED"? My Website went DOWN due to this!
Whyyyyyyy my ECS Task 2b0e2dc7f1df490b82a8ceecd46a1bad was "STOPPED"? My Website went DOWN due to this!
Whyyyyyyy my ECS Task d86474f7756f4d6fa78582c4e462c993 was "STOPPED"? My Website went DOWN due to this!
############################## END :::PLM Lab 1::: ##############################
```

## 2. PLM2ServiceScalingEventTriggered
```
################################################################################################
:::PLM Lab 2::: Troubleshoot ECS Service: PLM-ECS-PLM2ServiceScalingEventTriggeredECSService-lYxppidP6pnt
################################################################################################

ECS_CLUSTER_NAME = PLM-ECS-PLMEcsCluster-9nwxPSs3hmRM
PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME = PLM-ECS-PLM2ServiceScalingEventTriggeredECSService-lYxppidP6pnt

Whyyyyyyy my ECS Task 15cfbc2fa0224c83bd191d8ced806932 was 'STOPPED'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task 16d4ce62cf544abd9c4645060ac30ab3 was 'STOPPED'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task 3334b9d36d2d49ada744f4adddc60619 was 'STOPPED'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task 64bc35c831f6424eb5afea419ea36e1a was 'STOPPED'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task 7bc6008d30df4cf9bad0f7027e12e70a was 'STOPPED'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task 7ca81da079ac4c4bafefbcf7d60c802f was 'STOPPED'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task 9444a2c6ce6c4ac58616e575be33bdc4 was 'STOPPED'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task d81b0cf2d308457fb61a7e2e886c5a82 was 'STOPPED'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task e26fad58b3084891b004dc728089387d was 'STOPPED'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task fed4529fa849465989546ead2af3060b was 'STOPPED'? My Website went DOWN due to this!
############################## END :::PLM Lab 2::: ##############################
```

## 3. PLM3UnhealthyContainerInstance
https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_StateReason.html
```
################################################################################################
:::PLM Lab 3::: Troubleshoot ECS Service: PLM-ECS-PLM3UnhealthyContainerInstanceECSService-Y1jJi2UKBzjo
################################################################################################

ECS_CLUSTER_NAME = PLM-ECS-PLMEcsCluster-9nwxPSs3hmRM
PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME = PLM-ECS-PLM3UnhealthyContainerInstanceECSService-Y1jJi2UKBzjo

Whyyyyyyy my ECS Task 8c2135886a5643b8be4becc53d92af03 is 'STOPPED' or 'shutting-down'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task a20608fdce5d431ea7504b06d54d4bef is 'STOPPED' or 'shutting-down'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task dbca3f26760b475ea4c47f57f2d31fdd is 'STOPPED' or 'shutting-down'? My Website went DOWN due to this!
############################## END :::PLM Lab 3::: ##############################
```

6. Lets further break the Networking and ECS Infrastruction to troubleshoot the Lab 4, 5, 6 and 7

a. Then Break ECS Infra...
```
aws cloudformation update-stack --template-body file://PLM-ECS-Infra/Problematic_ECS-Cluster-Service.yaml --capabilities CAPABILITY_IAM --region us-west-2 --tags Key=Cost,Value=PLM-ECS --stack-name PLM-ECS
```

b. Wait before the "PLM-ECS" CFN stack is `UPDATE_COMPLETE`
```
while true ; do aws cloudformation describe-stacks --region us-west-2 --stack-name PLM-ECS --query Stacks[].StackStatus && sleep 5; done
```

c. First Break Networking...
```
aws cloudformation update-stack --template-body file://PLM-VPC/Problematic_PLM-VPC.yaml --region us-west-2 --tags Key=Cost,Value=PLM Key=MinorCost,Value=PLM-VPC --stack-name PLM-VPC
```
d. Wait before the "PLM-VPC" CFN stack is `UPDATE_COMPLETE`
```
while true ; do aws cloudformation describe-stacks --region us-west-2 --stack-name PLM-VPC --query Stacks[].StackStatus && sleep 5; done
```

## 4. PLM4CannotPullContainerErrorECSService
https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_identity-vs-resource.html

7. Run below command and troublesoot Lab 4
```
sh PLM-ECS-Infra/PLM-ECS-Lab-4-script.sh
```
```
"ECS deployment ecs-svc/3218299231915255212 in progress."
Waiting... 30s
Waiting... 25s
Waiting... 20s
Waiting... 15s
Waiting... 10s
Waiting... 5s
Waiting... 0s DONE

################################################################################################
:::PLM Lab 4::: Troubleshoot ECS Service: PLM-ECS-PLM4CannotPullContainerErrorECSService-LDiqYGhnkftA
################################################################################################

ECS_CLUSTER_NAME = PLM-ECS-PLMEcsCluster-6MVDIwxByE6W
PLM4CannotPullContainerErrorECSService_ECS_SERVICE_NAME = PLM-ECS-PLM4CannotPullContainerErrorECSService-LDiqYGhnkftA

Whyyyyyyy my ECS Task 73749240bb6143bc8828784f5e421336 is NOT RUNNING? My Website went DOWN due to this!
Whyyyyyyy my ECS Task ebf9d46969c145debd9b9bd9e884621b is NOT RUNNING? My Website went DOWN due to this!
Whyyyyyyy my ECS Task faab2faa3c244d54b43cc42bcf9dd810 is NOT RUNNING? My Website went DOWN due to this!
############################## END :::PLM Lab 4::: ##############################

################################################################################################
:::PLM Lab 4::: Troubleshoot ECS Service: PLM-ECS-PLM4CannotPullContainerErrorECSService-LDiqYGhnkftA
################################################################################################
Whyyyyyyy my ECS Task in the ECS Service 'PLM-ECS-PLM4CannotPullContainerErrorECSService-LDiqYGhnkftA' is not running? My Website went DOWN due to this!
############################## END :::PLM Lab 4::: ##############################
```
8. Some error you will notice:
```
(service PLM-ECS-PLM4CannotPullContainerErrorECSService-LDiqYGhnkftA) was unable to place a task because no container instance met all of its requirements. The closest matching (container-instance 3a09814c860f4d3fb05f6f14c6489eb3) doesn't have the agent connected. For more information, see the Troubleshooting section of the Amazon ECS Developer Guide.
```
```
(service PLM-ECS-PLM4CannotPullContainerErrorECSService-LDiqYGhnkftA) failed to launch a task with (error ECS was unable to assume the role 'arn:aws:iam::8xxxxxxxxxx0:role/PLM-ECS-PLMECSTaskExecutionAndTaskRole-1I2VC5SGVU8Y1' that was provided for this task. Please verify that the role being passed has the proper trust relationship and permissions and that your IAM user has permissions to pass this role.).
```
```
CannotPullContainerError: Error response from daemon: Get "https://8xxxxxxxxxx0.dkr.ecr.us-west-2.amazonawss.com/v2/": dial tcp 3.33.139.32:443: i/o timeout
```
```
CannotPullContainerError: Error response from daemon: Get "https://8xxxxxxxxxx0.dkr.ecr.us-west-2.amazonawss.com/v2/": net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```
```
CannotPullECRContainerError: RequestError: send request failed caused by: Post "https://api.ecr.us-west-2.amazonaws.com/": net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```
```
level=error time=2023-03-13T15:08:12Z msg="Error while pulling image; will try to run anyway" image="8xxxxxxxxxx0.dkr.ecr.us-west-2.amazonaws.com/dushyant8858/traefik-whoami:latest" container="PLM4CannotPullContainerError" error="AccessDeniedException: User: arn:aws:sts::8xxxxxxxxxx0:assumed-role/PLM-ECS-PLMECSTaskExecutionAndTaskRole-1I2VC5SGVU8Y1/8ff4fbc265ee40bba57f8f709c43fef3 is not authorized to perform: ecr:GetAuthorizationToken on resource: * because no VPC endpoint policy allows the ecr:GetAuthorizationToken action\n\tstatus code: 400, request id: 3d181671-2223-4f93-914b-92c606357e06" task="8ff4fbc265ee40bba57f8f709c43fef3"
...
level=info time=2023-03-13T15:08:12Z msg="Sending state change to ECS" eventType="task" eventData="TaskChange: [arn:aws:ecs:us-west-2:8xxxxxxxxxx0:task/PLM-ECS-PLMEcsCluster-6MVDIwxByE6W/8ff4fbc265ee40bba57f8f709c43fef3 -> STOPPED, Known Sent: NONE, PullStartedAt: 2023-03-13 15:08:12.427031721 +0000 UTC m=+128790.604338705, PullStoppedAt: 2023-03-13 15:08:12.492694518 +0000 UTC m=+128790.670001512, ExecutionStoppedAt: 2023-03-13 15:08:12.518532546 +0000 UTC m=+128790.695839544, container change: arn:aws:ecs:us-west-2:8xxxxxxxxxx0:task/PLM-ECS-PLMEcsCluster-6MVDIwxByE6W/8ff4fbc265ee40bba57f8f709c43fef3 PLM4CannotPullContainerError -> STOPPED, Reason CannotPullECRContainerError: AccessDeniedException: User: arn:aws:sts::8xxxxxxxxxx0:assumed-role/PLM-ECS-PLMECSTaskExecutionAndTaskRole-1I2VC5SGVU8Y1/8ff4fbc265ee40bba57f8f709c43fef3 is not authorized to perform: ecr:GetAuthorizationToken on resource: * because no VPC endpoint policy allows the ecr:GetAuthorizationToken action\n\tstatus code: 400, request id: 3d181671-2223-4f93-914b-92c606357e06, Known Sent: NONE] sent: false"
```
```
level=info time=2023-03-13T15:18:48Z msg="Sending state change to ECS" eventType="task" eventData="TaskChange: [arn:aws:ecs:us-west-2:8xxxxxxxxxx0:task/PLM-ECS-PLMEcsCluster-6MVDIwxByE6W/0565d0c4e65d46b6be9a2f5fdcdc0a9f -> STOPPED, Known Sent: NONE, PullStartedAt: 2023-03-13 15:18:47.835083835 +0000 UTC m=+129426.012390829, PullStoppedAt: 2023-03-13 15:18:47.874903409 +0000 UTC m=+129426.052210406, ExecutionStoppedAt: 2023-03-13 15:18:47.901643947 +0000 UTC m=+129426.078950951, container change: arn:aws:ecs:us-west-2:8xxxxxxxxxx0:task/PLM-ECS-PLMEcsCluster-6MVDIwxByE6W/0565d0c4e65d46b6be9a2f5fdcdc0a9f PLM4CannotPullContainerError -> STOPPED, Reason CannotPullECRContainerError: AccessDeniedException: User: arn:aws:sts::8xxxxxxxxxx0:assumed-role/PLM-ECS-PLMECSTaskExecutionAndTaskRole-1I2VC5SGVU8Y1/0565d0c4e65d46b6be9a2f5fdcdc0a9f is not authorized to perform: ecr:GetAuthorizationToken on resource: * because no identity-based policy allowsthe ecr:GetAuthorizationToken action\n\tstatus code: 400, request id: 5f798344-1a05-44bc-ba39-41629df40791, Known Sent: NONE] sent: false"
```


## 5. PLM5ResourceInitializationErrorECSService
9. Run below command and troublesoot Lab 6
```
sh PLM-ECS-Infra/PLM-ECS-Lab-5-script.sh
```
```
"ECS deployment ecs-svc/3201896668189956989 in progress."
Waiting... 40s
Waiting... 35s
Waiting... 30s
Waiting... 25s
Waiting... 20s
Waiting... 15s
Waiting... 10s
Waiting... 5s
Waiting... 0s DONE

################################################################################################
:::PLM Lab 6::: Troubleshoot ECS Service: PLM-ECS-PLM5ResourceInitializationErrorECSService-ynabz0v4qAOS
################################################################################################

ECS_CLUSTER_NAME = PLM-ECS-PLMEcsCluster-6MVDIwxByE6W
PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME = PLM-ECS-PLM5ResourceInitializationErrorECSService-ynabz0v4qAOS

Whyyyyyyy my ECS Task 150fd9859cb445ba970f570e594a739c is NOT RUNNING? My Website went DOWN due to this!
Whyyyyyyy my ECS Task 52fbc64c842f451d9a1fc0ba291e2094 is NOT RUNNING? My Website went DOWN due to this!
Whyyyyyyy my ECS Task cb6e89f35c9546f5949e2894d12f01bd is NOT RUNNING? My Website went DOWN due to this!
############################## END :::PLM Lab 6::: ##############################

################################################################################################
:::PLM Lab 6::: Troubleshoot ECS Service: PLM-ECS-PLM5ResourceInitializationErrorECSService-ynabz0v4qAOS
################################################################################################

Whyyyyyyy my ECS Task in the ECS Service 'PLM-ECS-PLM5ResourceInitializationErrorECSService-ynabz0v4qAOS' is not running? My Website went DOWN due to this!
############################## END :::PLM Lab 6::: ##############################
```
10. Some error you will notice:
```
Fetching secret data from SSM Parameter Store in us-west-2: AccessDeniedException: User: arn:aws:sts::8xxxxxxxxxx0:assumed-role/PLM-ECS-PLMECSTaskExecutionAndTaskRole-1I2VC5SGVU8Y1/5c0a28eeb5fc45828b57e982c940d1ea is not authorized to perform: ssm:GetParameters on resource: arn:aws:ssm:us-west-2:8xxxxxxxxxx0:parameter/PLMSecretParameter because no identity-based policy allows the ssm:GetParameters action status code: 400, request id: f2a5572f-3f7a-4cf1-8fdf-be6439d78e97
```
```
Fetching secret data from SSM Parameter Store in us-west-2: invalid parameters: /PLMSecretParameter
```
```
CannotPullContainerError: Error response from daemon: Get "https://8xxxxxxxxxx0.dkr.ecr.us-west-2.amazonaws.commmmm/v2/": dial tcp: lookup 8xxxxxxxxxx0.dkr.ecr.us-west-2.amazonaws.commmmm on 10.0.0.2:53: no such host
```
```
CannotStartContainerError: Error response from daemon: failed to initialize logging driver: failed to create Cloudwatch log stream: ResourceNotFoundException: The specified log group does not exist.
```



## 6. PLM6FailedContainerHealthChecksECSService
11. Run below command and troublesoot Lab 6
```
sh PLM-ECS-Infra/PLM-ECS-Lab-6-script.sh
```
```
"ECS deployment ecs-svc/9232663487764909975 in progress."
Waiting... 40s
Waiting... 35s
Waiting... 30s
Waiting... 25s
Waiting... 20s
Waiting... 15s
Waiting... 10s
Waiting... 5s
Waiting... 0s DONE

################################################################################################
:::PLM Lab 6::: Troubleshoot ECS Service: PLM-ECS-PLM6FailedContainerHealthChecksECSService-PMpyyQ4JiBMR
################################################################################################

Whyyyyyyy my ECS Task in the ECS Service 'PLM-ECS-PLM6FailedContainerHealthChecksECSService-PMpyyQ4JiBMR' is not running? My Website went DOWN due to this!
############################## END :::PLM Lab 6::: ##############################
```
12. Some error you will notice:
Troubleshoot guide: https://aws.amazon.com/premiumsupport/knowledge-center/ecs-task-container-health-check-failures/
```
Essential container in task exited

...
Logs:
Timestamp                       Message                                 Container
3/13/2023, 1:14:16 PM	        sh: 0: cannot open c: No such file	    PLM6FailedContainerHealthChecks
```
```
Task failed container health checks

...
Logs:
127.0.0.1 - - [13/Mar/2023:19:38:45 +0000] "GET /health HTTP/1.1" 404 196
127.0.0.1 - - [13/Mar/2023:19:38:55 +0000] "GET /health HTTP/1.1" 404 196
10.0.13.116 - - [13/Mar/2023:19:38:58 +0000] "GET / HTTP/1.1" 200 313
10.0.30.12 - - [13/Mar/2023:19:38:58 +0000] "GET / HTTP/1.1" 200 313
```
```
Task failed ELB health checks in (target-group arn:aws:elasticloadbalancing:us-west-2:8xxxxxxxxxx0:targetgroup/PLM-EC-PLM6F-A8OKA66DVRBX/4fe72fe75cdf9149)
```


## 7. ALB Health check Failure
13. Run below command and troublesoot Lab 6
```
sh PLM-ECS-Infra/PLM-ECS-Lab-7-script.sh
```
```
"ECS deployment ecs-svc/2721925815705398450 in progress."
"ECS deployment ecs-svc/1513561454589138998 in progress."
Waiting... 40s
Waiting... 35s
Waiting... 30s
Waiting... 25s
Waiting... 20s
Waiting... 15s
Waiting... 10s
Waiting... 5s
Waiting... 0s DONE

################################################################################################
:::PLM Lab 7::: Troubleshoot ECS Service: PLM-ECS-FrontEndDateTimeECSService-Uv4AFj0Elz3x
################################################################################################

ECS_CLUSTER_NAME = PLM-ECS-PLMEcsCluster-6MVDIwxByE6W
FrontEndDateTimeECSService_ECS_SERVICE_NAME = PLM-ECS-FrontEndDateTimeECSService-Uv4AFj0Elz3x

Whyyyyyyy my ECS Task af1fbb88d5f4476fa5e08041b664fbd6 is NOT RUNNING? My Website went DOWN due to this!
############################## END :::PLM Lab 7::: ##############################

################################################################################################
:::PLM Lab 7::: Troubleshoot ECS Service: PLM-ECS-FrontEndDateTimeECSService-Uv4AFj0Elz3x
################################################################################################

Whyyyyyyy my ECS Task in the ECS Service 'PLM-ECS-FrontEndDateTimeECSService-Uv4AFj0Elz3x' is not running? My Website went DOWN due to this!
############################## END :::PLM Lab 7::: ##############################
```


14. Some error you will notice:
```
Task failed ELB health checks in (target-group arn:aws:elasticloadbalancing:us-west-2:8xxxxxxxxxx0:targetgroup/PLM-EC-Front-QOXLVGYPLTKN/87338e954c567776)

...
Logs:
REST address: BackEndGreeting.BackEndGreeting.PLM-Failing-Endpoint..... No host found
```
