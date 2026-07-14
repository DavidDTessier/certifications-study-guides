# Terraform Cheat Sheet

## Table of Contents

- [Installation](#installation)
- [Basic Workflow](#basic-workflow)
- [Configuration Syntax](#configuration-syntax)
- [State Management](#state-management)
- [Backends](#backends)
- [Functions](#functions)
- [Meta-Arguments](#meta-arguments)
- [Provisioners](#provisioners)
- [Modules](#modules)
- [Testing & Validation](#testing--validation)
- [HCP Terraform](#hcp-terraform)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)

## Installation

### Download Terraform

```bash
# macOS
brew install terraform

# Linux
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Windows (Chocolatey)
choco install terraform
```

### Verify Installation

```bash
terraform version
```

## Basic Workflow

### Initialize Directory

```bash
terraform init
```

- Downloads providers and modules
- Initializes backend

### Plan Changes

```bash
terraform plan
```

- Shows what will be created, updated, or destroyed
- Use `-out=planfile` to save plan

### Apply Changes

```bash
terraform apply
```

- Applies the planned changes
- Use `terraform apply planfile` for saved plans
- Use `-auto-approve` for non-interactive

### Destroy Resources

```bash
terraform destroy
```
- Removes all managed resources

### Format Code

```bash
terraform fmt
```

### Validate Configuration

```bash
terraform validate
```

## Configuration Syntax

### Provider Block

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

### Resource Block

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1d0"
  instance_type = "t2.micro"
  tags = {
    Name = "Example"
  }
}
```

### Data Source

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
```

### Variable Declaration

```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
```

### Variable Usage

```hcl
resource "aws_instance" "example" {
  instance_type = var.instance_type
}
```

### Variable Order of Precedence

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

1. Environment variables (`TF_VAR_variable_name`)
2. The `terraform.tfvars` file, if present.
3. The `terraform.tfvars.json` file, if present.
4. Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.
5. Any `-var` and `-var-file` options on the command line, in the order they are provided.

### Output

```hcl
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.example.id
}
```

### Locals

```hcl
locals {
  common_tags = {
    Environment = "dev"
    Project     = "example"
  }
}

resource "aws_instance" "example" {
  tags = local.common_tags
}
```

### Import Block

```hcl
import {
  to = aws_instance.example
  id = "i-1234567890abcdef0"
}
```
- Use with `terraform plan -generate-config-out=generated.tf` to automatically generate configuration.

### Ephemeral Values

```hcl
ephemeral "example" "secrets" {
  # Write-only arguments that are never saved to the state file
}
```

## State Management

### Show State

```bash
terraform state show aws_instance.example
```

### List Resources

```bash
terraform state list
```

### Move Resource

```bash
terraform state mv aws_instance.old aws_instance.new
```

### Remove Resource

```bash
terraform state rm aws_instance.example
```

### Import Resource (CLI)

```bash
terraform import aws_instance.example i-1234567890abcdef0
```
- *Note: Config-driven import (`import` block) is recommended over CLI import for newer Terraform versions.*

### Refresh State

```bash
terraform apply -refresh-only
```
- *Note: `terraform refresh` is deprecated in modern Terraform versions.*

## Backends

### S3 Backend

```hcl
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```

### Remote Backend (HCP Terraform)
```hcl
terraform {
  cloud {
    organization = "example-org"
    workspaces {
      name = "my-workspace"
    }
  }
}
```

### Migrate Backend

```bash
terraform init -migrate-state
```

## Functions

### String Functions

- `upper(string)` - Convert to uppercase
- `lower(string)` - Convert to lowercase
- `substr(string, offset, length)` - Extract substring
- `join(separator, list)` - Join list elements

### Numeric Functions

- `max(numbers...)` - Maximum value
- `min(numbers...)` - Minimum value
- `ceil(number)` - Ceiling of number
- `floor(number)` - Floor of number

### Collection Functions

- `length(collection)` - Length of collection
- `lookup(map, key, default)` - Lookup value in map
- `keys(map)` - Keys of map
- `values(map)` - Values of map

### Type Conversion

- `tostring(value)` - Convert to string
- `tonumber(value)` - Convert to number
- `tolist(value)` - Convert to list
- `tomap(value)` - Convert to map

## Meta-Arguments

### Count

```hcl
resource "aws_instance" "example" {
  count         = 3
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  tags = {
    Name = "Example-${count.index}"
  }
}
```

### For Each

```hcl
resource "aws_instance" "example" {
  for_each = {
    web = "t2.micro"
    db  = "t3.small"
  }

  ami           = "ami-12345678"
  instance_type = each.value

  tags = {
    Name = each.key
  }
}
```

### Depends On

```hcl
resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  depends_on = [aws_security_group.web]
}
```

### Lifecycle

```hcl
resource "aws_instance" "example" {
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags["LastModified"]
    ]
    prevent_destroy = true
    
    precondition {
      condition     = data.aws_ami.example.architecture == "x86_64"
      error_message = "AMI must be x86_64."
    }
    
    postcondition {
      condition     = self.public_dns != ""
      error_message = "Instance must have a public DNS."
    }
  }
}
```

## Provisioners

### File Provisioner

```hcl
resource "aws_instance" "example" {
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh"
    ]
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host     = self.public_ip
  }
}
```

### Local Exec

```hcl
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Hello World'"
  }
}
```

## Modules

### Using a Module

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
}
```

### Module Structure

```
module/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## Testing & Validation

### Custom Validation Rules

```hcl
variable "image_id" {
  type        = string
  validation {
    condition     = length(var.image_id) > 4
    error_message = "The image_id value must be valid."
  }
}
```

### Check Blocks

```hcl
check "health_check" {
  data "http" "example" {
    url = "https://example.com"
  }

  assert {
    condition     = data.http.example.status_code == 200
    error_message = "Website is returning a non-200 status code."
  }
}
```

### Terraform Test

```bash
terraform test
```
- Executes test files (`*.tftest.hcl`) to validate module logic and configuration.

```hcl
# tests/setup.tftest.hcl
run "valid_name" {
  command = plan
  
  variables {
    prefix = "test"
  }

  assert {
    condition     = module.example.name == "test-example"
    error_message = "Name did not match expected output"
  }
}
```

## HCP Terraform

Formerly "Terraform Cloud", HCP Terraform is an application that helps teams use Terraform together.

### Workspaces

- **Local Workspaces**: Create isolated states in a single working directory using the `terraform workspace` command.
- **HCP Workspaces**: Act as completely separate environments. Each workspace securely limits access to its own variables, state file, run history, and settings.

### Variable Sets

A way to group variables and apply them globally across an organization, or to specific workspaces/projects. Great for sharing a single set of cloud credentials with multiple configurations.

### Run Triggers

Allows a workspace to automatically trigger a `terraform plan` in another workspace when it completes a successful `terraform apply`. Useful for stringing together dependent infrastructure tasks.

### Drift Detection

Continuous validation feature checking if real-world infrastructure diverges from the state file. If drift is detected, HCP Terraform creates an alert or run to visualize/correct it.

### Sentinel & OPA
Policy-as-Code frameworks embedded into HCP Terraform's standard workflow. Evaluates plan files before they are applied against defined rules (e.g., "Instances cannot be larger than t2.micro").

**Example Sentinel Policy (`restrict-ec2-type.sentinel`)**:
```sentinel
import "tfplan/v2" as tfplan

# Find all AWS EC2 instances
ec2_instances = filter tfplan.resource_changes as _, rc {
  rc.type is "aws_instance" and
  (rc.change.actions contains "create" or rc.change.actions contains "update")
}

# Ensure instance type is t2.micro
main = rule {
  all ec2_instances as _, instance {
    instance.change.after.instance_type == "t2.micro"
  }
}
```

**Example OPA Policy (`restrict-ec2-type.rego`)**:
```rego
package terraform.policies

# Fail if any instance is not t2.micro
deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_instance"
  resource.change.after.instance_type != "t2.micro"
  msg := sprintf("Instance %v has invalid type %v (must be t2.micro)", [resource.address, resource.change.after.instance_type])
}
```
## Troubleshooting

### Common Errors

#### Provider Version Conflicts

```bash
terraform init -upgrade
```

#### State Lock Issues

```bash
terraform force-unlock LOCK_ID
```

#### Debug Logging

Enable detailed logs by setting the `TF_LOG` environment variable.
Available log levels (in order of decreasing verbosity):
- `TRACE` (most detailed, default if `TF_LOG` is set without a specific level)
- `DEBUG`
- `INFO`
- `WARN`
- `ERROR`

```bash
# Set debug logging for a single command
TF_LOG=DEBUG terraform plan

# Save logs to a specific file
export TF_LOG=TRACE
export TF_LOG_PATH=./terraform.log
terraform apply
```

*Note: You can also specify `TF_LOG_CORE` or `TF_LOG_PROVIDER` to isolate logs to the Terraform engine or provider plugins separately.*

### Commands

- `terraform console` - Interactive console
- `terraform graph` - Dependency graph
- `terraform workspace list` - List workspaces
- `terraform workspace select <name>` - Switch workspace

## Best Practices

1. **Version Control**: Keep Terraform code in Git
2. **Modules**: Use modules for reusable components
3. **Variables**: Use variables for configuration
4. **State**: Never edit state manually
5. **Plan Before Apply**: Always review `terraform plan`
6. **Workspaces**: Use workspaces for different environments
7. **Lock Provider Versions**: Pin provider versions
8. **Naming Conventions**: Use consistent resource naming
9. **Documentation**: Document your infrastructure
10. **Testing**: Test changes in non-production first

## Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [HashiCorp Learn](https://learn.hashicorp.com/terraform)
