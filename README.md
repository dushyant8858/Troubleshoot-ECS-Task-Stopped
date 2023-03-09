Why my ECS task Stopped?
===
Lab to understand why ECS task are Stopped?

## 1. PLM1TaskStoppedByUser 
Why the below task stopped in the ECS Service `PLM-ECS-PLM1TaskStoppedByUserECSService`, this caused an outage?
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

