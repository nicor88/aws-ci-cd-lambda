SERVICE_NAME=my-service
STACK_NAME_PIPELINE=my-service-ci-cd
REGION=us-east-1

deploy-pipeline:
	@aws cloudformation deploy \
        --region ${REGION} \
        --stack-name ${STACK_NAME_PIPELINE} \
        --template-file infrastructure/pipeline.yml \
        --parameter-overrides Service=${SERVICE_NAME} \
        --tags Service=${SERVICE_NAME} \
        --capabilities CAPABILITY_IAM

build-lambdas:
	bash scripts/build_lambdas.sh

package-cfn-stack: build-lambdas
	@aws cloudformation package --template-file infrastructure/stack.yml \
	--output-template-file packaged_functions.yml --s3-bucket hello-world-us-east-1-artifacts

deploy-stack:
	@aws cloudformation deploy \
        --region ${REGION} \
        --stack-name ${SERVICE_NAME} \
        --template-file packaged_functions.yml \
        --parameter-overrides Service=${SERVICE_NAME} \
        --tags Service=${SERVICE_NAME} \
        --capabilities CAPABILITY_IAM
