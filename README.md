Exosite Operations Engineer Challenge:
The purpose of this document is to present a challenge to Operations Engineer candidates for completion

Assumptions:
Please assume the following conditions when creating the template:

The VPC/subnet(s) have already been deployed and their IDs can be provided.  
The provided subnet(s) already have access to the internet via a NAT Gateway if need.
The template can also assume the existence of a default VPC.

The Challenge:
Using Terraform to create a t4g.nano EC2 instance behind a load balancer that
serves the Nginx “Welcome to Nginx” default webpage that is publicly accessible.

BONUS: Service HTTPS requests from the load balancer using a certificate from ACM


Prerequisites:
Before you begin, ensure you have the following:
AWS Account: You need an AWS account with appropriate IAM permissions to create resources.
Terraform: Install Terraform on your local machine. 
Git: Install Git on your local machine to clone this repository.

Getting Started:
Follow these steps to deploy the infrastructure using Terraform:

Clone the Repository:

## git clone https://github.com/your-username/terraform-nginx-load-balancer.git

## cd terraform-nginx-load-balancer 


Configure AWS Credentials:
Ensure you have your AWS credentials configured on your system. You can do this by setting the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.


Customize Variables:
Edit the terraform.tfvars file to customize the following variables:
## Ask them a question about this part

aws_region            = "us-east-1"
instance_ami          = "ami-xxxxxxxxxxxxxxxxx"
instance_type         = "t4g.nano"
subnet_id             = "subnet-xxxxxxxxxxxxxxxxx"
subnet_ids            = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyyyyy"]
acm_certificate_arn   = "arn:aws:acm:us-east-1:123456789012:certificate/abcdef12-3456-7890-abcd-ef1234567890"


Initialize Terraform:
Run the following command to initialize Terraform and download required providers:

## terraform init


## terraform plan -out=FILE

Using the -out option with terraform plan and later terraform apply can be a useful approach, especially when working with automation and
separating the planning and execution phases. This allows you to review the plan, save it to a file, and then apply the plan later, 
ensuring that the execution matches your intended changes.


Deploy Infrastructure:
Run the following command to apply the Terraform configuration and create the infrastructure:

## terraform apply
Review the changes and type yes when prompted to confirm the deployment.

Access the Application:
After the deployment is complete, Terraform will output the DNS name of the load balancer. Access this DNS name in a web browser to see the Nginx "Welcome to Nginx" default webpage.


Destroy Infrastructure (Optional but highly recommand):
To tear down the infrastructure when you're done, run:

## terraform destroy
Confirm the destruction by typing yes when prompted.

Important Notes
Be cautious with your AWS credentials and never expose them publicly.
This code is intended for educational purposes. Always review and customize it for production use.

