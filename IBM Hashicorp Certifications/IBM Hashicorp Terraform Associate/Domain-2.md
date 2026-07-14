# Hashicorp Terraform Associate Cloud Engineer (003) Certification

## 2. Terraform Fundamentals

### 2a. Install and version Terraform Providers

#### Install Terraform

* **Homebrew on OSX**
  * Versions less the 1.7
    * `brew install terraform`
  * 1.7+
    * ```brew tap hashicorp.tap && brew install hashicorp/tap/terraform```
  * Unzip and add binary to PATH
  * Verify if command works:
    * `terraform -help`
* **Chocolatey on Windows**
  * `choco install terraform`

For Linux based installations follow the [installation guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) to install terraform cli

NOTE: Use `terraform -install-automcomplete` to set up autocompletion for _terraform_ commands, this is supported for Bash and Zsh

#### Hashicorp Configuration Language (HCL)

Terraform's high-level [configuration language](https://www.terraform.io/language) is a human-readable, **declarative** configuration files. 

Terraform files end in the extension of **.tf** or **.tf.json**

This allows you to create a blueprint that you can version, share and reuse, sample below:

```hcl
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}

<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```

Consists of the following:

* _Blocks_:
  * Are containers for other content and usually represent the configuration of some kind of object, like a resource.
  * Have a block type, can have zero or more labels, and have a body that contains any number of arguments and nested blocks. Most of Terraform's features are controlled by top-level blocks in a configuration file.
* _Arguments_:
  * Assign a value to a name. They appear within blocks.
* _Expressions_:
  * Represent a value, either literally or by referencing and combining other values. They appear as values for arguments, or within other expressions.

_The Terraform language is declarative, describing an intended goal rather than the steps to reach that goal. The ordering of blocks and the files they are organized into are generally not significant; Terraform only considers implicit and explicit relationships between resources when determining an order of operations._

End of Day 0 would commonly apply initial configurations like so:

```hcl
provisioner "remote-exec" {
  inline = [
    "sudo apt-get -y update",
    "sudo apt-get -y install nginx",
    "sudo service nginx start"
    ]
}
```

If it is necessary to apply Day 1 through Day N configurations, the code might leverage a tool like Chef, Ansible, Docker, etc.

```hcl
provider "chef" {
  server_url = "https://api.chef.io/organization/example"
  run_list = [ "recipe[example]" ]
}
```

Alternate JSON syntax using **.tf.json** extension. Useful when generating portions of a configuration programmatically, since existing JSON libraries can be used to prepare the generated configuration files.

```hcl
{
  "resource": {
    "aws_instance": {
      "example" : {
        "instance_type: "t2.micro",
        "ami": "ami-abc12345"
      }
    }
  }
}
```

HCL also supports:

* Loops (For Each)
* Dynamic Blocks
* Locals
* Complex Data Structure
  * Maps, Collections

HCL is used for:

* Terraform files (`.tf`)
* Packer Templates (`.pkr.hcl`)
* Vault Policies (no extension)
* Boundary Controllers and Workers (`.hcl`)
* Consul Configuration (`.hcl`)
* Waypoint Application Configuration (`.hcl`)
* Nomad Job Specifications (`.nomad`)
* Shipyard Blueprint (`.hcl`)

Sentinel Polices use own custom ACL language

#### Terraform Settings

The terraform block as shown below is used to configure behaviors that _Terraform_ will perform itself during command execution, like requiring a minimum version of _Terraform_ to apply to the configuration. This is done using the `required_version` argument:

```hcl
terraform {
  required_version = "> 0.7.0"
  #....
}
```

Only constant values can be used in the block. References to named resources, input variables, and/or built-in functions are not supported.

Use the `required_providers` block, within the `terraform` block, to specify all the providers that are required for the configuration:

```hcl
terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
}

```

Sometimes there are new language features the _Terraform_ team will introduce, you can opt-in by using the `experiments` argument inside the `terraform` block:

```
terraform {
  experiments = [example]
}
```

Use the `provider_meta` block to pass module specific data which individual modules can then populate independently of any provider configuration.

```
terraform {
  provider_meta "my-provider" {
    hello = "world"
  }
}
```

#### Providers

Providers are plugins that _Terraform_ uses to interact with cloud providers, SaaS providers, and other APIs (such as Kubernetes or Postgres). All _Terraform_ configurations must declare the providers that are required in order for _Terraform_ to install them.

The [Terraform Registry](https://registry.terraform.io/browse/providers) is the main directory of publicly available Terraform providers, and hosts providers for most major infrastructure platforms.

Providers come in three tiers:

* Official
  * providers are owned and actively maintained by Hashicorp
  * examples (aws, azure, google, IBM)
* Partner Premier
  * providers that are actively maintained by third-party technology partner companies that write and maintain partner premier providers. To earn a partner premier badge, the partner must qualify for the partner premier program ([refer to the program requirements](https://developer.hashicorp.com/terraform/docs/partnerships#requirements-for-the-partner-premier-tag)).
* Partner
  * are owned and actively maintained by technology vendors that are members of the [Hashicorp Technology Partner Program](https://www.hashicorp.com/ecosystem/become-a-partner/)
  * examples (Alibaba Cloud, Oracle Cloud, auth0)
* Community
  * publish by a community member but no guarantee of maintenance, up-to-date or compatibility
* Archived
  * Official or Partner Providers that are no longer maintained by HashiCorp or the community. This may occur if an API is deprecated or interest was low.

Providers are distributed separately from Terraform and the plugins must be downloaded before using `terraform init` command will download the necessary provider plugins listed in a terraform configuration file.

The provider configuration belongs in the root module of a _Terraform_ configuration. The following `provider configuration` has a `local name` (_aws_) which should be declared in the `required_providers` block, see [Terraform Settings](#terraform-settings) The body (between `{`and `}`) contains any arguments that the provider requires to initialize. In this example we set the `region`. Each provider has its own set up required arguments. Refer to the documentation for the provider you wish to use which can be found on the [Terraform Registry](https://registry.terraform.io/browse/providers)

```hcl
provider "aws" {
  region  = "us-east-2"
}
```

Use the `terraform providers` command to view the version constraints for all providers used in the current terraform configuration:

```hcl
%: terraform providers

Providers required by configuration:
.
├── provider[registry.terraform.io/hashicorp/azurerm] 2.92.0
├── module.network
│   └── provider[registry.terraform.io/hashicorp/azurerm]
└── module.linuxservers
    ├── provider[registry.terraform.io/hashicorp/azurerm]
    ├── provider[registry.terraform.io/hashicorp/random]
    └── module.os

```

The plugins are stored on disk like so:
`$PLUGIN_DIRECTORY/$SOURCEHOSTNAME/$SOURCENAMESPACE/$NAME/$VERSION/$OS_$ARCH/`

For example, if you wanted to use the community-created dominoes provider

```hcl
  providers {
    customplugin = {
      versions = ["0.1"]
      source = "example.com/myorg/customplugin"
    }
  }
```

The binary must be placed in the following directory (provided you use a linux_amd64-based platform):
`./plugins/example.com/myorg/customplugin/0.1/linux_amd64/`

See [Local Mirror Directories](https://developer.hashicorp.com/terraform/cli/v1.12.x/config/config-file#implied-local-mirror-directories) for more details on plugins

[Expressions](https://www.terraform.io/language/expressions) can be used in the `provider configuration` but only on values know before the configuration is applied. Unlike many other objects in the Terraform language, a provider block may be omitted if its contents would otherwise be empty. Terraform assumes an empty default configuration for any provider that is not explicitly configured.

#### Provider Meta-arguments

* `alias`:
  * Use for when you need to use the same provider with different configurations
  * when NO alias is specified, the provider is the _default_ provider.
* `version`:
  * NO LONGER RECOMMENDED, use `required_providers` block instead

##### Required Providers

Each Terraform module/config must declare which providers it requires, so that Terraform can install and use them. Provider requirements are declared in a `required_providers` block.

A provider requirement consists of a local name, a source location, and a version constraint:

```hcl
terraform {
    required_providers {
        mycloud = {
            source = "mycloud/mycloud"
            version = "~> 1.0"
        }
    }
}
```

Required providers MUST be nested inside the top-level terraform block

Example `alias`:

```hcl
# The default provider configuration; resources that begin with `aws_` will use
# it as the default, and it can be referenced as `aws`.
provider "aws" {
  region = "us-east-1"
}

# Additional provider configuration for west coast region; resources can
# reference this as `aws.west`.
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}
```

* `source` - [global source address](https://developer.hashicorp.com/terraform/language/v1.12.x/providers/requirements#source-addresses) for the provider ex: `hashicorp/aws`
  * Typical format is `NAMESPACE/TYPE` but you can use also `HOSTNAME/NAMESPACE/TYPE` if referencing a private registry otherwise it defaults to the public terraform registry (`registry.terraform.io`)
* `version` - [version constraint](https://developer.hashicorp.com/terraform/language/v1.12.x/providers/requirements#version-constraints) specify the version or version subsets that the module/config is compatible with

To declare an alias within a module to receive an alternate provider configuration use the `configuration_aliases` argument to the providers `required_providers` entry:

```hcl
terraform {
  required_providers {
    mycloud = {
      source  = "mycorp/mycloud"
      version = "~> 1.0"
      configuration_aliases = [ mycloud.alternate ]
    }
  }
}
```

By default, child modules inherit the _default_ provider, to specify a different or alternate provider for the module you pass the configuration to child modules:

```hcl
# The default "aws" configuration is used for AWS resources in the root
# module where no explicit provider instance is selected.
provider "aws" {
  region = "us-west-1"
}

# An alternate configuration is also defined for a different
# region, using the alias "usw2".
provider "aws" {
  alias  = "usw2"
  region = "us-west-2"
}

# An example child module is instantiated with the alternate configuration,
# so any AWS resources it defines will use the us-west-2 region.
module "example" {
  source    = "./example"
  providers = {
    aws = aws.usw2
  }
}
```

If using private providers and the registry being used requires authentication use the [`.netrc`](https://everything.curl.dev/usingcurl/netrc.html) file to provide credentials.

#### Provider Versioning

Using either the provider version constraints in the `terraform` settings block or using a [dependency lock file](https://www.terraform.io/language/files/dependency-lock), _terraform.lock.hcl_ .

#### Terraform Settings Block

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 2.0.0"
    }
  }
}
```

Using the above listed version for the `aws` provider, _Terraform_ will download version of the AWS Provider that is at-least greater than 2.0 which is due to the use of the `>=` [version constraint operator](https://www.terraform.io/language/expressions/version-constraints). Using the `~>` operator will allow only patch releases within a specific minor release.

#### The `terraform.lock.hcl`

* Used in _Terraform_ v0.14+
* Generated in the current working directory
* Should be included in your version control repository to ensure _Terraform_ uses the same provider versions across team members and in ephemeral remote execution environments.

Sample `.terraform.lock.hcl` file:

```hcl
# This file is maintained automatically by "terraform init".
# Manual edits may be lost in future updates.

provider "registry.terraform.io/hashicorp/aws" {
  version     = "2.50.0"
  constraints = ">= 2.0.0"
  hashes = [
    "h1:aKw4NLrMEAflsl1OXCCz6Ewo4ay9dpgSpkNHujRXXO8=",
    ## ...
    "zh:fdeaf059f86d0ab59cf68ece2e8cec522b506c47e2cfca7ba6125b1cd06b8680",
  ]
}
....

```

The following table shows which provider _Terraform_ will download on initialization (`terraform init`):

| Provider | Version Constraint | `terraform init` (no lock file) | `terraform init` (lock file) |
| -------- | ------------------ | ------------------------------- | ---------------------------- |
| aws | >= 2.0.0 | Latest version (e.g. 3.24.1) | Lock file version (2.50.0) |

To update the versions of providers (and modules) use the `terraform init -upgrade` command

* Providers → https://www.terraform.io/docs/language/providers/configuration.html
* Terraform Settings → https://www.terraform.io/docs/language/settings/index.html
* Installing Terraform → https://learn.hashicorp.com/tutorials/terraform/install-cli
* Lock and Upgrade Provider Versions → https://learn.hashicorp.com/tutorials/terraform/provider-versioning

### 2b. Describe how Terraform uses providers

_Terraform_ is split into two main parts:

* **_Terraform Core_**:
  * written in Golang
  * main binary that communicates with plugins via remote procedure calls (RPC) to manage infrastructure Resources
  * common interface that allows the use of many cloud providers and solutions
  * primary responsibilities are:
    * iac, reading and interpolating configuration files and modules
    * Resource state management
    * construction of the [Resource Graph](https://developer.hashicorp.com/terraform/internals/graph)
      * a dependency graph and uses it to perform operations, such as generate plans and refresh state
      * Graph Nodes:
        * **Resource Node**
          * represents a single resource `google_compute`
          * if you have a `count` there will be one resource per each count
        * **Provider Configuration Node**
          * Represents the time to fully configure a provider. This is when the provider configuration block is given to a provider, such as AWS security credentials.
        * **Resource Meta-Node**
          * Represents groups of resources
          * Only present for resources with a `count` parameter greater than 1  
      * use the `terraform graph` command to visualize the resource graph
    * Plan execution
    * Communication with plugins over RPC
* **_Terraform Plugins_**:
  * executable binaries written in Golang and invoked by Terraform Core over RPC
  * Exposes functionality for a specific service
    * AWS, GCP, Azure, provisioner (bash), etc
  * executed as a separate process and communicates with Terraform Core binary over an RPC interface
  * responsible for domain specific implementation of their type
  * primary responsibilities of Provider Plugins are:
    * initialization of any included libraries used to make API calls
    * authentication with infrastructure provider
    * Defined managed resources and data structures that map to specific services
    * Defined functions that enable or simplify computational logic for practitioner configuration
  * primary responsibilities of Provision Plugins are:
    * execution of commands or scripts on the designated resource after creation, or on destruction

![Plugin Workflow](https://spacelift.io/_next/image?url=https%3A%2F%2Fspaceliftio.wpcomstaging.com%2Fwp-content%2Fuploads%2F2023%2F03%2Fterraform-architecture-diagram.png&w=2048&q=75)

#### Provider Plugin Cache

* By default `terraform init` downloads plugins into a subdirectory of the working directory so that each working directory is self-contained.
  * `${WORKING_DIR}/.terraform/providers/registry/{PROVIDER_NAME}`
* if you have multiple configurations that use the same provider then a separate copy of its plugin will be downloaded for each configuration.
* If you wish to shared provider plugins between configurations for slow or metered internet connections you can use shared local directory as a shared plugin cache using the  `plugin_cache_dir` configuration settings in the `.terraformrc` file (See [CLI Configuration File](https://developer.hashicorp.com/terraform/cli/config/config-file#development-overrides-for-provider-developers))

**Explicit Installation Method Configuration**
A `provider_installation` block in the CLI configuration allows overriding Terraform's default installation behaviors, so you can force Terraform to use a local mirror for some or all of the providers you intend to use:

```hcl
provider_installation {
  filesystem_mirror {
    path    = "/usr/share/terraform/providers"
    include = ["example.com/*/*"]
  }
  direct {
    exclude = ["example.com/*/*"]
  }
}
```

If you set both include and exclude for a particular installation method, the exclusion patterns take priority. For example, including `registry.terraform.io/hashicorp/*` but also excluding `registry.terraform.io/hashicorp/dns` will make that installation method apply to everything in the _hashicorp_ namespace except for `hashicorp/dns`.

As with provider source addresses in the main configuration, you can omit the `registry.terraform.io/` prefix for providers distributed through the public Terraform registry, even when using wildcards. For example, `registry.terraform.io/hashicorp/*` and `hashicorp/*` are equivalent. `*/*` is a shorthand for `registry.terraform.io/*/*`, not for `*/*/*`.

The following are the two supported installation method types:

* **direct**
  * requests information from its origin registry and downloads over the network
* **filsystem_mirror**
  * uses a local disk path for copies of the providers, requires additional argument `path` to indicate which directory to look in.
    * Terraform expects the given directory to contain a nested directory structure where the path segments together provide metadata about the available providers. The following two directory structures are supported:
      * Packed layout:
        * `HOSTNAME/NAMESPACE/TYPE/terraform-provider-TYPE_VERSION_TARGET.zip` is the distribution zip file obtained from the provider's origin registry.
      * Unpacked layout:
        * `HOSTNAME/NAMESPACE/TYPE/VERSION/TARGET` is a directory containing the result of extracting the provider's distribution zip file.
* **network_mirror**
  * consults a particular HTTPS server for copies of providers
  * requires a `url` to indicate the mirror base url

To update/upgrade providers use the `terraform init -upgrade` which re-checks the Terraform Registry for newer acceptable provider versions and downloads them if available.

**NOTE:** This behavior only applies to providers whose only acceptable versions are in the correct subdirectories under `.terraform/providers/` (the automatic downloads directory); if any acceptable version of a given provider is installed elsewhere, `terraform init -upgrade` will not download a newer version of it.

**Implied Local Mirror Directories**
Configure this using the `provider_installation` block

### 2c. Write Terraform configurations using multiple providers

```hcl
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0"
    }
  }

  required_version = ">= 0.14"
}

provider "aws" {
  region = "us-west-2"
}

resource "random_pet" "petname" {
  length    = 5
  separator = "-"
}

resource "aws_s3_bucket" "sample" {
  bucket = random_pet.petname.id
  acl    = "public-read"

  region = "us-west-2"
}
```

Sometimes you will need to reference the same provider for multiple reasons
In the below example we're using multiple regions within AWS, therefore we need a mechanism for distinguishing between the two providers. Enter the `alias` argument. With it you can assign resources to specific environments:

```hcl
# The default provider configuration does not need an alias
provider "aws" {
    profile = "prod"
    region = "us-east-1"
}

# Additional provider configuration; resources can
# reference this as `aws.west`
provider "aws" {
    profile = "dev"
    region = "us-west-2"
    alias = "west"
}

```

**Links**:

* Lock and Upgrade Provider Versions → https://developer.hashicorp.com/terraform/tutorials/configuration-language/provider-versioning

* Alias argument → https://developer.hashicorp.com/terraform/language/block/provider#alias-multiple-provider-configurations

### 2d. Explain how Terraform uses and manages state

#### Benefits of state

* State is a necessary requirement for Terraform to function properly.
* Acts as the "database" that maps Terraform config to the real world
  * When you have a resource `resource aws_instance foo` in the configuration, Terraform uses this map to know that instance `i-abdc1234` is represented by that resource.
* Metadata Tracking
  * Dependencies between resources are also tracked in State which allows terraform to know the ordering of each.
  * Ordering within one provider and across multiple providers → complexity quickly ramps up
* When running `terraform plan`, Terraform must know the current state of resources in order to effectively determine what changes need to be made to reach the desired configuration.
* Terraform stores state in a file in the current working directory where terraform was run.
  * This is not ideal for collaboration as it is important for everyone to be working with the same state so that operations will be applied to the same remote objects.
* Remote State is the recommended approach
  * See [Implement and Maintain State](./Domain-7.md#7-implement-and-maintain-state) for more details.
* How does Terraform state improve the performance of `terraform apply`?
  * By caching the state of your infrastructure so that Terraform doesn't have to query the providers every run
* How is Terraform state beneficial from the perspective of syncing?
  * It enables multiple people to be able to work on one Terraform project
* What flag do you need to pass to Terraform to use the state file as a cache and not query the providers?
  * `terraform plan -refresh=false`
  * When you add the `-refresh=false` flag, Terraform skips its default implicit refresh, which typically syncs the state file with the actual infrastructure. 
  * This forces Terraform to rely solely on the attribute values cached in the local or remote state file when creating the plan or applying changes.

Sample state file:

```hcl
"resources": [
 {
      "mode": "data",
      "type": "aws_ami",
      "name": "ubuntu",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "architecture": "x86_64",
            "arn": "arn:aws:ec2:us-east-1::image/ami-0b287e7832eb862f8",
      ##...
    },
    ##...
]
```

**Links**:  

* Purpose of terraform state → https://developer.hashicorp.com/terraform/language/state/purpose
* Manage Resources In Terraform State → https://developer.hashicorp.com/terraform/tutorials/state/state-cli

[Back to Exam Guide](README.md)