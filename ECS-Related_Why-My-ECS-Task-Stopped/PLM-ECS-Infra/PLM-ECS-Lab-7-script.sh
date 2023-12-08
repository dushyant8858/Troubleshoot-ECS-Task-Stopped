#!/bin/bash -vex

# sh PLM-ECS-Infra/PLM-ECS-Lab-7-script.sh

REGION=us-west-2

ECS_CLUSTER_NAME=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`PLMEcsCluster`].PhysicalResourceId' \
                    --output text \
                    --region $REGION)


########################################
# FrontEndDateTimeECSService
########################################
echo ""
FrontEndDateTimeECSService_ECS_SERVICE_NAME=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`FrontEndDateTimeECSService`].PhysicalResourceId' \
                    --output text \
                    --region $REGION | cut -d "/" -f 3)
echo FrontEndDateTimeECSService_ECS_SERVICE_NAME=$FrontEndDateTimeECSService_ECS_SERVICE_NAME

aws ecs update-service \
    --cluster $ECS_CLUSTER_NAME \
    --service $FrontEndDateTimeECSService_ECS_SERVICE_NAME \
    --desired-count 1 \
    --force-new-deployment \
    --region $REGION \
    --query service.deployments[0].rolloutStateReason

echo ""

BackEndGreetingECSService_ECS_SERVICE_NAME=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`BackEndGreetingECSService`].PhysicalResourceId' \
                    --output text \
                    --region $REGION | cut -d "/" -f 3)
echo BackEndGreetingECSService_ECS_SERVICE_NAME=$BackEndGreetingECSService_ECS_SERVICE_NAME

aws ecs update-service \
    --cluster $ECS_CLUSTER_NAME \
    --service $BackEndGreetingECSService_ECS_SERVICE_NAME \
    --desired-count 1 \
    --force-new-deployment \
    --region $REGION \
    --query service.deployments[0].rolloutStateReason
echo ""

echo "Waiting... 40s"
sleep 5
echo "Waiting... 35s"
sleep 5
echo "Waiting... 30s"
sleep 5
echo "Waiting... 25s"
sleep 5
echo "Waiting... 20s"
sleep 5
echo "Waiting... 15s"
sleep 5
echo "Waiting... 10s"
sleep 5
echo "Waiting... 5s"
sleep 5
echo "Waiting... 0s DONE"


FrontEndDateTimeECSService_ECS_TASK_ARNs=$(aws ecs list-tasks \
                --cluster $ECS_CLUSTER_NAME \
                --service $FrontEndDateTimeECSService_ECS_SERVICE_NAME \
                --query taskArns[*] \
                --output json \
                --region $REGION)
# echo FrontEndDateTimeECSService_ECS_TASK_ARNs=$FrontEndDateTimeECSService_ECS_TASK_ARNs

COUNT=$(($(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $FrontEndDateTimeECSService_ECS_SERVICE_NAME --query taskArns[*] --output table --region $REGION | wc -l ) - 4))
if [ "$COUNT" -ge 1 ]
then
    echo ""
    echo "################################################################################################"
    echo ":::PLM Lab 7::: Troubleshoot ECS Service: $FrontEndDateTimeECSService_ECS_SERVICE_NAME"
    echo "################################################################################################"
    echo ""
    echo ECS_CLUSTER_NAME = $ECS_CLUSTER_NAME
    echo FrontEndDateTimeECSService_ECS_SERVICE_NAME = $FrontEndDateTimeECSService_ECS_SERVICE_NAME
    echo ""

    FrontEndDateTimeECSService_ECS_TASK_ARNs=$(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $FrontEndDateTimeECSService_ECS_SERVICE_NAME --query taskArns[*] --output text --region $REGION)
    for FrontEndDateTimeECSService_ECS_TASK_ARN in $FrontEndDateTimeECSService_ECS_TASK_ARNs
    do
        FrontEndDateTimeECSService_ECS_TASK_ID=$(echo $FrontEndDateTimeECSService_ECS_TASK_ARN | cut -d "/" -f 3)
        # echo ""   
        echo "Whyyyyyyy my ECS Task $FrontEndDateTimeECSService_ECS_TASK_ID is "NOT RUNNING"? My Website went DOWN due to this!"
        # echo ""
    done
    echo "############################## END :::PLM Lab 7::: ##############################"
fi
    echo ""
    echo "################################################################################################"
    echo ":::PLM Lab 7::: Troubleshoot ECS Service: $FrontEndDateTimeECSService_ECS_SERVICE_NAME"
    echo "################################################################################################"
    echo ""

    echo "Whyyyyyyy my ECS Task in the ECS Service '$FrontEndDateTimeECSService_ECS_SERVICE_NAME' is not running? My Website went DOWN due to this!"

    echo "############################## END :::PLM Lab 7::: ##############################"
