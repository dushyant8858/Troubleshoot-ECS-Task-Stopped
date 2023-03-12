#!/bin/bash -vex

# sh PLM-ECS-Infra/PLM-ECS-Lab-1-2-3-script.sh


# brew update
# brew upgrade
# brew install jq
# brew install awscli
# brew install session-manager-plugin


REGION=us-west-2

ECS_CLUSTER_NAME=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`PLMEcsCluster`].PhysicalResourceId' \
                    --output text \
                    --region $REGION)


########################################
# PLM1TaskStoppedByUserECSService
########################################
PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`PLM1TaskStoppedByUserECSService`].PhysicalResourceId' \
                    --output text \
                    --region $REGION | cut -d "/" -f 3)
# echo PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME=$PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME


PLM1TaskStoppedByUserECSService_ECS_TASK_ARNs=$(aws ecs list-tasks \
                --cluster $ECS_CLUSTER_NAME \
                --service $PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME \
                --query taskArns[*] \
                --output json \
                --region $REGION)
# echo PLM1TaskStoppedByUserECSService_ECS_TASK_ARNs=$PLM1TaskStoppedByUserECSService_ECS_TASK_ARNs

COUNT=$(($(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME --query taskArns[*] --output table --region $REGION | wc -l ) - 4))
if [ "$COUNT" -ge 1 ]
then
    echo ""
    echo "################################################################################################"
    echo ":::PLM Lab 1::: Troubleshoot ECS Service: $PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME"
    echo "################################################################################################"
    echo ""
    echo ECS_CLUSTER_NAME = $ECS_CLUSTER_NAME
    echo PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME = $PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME
    echo ""

    PLM1TaskStoppedByUserECSService_ECS_TASK_ARNs=$(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $PLM1TaskStoppedByUserECSService_ECS_SERVICE_NAME --query taskArns[*] --output text --region $REGION)
    for PLM1TaskStoppedByUserECSService_ECS_TASK_ARN in $PLM1TaskStoppedByUserECSService_ECS_TASK_ARNs
    do
        PLM1TaskStoppedByUserECSService_ECS_TASK_ID=$(echo $PLM1TaskStoppedByUserECSService_ECS_TASK_ARN | cut -d "/" -f 3)
        # echo ""
        TaskStatus=$(aws ecs stop-task \
                --cluster $ECS_CLUSTER_NAME \
                --region $REGION \
                --task $PLM1TaskStoppedByUserECSService_ECS_TASK_ID \
                --query task.desiredStatus)
        
        echo "Whyyyyyyy my ECS Task $PLM1TaskStoppedByUserECSService_ECS_TASK_ID was $TaskStatus? My Website went DOWN due to this!"
        # echo ""
    done
    echo "############################## END :::PLM Lab 1::: ##############################"
fi




########################################
# PLM2ServiceScalingEventTriggeredECSService
########################################
PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`PLM2ServiceScalingEventTriggeredECSService`].PhysicalResourceId' \
                    --output text \
                    --region $REGION | cut -d "/" -f 3)
# echo PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME=$PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME


PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_ScalableTargets_ResourceId=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`PLM2ServiceScalingEventTriggeredScalableTarget`].PhysicalResourceId' \
                    --output text \
                    --region $REGION | cut -d "|" -f 1)
# echo PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_ScalableTargets_ResourceId=$PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_ScalableTargets_ResourceId

PLM2ServiceScalingEventTriggeredECSService_ECS_TASK_ARNs=$(aws ecs list-tasks \
                --cluster $ECS_CLUSTER_NAME \
                --service $PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME \
                --query taskArns[*] \
                --output json \
                --region $REGION)
# echo PLM2ServiceScalingEventTriggeredECSService_ECS_TASK_ARNs=$PLM2ServiceScalingEventTriggeredECSService_ECS_TASK_ARNs

COUNT=$(($(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME --query taskArns[*] --output table --region $REGION | wc -l ) - 4))
if [ "$COUNT" -ge 1 ]
then
    echo ""
    echo "################################################################################################"
    echo ":::PLM Lab 2::: Troubleshoot ECS Service: $PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME"
    echo "################################################################################################"
    echo ""
    echo ECS_CLUSTER_NAME = $ECS_CLUSTER_NAME
    echo PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME = $PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME
    echo ""

    aws application-autoscaling register-scalable-target \
        --service-namespace ecs \
        --scalable-dimension ecs:service:DesiredCount \
        --resource-id $PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_ScalableTargets_ResourceId \
        --min-capacity 0 \
        --max-capacity 0

    PLM2ServiceScalingEventTriggeredECSService_ECS_TASK_ARNs=$(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $PLM2ServiceScalingEventTriggeredECSService_ECS_SERVICE_NAME --query taskArns[*] --output text --region $REGION)
    for PLM2ServiceScalingEventTriggeredECSService_ECS_TASK_ARN in $PLM2ServiceScalingEventTriggeredECSService_ECS_TASK_ARNs
    do
        PLM2ServiceScalingEventTriggeredECSService_ECS_TASK_ID=$(echo $PLM2ServiceScalingEventTriggeredECSService_ECS_TASK_ARN | cut -d "/" -f 3)
        # echo ""
        echo "Whyyyyyyy my ECS Task $PLM2ServiceScalingEventTriggeredECSService_ECS_TASK_ID was 'STOPPED'? My Website went DOWN due to this!"
        # echo ""
    done
    echo "############################## END :::PLM Lab 2::: ##############################"
fi



########################################
# PLM3UnhealthyContainerInstanceECSService
########################################
PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME=$(aws cloudformation describe-stack-resources \
                    --stack-name PLM-ECS \
                    --query 'StackResources[?LogicalResourceId==`PLM3UnhealthyContainerInstanceECSService`].PhysicalResourceId' \
                    --output text \
                    --region $REGION | cut -d "/" -f 3)
# echo PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME=$PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME

PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ARNs=$(aws ecs list-tasks \
                --cluster $ECS_CLUSTER_NAME \
                --service $PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME \
                --query taskArns[*] \
                --output json \
                --region $REGION)
# echo PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ARNs=$PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ARNs

COUNT=$(($(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME --query taskArns[*] --output table --region $REGION | wc -l ) - 4))
if [ "$COUNT" -ge 1 ]
then
    echo ""
    echo "################################################################################################"
    echo ":::PLM Lab 3::: Troubleshoot ECS Service: $PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME"
    echo "################################################################################################"
    echo ""
    echo ECS_CLUSTER_NAME = $ECS_CLUSTER_NAME
    echo PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME = $PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME
    echo ""

    PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ARNs=$(aws ecs list-tasks --cluster $ECS_CLUSTER_NAME --service $PLM3UnhealthyContainerInstanceECSService_ECS_SERVICE_NAME --query taskArns[*] --output text --region $REGION)
    for PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ARN in $PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ARNs
    do
        PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ID=$(echo $PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ARN | cut -d "/" -f 3)

        ECS_containerInstanceArn=$(aws ecs describe-tasks \
                --cluster $ECS_CLUSTER_NAME \
                --tasks $PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ARN \
                --region $REGION \
                --query tasks[].containerInstanceArn \
                --output text)
        # echo ECS_containerInstanceArn = $ECS_containerInstanceArn

        ECS_ec2InstanceId=$(aws ecs describe-container-instances \
                --cluster $ECS_CLUSTER_NAME \
                --container-instances $ECS_containerInstanceArn \
                --region $REGION \
                --query containerInstances[].ec2InstanceId \
                --output text)
        # echo ECS_ec2InstanceId=$ECS_ec2InstanceId

        CurrentState=$(aws ec2 terminate-instances \
                --instance-ids $ECS_ec2InstanceId \
                --region $REGION \
                --query TerminatingInstances[].CurrentState.Name \
                --output text)
        
        echo "Whyyyyyyy my ECS Task $PLM3UnhealthyContainerInstanceECSService_ECS_TASK_ID is 'STOPPED' or '$CurrentState'? My Website went DOWN due to this!"
        # echo ""
    done
    echo "############################## END :::PLM Lab 3::: ##############################"
fi

