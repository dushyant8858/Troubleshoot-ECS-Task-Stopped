#!/bin/bash -vex

# sh PLM-ECS-Infra/PLM-ECS-Lab-5-script.sh

REGION=us-west-2

ECS_CLUSTER_NAME=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`PLMEcsCluster`].PhysicalResourceId' \
                    --output text \
                    --region $REGION)


########################################
# PLM5ResourceInitializationErrorECSService
########################################
PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`PLM5ResourceInitializationErrorECSService`].PhysicalResourceId' \
                    --output text \
                    --region $REGION | cut -d "/" -f 3)
# echo PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME=$PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME

aws ecs update-service \
    --cluster $ECS_CLUSTER_NAME \
    --service $PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME \
    --desired-count 1 \
    --force-new-deployment \
    --region $REGION \
    --query service.deployments[0].rolloutStateReason

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


PLM5ResourceInitializationErrorECSService_ECS_TASK_ARNs=$(aws ecs list-tasks \
                --cluster $ECS_CLUSTER_NAME \
                --service $PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME \
                --query taskArns[*] \
                --output json \
                --region $REGION)
# echo PLM5ResourceInitializationErrorECSService_ECS_TASK_ARNs=$PLM5ResourceInitializationErrorECSService_ECS_TASK_ARNs

COUNT=$(($(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME --query taskArns[*] --output table --region $REGION | wc -l ) - 4))
if [ "$COUNT" -ge 1 ]
then
    echo ""
    echo "################################################################################################"
    echo ":::PLM Lab 5::: Troubleshoot ECS Service: $PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME"
    echo "################################################################################################"
    echo ""
    echo ECS_CLUSTER_NAME = $ECS_CLUSTER_NAME
    echo PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME = $PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME
    echo ""

    PLM5ResourceInitializationErrorECSService_ECS_TASK_ARNs=$(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME --query taskArns[*] --output text --region $REGION)
    for PLM5ResourceInitializationErrorECSService_ECS_TASK_ARN in $PLM5ResourceInitializationErrorECSService_ECS_TASK_ARNs
    do
        PLM5ResourceInitializationErrorECSService_ECS_TASK_ID=$(echo $PLM5ResourceInitializationErrorECSService_ECS_TASK_ARN | cut -d "/" -f 3)
        # echo ""   
        echo "Whyyyyyyy my ECS Task $PLM5ResourceInitializationErrorECSService_ECS_TASK_ID is "NOT RUNNING"? My Website went DOWN due to this!"
        # echo ""
    done
    echo "############################## END :::PLM Lab 5::: ##############################"
fi
    echo ""
    echo "################################################################################################"
    echo ":::PLM Lab 5::: Troubleshoot ECS Service: $PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME"
    echo "################################################################################################"
    echo ""

    echo "Whyyyyyyy my ECS Task in the ECS Service '$PLM5ResourceInitializationErrorECSService_ECS_SERVICE_NAME' is not running? My Website went DOWN due to this!"

    echo "############################## END :::PLM Lab 5::: ##############################"
