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
################################################################################################
:::PLM Lab 1::: Troubleshoot ECS Service: PLM-ECS-PLM1TaskStoppedByUserECSService-KAFp3WQml0sc
################################################################################################

ECS_CLUSTER_NAME = PLM-ECS-PLMEcsCluster-9nwxPSs3hmRM
PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME = PLM-ECS-PLM1TaskStoppedByUserECSService-KAFp3WQml0sc

Whyyyyyyy my ECS Task 2a44eebd7b7e4b3dbb4f62aa8ac5bdff was "STOPPED"? My Website went DOWN due to this!
Whyyyyyyy my ECS Task 2b0e2dc7f1df490b82a8ceecd46a1bad was "STOPPED"? My Website went DOWN due to this!
Whyyyyyyy my ECS Task d86474f7756f4d6fa78582c4e462c993 was "STOPPED"? My Website went DOWN due to this!
############################## END :::PLM Lab 1::: ##############################

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

################################################################################################
:::PLM Lab 3::: Troubleshoot ECS Service: PLM-ECS-PLM3UnhealthyContainerInstanceECSService-Y1jJi2UKBzjo
################################################################################################

ECS_CLUSTER_NAME = PLM-ECS-PLMEcsCluster-9nwxPSs3hmRM
PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME = PLM-ECS-PLM3UnhealthyContainerInstanceECSService-Y1jJi2UKBzjo

Whyyyyyyy my ECS Task 8c2135886a5643b8be4becc53d92af03 is 'STOPPED' or 'shutting-down'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task a20608fdce5d431ea7504b06d54d4bef is 'STOPPED' or 'shutting-down'? My Website went DOWN due to this!
Whyyyyyyy my ECS Task dbca3f26760b475ea4c47f57f2d31fdd is 'STOPPED' or 'shutting-down'? My Website went DOWN due to this!
############################## END :::PLM Lab 3::: ##############################





## 1. PLM1TaskStoppedByUser 
Why the below task stopped in the ECS Service `PLM-ECS-PLM1TaskStoppedByUserECSService`, this caused an outage?
- `022dec4fcd0944d0ab25969f9ab5d414`
- `367b85e4cbd142158e7ac7dc435fa3d6`
- `c102b84ee72d4dc5932ce029b403b81b`

- `f4b2fb53fd724e8fa0b8d6986196b8d2`
- `654177fd57884a0ba8908952b6ebed8c`

## 2. PLM2ServiceScalingEventTriggered 
Why the below task stopped in the ECS Service `PLM-ECS-PLM2ServiceScalingEventTriggered`, this caused an outage as suddenly task stopped?
- `1cc86b2eea9948f08eff56e76683b0c2`
- `2d7fff8ddb9945e29d09b4feab1a1146`
- `6cbecdfb846e40b7bf4a9d16dae74e8e`
- `8eff982c603045a6bfbb5ac2f413a04c`
- `c9db581bee43476eab9894cf1ae193e7`

## 3. PLM2ServiceScalingEventTriggered 
Why the below task stopped in the ECS Service `PLM-ECS-PLM2ServiceScalingEventTriggered`, this caused an outage as suddenly task stopped?
- `16f15a592f054446904777ceaa81b345`
-  `4f4fbb8250d94acea00205542c3f6951`
-  `6e4de1f9a93c4441b0f54169af5906ca`

- `1cc86b2eea9948f08eff56e76683b0c2`
- `2d7fff8ddb9945e29d09b4feab1a1146`
- `6cbecdfb846e40b7bf4a9d16dae74e8e`
- `8eff982c603045a6bfbb5ac2f413a04c`
- `c9db581bee43476eab9894cf1ae193e7`


CannotStartContainerError
18977b93c0ff43ad8d50cc094848e2dc
Status reason	CannotStartContainerError: Error response from daemon: failed to initialize logging driver: failed to create Cloudwatch log stream: ResourceNotFoundException: The specified log group does not exist.


59b93f2f38554f51b75f0ea827723c3c - Status reason	CannotPullContainerError: no matching manifest for linux/amd64 in the manifest list entries


Stopped reason Fetching secret data from SSM Parameter Store in us-west-2: AccessDeniedException: User: arn:aws:sts::8XXXXXXXXX0:assumed-role/PLM-ECS-PLMECSTaskExecutionRole-XXX/59f3473f332042e5840e824b1f8fdbec is not authorized to perform: ssm:GetParameters on resource: arn:aws:ssm:us-west-2:8XXXXXXXXX0:parameter/CFN-PLMSecretParameter-XXX because no identity-based policy allows the ssm:GetParameters action status code: 400, request id: XX-bbd0-XX-b8b8-XX


Stopped reason Fetching secret data from SSM Parameter Store in us-west-2: AccessDeniedException: User: arn:aws:sts::8XXXXXXXXX0:assumed-role/PLM-ECS-PLMECSTaskExecutionRole-1ELKRFLI7MRK8/ab31f3f626f2442da9bfb200c618e393 is not authorized to perform: ssm:GetParameters on resource: arn:aws:ssm:us-west-2:8XXXXXXXXX0:parameter/CFN-PLMSecretParameter-BlcjtHm1Fj7R because no VPC endpoint policy allows the ssm:GetParameters action status code: 400, request id: xx-214b-4704-ad1e-xx

