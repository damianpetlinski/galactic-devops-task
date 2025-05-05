1. docker run -d --name localstack -p 4566:4566 -e SERVICES=s3,lambda,sts,iam,apigateway,ec2,rds localstack/localstack

2. aws --endpoint-url=http://localhost:4566 s3api create-bucket --bucket tfstate-bucket

3. terraform init -backend-config="./environments/local/backend.tfvars" -var-file="./environments/local/variables.tfvars"

4. terraform plan -var-file="./environments/local/variables.tfvars" -out="plan.tfplan"