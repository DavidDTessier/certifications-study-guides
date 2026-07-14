# Hashicorp Terraform Associate Cloud Engineer (003) Certification

## 5. Terraform Modules

### 5a. Explain how Terraform sources modules

#### Finding Modules

_Terraform Modules_ can be publicly found in the [Terraform Registry](https://registry.terraform.io/).

You can filter based on popular providers or search partial terms eg. Azure compute. The search query will look at module name, provider, and description to match your search terms.

By default, only verified modules, which are reviewed by Hashicorp to ensure stability and compatibility and actively maintained by contributors to stay up-to-date and compatible with both Terraform and their respective providers, will be displayed in search terms.

On the results page, filters can be used further refine search results to include unverified modules.

#### Using Modules

The _Terraform Registry_ is integrated directly into _Terraform_, which means a Terraform configuration will refer to any module published on the registry. Using the syntax `{NAMESPACE}/{MODULE_NAME}/{PROVIDER}`, i.e. `hashicorp/consul/aws`.

Full example:

```hcl
module "consul" {
  source = "hashicorp/consul/aws"
  version = "0.1.0"
}
```

Running `terraform init` will download and cache any modules referenced by the configuration.

#### Private Registry Module Source

If you are using a private registry, like the one in _HCP Terraform Cloud_, in a private source code repository, or local within the same source structure as the main configuration. Use the following syntax when specifying the module:

* For _HPC Terraform Cloud_ :
  * `{HOSTNAME}/{NAMESPACE}/{NAME}/{PROVIDER}`
  * ex: `app.terraform.io/example_corp/vpc/aws`
* For source repos:
  * `{git::ssh://|https://}{HOSTNAME}/{REPO_NAME}//{MODULE}?ref={BRANCH|GIT_TAG}`
  * ex: `git:ssh://private_server:my_port/terraform_modules_repo.git//ecs_cluster?ref=staging`
  * See [Module Sources](https://www.terraform.io/language/modules/sources) for other options.
* For Local modules:
  * `./` or `../` to indicate that a local path is intended.
    * `./consul`

#### Publishing Modules

Anyone can publish modules to the [Terraform registry](https://registry.terraform.io/), all modules a public and are managed via Git or GitHub.

The following are requirements that must be met in order to publish to the registry:

* The module source must be on GitHub and be in a public repo. If you're using a private registry (Terraform Cloud Registry or internal private git repos), you may ignore this requirement.

* Named `terraform-<PROVIDER>-<NAME>`. Module repositories must use this three-part name format, where `<NAME>` reflects the type of infrastructure the module manages and `<PROVIDER>` is the main provider where it creates that infrastructure. The `<NAME>` segment can contain additional hyphens. Examples: terraform-google-vault or terraform-aws-ec2-instance.

* The GitHub repository description is used to populate the short description of the module. This should be a simple one sentence description of the module.

* The module must adhere to the standard module structure. This allows the registry to inspect your module and generate documentation, track resource usage, parse submodules and examples, and more.

* `x.y.z` tags for releases. The registry uses tags to identify module versions. Release tag names must be a [semantic version](https://semver.org/), which can optionally be prefixed with a v. For example, v1.0.4 and 0.9.2. To publish a module initially, at least one release tag must be present. Tags that don't look like version numbers are ignored.

Once these requirements are met use the _upload_ link in the registry, first you must be signed in and connected to your github account before publishing.

#### Standard Module Structure

**Root Module**:

* **This is the only required element** for the standard module structure
* Terraform files must exist in the root directory of the repository and be the primary entrypoint for the module and is expect to be opinionated
* Example: https://github.com/hashicorp/terraform-aws-consul

**README**:

* the root or any nested module should have README files.
* should be named `README` or `README.md`
* should be a description of the module and how it should be used, may include an example
* doesn't need to document input or outputs of the module because tooling will automatically generate this

**LICENSE**:

* the license under which this module is available

**Recommended Filenames**:

* `main.tf`, `variables.tf`, and `outputs.tf` are the recommended filenames for a minimal module, even if empty.
* _maint.tf_ should be the primary entrypoint
* **Variables and outputs should have descriptions**
* **Nested/Child Modules**
  * should existing under the `modules/` subdirectory
  * should also have a `README`
  * if the root module includes calls to nested modules, they should use relative paths like `.modules/consul-cluster` so Terraform will consider them to be part of the same repository or package, rather than downloading them again separately
* **Examples**
  * examples of the use of the module should exist under the `examples/` subdirectory
* **Published Modules**
  * Shared Terraform Modules in registries

Minimal tree:

```txt
$ tree minimal-module/
.
├── README.md
├── LICENSE
├── main.tf
├── variables.tf
├── outputs.tf

```

A complete tree:

```txt
$ tree complete-module/
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── ...
├── modules/
│   ├── nestedA/
│   │   ├── README.md
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   ├── nestedB/
│   ├── .../
├── examples/
│   ├── exampleA/
│   │   ├── main.tf
│   ├── exampleB/
│   ├── .../

```

Sample usage of modules in Terraform Configuration:

```hcl
module "ec2_instances" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    version = "3.5.0"
    count   = 2

    name    = "my-ec2-cluster"

    ami                     = "ami-0c5204531f799e0c6"
    instancy_type           = "t2.micro"
    vpc_security_group_ids  = [module.vpc.default_security_group_id]
    subnet_id               = module.vpc.public_subnets[0]

    tags = {
        Terraform   = "true"
        Environment = "dev"
    } 
}
```

**Links**:

* Finding and Using Modules → https://developer.hashicorp.com/terraform/tutorials/modules/module-use
* Modules → https://developer.hashicorp.com/terraform/tutorials/modules/module
* Modules Source → https://developer.hashicorp.com/terraform/language/modules/configuration

### 5b. Describe variable scope within modules

Each module can only access its own inputs, and module callers can only access that module's outputs. Similarly, the outside world is only allowed to interact with root level inputs and outputs.

#### Local variables

A local value (locals) assigns a name to an expression, so you can use it multiple times within a module without repeating it.
Locals are set using the locals block ← Static value

```hcl
locals {
  service_name = "forum"
  owner        = "Community Team"
}
```

You can define multiple locals blocks ← computed values

```hcl
locals {
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}
```

You can reference locals within locals

```hcl
locals {
  service_name = "forum"
  owner
  # Common tags to be assigned to all resources
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
  }
```

Once a local value is declared, you can reference it in expressions as `local.{NAME}`.
When you are referencing you use the singular _“local”_
Locals help can help DRY up your code.
It is best practice to use locals sparingly since Terraform is intended to be declarative and overuse of locals can make it difficult to determine what the code is doing.

Locals are scoped to the module they are declared in and are not exposed outside of the module.

#### Input Variables

_Input_ variables are defined via variable block which has the following arguments:

* `type`: the value type expected
* `default`: the default value for the variable
* `description`: the variables documentation
* `validation`: block defining validation rules, type constraints for the variable
* `sensitive`: indicates the variable contains sensitive data and will not be displayed in any outputs.
  * `true` or `false`
  * default is `false`
* `ephermal`: indicates the variable contains sensitive data and will not be persisted and is only used in the current operation
  * `true` or `false`
  * default is `false`
* `nullable`: Specify if the variable can be _null_ within the module
  * `true` or `false`
  * default is `true`

The supported types are:

* **Primitive Types**:
  * `string`
  * `number`
  * `bool`
* **Collection Types**:
  * `list(<TYPE>)` : ex `["us-west-1a", "us-west-1c"]`
  * `set(<TYPE>)` : Similar to List/Tuple but unordered
  * `map(<TYPE>)` : ex `{name = "Mabel", age = 52}`
* **Structural Types**:
  * `object({<ATTR NAME> = <TYPE>, ...})`
  * `tuple([<TYPE>,...])`

`null` can be used for argument value which tells Terraform to use the type's default value or raise an error if its mandatory.

`any` is a special construct that serves as a placeholder for a type yet to be decided. _Terraform_ will attempt to find a single actual type that could replace the _any_ keyword to produce a valid result. **Do not use any just to avoid specifying a type constraint**. Always write an exact type constraint unless you are truly handling dynamic data.

`optional(string)` this experimental feature, as of _Terraform v0.14_ marks an attribute as optional within an object type. In order to use this feature you need to enable it in the _terraform settings_ `experiments = [module_variable_optional_attrs]`

Example:

```hcl
variable "with_optional_attribute" {
  type = object({
    a = string           # a required attribute
    b = optional(string) # an optional attribute
  })
}

```

See [here](hhttps://developer.hashicorp.com/terraform/language/expressions/types) for more details on type constraints.

A variable definitions file allows you to set the values for multiple variables at once.
Variable definition files are named `.tfvars` or `.tfvars.json`
By default `terraform.tfvars` will be auto-loaded when included in the root of your project directory
Variable Definition Files use the Terraform Language.

A variable value can be defined by Environment Variables, those starting with `TF_VAR_` will be read and loaded.

**Links**:

* Accessing Module Values → https://developer.hashicorp.com/terraform/language/block/module#accessing-module-output-values
* Module Usage → https://developer.hashicorp.com/terraform/tutorials/modules/module-use

### 5c. Use Modules in Configuration

A _module_ is a group of configuration files that provide common configuration functionality.​

* Enforces best practices​
* Reduce the amount of code​
* Reduce time to develop scripts​

Every Terraform configuration has at-least one module, know as the _root_ module, consisting of resources defined in `.tf` files in the main working directory.

Modules can call other modules, like the following:

```hcl
module "servers" {
  source = "./app-cluster"
  servers = 5
}
```

The _module block_ has the following definitions:

* the label immediately after the `module` keyword is the local name of the module
* Within the body between `{` and `}` are the arguments for the module:
  * `source`: mandatory and points to the location of the module source code.
  * `version`: recommended when using modules from the _Terraform Registry_, specifies the version of the module to use.
  * other _input variables_, like `server` as noted above.
  * can use meta-arguments like :
    * `for_each`
    * `count`
    * `depends_on`
    * `providers`
      * use this argument to pass provider configurations to a child module.

To expose values from the module, these must be specified as output values, and can be references by other resources in the root module using the following syntax: `module.{module_name}.{output_value}`

```hcl
resource "aws_elb" "example" {
  # ...

  instances = module.servers.instance_ids
}
```

#### Replacing Resources within a module

Use the `-replace=...` planning option to force Terraform to replace the object.

`terraform plan -replace=module.example.aws_instance.example`

Because replacing is a very disruptive action, Terraform only allows selecting individual resource instances. There is no syntax to force replacing all resource instances belonging to a particular module.

### 5d. Set module version

#### Module Version

The `version` argument accepts a version constraint string, see below, this tells Terraform to only install the specified version of the module during initialization. If no version is specified the newest version will be downloaded.

Example:

```hcl
module "consul" {
  source  = "hashicorp/consul/aws"
  version = "0.0.5"

  servers = 3
}
```

#### Version Constraint

`version = ">= 1.2.0, < 2.0.0"`
_Version constraint_ is a string literal that contains the conditions separated by commas.

Each constraint uses an _operator_ and a _version number (`1.2.0`)_.

Valid operators:

* `=`: allow exactly one version number
* `!=`: excludes the version number
* `>`: _less-than_ will request older versions than that of the version specified
* `>=`: _less-than-or-equal-to_  will request older version up to and include the version specified.
* `<`: _greater-than_ will request newer versions than that of the version specified.
* `<=`: _greater-than-or-equal-to_ will request new versions up to and include the version specified.
* `~>`:
  * allows only the _rightmost_ version component to increment
    * example: `~> 1.0.4` will allow installation of `1.0.5` to `1.0.10` but not `1.1.0`. This is referred to as the _pessimistic constraint operator_.

#### Best Practices

Reusable modules should constrain Terraform Core and Providers versions to use `>={version}`(`>= 0.12.0`).

Root Modules should use a `~>` constraint to set a lower and upper bound.

Module version constraint is only supported by modules installed my registries like Terraform Registry or Terraform Cloud Private Registry.

* Module versions → https://developer.hashicorp.com/terraform/language/block/module#version
* Modules → https://developer.hashicorp.com/terraform/tutorials/modules/module-use

[Back to Exam Guide](README.md)