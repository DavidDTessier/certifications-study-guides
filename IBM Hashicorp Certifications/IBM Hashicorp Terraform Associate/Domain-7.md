# Hashicorp Terraform Associate Cloud Engineer (004) Certification

## 7. Maintain infrastructure with Terraform

### 7a. Import existing infrastructure into your Terraform workspace

#### `import` Command

**Command import**

* Used to import existing resources into Terraform. Define a placeholder for your imported resource in the configuration file.
* You can leave the body blank and fill it in after importing. It will not be auto-filled.
* `terraform import {RESOURCE_ADDRESS} {ID}`
* Proceed to importing your import file.
* The command can only import one resource at a time.
* Each resource in Terraform must implement some basic logic to become importable therefore not all resources are importable, you need to check the bottom of resource documentation for support


Usage:

`terraform import [options] RESOURCE_ADDRESS ID`, Terraform will import the existing infrastructure resource at the specified `RESOURCE_ADDRESS ID`.

Options:
* `-h,-help`: gives more details about the command
* `-config={path}`:
  * Path to the directory of Terraform configuration files. Defaults to current directory.
* `-input=true`:
  * Whether to ask for input for providor config
* `-lock=false`:
  * Don't hold a state lock during the operation. **This is dangerous if others might concurrently run commands against the same workspace.**
* `lock-timeout=0s`:
  * Duration to retry state locking
* `-no-color`:
  * output won't be in-color
* `-parallelism=n`:
  * Limit the number of concurrent operation as Terraform walks the graph. Defaults to 10.
* `-provider={provider}`:
  * **DEPRECATED**
  * Override the current provider configurations
* `-var 'foo=bar'`:
  * Set a variable in the Terraform configuration
* `-var-file={path}`:
  * Set variables in the terraform configuration from a variable file.
  * `terraform.tfvars` is loaded first
  * `*.auto.tfvars` is loaded second, alphabetically
  * files specified using `-var-file`, will override any variables auto loaded.
* `-ignore-remote-version`:
    * For configurations using the Terraform Cloud CLI integrations or remote backend only
    * Overrides checking that the local and remote terraform version agree, making an operation proceed even when there is a mismatch
    * recommend **NOT** to be be used unless absolutely necessary
* Legacy State Flags:
    * `-state={FILENAME}`
        * overrides the state filename when reading the prior state snapshot
        * if used without `-state-out`, terraform will use the specified filename for both
    * `-state-out={FILENAME}`
        * overrides the state filename when writing new state snapshots
        * 
    * `-backup={FILENAME}`

**Examples**
Import an AWS instance in the `aws_instance` resource named `foo`:

`terraform import aws_instance.foo i-abcd1234`

Importing in an AWS instance in the `aws_instance` resource named `bar` into a module named `foo`:

`terraform import module.foo.aws_instance.bar i-abc1234`

Import a resource configured with count:

`terraform import 'aws_instance.baz[0]' i-abcd1234`

Import a resource configured with for_each:

`terraform import 'aws_instance["example"]' i-abc1234`

#### `import` Block

```hcl
import {
  to = aws_instance.my_instance
  id = "id-123345"
}

resource "aws_instance" "my_instance" {
  name = "my_instance"
  ....
}
```

Will import the resource specified in the _import_ block into managed state and assign it to the managed resource. You can also use the `terraform plan -generate-config-out=generated.tf` to auto-generate the terraform configuration (NOTE this is Experimental only). You can then use this generated TF config to add to you root module.

* Command: import → https://developer.hashicorp.com/terraform/cli/commands/import
* Import Terraform Configuration → https://developer.hashicorp.com/terraform/tutorials/state/state-import
* Import Block → https://developer.hashicorp.com/terraform/language/block/import

### 7b. Use the CLI to inspect state

Terraform uses _state data_ to map real objects to resources in the configuration, which allows it to modify an existing object when the corresponding declaration changes. Terraform will store this mapping in a file called `terraform.tfstate`, which is a JSON data structure with a one-to-one mapping from resources instances to remote objects.

State is updated automatically during plan and apply, however there are times when you need to modify state directly. Use the `terraform state` command for advanced state management.

* `terraform state list`:
  * displays the resources addresses for every resource Terraform knows about.
  * Option flags:
    * `-state={path}`: path to the state file
    * `-id={id}`: ID of resources to show
* `terraform state show {ADDRESS}`
  * displays detailed state data about one resource.
  * Option flags:
    * `-h,-help`: gives more details about the command
    * `-state={path}`: path to the state file
* `terraform refresh`
  * updates state to match real-world conditions. 
  * Done automatically during plan and apply.
  * This command is **DEPRECATED** use the `-refresh-only` flag during `terraform plan` or `terraform apply`
* `terraform state mv {SOURCE} {DESTINATION}`
  * if the resource specified by `{SOURCE}` is found in state, terraform will move the remote object to be tracked instead by `{DESTINATION}`.
  * Use the `-dry-run` flag to report all the resources that match the given address without actually "forgetting" any of them.
  * New Recommended flow is to use the `moved` block in terraform configurations.
* `terraform state rm {ADDRESS}`
  * removes a resource from being tracked by Terraform. **IT DOES NOT destroy the remote object.**
  * New Recommend process is to use the `removed` block
* `terraform state replace-provider {FROM} {TO}`
  * updates all resources using the _FROM_ provider, setting the provider to the specified _TO_ provider.
  * accepts the following options:
    * `-auto-approve`
      * skip interactive approval
    * `lock=false`
      * dont hold a state lock during the operation
        * dangerous if others might concurrently run commands against the same workspace
    * `lock-timeout=0s`
      * duration to retry a state lock
    * `-ignore-remote-version`
      * Override checking that the local and remote Terraform versions agree, making an operation proceed even when there is a mismatch.
      * Only used with remote backend or HCP Terraform ClI integrations
* `terraform state pull`: download the state from its current location, upgrade the local copy to the latest state file version, output the raw format to stdout.
* `terraform state push {PATH}`: manually upload a local state file to remote state.
  * use the `-force` flag to tell Terraform to ignore any safety checks and force the remote state override.
* `terraform force-unlock {LOCK_ID}`: Removes the lock on the state file, _LOCK_ID_.

All `terraform state` subcommands except read-only ones (`show`, `list`) will generate a backup file of the current state before making modifications.

### 7c. Describe when and how to use verbose logging

Set the `TF_LOG` environment variable to enable logging which will cause detailed logs to appear on `stderr`

Use one of the following log levels (in order of verbosity) `TRACE`, `DEBUG`, `INFO`, `WARN` or `ERROR` to change the verbosity of the logs.

Setting `TF_LOG` to `JSON` will output the logs at the `TRACE` level or higher and use JSON encoding as the formatting.

Alternatively your can enable logging for Terraform itself and the provider plugins:

* `TF_LOG_CORE`:
  * uses same log levels as `TF_LOG`
  * enables logging for Terraform Core
* `TF_LOG_PROVIDER`:
  * uses same log levels as `TF_LOG`
  * enables logging for the provider plugins

To persist logged output you can set `TF_LOG_PATH` in order to force the log to always be appended to a specific file when logging is enabled. Note that even when `TF_LOG_PATH` is set, `TF_LOG` must be set in order for any logging to be enabled.

If Terraform ever crashes (a "panic" in the Go runtime), it saves a log file with the debug logs from the session as well as the panic message and backtrace to crash.log

This log file is meant to be passed along to the developers via a GitHub Issue as a gist.

As a user, you're not required to dig into this file.

**Links**:

* Debugging Terraform → https://developer.hashicorp.com/terraform/internals/debugging
* Troubleshoot Terraform → https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow#enable-terraform-logging



## 7. Implement and Maintain State
### 7a. Describe default `local` backend

#### Backends

Each Terraform configuration can specify a backend, which defines where and how operations are performed, where state snapshots are stored.

They are defined using the `backend` block withing the Terraform Settings block.

```
terraform {
  backend "remote" {
    ....
  }
}
```
**Valid for Terraform versions prior to v1.1.0**
Terraform's backends are divided into two types:
* **Standard Backends**
  * only store state
  * does not perform terraform operations eg. `terraform apply`
    * To perform operations you use the CLI on your local machine
  * third-party backends are Standard backends e.g. _AWS S3_
  * Does not require terraform cloud or workspace
* **Enhanced Backends**
  * can both store state and perform _terraform_ operations
  * subdivided:
    * **local**
      * files and data are stored on the local machine executing _terraform_ commands.
    * **remote**
      * files and data are stored in the cloud eg. _Terraform Cloud_.

![standard backends](images/standard-backends.png)

#### Enhanced Backends - "default" Local Backends

The `local` backend:
  * stores state on the local filesystem
  * locks that state using system APIs
  * performs operations locally
  * default if nothing is specified

The default state file is name `terraform.tfstate`

By default, you are using the backend state when you have not specified backend.

```
terraform {
  // empty means local by default and the .tfstate file will be written in the current directory.
}
```

You can specify the backend with argument "local", and you can change the path to the local file and working_directory.

```
terraform {
  backend "local" {
    path = "relative/path/to/terraform.tfstate"
  }
}
```
You can set a backend to reference another state file so you can read its outputted values. This is a way of cross-referencing stacks.

```
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "${path.module}/vpc/terraform.tfstate"
  }
}

resource "aws_instance" "my_server" {
  ...
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
}
```

Option configuration arguments:
- `state={FILENAME}`: overrides the state filename when reading the prior state snapshot.
- `state-out={FILENAME}`: overrides the state filename when writing new state snapshots.
- `backup={FILENAME}`: overrides the default filename that the local backend would normally choose dynamically to create backup files when it writes new state.


**Links**
* Backends --> https://www.terraform.io/docs/language/settings/backends/index.html
* Local --> https://www.terraform.io/docs/language/settings/backends/local.html
* Migrate State to Terraform Cloud --> https://learn.hashicorp.com/tutorials/terraform/cloud-migrate#set-up-the-remote-backend

### 7b. Describe state locking

Terraform will lock your state for all operations that could write state. This prevents others from acquiring the lock and potentially corrupting your state
State locking happens automatically on all operations that could write state, you won't see any message that it is happening.

If state locking fails you can disable state locking for most commands with the `-lock` flag but it is not recommended.

Terraform does not output when a lock is complete,
however, If acquiring the lock is taking longer than expected, Terraform will output a status message.

Terraform has a `force-unlock` command to manually unlock the state if unlocking failed. 

If you unlock the state when someone else is holding the lock it could cause multiple writes.

Force unlock should only be used to unlock your own lock in the situation where automatic unlocking failed.

To protect you, the force-unlock command requires a unique lock ID
Terraform will output this lock ID if unlocking fails.

State lock file `.terraform.tfstate.lock.hcl`

Not all backends support locking, Local, TFC, AWS S3 (with some tweaks), and several others do ([see docs for which ones do/don't](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)).

You can manually retrieve remote state with `terraform state pull`
You can manually write state with `terraform state push`.... but don't ever ever ever do this without proper supervision and guidance and backups.


**Links**
* State Locking --> https://www.terraform.io/docs/language/state/locking.html

### 7c. Handle backend and cloud integration between authentication methods

#### HCP Terraform Cloud Authentication

Use the `terraform login` command to log into Terraform Cloud.
This command will:
* Open browser to https://app.terraform.io
* Asks you to login
* Asks you to create an API token
* By default, it will store credentials file `credentials.tfrc.json` locally for terraform cli to use to connect to terraform cloud.

The `terraform login` command supports performing OAuth 2.0 authorization request using a configuration provided by the target host. You may wish to implement this protocol if you are producing a third-party implementation of any Terraform-native services, such as a Terraform module registry.

First, Terraform uses [remote service discovery](https://developer.hashicorp.com/terraform/internals/remote-service-discovery) to find the OAuth configuration for the host. The host must support the service name login.v1 and define for it an object containing OAuth client configuration values, like this:

```
{
  "login.v1": {
    "client": "terraform-cli",
    "grant_types": ["authz_code"],
    "authz": "/oauth/authorization",
    "token": "/oauth/token",
    "ports": [10000, 10010],
  }
}
```

See the [Login Protocol](https://developer.hashicorp.com/terraform/internals/login-protocol) documentation for more details.

#### Credential Helper
A program that instructs Terraform to use a different credential storage mechanism. A credentials helper called "credstore", for example, would be implemented as an executable program named terraform-credentials-credstore (with an .exe extension on Windows only), and installed in one of the default plugin search locations. Once Terraform has located the configured credentials helper, it will execute it once for each credentials request that cannot be satisfied by a credentials block in the CLI configuration.

Example: 
```
credentials_helper "credstore" {
  args = ["--host=credstore.example.com"]
}
```

Terraform runs the helper program with each of the arguments given in args, followed by an verb and then the hostname that the verb will apply to. The current set of verbs are:
  * `get`: retrieve the credentials for the given hostname
  * `store`: store new credentials for the given hostname
  * `forget`: delete any stored credentials for the given hostname

See more details on credential helper [here](https://developer.hashicorp.com/terraform/internals/credentials-helpers)

As of v1.2, the preferred option for storing credentials is using environment variables using `TF_TOKEN_` example for login in to terraform cloud set the variable `TF_TOKEN_app_terraform_io` this will be used as a bearer authorization token when the CLI makes service requests to the hostname `app.terraform.io`.


#### S3 Backend

Uses AWS credentials either in the `backend` block or stored as environment variables (recommended).

**Backend Block**
```
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    # This can also be sourced from AWS_REGION environment variale.
    region = "us-east-1"

    # Rather than specify these in-line, they can be sourced
    # from environment variables AWS_ACCESS_KEY and AWS_SECRET_ACCESS_KEY.
    access_key = "somekey"
    secret_key = "somesecretkey"

  }
}
```

**Environment Variables**

* `AWS_REGION`: The default region in aws.
* `AWS_ACCESS_KEY`: AWS IAM user access key
* `AWS_SECRET_ACCESS_KEY`: AWS IAM user access key secret
* `AWS_PROFILE`: The name of an AWS Profile in a shared credentials file (e.g. `~/.aws/credentials`) or shared configuration file (e.g. `~/.aws/config`)

#### AzureRM Backend

Uses Azure credentials either in the `backend` block or stored as environment variables (recommended).

**Backend Block**
```
terraform {
  backend "azurerm" {
    resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "abcd1234"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"

    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variables, see below.

    subscription_id      = "00000000-0000-0000-0000-000000000000"
    tenant_id            = "00000000-0000-0000-0000-000000000000"
    access_key = "abcdefghijklmnopqrstuvwxyz0123456789..."

  }
}
```

**Environment Variables**

* `ARM_SUBSCRIPTION`: The azure subscription ID in which the storage account exists.
* `ARM_TENANT_ID`: The azure tenant ID in which the Subscription existst.
* `ARM_ACCESS_KEY`: The storage account access key


#### Google Cloud Storage (GCS) Backend

Uses the GCP credentials either in the `backend` block or stored as environment variables (recommended).

**Backend Block**
```
terraform {
  backend "gcs" {
    bucket  = "tf-state-prod"
    prefix  = "terraform/state"
    # Rather than define in-line use an Environment variable, see below
    credentials = "path/to/gcp_credentials"
  }
}
```

Running Terraform locally first you need to authenticate to GCP, runinng `gcloud auth application-default login`

**Environment Variables**

* `GOOGLE_BACKEND_CREDENTIALS` or `GOOGLE_CREDENTIALS`: The local path to GCP account credentials in JSON format. If unset, `Google Application Default Credentials` are used.

**Links**
* Backend Types --> https://www.terraform.io/docs/language/settings/backends/index.html
* Login to Terraform Cloud from the CLI --> https://learn.hashicorp.com/tutorials/terraform/cloud-login

### 7d. Differentiate remote state backend options

Backends define where Terraform's state snapshots are stored.

You don't need to configure a backend when using TFC because it auto-manages state in the workspaces assoc. to the config. If your config includes a `cloud` block it cannot have a `backend` block.

Can be either integrated with [Terraform Cloud](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/terraform-cloud) or any of the following:
  * [local](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/local)
    * this is the default configuration if you backend configuration is provided
    * stores state on local disk
    * supports locking
  * [remote](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/remote)
    * As of Terraform v1.1.0 its now recommended to not use this but use the Terraform Cloud Integration instead
  * [jfrog artifactory](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/artifactory)
    * Generic HTTP repositories are supported, and state from different configurations may be kept at different subpaths within the repository.
    * does not support state locking
  * [Azure Resource Manager (azurerm)](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/azurerm)
    * Stores state as blob in blob container in an Azure Blob Storage Account
    * Supports state locking and consistency checking
  * [Hashicorp Consul](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/consul)
    * supports State locking
    * key/value store
  * [Tencent Cloud Object Storage (COS)](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/cos)
    * supports state locking
    * stores state as an object in a given bucket
  * [etcd](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/etcd)
    * key/value store
    * does not support state locking
  * [etcdv3](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/etcdv3)
    * key/value store
    * supports state locking
  * [Google Cloud Storage (gcs)](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/gcs)
    * stores state as an object in a pre-existing bucket in Google Cloud Storage
    * bucket must exist prior to backend configuration
    * supports state locking
  * [http](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/http)
  * [Kubernetes](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/kubernetes)
    * stores state as a kubernets secret (max size 1 MB)
    * supports state locking with locking done using a lease resource
  * [Triton Object Storage (fka Manta)](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/manta)
    * supports state locking
  * [Alibaba Cloud OSS (oss)](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/oss)
    * supports state locking and consistency checking via Alibaba Cloud Table Store which can be enabled by setting the `tablestore_table` field to an existing TableStore table
  * [Postgres (pg)](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/pg)
    * stores state in a Postgress Database v10 or newer
    * supports state locking
  * [AWS S3](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/s3)
    * stores state as given key in a given bucket
    * supports state locking and consistency checking via DynamoDb, which is enabled using the `dynamodb_table` field to an exsting DynamoDB table name.
    * A single DynamoDB table can be used to lock multiple remote state files.
    * Terraform generates key names that include the values of the bucket and key variables.
  * [OpenStack Swift](https://developer.hashicorp.com/terraform/language/v1.1.x/settings/backends/swift)
    * stores state as an artificat in Swift
    * supports state locking
  
#### Commonly used Backends 

##### Azure

```
terraform {
  backend "azurerm" {
    resource_group_name  = "StorageAccount-ResourceGroup"
    storage_account_name = "abcd1234"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    
    **Using Managed Service Identity (MSI)**
    use_msi              = true
    subscription_id      = "00000000-0000-0000-0000-000000000000"
    tenant_id            = "00000000-0000-0000-0000-000000000000"

    **Using Azure AD requires Storage Blob Data Owner is assigned as a role**
    use_azuread_auth     = true
    subscription_id      = "00000000-0000-0000-0000-000000000000"
    tenant_id            = "00000000-0000-0000-0000-000000000000"

    **Using a Storage Access Key**
    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variable - more information is available below.
    access_key = "abcdefghijklmnopqrstuvwxyz0123456789..."


    **Using a SAS Token with storage account**
    # rather than defining this inline, the SAS Token can also be sourced
    # from an Environment Variable - more information is available below.
    sas_token = "abcdefghijklmnopqrstuvwxyz0123456789..."
  }
}
```

##### AWS S3

```
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```

Terraform will need the following AWS IAM permissions on the target bucket
  * s3:ListBucket on `arn:aws:s3::{BUCKET_NAME}`
  * s3:GetObject on `arn:aws:s3:::{BUCKET_NAME/{PATH_TO_KEY}}`
  * s3:PutObject on `arn:aws:s3:::{BUCKET_NAME/{PATH_TO_KEY}}`
  * s3:DeletObject on `arn:aws:s3:::{BUCKET_NAME/{PATH_TO_KEY}}`

Example:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::mybucket"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::mybucket/path/to/my/key"
    }
  ]
}
```

Terraform will require the following DynamoDB Table Permissions
  * `dynomodb:GetItem`
  * `dynamodb:PutItem`
  * `dynamodb:DeleteItem`

Example:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "arn:aws:dynamodb:*:*:table/mytable"
    }
  ]
}
```

##### Google Cloud Storage

```
terraform {
  backend "gcs" {
    bucket  = "tf-state-prod"
    prefix  = "terraform/state"
  }
}
```

**Running Terraform on Google Cloud**
If you are running terraform on Google Cloud, you can configure that instance or cluster to use a Google Service Account. This will allow Terraform to authenticate to Google Cloud without having to bake in a separate credential/authentication file. Make sure that the scope of the VM/Cluster is set to cloud-platform.

**Running Terraform outside of Google Cloud**
If you are running terraform outside of Google Cloud, generate a service account key and set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to the path of the service account key. Terraform will use that key for authentication.

**Impersonating Service Accounts**
Terraform can impersonate a Google Service Account as described [here](https://cloud.google.com/iam/docs/creating-short-lived-service-account-credentials). A valid credential must be provided as mentioned in the earlier section and that identity must have the roles/iam.serviceAccountTokenCreator role on the service account you are impersonating.

### 7e. Manage resource drift and Terraform state

**Command refresh**

The terraform refresh command reads the current settings from all managed remote objects and updates the Terraform state to match.
The terraform refresh command is an alias for the refresh only and auto approve:
* `terraform apply -refresh-only -auto-approve` or `terraform plan -refresh-only`
Terraform refresh will not modify your real remote objects, but it will modify the Terraform state.
Terraform refresh **has been deprecated** and replaced with the `refresh-only` flag because it was not safe since it did not give you an opportunity to review proposed changes before updating the state file.

**Refresh-Only Mode**

The `–refresh-only` flag for terraform plan or apply allows you to refresh and update your state file without making changes to your remote infrastructure.

Scenario

Imagine you create a terraform script that deploys a Virtual Machine on AWS and you ask an engineer to terminate the server, and instead of updating the terraform script they mistakenly terminate the server via the AWS Console. This is change is referred to as _drift_, when your expected resources are in a different state that your expected stated.

Running `terraform apply`:
* Terraform will notice that the VM is missing
* Terraform will propose to create a new VM
* The `State File` is correct
* Changes the infrastructure to match state file.

Running `terraform apply –refresh-only`:
* Terraform will notice that the VM you provisioned is missing.
* With the `refresh-only` flag that the missing VM is intentional
* Terraform will propose to delete the VM from the state file
* The State File is wrong
* Changes the state file to match infrastructure

**Replacing Selected Resources**

The `replace={RESOURCE_ADDRESS}` option instructs Terraform to replace the object with the given resource address

* `terraform plan -replace={RESOURCE_ADDRESS}` or `terraform apply -replace={RESOURCE_ADDRESS}`

**Targeted Plan and Apply**

The `-target` option instructs Terraform to focus it's attention on only a subset of resources. You can use resource address syntax to specify the constraint. Terraform interprets the resource address as follows:

  * If the given address identifies one specific resource instance, Terraform will select that instance alone. For resources with either count or for_each set, a resource instance address must include the instance index part, like aws_instance.example[0].

  * If the given address identifies a resource as a whole, Terraform will select all of the instances of that resource. For resources with either count or for_each set, this means selecting all instance indexes currently associated with that resource. For single-instance resources (without either count or for_each), the resource address and the resource instance address are identical, so this possibility does not apply.

  * If the given address identifies an entire module instance, Terraform will select all instances of all resources that belong to that module instance and all of its child module instances.

Once Terraform has selected one or more resource instances that you've directly targeted, it will also then extend the selection to include all other objects that those selections depend on either directly or indirectly.

This targeting capability is provided for exceptional circumstances, such as recovering from mistakes or working around Terraform limitations. It is not recommended to use `-target` for routine operations, since this can lead to undetected configuration drift and confusion about how the true state of resources relates to configuration.

Instead of using `-target` as a means to operate on isolated portions of very large configurations, prefer instead to break large configurations into several smaller configurations that can each be independently applied.

Example : `terraform plan -target={RESOURCE_ADDRESS}` or `terraform apply -target={RESOURCE_ADDRESS}`

**Links**
* Command: refresh --> https://www.terraform.io/docs/cli/commands/refresh.html
* Manage Resource Drift --> https://learn.hashicorp.com/tutorials/terraform/resource-drift
* Use Refresh-Only Mode to sync Terraform State --> https://learn.hashicorp.com/tutorials/terraform/refresh


### 7f. Describe `backend` block and cloud integration in configuration



### 7g. Understand secret management in state files

Using the `sensitive=true` property on [_input_](#input-variables) and [_output_](#output-variables) variables will only restrict the value from being displayed in the output, the plain-text value **WILL** be stored in state. Hence it is recommended to use a backend that supports encrypt at rest and in transit.

_Terraform Cloud_ supports encrypt at rest and in transit by default and the same goes for other remote backends like `s3`, `azurerm` and `gcs`; however for `s3` you need to enable the `encrypt` option.

**Links**
* Sensitive Data In State --> https://www.terraform.io/docs/language/state/sensitive-data.html
* Protective Sensitve Input Variables --> https://learn.hashicorp.com/tutorials/terraform/sensitive-variables#sensitive-values-in-state

[Back to Exam Guide](README.md)