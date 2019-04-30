SERVICE_NAME=hello-world
STACK_NAME=hello-world-pipeline
REGION=us-east-1


init-pipeline:
	@echo "Creating stack"
	@aws cloudformation create-stack \
        --region ${REGION} \
        --stack-name ${STACK_NAME} \
        --template-body file://infrastructure/pipeline.yml \
        --parameters ParameterKey=Service,ParameterValue=${SERVICE_NAME} \
        --tags Key=Service,Value=${SERVICE_NAME} \
        --capabilities CAPABILITY_IAM
