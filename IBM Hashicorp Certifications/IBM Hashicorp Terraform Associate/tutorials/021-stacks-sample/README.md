# AWS Infrastructure Stack

This Terraform Stack creates a complete AWS infrastructure setup with VPC, subnets, security groups, load balancer, and EC2 instances configured as web servers using Terraform Stacks.

## Architecture Overview

This stack creates the following AWS resources:

- **VPC**: Custom VPC with configurable CIDR block
- **Subnets**: Public and private subnets across multiple availability zones
- **Internet Gateway**: For public subnet internet access
- **NAT Gateway**: For private subnet outbound internet access
- **Security Groups**: Configurable security rules for SSH, HTTP, and HTTPS
- **Application Load Balancer**: To distribute traffic across EC2 instances
- **EC2 Instances**: Web servers with user data configuration
- **Target Groups**: For load balancer health checks and routing

## Terraform Stack Structure

This project uses Terraform Stacks with the following structure:

```hcl
021-stacks-sample/
├── stack.tfstack.hcl          # Main stack configuration
├── variables.tfstack.hcl       # Stack variables
├── providers.tfstack.hcl       # Provider configuration
├── deployments.tfdeploy.hcl    # Deployment configurations
├── components/                # Component directory
│   ├── aws-infrastructure.tf  # AWS infrastructure component
│   └── user-data.sh          # EC2 user data script
└── README.md                  # This file
```

## Prerequisites

1. **Terraform**: Version 1.11 or later with Stacks support
2. **HCP Terraform Account**: For deploying stacks
3. **AWS Account**: Active AWS account with appropriate permissions
4. **AWS CLI**: Configured with your credentials
5. **SSH Key Pair**: EC2 key pair for SSH access to instances

## Setup Instructions

### 1. Configure AWS Credentials

Set up your AWS credentials using one of the following methods:

```bash
# Method 1: AWS CLI
aws configure

# Method 2: Environment Variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### 2. Configure Deployment Settings

Edit `deployments.tfdeploy.hcl` with your specific values:

- `key_pair_name`: Your EC2 key pair name
- `allowed_ssh_cidr`: Restrict to your IP for production
- Update AMI IDs for your specific regions

### 3. Create the Stack

First, create the stack in HCP Terraform:

```bash
# Create a new stack
terraform stacks create -organization-name <ORGANIZATION_NAME> -project-name <PROJECT_NAME> -stack-name <STACK_NAME>
```

Replace the placeholders with your actual organization name, project name, and desired stack name.

### 4. Upload Stack Configuration

Upload your stack configuration files to HCP Terraform:

```bash
# Upload configuration files
terraform stacks configuration upload -organization-name <ORGANIZATION_NAME> -project-name <PROJECT_NAME> -stack-name <STACK_NAME>
```

### 5. Monitor Deployment

Watch the configuration roll out across your deployments:

```bash
# Monitor stack deployment status
terraform stacks configuration watch -organization-name <ORGANIZATION_NAME> -project-name <PROJECT_NAME>
```

### 6. List Stacks

You can list all stacks in your project:

```bash
# List stacks in project
terraform stacks list -organization-name <ORGANIZATION_NAME> -project-name <PROJECT_NAME>
```

## Configuration Options

### Stack Variables

The stack supports the following variables defined in `variables.tfstack.hcl`:

- `aws_region`: AWS region for deployment
- `vpc_cidr`: CIDR block for VPC
- `public_subnet_cidrs`: CIDR blocks for public subnets
- `private_subnet_cidrs`: CIDR blocks for private subnets
- `availability_zones`: Availability zones for subnets
- `instance_type`: EC2 instance type
- `ami_id`: AMI ID for EC2 instances
- `key_pair_name`: EC2 Key Pair name for SSH access
- `instance_count`: Number of EC2 instances to create
- `allowed_ssh_cidr`: CIDR block allowed for SSH access
- `allowed_http_cidr`: CIDR block allowed for HTTP/HTTPS access
- `environment`: Environment tag for resources
- `project_name`: Project name for resource tagging

### Deployment Configurations

The `deployments.tfdeploy.hcl` file defines two environments:

1. **Development**: 
   - 2 t3.micro instances
   - 2 availability zones
   - Open SSH access (for development)

2. **Production**:
   - 3 t3.small instances  
   - 3 availability zones
   - Restricted SSH access (update `YOUR_IP_HERE`)

### Component Configuration

The AWS infrastructure is defined as a component in `components/aws-infrastructure.tf`. This makes it reusable across different deployments and environments.

## Accessing Your Infrastructure

After deployment, you can access:

- **Load Balancer DNS**: Use the output from the stack deployment
- **EC2 Instances**: SSH using the public IPs and your key pair
- **VPC Resources**: View all resources in AWS console

## Stack Outputs

The component provides the following outputs:

- `vpc_id`: ID of created VPC
- `public_subnet_ids`: List of public subnet IDs
- `private_subnet_ids`: List of private subnet IDs
- `security_group_id`: ID of main security group
- `instance_ids`: List of EC2 instance IDs
- `public_ips`: List of EC2 instance public IP addresses
- `load_balancer_dns`: DNS name of application load balancer

## Adding New Environments

To add a new environment, add a new deployment block in `deployments.tfdeploy.hcl`:

```hcl
deployment "staging" {
  inputs = {
    aws_region            = "us-east-1"
    vpc_cidr             = "10.2.0.0/16"
    # ... other configuration
    environment          = "staging"
    project_name        = "aws-stack-staging"
  }
}
```

## Multi-Region Deployment

For multi-region deployments, you can use identity tokens and provider configurations:

```hcl
identity_token "aws_west" { audience = ["aws.workload.identity.west"] }
identity_token "aws_east" { audience = ["aws.workload.identity.east"] }

deployment "us_dev_east" {
  inputs = {
    aws_region = "us-east-1"
    # ... other inputs
  }
}

deployment "us_dev_west" {
  inputs = {
    aws_region = "us-west-1" 
    # ... other inputs
  }
}
```

## Cost Optimization

- Use `t3.micro` instances for development
- Set appropriate instance counts
- Consider using spot instances for non-critical workloads
- Monitor costs using AWS Cost Explorer

## Troubleshooting

### Common Issues

1. **Key Pair Not Found**: Ensure key pair exists in target region
2. **AMI Not Available**: Use region-specific AMI IDs
3. **Insufficient Permissions**: Verify AWS IAM permissions
4. **Stack Validation**: Check stack syntax with `terraform stack validate`

### Debug Commands

```bash
# List all stacks
terraform stacks list -organization-name <ORGANIZATION_NAME> -project-name <PROJECT_NAME>

# Monitor stack configuration
terraform stacks configuration watch -organization-name <ORGANIZATION_NAME> -project-name <PROJECT_NAME>

# Upload new configuration
terraform stacks configuration upload -organization-name <ORGANIZATION_NAME> -project-name <PROJECT_NAME> -stack-name <STACK_NAME>

# Delete stack
terraform stacks delete -organization-name <ORGANIZATION_NAME> -project-name <PROJECT_NAME> -stack-name <STACK_NAME>
```

## Cleanup

To remove the stack and all created resources:

```bash
terraform stacks delete -organization-name <ORGANIZATION_NAME> -project-name <PROJECT_NAME> -stack-name <STACK_NAME>
```

This will delete the stack and all AWS resources created by the stack deployments.

## Stack vs Traditional Terraform

**Benefits of Stacks:**
- **Dependency Management**: Automatic handling of inter-component dependencies
- **Environment Isolation**: Easy management of multiple environments
- **Deferred Changes**: Automatic deferral of changes that can't be applied immediately
- **Unified Configuration**: Single place to manage all deployments

**When to Use Stacks:**
- Complex infrastructure with multiple components
- Multiple environments (dev, staging, prod)
- Cross-region or cross-account deployments
- Infrastructure with interdependencies

## Support

For issues related to:
- **AWS Services**: Check AWS documentation
- **Terraform Stacks**: Refer to [Terraform Stacks documentation](https://developer.hashicorp.com/terraform/language/stacks)
- **Stack Configuration**: Review configuration files in this repository
