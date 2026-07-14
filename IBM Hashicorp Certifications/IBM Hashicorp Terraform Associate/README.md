# IBM Terraform Associate Certification -  Prep Guide

**Align center:**
<p align="center" width="100%">
    <img width="50%" src="https://www.datocms-assets.com/2885/1645553469-hcta0-badge.png"> 
</p>

_"The Terraform Associate certification is for cloud engineers specializing in operations, IT, or development who know the basic concepts and skills of HashiCorp Terraform. While experience using Terraform in production is helpful, performing the exam objectives in a demo environment can be sufficient to pass the exam. The exam expects familiarity with the enterprise features available in Terraform Cloud, and what Terraform Community Edition does and does not support."_
--- (Excerpt from The Official Hashicorp Terraform Associate Exam Reference Guide)

Exam Guide - Updated for Terraform Associate 004

1. [Understanding Infrastructure as Code (IaC) Concepts](Domain-1.md)
    * 1a. Explain what IaC is
    * 1b. Describe the advantages of IaC patterns
    * 1c. Explain how Terraform manages multi-cloud, hybrid cloud, and service-agnostic workflows
2. [Terraform Fundamentals](Domain-2.md)
    * 2a. Install and version Terraform providers
    * 2b. Describe how Terraform uses providers
    * 2c. Write Terraform configurations using multiple providers
    * 2d. Explain how Terraform uses and manages state
3. [Core Terraform Workflow](Domain-3.md)
    * 3a. Describe the Terraform Workflow (Write > Plan > Create)
    * 3b. Initialize a Terraform Working directory (`terraform init`)
    * 3c. Validate a Terraform configuration (`terraform validate`)
    * 3d. Generate and review an execution plan for Terraform (`terraform plan`)
    * 3e. Apply changes to infrastructure with Terraform (`terraform apply`)
    * 3f. Destroy Terraform-managed infrastructure (`terraform destroy`)
    * 3g. Apply formatting and style adjustments to a configuration (`terraform fmt`)
4. [Terraform configuration](Domain-3.md)
    * 4a. Use and differentiate `resource` and `data` blocks
    * 4b. Refer to resource attributes and create cross-resource references
    * 4c. Use variables and outputs
    * 4d. Understand and use complex types
    * 4e. Write dynamic configuration using expressions and functions
    * 4f. Validate configurations using custom conditions
    * 4h. Understand best practices for managing sensitive data, including secrets management with Vault
5. [Interact with Terraform Modules](Domain-5.md)
    * 5a. Contrast and use different module source options
    * 5b. Interact with module inputs and outputs
    * 5c. Describe variable scope within modules/child modules
    * 5d. Set module version
6. [Implement and maintain state](Domain-7.md)
    * 6a. Describe default `local` backend
    * 6b. Describe state locking
    * 6c. Configure remote state using the `backend` block
    * 6d. Manage resource drift and Terraform state
7. [Maintain infrastructure with Terraform](Domain-7.md)
    * 7a. Import existing infrastructure into your Terraform Workspace
    * 7b. Use the CLI to inspect state (`state` command)
    * 7c. Describe when and how to use verbose logging
8. [HCP Terraform](Domain-9.md)
    * 9a. Explain how Terraform Cloud helps to manage infrastructure
    * 9b. Describe how Terraform Cloud enables collaboration and governance

[Terraform Cheat Sheet](TF-Cheat-Sheet.md)

[Back To Main](../README.md)
