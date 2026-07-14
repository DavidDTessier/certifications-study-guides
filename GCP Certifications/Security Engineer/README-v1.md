![Logo](https://storage.googleapis.com/support-kms-prod/KCn1CGYhasOwNLuyFjDyKs9BU75Xi3pZWXib)
# Google Cloud - Cloud Security Engineer Certification

[^1] A Professional Cloud Security Engineer enables organizations to design and implement a secure infrastructure on Google Cloud Platform. Through an understanding of security best practices and industry security requirements, this individual designs, develops, and manages a secure infrastructure leveraging Google security technologies. The Cloud Security Professional should be proficient in all aspects of Cloud Security including managing identity and access management, defining organizational structure and policies, using Google technologies to provide data protection, configuring network security defenses, collecting and analyzing Google Cloud Platform logs, managing incident responses, and an understanding of regulatory concerns.

The Professional Cloud Security Engineer exam assesses your ability to:

* Configure access within a cloud solution environment
* Configure network security
* Ensure data protection
* Manage operations within a cloud solution environment
* Ensure compliance

Link to the Exam Guide: [Sec Engineer Exam](https://cloud.google.com/certification/guides/cloud-security-engineer)

# Section 1. Configuring access with a cloud solution environment

<details>
<summary> 1.1 Configuring Cloud Idenity</summary>

## 1.1.a - Managing Cloud identity
Cloud Identity is an Identity as a Service (IDaaS) and enterprise mobility management (EMM) product. It offers the identity services and endpoint administration that are available in G Suite as a stand-alone product. As an administrator, you can use Cloud Identity to manage your users, apps, and devices from a central location—the Google Admin console.

There are free and premium editions of Cloud Identity. [Compare the differences](https://support.google.com/cloudidentity/answer/7431902)

**If you're a G Suite admin**
* G Suite licenses are required only for users who need certain G Suite services, like Gmail. To manage users who don't need any G Suite services, you can create free Cloud Identity accounts for them.  
* In most cases, Cloud Identity Free edition users have the same identity services as G Suite users, such as single sign-on (SSO) and 2-Step Verification (2SV).

**If you're a GCP admin**
* Consumer accounts, such as personal Gmail accounts or consumer accounts with work email IDs, are unmanaged accounts and are outside of your control. If developers in your organization use unmanaged accounts to use GCP resources, you can create Cloud Identity accounts to manage these users.
* You can create free Cloud Identity accounts for each user, separate from paid G Suite accounts. By doing so, you can manage all users across your entire domain from the Google Admin console.
* Cloud Identity Free edition provides common identity services, such as SSO.

You can manage Cloud Identity via the [REST API](https://cloud.google.com/identity/docs/reference/rest)

_Cloud Identity APIs_
* [Groups API](https://cloud.google.com/identity/docs/groups)
  * Allows you to create and manage different types of groups, each of which supports different features, as well as their memberships.

Google Recommends leveraging there [Client Libraries](https://cloud.google.com/apis/docs/client-libraries-explained) in order to interact with there APIs.

Enforce multi-factor authentication
* https://cloud.google.com/identity/solutions/enforce-mfa

Enable SSO for cloud apps:
* https://cloud.google.com/identity/solutions/enable-sso

Secure corporate access on personal devices:
* https://cloud.google.com/identity/solutions/secure-corp-on-personal-devices

The following diagram illustrates the flow for integrate you existing Identity and Access Management system.

![IdP](images/integrating_your_current_identity_manageme.max-1500x1500.png)

* Grant roles to a Google group instead of to individual users when possible. It is easier to manage members in a Google group than to update an IAM policy. Make sure to control the ownership of the Google group used in IAM policies.

* Use the security principle of least privilege to grant IAM roles; that is, only give the least amount of access necessary to your resources.

* Grant roles at the smallest scope needed. For example, if a user only needs access to publish messages to a Pub/Sub topic, grant the Publisher role to the user for that topic. **_Remember that the policies for child resources inherit from the policies for their parent resources. For example, if the policy for a project grants a user the ability to administer Compute Engine virtual machine (VM) instances, then the user can administer any Compute Engine VM in that project, regardless of the policy you set on each VM. If you need to grant a role to a user or group that spans across multiple projects, set that role at the folder level instead of setting it at the project level._**

* Use labels to annotate, group, and filter resources.

* Audit your policies to ensure compliance. Audit logs contain all `setIamPolicy()` calls, so you can trace when a policy has been created or modified.

* Audit the ownership and the membership of the Google groups used in policies.

* If you want to limit project creation in your organization, change the organization access policy to grant the Project Creator role to a group that you manage.

### Perform G Suite Domain-Wide Delegation of Authority
In enterprise applications you may want to programmatically access a user's data without any manual authorization on their part. In G Suite domains, the domain administrator can grant third-party applications with domain-wide access to its users' data — this is known as domain-wide delegation of authority. To delegate authority this way, domain administrators can use service accounts with OAuth 2.0.

To access user data on a G Suite domain, the service account that you created needs to be granted access by a super administrator for the domain.

OAuth Scopes:
For example, if you require domain-wide access to Users and Groups enter: https://www.googleapis.com/auth/admin.directory.user, https://www.googleapis.com/auth/admin.directory.group


## 1.1.b - Configuring Google Cloud Directory Sync
Google Cloud Directory Sync enables administrators to synchronize users, groups and other data from an Active Directory/LDAP service to their Google Cloud domain directory.

You need to enable Cloud Platform to recognize your users, using one of two recommended methods: Google Cloud directory sync (shown on the left below), or third-party identity provider connectors to Cloud Identity (shown on the right below).

![Sync Identities](images/Sync_identities.max-1100x1100_m0h2F9X.max-1100x1100.png)

![GC Directory Sync](images/active-directory-as-idp.svg)

Google Cloud uses Google identities for authentication and access management. Manually maintaining Google identities for each employee can add unnecessary management overhead when all employees already have an account in Active Directory. By federating user identities between Google Cloud and your existing identity management system, you can automate the maintenance of Google identities and tie their lifecycle to existing users in Active Directory.

Cloud Directory Sync queries the LDAP directory to retrieve the necessary information from the directory and uses the [Directory API](https://developers.google.com/admin-sdk/directory/) to add, modify, or delete users in your Cloud Identity or G Suite account.

[Preparing your Cloud Identity or G Suit account](https://cloud.google.com/architecture/identity/federating-gcp-with-active-directory-synchronizing-user-accounts#configuring_cloud_identity)

[Configuring user provisioning](https://cloud.google.com/architecture/identity/federating-gcp-with-active-directory-synchronizing-user-accounts#configuring_user_provisioning)

## 1.1.c - Managing super administrator account

Best practices for super admin can be found [here](https://cloud.google.com/resource-manager/docs/super-admin-best-practices).

## Super Admin Best Practices

Super admin accounts have irrevocable administrative permissions that we do not recommended using in the day-to-day administration of your organization. Best practices for managing super admins are as follows:

* Create a super admin email address
  * Create a new email address that is not specific to a particular user as the G Suite or Cloud Identity super admin account. This account should be further secured with multi-factor authentication, and could be used as an emergency recovery tool.

* Designate organization admins
  * This role has a smaller set of permissions that are designed to manage your day to day organization operations. You should also create a private Google Cloud administrator group in your G Suite or Cloud Identity super admin account. Add your organization administrator users to this group, but not your super admin user. Grant this group the Organization Administrator IAM role or a limited subset of the role's permissions.
  * We recommend keeping your super admin account separate from your organization administrator group.

* Set appropriate roles
* Discourage the use of Super Admin
  * Enforce multi-factor authentication on your super admin accounts as well as all accounts that have elevated privileges.
  * Use a security key or other physical authentication device to enforce two-step verification.
  * For the initial super admin account, ensure that the security key is kept in a safe place, preferably at your physical location.

* Setup Multiple Super Admin Accounts
  * A business should have more than one super admin account, each managed by a separate individual. If one account is lost or compromised, another super admin can perform critical tasks while the other account is recovered.

## 1.1.d - Automating user lifecycle management process

User lifecycle management—the ability to automatically add and remove users to applications—is one of the key features of [Cloud Identity](https://cloud.google.com/identity), Google Cloud’s identity, access, and device management solution, will allow you to provision and de-provision users and provide them access to a multitude of third-party applications directly from the Cloud Identiy or GSuite Admin Console.

This is done by enabling Single-Sign-On (SSO) on the application to use Google Cloud Identity as the Identity Provider (IdP)

**GCloud SDK Snippets**
Use _**add-iam-policy-binding**_ to add a role to a member
_`gcloud group add-iam-policy-binding resource --member=member --role=role-id`_

**Example**:
```
gcloud projects add-iam-policy-binding my-project --member=user:my-user@example.com --role=roles/viewer
```

Use _**remove-iam-policy-binding**_ to remove a role from a member
_`gcloud group remove-iam-policy-binding resource --member=member --role=role-id`_
**Example:**
```
gcloud projects remove-iam-policy-binding my-project --member=user:my-user@example.com --role=roles/viewer
```



## 1.1.e - Administering user accounts and groups programmatically

Use the [Directory API](https://developers.google.com/admin-sdk/directory/) within the Admin SDK to add, modify, or delete users in your Cloud Identity or G Suite account.


The following script leverages the directory api within the Admin SDK add a new user:
```
/**
 * Adds a new user to the domain, including only the required information. For
 * the full list of user fields, see the API's reference documentation:
 * @see https://developers.google.com/admin-sdk/directory/v1/reference/users/insert
 */
function addUser() {
  let user = {
    // TODO (developer) - Replace primaryEmail value with yours
    primaryEmail: 'liz@example.com',
    name: {
      givenName: 'Elizabeth',
      familyName: 'Smith'
    },
    // Generate a random password string.
    password: Math.random().toString(36)
  };
  try {
    user = AdminDirectory.Users.insert(user);
    Logger.log('User %s created with ID %s.', user.primaryEmail, user.id);
  } catch (err) {
    // TODO (developer)- Handle exception from the API
    Logger.log('Failed with error %s', err.message);
  }
}

```

More samples can be found [here](https://developers.google.com/apps-script/advanced/admin-sdk-directory).


</details>
<details>
<summary> 1.2 Managing service accounts</summary>

## 1.2.a - Protecting and auditing service account keys

Details on auditing service accounts and keys
can be found [here](https://cloud.google.com/iam/docs/audit-logging).



## 1.2.b - Automating the rotation of user-managed service account keys
Automating the rotation of user-managed service account keys can be done leveraging the [Keyrotator python app](https://github.com/Googlecloudplatform/keyrotator)

![sa key rotation vault](https://miro.medium.com/max/1400/0*0NB2VCIYxFw0vQK1)

One key best practice for key rotation is to setup a cron job to rotate keys and store them in a Cloud Storage Bucket which developers have READ access to and have them download the updated keys daily from there.

You Can also leverage [Hashicorp Vault](https://www.vaultproject.io/) for managing service account & keys. See [here](https://medium.com/techking/key-rotation-in-google-cloud-3ee8ff0a7828#:~:text=%E2%80%9CA%20security%20best%20practice%20is,keys) as well as [official google documentation](https://cloud.google.com/blog/products/identity-security/how-you-and-wepay-can-use-hashicorp-vault) for more details

### Hashicorp Vault

First enable the secrets engine:

`$ vault secrets enable gcp`

Then setup the engine with initial config and role sets:
```
$ vault write gcp/config \
credentials=@path/to/creds.json \
 ttl=3600 \
 max_ttl=86400
```
This config supplies default credentials that Vault will use to generate the service account keys and access tokens, as well as TTL metadata for the leases Vault assigns to these secrets when generated.

Role sets define the sets of IAM roles, bound to specific resources, that you assign to generated credentials. Each role set can generate one of two types of secrets: either `access_token` for one-use OAuth access tokens or `service_account_key` for long-lived service account keys. Here are some examples for both types of rolesets:

```
# Create role sets
$ vault write gcp/roleset/token-role-set \
    project="myproject" \
    secret_type="access_token" \
    bindings=@token_bindings.hcl
    token_scopes="https://www.googleapis.com/auth/cloud-platform"
$ vault write gcp/roleset/key-role-set \
    project="myproject" \
    secret_type="service_account_key"
    bindings=””
```

The above bindings param expects a string (or, using the special Vault syntax ‘@’, a path to a file containing this string) with the following HCL (or JSON) format

```
resource "path/to/my/resource" {
    roles = [
      "roles/viewer",
      "roles/my-other-role",
    ]
}
resource "path/to/another/resource" {
    roles = [
      "roles/editor",
    ]
}
```

Creating a new role set generates a new service account for a role set. When a user generates a set of credentials, they specify a role set (and thus service account) under which to create the credentials.

Once you have set up the secrets engine, a Vault client can easily generate new secrets:

```
$ vault read gcp/key/key-role-set
Key                 Value
---                 -----
lease_id            gcp/key/key-roleset/
lease_duration      1h
lease_renewable     true
key_algorithm       KEY_ALG_RSA_2048
key_type            TYPE_GOOGLE_CREDENTIALS_FILE
private_key_data    
$ vault read gcp/token/token-role-set
Key                 Value
---                 -----
lease_id           gcp/token/test/
lease_duration     59m59s
lease_renewable    false
token              ya29.c.restoftoken...
```

These credentials can then be used to make calls to GCP APIs as needed and can be automatically revoked by Vault.

To learn more, check out the [GCP IAM service account secret engine documentation](https://www.vaultproject.io/docs/secrets/gcp/index.html).

## 1.2.c - Identifying scenarios requiring service accounts
Typically, service accounts are used in scenarios such as:

* Running workloads on virtual machines (VMs).
* Running workloads on on-premises workstations or data centers that call Google APIs.
* Running workloads which are not tied to the lifecycle of a human user.

## 1.2.d - Creating, authorizing, and securing service accounts

When using an application to access Cloud Platform APIs, we recommend you use a service account, an identity whose credentials your application code can use to access other GCP services. You can access a service account from code running on GCP, in your on-premises environment or even another cloud.

Service accounts differ from user accounts in a few key ways:

  * Service accounts do not have passwords, and cannot log in via browsers or cookies.
  * Service accounts are associated with private/public RSA key-pairs that are used for authentication to Google.
  * IAM permissions can be granted to allow other users (or other service accounts) to impersonate a service account.
  * Service accounts are not members of your G Suite domain, unlike user accounts. For example, if you share assets with all members in your G Suite domain, they will not be shared with service accounts. Similarly, any assets created by a service account cannot be owned or managed by G Suite or Cloud Identity admins. This doesn't apply when using domain-wide delegation, because API calls are authorized as the impersonated user, not the service account itself.

GCP provides the [IAM Recommender](https://cloud.google.com/iam/docs/recommender-overview) tool for providing insights and recommendations on enforcing least priviledge on you IAM accounts.

Once you decide that you need a service account, you can ask yourself the following questions to understand how you're going to use the service account:

* What resources can the service account access?
* What permissions does the service account need?
* Where will the code that assumes the identity of the service account be running: on Google Cloud Platform or on-premises?

Use the following diagram to help answer the above questions:

![sa flow](images/sa-flowchart.png)

There are two types of service account keys:
* GCP-managed keys.
  * These keys are used by Cloud Platform services such as App Engine and Compute Engine. They cannot be downloaded, and are automatically rotated and used for signing for a maximum of two weeks. The rotation process is probabilistic; usage of the new key will gradually ramp up and down over the key's lifetime. We recommend caching the public key set for a service account for at most 24 hours to ensure that you always have access to the current key set.
* User-managed keys.
  * These keys are created, downloadable, and managed by users. They expire 10 years from creation, and cease authenticating successfully when they are deleted from the service account.
    * [Managing Service Account Keys](https://cloud.google.com/iam/docs/understanding-service-accounts#managing_service_account_keys)

**GCloud CLI Snippets**
Creating a service account:

```
gcloud iam service-accounts create sa-name --description="sa-description" --display-name="sa-display-name"
```

Creating a service account key:

```
gcloud iam service-accounts keys create ~/key.json --iam-account sa-name@project-id.iam.gserviceaccount.com
```

This command generates a key json that will look like the following:

```
{
  "type": "service_account",
      "project_id": "project-id",
      "private_key_id": "key-id",
      "private_key": "-----BEGIN PRIVATE KEY-----\nprivate-key\n-----END PRIVATE KEY-----\n",
      "client_email": "service-account-email",
      "client_id": "client-id",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://accounts.google.com/o/oauth2/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/service-account-email"
    }
```

To updated a Service Account use the following command:
```
gcloud iam service-accounts update sa-name@project-id.iam.gserviceaccount.com --description="updated-sa-description" --display-name="updated-display-name"
```

To disable a service account use the following command:
```
gcloud iam service-accounts disable sa-name@project-id.iam.gserviceaccount.com
```

To enable a service account use the following command:

```
gcloud iam service-accounts enable sa-name@project-id.iam.gserviceaccount.com
```

To delete a service account use the following command:

```
gcloud iam service-accounts delete sa-name@project-id.iam.gserviceaccount.com
```

In some cases you can use the `undelete` command to _undelete_ a deleted service account.

These scenerios are:

    * The service account was deleted less than 30 days ago.
      * After 30 days, IAM permanently removes the service account. Google Cloud cannot recover the service account after it is permanently removed, even if you file a support request.

    * The service account was deleted less than 30 days ago.

    After 30 days, IAM permanently removes the service account. Google Cloud cannot recover the service account after it is permanently removed, even if you file a support request.

    * There is no existing service account with the same name as the deleted service account.
      * For example, suppose that you accidentally delete the service account my-service-account@project-id.iam.gserviceaccount.com. You still need a service account with that name, so you create a new service account with the same name, my-service-account@project-id.iam.gserviceaccount.com. The new service account does not inherit the permissions of the deleted service account. In effect, it is completely separate from the deleted service account. However, you cannot undelete the original service account, because the new service account has the same name.

    * To address this issue, delete the new service account, then try to undelete the original service account.

    If you are not able to undelete the service account, you can create a new service account with the same name; revoke all of the roles from the deleted service account; and grant the same roles to the new service account. For details, see Policies with deleted members.


**Best Practices**
Best practice for managing service accounts can be found [here](https://cloud.google.com/blog/products/gcp/help-keep-your-google-cloud-service-account-keys-safe) and [here](https://cloud.google.com/iam/docs/understanding-service-accounts#best_practices) also.



## 1.2.3 - Securely managing API access management
## 1.2.f - Managing and creating short-lived credentials

Can you vault to create short live credentials or use the [following](https://cloud.google.com/iam/docs/create-short-lived-credentials-direct).

The **Service Account Token Creator role** lets principals impersonate service accounts to do the following:

* Create OAuth 2.0 access tokens, which you can use to authenticate with Google APIs
* Create OpenID Connect (OIDC) ID tokens
* Sign JSON Web Tokens (JWTs) and binary blobs so that they can be used for authentication


Key IAM Permissions for Services Accounts:

    * `iam.serviceAccounts.actAs`:
      * attach it so resources that will authenticate as the service account
      * process that perform long running jobs
    * `iam.serviceAccounts.getAccessToken` (for OAuth 2.0 access tokens) and
      `iam.serviceAccounts.getOpenIdToken` (for OpenID Connect(OICD) ID Tokens)
    `iam.serviceAccounts.signBlob` and
    `iam.serviceAccounts.signJwt` and
    `iam.serviceAccounts.implicitDelegation` and also the role `roles/iam.serviceAccountTokenCreator`
      * a user (or service) can directly impersonate (or assert) the identity of a service account in a few common scenarios


**Impersonate a service account**

```
# serviceAccount:ansible  impersonate as a svc account terraform@${PROJECT_ID}.iam.gserviceaccount.com

# ${SA_PROJECT_ID} is the global project storing all the service accounts
TF_SA_EMAIL=terraform@${SA_PROJECT_ID}.iam.gserviceaccount.com
ANSIBLE_SA_EMAIL="ansible@${SA_PROJECT_ID}.iam.gserviceaccount.com"

gcloud iam service-accounts add-iam-policy-binding ${TF_SA_EMAIL} \
    --project ${SA_PROJECT_ID} \
    --member "serviceAccount:$ANSIBLE_SA_EMAIL" \
    --role roles/iam.serviceAccountTokenCreator

# create a gcp project $A_PROJECT_ID under $A_FOLDER_ID
gcloud projects --impersonate-service-account=$TF_SA_EMAIL create $A_PROJECT_ID --name=$A_PROJECT_NAME --folder=$A_FOLDER_ID

# user:pythonrocks@gmail.com impersonate as a svc account terraform@${PROJECT_ID}.iam.gserviceaccount.com
TF_SA_EMAIL=terraform@your-service-account-project.iam.gserviceaccount.com

gcloud iam service-accounts add-iam-policy-binding  $TF_SA_EMAIL --member=user:pythonrocks@gmail.com \
--role roles/iam.serviceAccountTokenCreator

gcloud container clusters list --impersonate-service-account=terraform@${PROJECT_ID}.iam.gserviceaccount.com

```

See more details [here](https://cloud.google.com/iam/docs/create-short-lived-credentials-direct)

**Workload Identity Federation**

You can also grant identities from a workload that runs outside of Google Cloud, such as on Amazon Web Services (AWS) or Microsoft Azure, the ability to impersonate a service account. This lets you access resources directly, using short-lived credentials, instead of using a service account key.

You can use a workload identity pool to organize and manage external identities.

A project can contain multiple workload identity pools, and each pool can have access to different resources. This lets you follow the principle of least privilege by grouping related identities in the same pool, and then granting them fine-grained access to resources.

In general, we recommend creating a new pool for each non-Google Cloud environment that needs to access Google Cloud resources, such as development, staging, or production environments.

Workload identity pool providers
A workload identity pool provider is an entity that describes a relationship between Google Cloud and an external identity provider, such as the following:
  * AWS
  * Azure Active Directory
  * On-premises Active Directory
  * Okta
  * Kubernetes clusters

Workload identity federation follows the OAuth 2.0 token exchange specification. You provide a credential from an external identity provider to the [Security Token Service](https://cloud.google.com/iam/docs/reference/sts/rest), which verifies the identity on the credential, and then returns a federated token in exchange.

To impersonate a service account you need to grant the external entity the Workload Identity User role (`roles.iam.workloadIdentityUser`) on a service account with roles required for the workload.

**Single Identity**
```
principal://iam.googleapis.com/projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL_ID/subject/SUBJECT_NAME
```

**All identities in a group**
```
principalSet://iam.googleapis.com/projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL_ID/group/GROUP_NAME
```

**All identities with a specific attribute value**
```
principalSet://iam.googleapis.com/projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL_ID/attribute.ATTRIBUTE_NAME/ATTRIBUTE_VALUE
```

**All identities in a pool**
```
principalSet://iam.googleapis.com/projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL_ID/*
```

</details>


<details>
<summary> 1.3 Managing Authentication</summary>

## 1.3.a - Creating a password policy for user accounts
12 Best Practices on managing passwords - [here](https://cloud.google.com/blog/products/gcp/12-best-practices-for-user-account)


Set up password policy for users following the best practices found [here](https://cloud.google.com/solutions/modern-password-security-for-users.pdf) as well as best practices for system/app authentication [here](https://cloud.google.com/solutions/modern-password-security-for-system-designers.pdf).

**When password policies don't apply**
* You can update user passwords as a hash by using the bulk user upload tool or the G Suite Password Sync tool. However, if you apply password policies to an entire organizational unit and then upload passwords as a hash for a subset of users in that unit, the policies are not enforced for that subset of users. For details, see the G Suite Admin SDK and About G Suite Password Sync.
* Password policies don't apply to any user passwords that you reset manually. If you manually reset a password, make sure to select Enforce password policy at next sign-in for that user.
* The password policies you configure don't apply to users who are authenticated on a third-party identity provider (IdP) using SAML.

Enabling SSO for Cloud Apps [here](https://cloud.google.com/identity/solutions/enable-sso)


## 1.3.b - Establishing a Security Assertion Markup Language (SAML)

Signing in users with SAML:https://cloud.google.com/identity-platform/docs/web/saml


## 1.3.c - Configuring and enforcing two-factor authentication

Configuring and enfocing Two-Factor Auth(2mfa): https://cloud.google.com/identity/solutions/enforce-mfa

If Cloud Identity is your identity provider (IdP), you can implement 2SV in several ways. If you use a third-party IdP, check with them about their 2SV offering.

You can select different levels of 2SV enforcement:

* Optional—employee decides if they will use 2SV.
* Mandatory—employee chooses the 2SV method.
* Mandatory security keys—employee must use a security key.

</details>

<details>
<summary> 1.4 Managing and implementing authorization controls </summary>

## 1.4.a - Managing privileged roles and separation of duties

Best practices for IAM Security can be found [here](https://cloud.google.com/iam/docs/using-iam-securely)

**Cloud IAM best Practices**
* Use groups when configuring GCP access
* Assign roles to the groups instead of individual users
* Utilizing predifined roles offers less admin overhead
* Prededinfed roles are managed by Google
* Custom roles are **NOT** managed by Google
* Audit logs record project-level permission changes
* Audit policy changes
* Export audit logs to Cloud Storage to store logs for longer periods of time
* Service Account Key Rotation
  * Create a new key, update app config, delete old key

The following command lists all grantable roles for a given resource.
```
gcloud iam list-grantable-roles [full-resource-name]
```

## 1.4.b - Managing IAM permissions with basic, predefined, and custom roles

There are three kinds of roles in IAM:

* Primitive roles:
  * Roles historically available in the Google Cloud Console. These roles are Owner, Editor, and Viewer. Avoid using these roles if possible, because they include a wide range of permissions across all Google Cloud services.

* Predefined roles:
  * Roles that give finer-grained access control than the primitive roles. For example, the predefined role Pub/Sub Publisher (roles/pubsub.publisher) provides access to only publish messages to a Pub/Sub topic.

* Custom roles:
  * Roles that you create to tailor permissions to the needs of your organization when predefined roles don't meet your needs.

GKE IAM Predefined Roles - [here](https://cloud.google.com/kubernetes-engine/docs/how-to/iam#predefined)

GCE IAM Policies - [here](https://cloud.google.com/compute/docs/access#resource-policies)

## 1.4.c - Granting permissions to different types of identities

Cloud Identity and access management (IAM) is the practice of granting the right individuals access to the right resources for the right reasons. This series explores IAM and the individuals who are subject to it, including the following:

* **Corporate identities**: The identities that you manage for employees of your organization. These identities are used for signing in to workstations, accessing email, or using corporate applications. Corporate identities might also include non-employees such as contractors or partners that need access to corporate resources.
* **Customer identities**: The identities that you manage for users in order to interact with your website or customer-facing applications.
* **Service identities**: The identities that you manage in order to enable applications to interact with other applications or the underlying platform.

You might need to grant access to the following resources:
* Google services such as Google Cloud, Google Analytics, or G Suite
* Resources in Google Cloud, such as projects, Cloud Storage buckets, or virtual machines (VMs)
* Custom applications or resources managed by such applications

![IAM Descision Tree](images/IAM-Descision-Tree.png)

Customer identities are the identities that you manage for users to let them interact with your website or customer-facing applications. Managing customer identities and their access is also referred to as customer identity and access management (CIAM).

By leveraging Google's [Identity Platform](https://cloud.google.com/identity-platform) you can control access to your business application. It provides Single-Sign-On (SSO) capabilities. This is done by building [authentication workflows](https://cloud.google.com/identity-platform/docs/concepts-authentication) into the application using easy-to-use SDK functionality.


## 1.4.d - Understanding differences between Cloud Storage IAM and ACLs


Cloud Storage IAM and ACLs work in tandem to grant access to your buckets and objects: a user only needs permission from either Cloud IAM or an ACL to access a bucket or object.
In general, permissions granted by Cloud IAM policies do not appear in ACLs, and permissions granted by ACLs do not appear in Cloud IAM policies.

In most cases IAMs are the recommended approach for giving access to resources.

* ACLs
  * An access control list (ACL) is a mechanism you can use to define who has access to your buckets and objects, as well as what level of access they have. In Cloud Storage, you apply ACLs to individual buckets and objects. Each ACL consists of one or more entries. An entry gives a specific user (or group) the ability to perform specific actions. Each entry consists of two pieces of information:

    * A **permission**, which defines what actions can be performed (for example, read or write).
    * A **scope** (sometimes referred to as a grantee), which defines who can perform the specified actions (for example, a specific user or group of users).

* Legacy Bucket Cloud IAM roles work in tandem with bucket ACLs: when you add or remove a Legacy Bucket role, the ACLs associated with the bucket reflect your changes. Similarly, changing a bucket-specific ACL updates the corresponding Legacy Bucket role for the bucket.
  * _(IAM) Storage Legacy Bucket Reader = (ACL)Bucket Reader_
  * _(IAM) Storage Legacy Bucket Writer = (ACL) Bucket Writer_
  * _(IAM) Storage Legacy Bucket Owner = (ACL) Bucket Owner_

* IAMs
  * https://cloud.google.com/storage/docs/access-control/iam#overview
  * https://cloud.google.com/storage/docs/access-control/iam-permissions
  * Cloud IAM allows you to control who has access to the resources in your Google Cloud project. Resources include Cloud Storage buckets and objects stored within buckets, as well as other Google Cloud entities such as Compute Engine instances.
  * The set of access rules you apply to a resource is called a Cloud IAM policy. A Cloud IAM policy applied to your project defines the actions that users can take on all objects or buckets within your project. A Cloud IAM policy applied to a single bucket defines the actions that users can take on that specific bucket and objects within it.
    * For example, you can create a Cloud IAM policy for one of your buckets that gives one user administrative control of that bucket. Meanwhile, you can add another user to your project-wide Cloud IAM policy that gives that user the ability to view objects in any bucket of your project.
  * Roles are a bundle of one or more permissions. For example, the Storage Object Viewer role contains the permissions storage.objects.get and storage.objects.list. You assign roles to members, which allows them to perform actions on the buckets and objects in your project.
  * Granting roles at the bucket level does not affect any existing roles that you granted at the project level, and vice versa. For example, say you want to give a user permission to read objects in any bucket but create objects only in one specific bucket. To achieve this, give the user the Storage Object Viewer role at the project level, thus allowing the user to read any object stored in any bucket in your project, and give the user the Storage Object Creator role at the bucket level for a specific bucket, thus allowing the user to create objects only in that bucket. Some roles can be used at both the project level and the bucket level. When used at the project level, the permissions they contain apply to all buckets and objects in the project. When used at the bucket level, the permissions only apply to a specific bucket and the objects within it. Examples of such roles are Storage Admin, Storage Object Viewer, and Storage Object Creator. Some roles can only be applied at one level. For example, you can only apply the Viewer role at the project level, while you can only apply the Storage Legacy Object Owner role at the bucket level.
  * All other bucket-level Cloud IAM roles, and all project-level Cloud IAM roles, work independently from ACLs. For example, if you give a user the Storage Object Viewer role, the ACLs remain unchanged.

## 1.4.e - Designing identity roles at the organization, folder, project, and resource level

![Cloud Identity Hierarchy](images/policy-hierarchy.png)

IAM lets you set policies at the following levels of the resource hierarchy:

* Organization level.
  * The organization resource represents your company. IAM roles granted at this level are inherited by all resources under the organization. For more information, see Access control for organizations using IAM.
    * Users who are not owners, including organization administrators, must be assigned either the `Organization Role Administrator role (roles/iam.organizationRoleAdmin)` or the IAM `Role Administrator role (roles/iam.roleAdmin)`. The IAM `Security Reviewer role (roles/iam.securityReviewer)` enables the ability to view custom roles but not administer them.

* Folder level.
  * Folders can contain projects, other folders, or a combination of both. Roles granted at the highest folder level will be inherited by projects or other folders that are contained in that parent folder. For more information, see Access control for folders using IAM.

* Project level.
  * Projects represent a trust boundary within your company. Services within the same project have a default level of trust. For example, App Engine instances can access Cloud Storage buckets within the same project. IAM roles granted at the project level are inherited by resources within that project. For more information, see Access control for projects using IAM.

* Resource level.
  * In addition to the existing Cloud Storage and BigQuery ACL systems, additional resources such as Genomics Datasets, Pub/Sub topics, and Compute Engine instances support lower-level roles so that you can grant certain users permission to a single resource within a project.

IAM policies are hierarchical and propagate down the structure. The effective policy for a resource is the union of the policy set at that resource and the policy inherited from its parent.

The following examples explain how policy inheritance works in practice.

**Example: Pub/Sub**
In Pub/Sub, topics and subscriptions are resources that live under a project. Assume that project_a has a topic topic_a under it. If you set a policy on project_a that grants the Editor role to bob@example.com, and set a policy on topic_a that grants the Publisher role to alice@example.com, you effectively grant the Editor role to bob@example.com and the Publisher role to alice@example.com for topic_a.

The following diagram illustrates the preceding example.

![PubSub Example](images/resource-hierarchy-pubsub1.png)

Other Examples can be found [here](https://cloud.google.com/iam/docs/resource-hierarchy-access-control)

## 1.4.f - Configuring Access Context Manager

Access Context Manager allows enterprises to configure access levels which map to a policy defined on request attributes.

Access Context Manager allows Google Cloud organization administrators to define fine-grained, attribute based access control for projects and resources in Google Cloud.

Administrators first define an access policy, which is an organization-wide container for access levels and service perimeters.

Access levels describe the requirements for requests to be honored. Examples include:

* Device type and operating system
* IP address
* User identity

Service perimeters define sandboxes of resources which can freely exchange data within the perimeter, but are not allowed to export data outside of it. Access Context Manager isn't responsible for policy enforcement. Its purpose is to describe the desired rules. Policy is configured and enforced across various points, such as VPC Service Controls. You can read more about these services in their respective user guides.

Access Context Manager is an integral part of the BeyondCorp effort at Google. To learn more, see [BeyondCorp](https://cloud.google.com/beyondcorp/).

An access policy collects the service perimeters and access levels you create for your Organization. An Organization can only have one access policy.

When service perimeters are created and managed using the VPC Service Controls page of the Cloud Console, you do not need to create an access policy.

IAM Roles/Permissions required:

* accesscontextmanager.policies.create
  - Privided by the `roles/accesscontextmanager.policy.Editor` role
  - Allow creation of an orginzation-level access policy or scoped policies
* accesscontextmanager.policies.list
  - Provided by `roles/accesscontextmanager.policyEditor` and `roles/accesscontextmanager.policyReader`
  - Lists an organization-level access policy or scoped policies

```
gcloud access-context-manager policies create --organization ORGANIZATION_ID --title POLICY_TITLE
```

Set the default policy:

```
gcloud config set access-context-manager/policy POLICY_NAME
```

You can update the access levels of you organization by using the bulk management apis using gcloud cli:

```
gcloud access-context-manager levels replace-all \
  --source-file=FILE \
  --etag=ETAG \
  [--policy=POLICY_NAME]
```
 `FILE` is a `.yaml` file containing the access levels as shown below:

 ```
- name: accessPolicies/11271009391/accessLevels/corpnet_access
  title: Corpnet Access
  description: Permit access to corpnet.
  basic:
    combiningFunction: AND
    conditions:
      - ipSubnetworks:
        - 252.0.2.0/24
        - 2001:db8::/32
- name: accessPolicies/11271009391/accessLevels/prodnet_access
  title: Prodnet Access
  description: Permit access to prodnet.
  basic:
    combiningFunction: OR
    conditions:
      - members:
        - user:exampleuser@example.com
        - serviceAccount:exampleaccount@example.iam.gserviceaccount.com
      - ipSubnetworks:
        - 176.0.2.0/24
 ```


</details>

<details>
<summary> 1.5 Defining resource hierarchy </summary>

## 1.5.a - Creating and managing organizations

The following diagram outlines a sample resource outline in Google Cloud:
![Resource Outline](images/cloud-folders-hierarchy.png).

The _Origanization_ node is the root node and all access control policies will trickle down from there. Org admins can set [Originizational Policies](https://cloud.google.com/resource-manager/docs/organization-policy/overview), which is a configuration of restrictions that enforce access control to folders and/or projects at the organization level on resources and their descendants. Available for Google Workspace and Cloud Identity.

Best Practices For Organizations can be found [here](https://cloud.google.com/docs/enterprise/best-practices-for-enterprise-organizations).

Key Best Practices:
* Map you organizational structure to GCP
  * Top level node represents you organization, folders represent business units/departments and/or teams.
* Federate your identity provider with Google Cloud
  * If your organization uses an on-premises or third-party identity provider, synchronize your user directory with Cloud Identity to let users access Google Cloud with their corporate credentials. This way, your identity platform remains the source of truth while Cloud Identity controls how your employees access Google services.

The following image outlines an example of  resource hierarchy illustrating the core account-level resources involved in administering your Google Cloud account.
![Resource Hierarchy](images/resource-hierarchy-overview.png)

  * Billing Account:
    * Tracks all organizational costs
      * Linked to one or more projects
  * Domain:
    * Your company Domain is the primary identity of your organization and establishes your company's identity with Google services, including Google Cloud.
    * Can be linked to either a Google Workspace or Cloud Identity Account
  * Organization:
    * Highest unit
    * Using [Google Workspace](https://support.google.com/a/answer/53926) and [Cloud Identity](https://cloud.google.com/identity/docs/set-up-cloud-identity-admin)
    * Common place to register your domain as the org name
  * Folders:
    * Orgs can have one or more folders
    * Common practice is to have folders represent departments in an org
    * Max 100 folders under a single folder or up to four levels of folder nesting
  * Projects:
    * A unit of resource management below folders
    * Contains a set of users, API permission, billing information and provisioned resources
    * Identified by their project ID which should be unique to each org
    * Auto-generated by GCP
      * Cloud Deployment Manager
      * Terraform
      * Ansible
    * Users and roles specified per project
  * Resources:
    * Instance of offerings and services of GCP
    * Roles are defined to manage access

The following diagram outlines a sample resource outline in Google Cloud:
![Resource Outline](images/cloud-folders-hierarchy.png).

When you set an organization policy on a resource hierarchy node, all descendants of that resource hierarchy node inherit the organization policy by default. If you set an organization policy at the root organization node, then those restrictions are inherited by all child folders, projects, and resources.
You can set custom organization policy on child nodes, which will overwrite or merge with the inherited policy based on the rules of hierarchy evaluation.

**Resource Management Best Practices**

1. Mirror your Google Cloud resource hierarchy structure to your organization structure. The Google Cloud resource hierarchy should reflect how your company is organized, whether it's a startup, a SME, or a large corporation. A startup may start out with a flat resource hierarchy with no organization resource. When more people start collaborating on projects and the number of projects increase, getting an organization resource might make sense. An organization resource is recommended for larger companies with multiple departments and teams where each team is responsible for their own set of applications and services.

2. Use projects to group resources that share the same trust boundary. For example, resources for the same product or microservice can belong to the same project.

3. Set policies at the organization level and at the project level rather than at the resource level. As new resources are added, you may want them to automatically inherit policies from their parent resource. For example, as new virtual machines are added to the project through auto-scaling, they automatically inherit the policy on the project.



## 1.5.b - Designing resource policies for organizations, folders, projects, and resources

Organization policies are a set of configurations outlining restrictions associated to the organization, which can be assigned to organizations, folders, and projects in order to enforce the restrictions on that resource and its descendants.

![Org Policy](images/org-policy-concepts.svg)

In order to define an organization policy, you choose a [constraint](https://cloud.google.com/resource-manager/docs/organization-policy/overview#constraints), which is a particular type of restriction against either a Google Cloud service or a group of Google Cloud services. You configure that constraint with your desired restrictions.




## 1.5.c - Managing organization constraints

The Organization Policy Service gives you centralized and programmatic control over your organization's cloud resources. As the organization policy administrator, you will be able to configure constraints across your entire resource hierarchy.

Benefits
* Centralize control to configure restrictions on how your organization’s resources can be used.
* Define and establish guardrails for your development teams to stay within compliance boundaries.
* Help project owners and their teams move quickly without worry of breaking compliance.

Identity and Access Management focuses on **who**, and lets the administrator authorize who can take action on specific resources based on permissions.

Organization Policy focuses on **what**, and lets the administrator set restrictions on specific resources to determine how they can be configured.

## Policies and Constraints
The IAM role `roles/orgpolicy.policyAdmin` enables an administrator to manage organization policies.


### Constraints

A **_constraint_** is a definition of the behaviors that are controlled by an organization policy. A constraint has a type, either list or boolean.



### Restricting by domains
_Resource Manager_ provides a domain restriction constraint, used within an org policy, that can limit resource sharing based on domain.

Organization policies can use this constraint to limit resource sharing to a specified set of one or more G Suite domains, and exceptions can be granted on a per-folder or per-project basis.

The domain restriction constraint is not retroactive. Once a domain restriction is set, this limitation will apply to IAM policy changes made from that point forward, and not to any previous changes.

_For example, consider two related organizations: examplepetstore.com and altostrat.com. You have granted an examplepetstore.com identity an IAM role in altostrat.com. Later, you decided to restrict identities by domain, and implemented an organization policy with the domain restriction constraint in altostrat.com. In this case, the existing examplepetstore.com identities would not lose access in altostrat.com. From that point, you could only grant IAM roles to identities from the altostrat.com domain._

The domain restriction constraint is based on the `iam.allowedPolicyMemberDomains` list constraint.


## Resource Liens

The project resource is the base-level organizing entity. Organizations and folders may contain multiple projects. A project is required to use Google Cloud, and forms the basis for creating, enabling, and using all Google Cloud services, managing APIs, enabling billing, adding and removing collaborators, and managing permissions.
https://cloud.google.com/resource-manager/docs/access-control-proj
You can place a lien upon a project to block the project's deletion until you remove the lien. This can be useful to protect projects of particular importance.
```
gcloud alpha resource-manager liens create
  --restrictions=resourcemanager.projects.delete
  --reason="Super important production system"
```

## 1.5.d - Using resource hierarchy for access and permissions inheritance

The resource nodes that are in the hierarchy below the Organization Node are evaluated as follows:

* Resource 1 defines a custom policy that sets inheritFromParent to TRUE and allows blue diamond. The policy from the Organization Node is inherited and merged with the custom policy, and the effective policy evaluates to allow red square, green circle, and blue diamond.

* Resource 2 defines a custom policy that sets inheritFromParent to TRUE and denies green circle. Deny values always take precedence during policy reconciliation. The policy from the Organization Node is inherited and merged with the custom policy, and the effective policy evaluates to allow only red square.

* Resource 3 defines a custom policy that sets inheritFromParent to FALSE and allows yellow hexagon. The policy from the Organization Node is not inherited, so the effective policy evaluates to only allow yellow hexagon.

* Resource 4 defines a custom policy that sets inheritFromParent to FALSE and includes the restoreDefault value. The policy from the Organization Node is not inherited, and the default constraint behavior is used, so the effective policy evaluates to allow all.

Descendants of the targeted resource hierarchy node inherit the organization policy. By applying an organization policy to the root organization node, you are able to effectively drive enforcement of that organization policy and configuration of restrictions across your organization.

You can set an Cloud IAM policy at the organization level, the folder level, the project level, or (in some cases) the resource level. Resources inherit the policies of the parent node. If you set a policy at the Organization level, it is inherited by all its child folders and projects, and if you set a policy at the project level, it is inherited by all its child resources.

The effective policy for a resource is the union of the policy set on the resource and the policy inherited from its ancestors. This inheritance is transitive. In other words, resources inherit policies from the project, which inherit policies from the organization. Therefore, the organization-level policies also apply at the resource level.

Ex:
![Org Policy Inheritance](images/org-policy-inheritance.svg)

## 1.5.e - Designing and managing trust and security boundaries within Google Cloud

**VPC Service Controls**

VPC Service Controls improves your ability to mitigate the risk of data exfiltration from Google Cloud services such as Cloud Storage and BigQuery. With VPC Service Controls, you create perimeters that protect the resources and data of services that you explicitly specify.

To configure Service Control perimeter:
1. If you want to use the `gcloud` command-line tool or the Access Context Manager APIs to create your service perimeters, create an access policy.

_**Note**: You do not have to manually create an access policy if you are using the Cloud Console to manage VPC Service Controls. An access policy will be created for your Organization automatically.
Secure GCP resources with service perimeters._

2. Set up VPC accessible services to add additional restrictions to how services can be used inside your perimeters (optional).
3. Set up private connectivity from a VPC network (optional).
4. Grant access from outside a service perimeter using access levels (optional).
5. Set up resource sharing between perimeters using service perimeter bridges (optional).

[Creating a service perimeter](https://cloud.google.com/vpc-service-controls/docs/create-service-perimeters)

</details>

# Section 2. Configuring network security
<details>
<summary> 2.1 Designing network security</summary>

## VPCs
Best practices for secure VPC designs can be found [here](https://cloud.google.com/solutions/best-practices-vpc-design).

A Virtual Private Cloud (VPC) network is a virtual version of a physical network, implemented inside of Google's production network, using [Andromeda](https://www.usenix.org/system/files/conference/nsdi18/nsdi18-dalton.pdf). A VPC network provides the following:

* Provides connectivity for your Compute Engine virtual machine (VM) instances, including Google Kubernetes Engine (GKE) clusters, App Engine flexible environment instances, and other Google Cloud products built on Compute Engine VMs.
* Offers native Internal TCP/UDP Load Balancing and proxy systems for Internal HTTP(S) Load Balancing.
* Connects to on-premises networks using Cloud VPN tunnels and Cloud Interconnect attachments.
* Distributes traffic from Google Cloud external load balancers to backends.

VPC networks have the following properties:
* VPC networks, including their associated routes and firewall rules, are global resources. They are not associated with any particular region or zone.
* Subnets are regional resources. Each subnet defines a range of IP addresses.
* Traffic to and from instances can be controlled with network firewall rules.
* Resources within a VPC network can communicate with one another by using internal (private) IPv4 addresses, subject to applicable network firewall rules. [See Network Communication](https://cloud.google.com/vpc/docs/vpc#intra_vpc_reqs)
* Instances with internal IP addresses can communicate with Google APIs and services. [See Private Access](https://cloud.google.com/vpc/docs/private-access-options)
* Network administration can be secured by using Cloud Identity and Access Management (Cloud IAM) roles.
* An organization can use Shared VPC to keep a VPC network in a common host project. Authorized Cloud IAM members from other projects in the same organization can create resources that use subnets of the Shared VPC network.
* VPC networks can be connected to other VPC networks in different projects or organizations by using VPC Network Peering.
* VPC networks can be securely connected in hybrid environments by using Cloud VPN or Cloud Interconnect.
* VPC networks only support IPv4 unicast traffic. They do not support broadcast, multicast, or IPv6 traffic within the network; VMs in the VPC network can only send to IPv4 destinations and only receive traffic from IPv4 sources. However, it is possible to create an IPv6 address for a global load balancer.

Each VPC network consists of one or more useful IP range partitions called _subnets_. Each subnet is associated with a region. VPC networks do not have any IP address ranges associated with them. IP ranges are defined for the subnets.

A network must have at least one subnet before you can use it. Auto mode VPC networks create subnets in each region automatically. Custom mode VPC networks start with no subnets, giving you full control over subnet creation. You can create more than one subnet per region.

Types of networks:
* **_auto mode_**:
  * one subnet from each region is automatically created within it. These automatically created subnets use a set of predefined IP ranges that fit within the 10.128.0.0/9 CIDR block. As new Google Cloud regions become available, new subnets in those regions are automatically added to auto mode VPC networks by using an IP range from that block.In addition to the automatically created subnets, you can add more subnets manually to auto mode VPC networks in regions that you choose by using IP ranges outside of 10.128.0.0/9.
* **_custom mode_**:
  * no subnets are automatically created. This type of network provides you with complete control over its subnets and IP ranges. You decide which subnets to create in regions that you choose by using IP ranges that you specify.

You can switch from auto mode to custom mode but this is a one-way conversion.

Considerations for choosing _auto mode_ over _custom mode_:

* auto mode:
  * easy to set up and use
  * Having subnets automatically created in each region is useful.
  * The predefined IP ranges of the subnets do not overlap with IP ranges that you would use for different purposes (for example, Cloud VPN connections to on-premises resources).

* custom mode:
  * more flexible and bettwe suited for production use cases
  * Having one subnet automatically created in each region isn't necessary.
  * Having new subnets automatically created as new regions become available could overlap with IP addresses used by manually created subnets or static routes, or could interfere with your overall network planning.
  * You need complete control over the subnets created in your VPC network, including regions and IP address ranges used.
  * You plan to connect VPC networks by using VPC Network Peering or Cloud VPN. Because the subnets of every auto mode VPC network use the same predefined range of IP addresses, you cannot connect auto mode VPC networks to one another.

**Default network**
Unless you choose to disable it, each new project starts with a default network. The default network is an auto mode VPC network with pre-populated firewall rules.

`default-allow-internal` fw rule which enables ingress connections within the VPC network for all protocols and ports between instances. This rule effectively permits inbound connections between VM instances in the same network.

The other three rules in the auto-generated network are `default-allow-ssh`, `default-allow-rdp` and `default allow-icmp`. The inclusion of these rules allows port 22, Secure Shell or SSH, port 3389, remote desktop protocol or RDP and ICMP traffic from any source IP.

You can disable the creation of default networks by creating an organization policy with the `compute.skipDefaultNetworkCreation` constraint. Projects that inherit this policy won't have a default network.

### Subnets
When you create a subnet, you must define its primary IP address range. The primary internal addresses for the following resources come from the subnet's primary range: VM instances, internal load balancers, and internal protocol forwarding. You can optionally add secondary IP address ranges to a subnet, which are only used by alias IP ranges. However, you can configure alias IP ranges for instances from the primary or secondary range of a subnet.

The following table shows valid CIDR block ranges for IPs
![Valid IP Ranges](images/valid-subnet-ranges.png)

Every subnet has four reserved IP addresses in its primary IP range. There are no reserved IP addresses in the secondary IP ranges.
![reserved ips](images/reserved_ip_ranges.png)

**Code Snippets**
To Create a vpc you can leverage the following GCloud CLI command:
```
gcloud compute networks create NETWORK_NAME
    --subnet-mode=auto|custom
    --bgp-routing-mode=global|regional
```

To add a _subnet_ to an existing VPC use the following command:
```
gcloud compute networks subnets create SUBNET_NAME \
    --network=NETWORK \
    --range=PRIMARY_RANGE \
    --region=REGION
```

You can modify the previous command with the following optional flags:

* `--secondary-range=SECONDARY_RANGE_NAME=SECONDARY_RANGE`:
  * Replace SECONDARY_RANGE_NAME with name for the secondary range and SECONDARY_RANGE with a secondary range in CIDR notation. The per network limits describe the maximum number of secondary ranges that you can define for each subnet.
* `--enable-flow-logs`:
  *  Enables VPC Flow Logs in the subnet at creation time.
* `--enable-private-ip-google-access`:
  * Enables Private Google Access in the subnet at creation time.
* `--purpose`:
  * Enables you to creata a proxy-only subnet for Internal HTTP(S) Load Balancing.
* `--role`:
  * For Internal HTTP(S) Load Balancing only, enables you to specify a role (active or backup) for a proxy-only subnet.

To delete a subnet use the following command:
```
gcloud compute networks subnets delete SUBNET_NAME \
    --region=REGION
```

To delete a VPC use the following command:
```
gcloud compute networks delete NETWORK_NAME
```

[Multi VPC Lab](https://www.qwiklabs.com/focuses/1230?parent=catalog)

### Network Intelligence Center

Network Intelligence Center provides a single console for managing Google Cloud network visibility, monitoring, and troubleshooting.

**Network Topology**
Visualize the topology of your VPC network and their associated metrics

**Connectivity Tests**
Test network connectivity to and from your VPC

**Performance Dashboard**
View packet loss and latency between zones where have VMs

**Firewall Insights**
View usage for your VPC firewall rules and optimize thier configuration

**Network Analyzer**
View network and service issues, insights, and best practice recommendations from automatic discoveries


## 2.1.a Configuring network perimeter controls

**VPC Service Controls**

VPC Service Controls improves your ability to mitigate the risk of data exfiltration from Google Cloud services such as Cloud Storage and BigQuery. With VPC Service Controls, you create perimeters that protect the resources and data of services that you explicitly specify.

To configure Service Control perimeter:
1. If you want to use the gcloud command-line tool or the Access Context Manager APIs to create your service perimeters, create an access policy.

_**Note**: You do not have to manually create an access policy if you are using the Cloud Console to manage VPC Service Controls. An access policy will be created for your Organization automatically.
Secure GCP resources with service perimeters._

2. Set up VPC accessible services to add additional restrictions to how services can be used inside your perimeters (optional).
3. Set up private connectivity from a VPC network (optional).
4. Grant access from outside a service perimeter using access levels (optional).
5. Set up resource sharing between perimeters using service perimeter bridges (optional).

![VPC Service Controls](https://cloud.google.com/static/vpc-service-controls/images/service_perimeter.png)

You can configure private communication to Google Cloud resources from VPC networks that span hybrid environments with Private Google Access [on-premise extensions](https://cloud.google.com/vpc-service-controls/docs/private-connectivity). A VPC network must be part of a service perimeter for VMs on that network to privately access managed Google Cloud resources within that service perimeter.

VMs with private IPs on a VPC Network that is part of a service perimeter cannot access managed resources outside the service perimeter. If necessary, you can continue to enable inspected and audited access to all Google APIs (for example, Gmail) over the internet.

The following diagram shows a service perimeter that extends to hybrid environments with Private Google Access:

![hybrid VPC Service Controls](https://cloud.google.com/static/vpc-service-controls/images/service_perimeter_private.png)

You can leverage Service Perimeter bridges to allow projects in different service perimeters to communicate. Perimeter Bridges are bidirectional, allow projects form each service perimeter equal access within the scope of the bridge.

[Creating a service perimeter](https://cloud.google.com/vpc-service-controls/docs/create-service-perimeters)

**gcloud - create vpc service perimeter**

```
gcloud access-context-manager perimeters create NAME \
  --title=TITLE \
  --resources=PROJECTS \
  --restricted-services=RESTRICTED-SERVICES \
  --ingress-policies=INGRESS-FILENAME.yaml \
  --egress-policies=EGRESS-FILENAME.yaml \
  [--access-levels=LEVELS] \
  [--enable-vpc-accessible-services] \
  [--vpc-allowed-services=ACCESSIBLE-SERVICES] \
  --policy=POLICY_NAME
```

In dry-run mode:

```
gcloud access-context-manager perimeters dry-run create NAME \
  --perimeter-title=TITLE \
  --perimeter-type=TYPE \
  --perimeter-resources=PROJECTS \
  --perimeter-restricted-services=RESTRICTED-SERVICES \
  --perimeter-ingress-policies=INGRESS-FILENAME.yaml \
  --perimeter-egress-policies=EGRESS-FILENAME.yaml \
  [--perimeter-access-levels=LEVELS] \
  [--perimeter-enable-vpc-accessible-services] \
  [--perimeter-vpc-allowed-services=ACCESSIBLE-SERVICES] \
  --policy=POLICY_NAME
```

Sample:
```
gcloud access-context-manager perimeters \
  dry-run create ProdPerimeter --perimeter-title="Production Perimeter" \
  --perimeter-type="regular" \
  --perimeter-resources=projects/12345,projects/67890 \
  --perimeter-restricted-services=storage.googleapis.com,bigquery.googleapis.com \
  --perimeter-ingress-policies=ingress.yaml \
  --perimeter-egress-policies=egress.yaml \
  --policy=330193482019
```

## 2.1.b Configuring load balancing (global, network, HTTP(s), SSL Proxy, and TCP Proxy)

A load balancer distributes user traffic across multiple instances of your applications. By spreading the load, load balancing reduces the risk that your applications become overburdened, slow, or nonfunctional.

![LB](images/lb-simple-overview.svg)

Types of LBs:
* Global LB
  * Use this when you backen servers are across multi regions / continents
  * Provides IPV6 termination
* Regional LB
  * Use when only One region is needed
  * Use when only IPV 4 termination is needed
* External load balancers:
  * distribute traffic coming from the internet to your Google Cloud Virtual Private Cloud (VPC) network. They are Global load balancing requires that you use the Premium Tier of Network Service Tiers. For regional load balancing, you can use Standard Tier.
* Internal load balancers distribute traffic to instances inside of Google Cloud network permimeter.

GC Cloud Load balancers is built on the following propretary products:

* [Google Front End(s)](https://cloud.google.com/security/infrastructure/design#google_front_end_service):
  * which are software-defined, distributed systems that are located in Google points of presence (PoPs) and perform global load balancing in conjunction with other systems and control planes.
  * smart reverse-proxy
  * provides public IP hosting of its public DNS name, Denial of Service (DoS) protection, and TLS termination
* [Andromeda](https://cloudplatform.googleblog.com/2014/04/enter-andromeda-zone-google-cloud-platforms-latest-networking-stack.html)
  * is Google Cloud's software-defined network virtualization stack.
* [Maglev](https://research.google/pubs/pub44824/)
  * which is a distributed system for Network Load Balancing
* [Envoy proxy](https://www.envoyproxy.io/)
  * is an open source edge and service proxy, designed for cloud-native applications

* Internal HTTP(s) Load Balancer (Layer 7)
  * built on the Andromeda network virtualization stack and is a managed service based on the open source Envoy proxy. This load balancer provides proxy-based load balancing of Layer 7 application data. You specify how traffic is routed with URL maps. The load balancer uses an internal IP address that acts as the frontend to your backends.
* External HTTP(s) Load Balancer (Layer 7)
  * is implemented on GFEs. GFEs are distributed globally and operate together using Google's global network and control plane. In Premium Tier, GFEs offer cross-regional load balancing, directing traffic to the closest healthy backend that has capacity and terminating HTTP(S) traffic as close as possible to your users.
  * Provides DDoS Protection
* Internal TCP/UDP Load Balancer (Layer 4)
  * is built on the Andromeda network virtualization stack. Internal TCP/UDP Load Balancing enables you to load balance TCP/UDP traffic behind an internal load balancing IP address that is accessible only to your internal virtual machine (VM) instances. By using Internal TCP/UDP Load Balancing, an internal load balancing IP address is configured to act as the frontend to your internal backend instances. You use only internal IP addresses for your load balanced service. Overall, your configuration becomes simpler.
  * supports regional managed instance groups so that you can autoscale across a region, protecting your service from zonal failures.
* External TCP/UDP Load Balancer (Layer 4)
  * Built on Maglev.
  * enables you to load balance traffic on your systems based on incoming IP protocol data, including address, port, and protocol type. It is a regional, non-proxied load balancing system. Use Network Load Balancing for UDP traffic, and for TCP and SSL traffic on ports that are not supported by the SSL proxy load balancer and TCP proxy load balancer. A network load balancer is a pass-through load balancer that does not proxy connections from clients.
* SSL Proxy Load Balancer (Layer 7)
  * intended for non-HTTP(S) traffic
  * Implemented on GFEs that are distributed globally.
  * If you choose the Premium Tier of Network Service Tiers, an SSL proxy load balancer is global. In Premium Tier, you can deploy backends in multiple regions, and the load balancer automatically directs user traffic to the closest region that has capacity. If you choose the Standard Tier, an SSL proxy load balancer can only direct traffic among backends in a single region.
  * Provides DDoS protection
  * Supports load balancing on ports:
    * 25, 43, 110, 143, 195, 443, 465, 587, 700, 993, 995, 1883, 3389, 5222, 5432, 5671, 5672, 5900, 5901, 6379, 8085, 8099, 9092, 9200, and 9300.
* TCP Proxy Load Balancer (Layer 4)
  * implemented on GFEs that are distributed globally. If you choose the Premium Tier of Network Service Tiers, a TCP proxy load balancer is global. In Premium Tier, you can deploy backends in multiple regions, and the load balancer automatically directs user traffic to the closest region that has capacity. If you choose the Standard Tier, a TCP proxy load balancer can only direct traffic among backends in a single region.

Choosing the right Cloud Load Balancer:
![Choose LB](images/choose-lb.svg)

[HTTP Load Balancer Lab](https://google.qwiklabs.com/focuses/12007?parent=catalog)
[Internal Load Balancer Lab](https://google.qwiklabs.com/focuses/1250?catalog_rank=%7B%22rank%22%3A1%2C%22num_filters%22%3A0%2C%22has_search%22%3Atrue%7D&parent=catalog&search_id=6735196)

#### SSL Policies
SSL policies give you the ability to control the features of SSL that your Google Cloud SSL proxy load balancer or external HTTP(S) load balancer negotiates with clients.

By default, HTTP(S) Load Balancing and SSL Proxy Load Balancing use a set of SSL features that provides good security and wide compatibility. Some applications require more control over which SSL versions and ciphers are used for their HTTPS or SSL connections. You can define SSL policies to control the features of SSL that your load balancer negotiates with clients.

The TLS versions currently supported are TLS 1.0, 1.1 and 1.2. SSL 3.0 or earlier is no longer supported by GCP Load Balancers or SSL Proxy.

There are three pre-configured Google Managed profiles which allow you to specify the level of compatibility that is appropriate for your application. A custom profile is also provided that allows you to select the SSL features you want manually.

Google Managed Profiles:
* **COMPATIBLE**:
  * allows the broadset of clients, including those which support only out-of-date SSL features, to negotiate SSL with the LB.
* **MODERN**:
  * Supports a wide set of SSL features, allowing modern clients to negotiate SSL.
* **RESTRICTED**:
  * Supports a reduced set of SSL features, intended to meet stricter compliance requirements.

The following table shows all the current features available that are supported for each pre-configured profiles.

![SSL Policy Features](images/SSL-Policy-Features-Pre-Configured.png)

**NOTE: If no SSL Policy is specified, the default SSL Policy is used which is equivalent to the _COMPATIBLE_ profile.**

Enabling an SSL Policy using `glcoud` command line tool:

```
gcloud compute ssl-policies create NAME \
    --profile COMPATIBLE|MODERN|RESTRICTED|CUSTOM \
    --global \
    [--min-tls-version 1.0|1.1|1.2] \
    [--custom-features FEATURES]
```

Using pre-defined (MODERN):
```
gcloud compute ssl-policies create my_ssl_policy \
    --global \
    --profile MODERN    \
    --min-tls-version 1.0
```

Using custom profile:
```
gcloud compute ssl-policies create NAME \
    --global \
    --profile CUSTOM --min-tls-version 1.2 \
    --custom-features "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256,"\
    "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256"
```

You can also create a target SSL Proxy or HTTPS proxy with an SSL Policy:

```
gcloud compute target-ssl-proxies | target-https-porxy create NAME \
    --backend-service BACKEND_SERVICE_NAME \
    --ssl-certificate SSL_CERTIFICATE_NAME \
    [--ssl-policy SSL_POLICY_NAME]
```

### Network Endpoint Groups (NEGs)
A _network endpoint group (NEG)_ is a configuration object which specifies a group of backend endpoints/services. HTTPs (internal/external) LBs and External SSL/TCP proxy LBs support NEGs.

NEG Types:

* Zonal
  * Contains one or more endpoints that can be compute engine vms or services running on the VMs.
  * Endpoints are specified via `IP:port` combo
* Internet
  * contains a single endpoint that is hosted outside of GCP.
  * specified by a hostname `FQDN:port` or `IP:port` combination.
* Serverless
  * points to Cloud Run, App Engine or Cloud Functions services
  * MUST reside in the same region

**Standalone NEGs**
When NEGs are deployed with load balancers provisioned by anything other than Ingress, they are considered standalone NEGs. Standalone NEGs are deployed and managed through the NEG controller, but the forwarding rules, health checks, and other load balancing objects are deployed manually.

Standalone NEGs do not conflict with Ingress enabled container-native load balancing.

The following diagram shows the difference in how the load balancing objects are deployed in each scenerio:
![Standalone NEGs](images/sneg2.svg)


## 2.1.c Configuring Cloud DNS & Identifying Domain Name System Security Extensions (DNSSEC)

## Cloud DNS & DNS Security
Cloud DNS is a high-performance, resilient, global Domain Name System (DNS) service that publishes your domain names to the global DNS in a cost-effective way.

DNS is a hierarchical distributed database that lets you store IP addresses and other data, and look them up by name. Cloud DNS lets you publish your zones and records in DNS without the burden of managing your own DNS servers and software.

Cloud DNS offers both public zones and private managed DNS zones. A public zone is visible to the public internet, while a private zone is visible only from one or more Virtual Private Cloud (VPC) networks that you specify. For detailed information about zones, see DNS zones overview.

Cloud DNS supports Identity and Access Management (IAM) permissions at the project level and individual DNS zone level (available in Preview). For information about how to set individual resource IAM permissions, see Create a zone with specific IAM permissions.

DNSSEC is a feature of the Domain Name System that authenticates responses to domain name lookups. It does not provide privacy protections for those lookups, but prevents attackers from manipulating or poisoning the responses to DNS requests.

**Terminalogy**
* Managed Zones:
  * This zone holds DNS records for the same DNS name suffix (example.com, for example). There can be multiple managed zones in a GCP project, but they all must have a unique name.In Cloud DNS, the managed zone is the resource that models a [DNS zone](https://en.wikipedia.org/wiki/DNS_zone). All records in a managed zone are hosted on the same Google-operated name servers. These name servers respond to DNS queries against your managed zone according to how you configure the zone.
* Public Zones:
  * This zone is visible to the internet. Cloud DNS has public authoritative name servers that respond to queries about public zones regardless of where the queries originate. You can create DNS records in a public zone to publish your service on the internet. For example, you might create the following record in a public zone example.com for your public web site www.example.com.

ex:
|DNS Name|Type|TTL (seconds)|Data|
|--------|-----|------------|-------|
|www.example.com|	A|	300	198.51.100.0|

Cloud DNS assigns a set of name servers when a public zone is created. For the DNS records in a public zone to be resolvable over the internet, you must update the name server setting of your domain registration at your registrar.

* Private Zones:
  * This zone enables you to manage custom domain names for your virtual machines, load balancers, and other Google Cloud resources without exposing the underlying DNS data to the public internet. A private zone is a container of DNS records that can only be queried by one or more VPC networks that you authorize. A private zone can only be queried by resources in the same project where it is defined. The VPC networks that you authorize must be located in the same project as the private zone. If you need to query records hosted in managed private zones in other projects, use DNS peering.
  * Private zones do not support DNS security extensions (DNSSEC) or custom resource record sets of type NS.

ex:
|DNS Name|	Type|	TTL (seconds)|	Data|
|--------|------|----------------|------|
|db-01.dev.gcp.example.com|	A|	5|	10.128.1.35|
|instance-01.dev.gcp.example.com|	A|	50|	10.128.1.10|
* Forwarding Zones:
  * A forwarding zone is a type of Cloud DNS managed private zone that sends requests for that zone to the IP addresses of its forwarding targets. For more information, see DNS forwarding methods.

For more details on Cloud DNS go [here](https://cloud.google.com/dns/docs/overview)

## Domain Name System Security Extensions (DNSSEC)
DNSSEC is a feature of the Domain Name System that authenticates responses to domain name lookups. It does not provide privacy protections for those lookups, but prevents attackers from manipulating or poisoning the responses to DNS requests.

DNSSec needs to be enabled in the following three places:

1. The DNS zone for your domain must serve special DNSSEC records for public keys (DNSKEY), signatures (RRSIG), and non-existence (NSEC, or NSEC3 and NSEC3PARAM) to authenticate your zone's contents. Cloud DNS manages this automatically if you [enable DNSSEC for a zone](https://cloud.google.com/dns/docs/dnssec-config#enabling).
2. The top-level domain registry (for example.com, this would be .COM) must have a DS record that authenticates a DNSKEY record in your zone. Do this by activating DNSSEC at your domain registrar.
3. For full DNSSEC protection, clients must use a DNS resolver that validates signatures for DNSSEC-signed domains. You can enable validation for individual systems or the local DNS resolvers (Refer to the appendices in this PDF guide). You can also configure systems to use public resolvers that validate DNSSEC, notably Google Public DNS and Verisign Public DNS.

You can enable DNSSec on Cloud DNS managed zones through the console window as well as throught the Command Line Interface(CLI) tools:

On an existing managed zone:
```
gcloud dns managed-zones update EXAMPLE_ZONE --dnssec-state on
```

At creation time:
```
gcloud dns managed-zones create EXAMPLE_ZONE \
    --description "Signed Zone" --dns-name myzone.example.com --dnssec-state on
```

### Verifying DNSSEC deployment
You can use [DNSViz](http://dnsviz.net/),the [Verisign DNSSEC debugger](http://dnssec-debugger.verisignlabs.com/), or [Zonemaster](https://zonemaster.net/) to verify correct deployment of your DNSSEC-enabled zone (the latter two can also be used before you update your registrar with your Cloud DNS name servers or DS record to activate DNSSEC). An example of a domain that is properly configured for DNSSEC is example.com; you can see it with DNSViz at http://dnsviz.net/d/www.example.com/dnssec/.

### dig Command
The `dig` command allows you to query information about various DNS records, including host addressses, mail exchanges, and name servers. Its mostly used by system adminstrators for troubleshooting DNS problems.

`$ dig linux.org`

Output:

![dig output](https://linuxize.com/post/how-to-use-dig-command-to-query-dns-in-linux/dig-command-output_hu636dcbe221bee3ee0ad79218c8886c5f_81144_768x0_resize_q75_lanczos.jpg)

More details on the dig command can be found [here](https://linuxize.com/post/how-to-use-dig-command-to-query-dns-in-linux/)

## 2.1.d Identifying differences between private versus public addressing

## 2.1.e Configuring web application firewall (Cloud Armour)


Google Cloud Armour helps you protect your Google Cloud deployments from multiple types of threats, including distributed denial-of-service (DDoS) attacks and application attacks like cross-site scripting (XSS) and SQL injection (SQLi). Google Cloud Armor features some automatic protections and some that you need to configure manually. This document provides a high-level overview of these features, several of which are only available for global external HTTP(S) load balancers and global external HTTP(S) load balancer (classic)s.

# Cloud Armour
Google Cloud Armor delivers defense at scale against infrastructure and application distributed denial of service (DDoS) attacks by using Google's global infrastructure and security systems.

Google Cloud Armour security policies are made up of rules that filter traffic based on layer 3, 4, and 7 attributes. For example, you can specify conditions that match on an incoming request's IP address, IP range, region code, or request headers. Security policies are available only for backend services behind an externall HTTP(s) Load Balancer, which can be in Premium or Standard Tier.

DDoS protection is automatically provided for HTTP(s), SSL Proxy and TCP Proxy Load Balancing.

Requirements for Cloud Armour Usage:
* Load Balancer **MUST** be an external HTTP(S) Load Balancer
* The backend service's load balancing scheme **MUST** be `EXTERNAL`.
* The backend service's protocol **MUST** be on of `HTTP`,`HTTPS` or `HTTP/2`

**IAM Permissions**:
![Cloud Armour IAM](images/cloud_armour_iam.png)

### Security Policies

External load balancing is implemented at the edge of Google's network in their [Points of presence (PoPs)](https://cloud.google.com/about/locations#network-tab), Cloud Armour security policies apply at the edge for external load balancers:

![GLB Cloud Armour](https://cloud.google.com/static/armor/images/ip-bl-wl-1.svg)

* Protect applications running behind a load balancer from DDoS and other web attacks
* Configured manually with configurable match conditions and actions
* Comes with preconfigured policies that cover a variety of uses Cases
* Backend Services can be either of the following:
  - [Instances Groups](https://cloud.google.com/compute/docs/instance-groups)
  - [Zonal network endpoint groups (NEGs)](https://cloud.google.com/load-balancing/docs/negs/zonal-neg-concepts)
  - [Serverless NEGs](https://cloud.google.com/load-balancing/docs/negs/serverless-neg-concepts)
    - One or more AppEngine, Cloud Run or Cloud Functions Services
  - [Internet NEGs](https://cloud.google.com/load-balancing/docs/negs/internet-neg-concepts)
  - Cloud Storage buckets
* Provides advanced network DDoS protection for External TCP/UDP network load balancer, protocol forwarding, and VMs with public IP addresses (BETA FEATURE)
  - https://cloud.google.com/armor/docs/advanced-network-ddos


Common uses cases : https://cloud.google.com/armor/docs/common-use-cases

#### Configuring Security Policies
You require either the `roles/compute.securityAdmin` or `roles/compute.networkAdmin` in order to configure Cloud Armour Security Policies:
* SecurityAdmin can access the following APIs:
  - SecurityPolicies insert, delete, patch, addRule, patchRule, removeRule
  - Configuring, modifying, updating, and deleting of Cloud Armour Security Policies
* NetworkAdmin can setup a Cloud Armour security policy for a backend service
  - Access the following APIs:
    - BackendServices setSecurityPolicy, list (gcloud only)

![Cloud Armour Sec Policies](images/Cloud_Armour_Policies.png)

The default rule is automatically assigned a priority of 2147483647 (INT-MAX) and it is always present in the Google Cloud Armor security policy. This rule CANNOT be deleted.

**Create the Cloud Armour Security policies**

Creating a Cloud Armour security Policy:

```
gcloud compute security-policies create [POLICY_NAME] --description [DESCRITPION]"
```

Update default rules to deny traffic:

```
gcloud compute security-policies rules update 2147483647 \
    --security-policy [POLICY_NAME] \
    --action "deny-404"|"deny-403"|"deny-502"
```

Add rules for specifiy valid IPv4/v6 CIDR IP ranges:

```
gcloud compute security-policies rules create 1000 \
    --security-policy [POLICY_NAME] \
    --description "allow traffic from 192.0.2.0/24" \
    --src-ip-ranges "192.0.2.0/24" \
    --action "allow"
```

Create a policy leveraging the advanced expression:

```
gcloud compute security-policies rules create 1000 \
   --security-policy my-policy \
   --expression "inIpRange(origin.ip, '1.2.3.4/32') && has(request.headers['user-agent']) && request.headers['user-agent'].contains('Godzilla')" \
   --action allow \
   --description "Block User-Agent 'Godzilla'"
```
```
gcloud compute security-policies rules create 1000 \
   --security-policy my-policy \
   --expression "origin.region_code == 'AU'" \
   --action "deny-403" \
   --description "AU block"
```


You can use the `--enable-layer7-ddos-defense` flag to enable [Adpative Protection](https://cloud.google.com/armor/docs/adaptive-protection-overview)

Add Rules
```
gcloud compute security-policies rules create 1000 \
    --security-policy mobile-clients-policy \
    --description "allow traffic from 192.0.2.0/24" \
    --src-ip-ranges "192.0.2.0/24" \
    --action "allow"
```

Attach the policy to a the backend service:
```
gcloud compute backend-services update games \
    --security-policy mobile-clients-policy
```

`--type=CLOUD_ARMOUR|CLOUD_ARMOUR_EDGE` is optional and defaults to `CLOUD_ARMOUR` which creates a backend security policy. `CLOUD_ARMOUR_EDGE` is used to create an edge policy.

**GKE BackendConfig**

Once a security policy is configured your can reference it using the `BackendConfig` kubernetes config.

```
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  namespace: cloud-armor-how-to
  name: my-backendconfig
spec:
  securityPolicy:
    name: "example-security-policy"
```

**Pre-Configured Rules**
You can also use the preconfigured rules that exist:

To view the pre-configured rules list :

`gcloud compute security-policies list-preconfigured-expression-sets`

Result:
```
    EXPRESSION_SET
sqli-canary
    RULE_ID
    owasp-crs-v030001-id942110-sqli
    owasp-crs-v030001-id942120-sqli
    …
xss-canary
    RULE_ID
    owasp-crs-v030001-id941110-xss
    owasp-crs-v030001-id941120-xss
…
sourceiplist-fastly
sourceiplist-cloudflare
sourceiplist-imperva
```

The output will display the list of rules that can be found [here](https://cloud.google.com/armor/docs/rule-tuning#preconfigured_rules).

### Rules language
Cloud Armour custom rules language is an extension of the [Common Expression Language (CEL)](https://github.com/google/cel-spec) and is used to write expressions for advanced matching conditions for security policy rules.

An expression requires two components:
  * _Attributes_ that can be inspected in rule expressions.
  * _Operations_ that can be performed on the attributes as part of an expression.

The following example creates a rate-based ban rule at priority 100 for each IP address whose requests match a header `fist` with value `tuna` and ban it for 300 seconds when its rate exceeds a limit of 50 requests for each 120 seconds. Banned requests return an error code of `404`.


**Tuning WAF Rules**

Each preconfigured rule consists of multiple signatures. Incoming requests are evaluated against the preconfigured rules. A request matches a preconfigured rule if the request matches any of the signatures that are associated with the preconfigured rule. A match is made when the `evaluatePreconfiguredExpr()` command returns the value `true`.

If you decide that a preconfigured rule matches more traffic than is necessary or if the rule is blocking traffic that needs to be allowed, the rule can be tuned to disable noisy or otherwise unnecessary signatures. To disable signatures in a particular preconfigured rule, you provide a list of IDs of the unwanted signatures to the `evaluatePreconfiguredExpr()` command. The following example excludes two CRS rule IDs from the preconfigured `xss-stable` WAF rule:

```
evaluatePreconfiguredExpr('xss-stable', ['owasp-crs-v020901-id981136-xss', 'owasp-crs-v020901-id981138-xss'])
```

The following command adds a rule that uses a pre-configured expression set to mitigate SQLi attacks:
```
gcloud compute security-policies rules create 1000 \
   --security-policy my-policy \
   --expression "evaluatePreconfiguredExpr('sqli-stable')" \
   --action "deny-403"
```

Attach the policy to backend services
```
gcloud compute backend-services update [BACKEND_SERVICE_NAME] --security-policy [POLICY_NAME]
```

Two kinds of match conditions:
* basic contains list of ips or ip ranges
* advanced contains expressions written using an extension of the [Common Expression Language (CEL)](https://github.com/google/cel-spec)


```
gcloud compute security-policies rules create 100 \
    --security-policy=sec-policy     \
    --expression="request.headers['fish'] == 'tuna'" \
    --action=rate-based-ban                   \
    --rate-limit-threshold-count=50           \
    --rate-limit-threshold-interval-sec=120   \
    --ban-duration-sec=300           \
    --conform-action=allow           \
    --exceed-action=deny-404         \
    --enforce-on-key=IP
```

The following example creates a rate-based ban rule at priority 101 to limit all requests whose region code matches `US` to 10 requests per 60 seconds. The rule also bans requests from the US region for 300 seconds when their rate exceeds a limit of 1000 requests per 600 seconds. Banned requests return an error code of `403`.

```
gcloud compute security-policies rules create 101 \
   --security-policy sec-policy     \
   --expression "origin.region_code == 'US'" \
   --action rate-based-ban                 \
   --rate-limit-threshold-count 10         \
   --rate-limit-threshold-interval-sec 60  \
   --ban-duration-sec 300           \
   --ban-threshold-count 1000       \
   --ban-threshold-interval-sec 600 \
   --conform-action allow           \
   --exceed-action deny-403         \
   --enforce-on-key ALL
```

You can use `--src-ip-ranges="*"` to setup a rule that applies to any source IP address range.

You can also issue rate-based bans for users who have a valid reCAPTCHA exemption cookie. For example, the following gcloud command creates a throttle rule at priority 115 with a rate limit of 20 requests per 5 minutes for each unique reCAPTCHA exemption cookie across all requests that have a valid reCAPTCHA exemption cookie. Requests that exceed the throttling limit are redirected for reCAPTCHA Enterprise assessment. For more information about exemption cookies and reCAPTCHA Enterprise assessment, see the [bot management overview](https://cloud.google.com/armor/docs/bot-management)

```
gcloud compute security-policies rules create 115 \
    --security-policy sec-policy     \
    --expression="token.recaptcha_exemption.valid"     \
    --action=throttle                \
    --rate-limit-threshold-count=20 \
    --rate-limit-threshold-interval-sec=300 \
    --conform-action=allow           \
    --exceed-action=redirect         \
    --exceed-redirect-type=google-recaptcha         \
    --enforce-on-key=HTTP-COOKIE         \
    --enforce-on-key-name="recaptcha-ca-e"
```

Other sec policy examples can be found [here](https://cloud.google.com/armor/docs/configure-security-policies)

### Cloud Armour Tiers

|  Feature   | Cloud Armour Standard | Managed Protection Plus |
| ---------- | ----------------------| ----------------------- |
| Billing method | Pay-as-you-go   | Monthly subscription + Data Processing Fee (see [pricing](https://cloud.google.com/armor/pricing))   |
|DDoS Attack Protection   | HTTP(s) Load Balancing, External TCP / SSL Proxy Load Balancing   | HTTP(s) Load Balancing, External TCP / SSL Proxy Load Balancing   |
| WAF   | Per policy, per rule, pre request (see [Pricing](https://cloud.google.com/armor/pricing))   |  Included with Plus subscription |
| Resource Limits   | Up to quota limits   | Up to quota limits   |
|Preconfigured WAF rules   | Yes   | Yes   |
|Time commitment   | N/A  | One year   |
|Named IP address list   | No   | Yes   |
|Threat Intelligence (Preview)  | No   | Yes   |
|Adaptive Protection   | Alerting only   | Yes  |
|DDoS response support   | N/A   | Yes (w/ Premium support)   |
|DDoS bill protection   | N/A   | Yes   |


### Distributed Denial of Service Attacks (DDoS) Mitigation

A Denial of Service (DoS) attack is an attempt to render your service or application unavailable to your end users.

With Distributed Denial of Service (DDoS) attacks, the attackers use multiple resources (often a large number of compromised hosts/instances) to orchestrate large scale attacks against targets.

Mitigation Best Practices:
* **Reduce the attack surface for GCE Deployment**:
  * Provision with in isolated VPCs leveraging the best practices [here](https://cloud.google.com/docs/enterprise/best-practices-for-enterprise-organizations#define-your-network)
  * Isolate and secure deployment using vpcs, subnets, firewall rule tag, IAMs
  * Open access to only the ports and protocols you need and disable those that you dont using firewall rules and/or [protocol forwarding](https://cloud.google.com/compute/docs/protocol-forwarding/)
* **Isolate you internal traffice from the external world**
  * Deploy instances without public IPs unless necessary
  * set a NAT gateway or SSH Bastion host to limit the number of instances that are exposed to the internet
  * Deploy internal Load Balancers for internal clietn instances accessing internally deployed services
* **DDoS Proectection By Enabling Proxy-based Load Balancing**
  * SSL Proxy Or HTTP(s) Load Balancing mitigates and absorbs many Layer 4 and below attacks, such as SYN floods, IP fragment floods, ports exhaustion, etc
* **Scale to absorbe the attack**
  * With Google Cloud Global Load Balancing, the frontend infrastructure which terminates user traffic, automatically scales to absorb certain types of attacks (e.g., SYN floods) before they reach your compute instances.
  * _Anycast-based Load Balancing_:
    * HTTP(S) and SSL Proxy enable a single anycast IP to front-end you deployed instances in all regions to increase the surface area to absorb any attacks.
    * _Autoscaling_:
      * Provision sufficient number of instances and/or configure autoscaling to handle traffic spikes.
* **Protection with CDN Offloading**:
  * Google Cloud CDN acts as a proxy between your clients and your origin servers. For cacheable content, Cloud CDN caches and services this content from points-of-presence (POPs) closer to your users as opposed to sending them to backend servers (instances). In the event of DDoS attack for cacheable content, the requests are sent to POPs all over the globe as opposed to your origin servers, thereby providing a larger set of locations to absorb the attack.
  * If CDN interconnect is used, you can leverage additional DDoS protection provided by GCPs CDN Interconnect partners.
* **Deploy third-party DDoS protection solutions**:
  * DDoS protection solutions are offered by GCP partners such as CloudFlare, F5 Networks, Fortinet, etc.
  * DDoS protection solutions are available via the [Google Cloud Marketplace](http://console.cloud.google.com/marketplace/browse?q=DDoS)
  * GCP Cloud Armour offers DDoS Protection
* **App Engine Deployment**:
  * Designed to be a multi-tenant system and has safeguards to ensure a bad app will not impact performance or availability of other applications on the platform
  * Sits behind Google Front-Ends which mitigate and absorbes DDoS attacks
  * Use a [dos.yaml](https://cloud.google.com/appengine/docs/standard/python/config/dos) to block unwanted IPs/IP networks from access the app.
* **Google Cloud Storage**:
  * Used signed URLs
* Use Identity Aware Proxy (IAP)
* Use API Management (Cloud Endpoints, Apigee):
  * Request Limits
  * Control API Access
  * Monitor API Usage

### Labs

[HTTP Loadbalancer with Cloud Armour](https://www.qwiklabs.com/focuses/1232?parent=catalog)

**Using Cloud Armour with Serverless apps**

Cloud Armour can be by-passed IF the user has the default URL for the Cloud Function. To mitigate this risk, us the `internal-and-gclb` when you configure Cloud Functions, which will allows only internal traffic and traffic sent to a public IP address exposed by the external HTTP(s) LB. Traffic sent to `cloudfunctions.net` or any custom domain setup through Cloud Functions is blocked.

### Monitoring
Cloud Armour logs are exported to Cloud Monitoring, which can be used to monitor and check whether policies are working as intended.


</details>

<details>
<summary>2.2 Configuring Network Segmentation</summary>

## 2.2.a - Configuring security properties of a VPC network, VPC peering, Shared VPC and firewall rules

### Firewalls
Virtual Private Cloud (VPC) firewall rules apply to a given project and network. You can create a [Firewall Policy](https://cloud.google.com/vpc/docs/firewall-policies) that can be applied accross the orgranization.

VPC firewall rules let you allow or deny connections to or from your virtual machine (VM) instances based on a configuration that you specify. Enabled VPC firewall rules are always enforced, protecting your instances regardless of their configuration and operating system, even if they have not started up.

Every VPC network functions as a distributed firewall. While firewall rules are defined at the network level, connections are allowed or denied on a per-instance basis. You can think of the VPC firewall rules as existing not only between your instances and other networks, but also between individual instances within the same network.

In addition to firewall rules that you create, Google Cloud has other rules that can affect incoming (ingress) or outgoing (egress) connections:

* Google Cloud doesn't allow certain IP protocols, such as egress traffic on TCP port 25 within a VPC network.
* Google Cloud always allows communication between a VM instance and its corresponding metadata server at 169.254.169.254.
* Every network has **two implied firewall rules that permit outgoing connections and block incoming connections**. Firewall rules that you create can override these implied rules. These implied rules apply to all instances in the network.
* The default network is pre-populated with firewall rules that you can delete or modify.

Firewall rules only support IPv4 connections.

To create a firewall rule use the following command:

```
gcloud compute firewall-rules create NAME \
    [--network NETWORK; default="default"] \
    [--priority PRIORITY;default=1000] \
    [--direction (ingress|egress|in|out); default="ingress"] \
    [--action (deny | allow )] \
    [--target-tags TAG,TAG,...] \
    [--target-service-accounts=IAM Service Account,IAM Service Account,...] \
    [--source-ranges CIDR-RANGE,CIDR-RANGE...] \
    [--source-tags TAG,TAG,...] \
    [--source-service-accounts=IAM Service Account,IAM Service Account,...] \
    [--destination-ranges CIDR-RANGE,CIDR-RANGE...] \
    [--rules (PROTOCOL[:PORT[-PORT]],[PROTOCOL[:PORT[-PORT]],...]] | all ) \
    [--disabled | --no-disabled] \
    [--enable-logging | --no-enable-logging] \
    [--logging-metadata logging_metadata]
```

Use the parameters as follows. More details about each are available in the SDK reference documentation.

* `--network`:
  * The network where the rule will be created. If omitted, the rule will be created in the default network. If you don't have a default network or want to create the rule in a specific network, you must use this field.
* `--priority`:
  * A numerical value that indicates the priority for the rule. The lower the number, the higher the priority. A rule with a priority of 1 is evaluated first. Priorities must be unique for each rule. A good practice is to give rules priority numbers that allow later insertion (such as 100, 200, 300).
* `--direction`:
  * The direction of traffic, either ingress or egress.
* `--action`:
  * The action on match, either allow or deny. Must be used with the `--rules` flag.
* Specify a target in one of three ways:
  * Omit `--target-tags` and `--target-service-accounts` if the rule should apply to all targets in the network.
  * `--target-tags` Use this flag to define targets by network tags.
  * `--target-service-accounts` Use this flag to define targets by associated service accounts.
* For an ingress rule, specify a source:
  * Omit `--source-ranges`, `source-tags`, and `--source-service-accounts` if the ingress source should be everywhere, 0.0.0.0/0.
  * `--source-ranges` Use this flag to specify ranges of source IP addresses in CIDR format.
  * `--source-tags` Use this flag to specify source instances by network tags. Filtering by source tag is only available if the target is not specified by service account. For more information, see filtering by service account vs. network tag.
  * `--source-ranges` and `--source-tags` can be used together. If both are specified, the effective source set is the union of the source range IP addresses and the instances identified by network tags, even if the tagged instances do not have IPs in the source ranges.
  * `--source-service-accounts` Use this flag to specify instances by the service accounts they use. Filtering by source service account is only available if the target is not specified by network tag. For more information, see [filtering by service account vs. network tag](https://cloud.google.com/vpc/docs/firewalls#service-accounts-vs-tags). `--source-ranges` and `--source-service-accounts` can be used together. If both are specified, the effective source set is the union of the source range IP addresses and the instances identified by source service accounts, even if the instances identified by source service accounts do not have IPs in the source ranges.
* For an egress rule, specify a destination:
  * Omit `--destination-ranges` if the egress destination should be anywhere, 0.0.0.0/0.
  * `--destination-ranges` Use this flag to specify ranges of destination IP addresses in CIDR format.
* `--rules`:
  *  A list of protocols and ports to which the rule will apply. Use all to make the rule applicable to all protocols and all ports. Requires the `--action` flag.
* By default, firewall rules are created and enforced automatically; however, you can change this behavior.
  * If both `--disabled` and `--no-disabled` are omitted, the firewall rule is created and enforced.
  * `--disabled` :
    * Add this flag to create the firewall rule but not enforce it. The firewall rule will remain in a disabled state until you update the firewall rule to enable it.
  * `--no-disabled`:
    * Add this flag to ensure the firewall rule is enforced.
* `--enable-logging` | `--no-enable-logging` :
  * You can enable Firewall Rules Logging for a rule when you create or update it. Firewall Rules Logging allows you audit, verify, and analyze the effects of your firewall rules. See [Firewall Rules Logging](https://cloud.google.com/vpc/docs/firewall-rules-logging) for details.
* `--logging-metadata`:
  * If you enable logging, by default, Firewall Rules Logging includes base and metadata fields. You can omit metadata fields to save storage costs.

To update a firewall rule use the following command:
```
gcloud compute firewall-rules update NAME \
    [--priority=PRIORITY] \
    [--description=DESCRIPTION] \
    [--target-tags=TAG,...] \
    [--target-service-accounts=IAM Service Account, ...] \
    [ --source-ranges=CIDR-RANGE, ...] \
    [--source-tags=TAG,...] \
    [--source-service-accounts=IAM Service Account, ...] \
    [--destination-ranges=CIDR-RANGE, ...] \
    [--rules=[PROTOCOL[:PORT[-PORT]],…]] \
    [--disabled | --no-disabled] \
    [--enable-logging | --no-enable-logging]
```

#### GCP Allows Blocked Traffic
The following is network traffic that is allways blocked by GCP and firewall rules **CANNOT** unblock them:

|Blocked Traffic| Applies To|
|---------------|-----------|
| GRE Traffic| all sources, all destinations, including among instances using internal ip addresses, unless explicitly allowed through protocol forwarding|
| Protocols other than than TCP, UDP, ICMP, and IPIP| Traffic between: * instances and the internet * instances if they are addressed with external IPs * instances if a load balancer with an external IP is involved |
| Egress Traffic on TCP port 25 (SMTP) | Traffic From: * instances to the internet * instances to other instances addressed by external IPs |
| Egress Traffic on TCP port 465 or 587 (SMTP over SSL/TLS) | Traffic from: * instances to the internet, except for traffic destined for known Google SMTP Servers * instances to other instances addressed by external IPs |


**Filter by service account vs network tag**
If you need strict control over how firewall rules are applied to VMs, use target service accounts and source service accounts instead of target tags and source tags:
  * A network tag is an arbitrary attribute. One or more network tags can be associated with an instance by any Identity and Access Management (IAM) member who has permission to edit it. IAM members with the Compute Engine Instance Admin role to a project have this permission. IAM members who can edit an instance can change its network tags, which could change the set of applicable firewall rules for that instance.
  * A service account represents an identity associated with an instance. Only one service account can be associated with an instance. You control access to the service account by controlling the grant of the Service Account User role for other IAM members. For an IAM member to start an instance by using a service account, that member must have the Service Account User role to at least that service account and appropriate permissions to create instances (for example, having the Compute Engine Instance Admin role to the project).

You cannot mix filtering by service account or network tags.

[Configure VPC Firewall Lab](https://docs.google.com/document/d/1RWck9O9sJt6SqI1l8o9-aih2UPwLmp6dQQFbvoWmNwM/edit#heading=h.2g4x5d8r4egh)

#### Hierarchial Firewall Rules/Policies

Hierarchical firewall policies let you create and enforce a consistent firewall policy across your organization. You can assign hierarchical firewall policies to the organization as a whole or to individual folders. These policies contain rules that can explicitly deny or allow connections, as do Virtual Private Cloud (VPC) firewall rules. In addition, hierarchical firewall policy rules can delegate evaluation to lower-level policies or VPC network firewall rules with a goto_next action.

Lower-level rules cannot override a rule from a higher place in the resource hierarchy. This lets organization-wide admins manage critical firewall rules in one place.

**Specifications**

* Hierarchical firewall policies are created at organization and folder nodes. Creating a policy does not automatically apply the rules to the node.
* Policies, once created, can be applied to (associated with) any nodes in the organization.
* Hierarchical firewall policies are containers for firewall rules. When you associate a policy with the organization or a folder, all rules are immediately applied. You can swap policies for a node, which atomically swaps all the firewall rules applied to virtual machine (VM) instances under that node.
* Rule evaluation is hierarchical based on resource hierarchy. All rules associated with the organization node are evaluated, followed by those of the first level of folders, and so on.
* Hierarchical firewall policy rules have a new goto_next action that you can use to delegate connection evaluation to lower levels of the hierarchy.
* Hierarchical firewall policy rules can be targeted to specific VPC networks and VMs by using target resources for networks and target service accounts for VMs. This lets you create exceptions for groups of VMs. Hierarchical firewall policy rules do not support targeting by instance tags.
* Each hierarchical firewall policy rule can include either IPv4 or IPv6 ranges, but not both.
* To help with compliance and debugging, firewall rules applied to a VM instance can be audited by using the VPC network details page and the VM instance's network interface details page.

By default, all hierarchical firewall policy rules apply to all VMs in all projects under the organization or folder where the policy is associated. However, you can restrict which VMs get a given rule by specifying target networks or target service accounts.

![Hierarchial FW Policy](https://cloud.google.com/static/vpc/images/firewall-policies/hfw-1.svg)

Hierarchical firewall policies containing rules (yellow boxes) are applied at the organization and folder levels. VPC firewall rules are applied at the VPC network level.

### VPC Peering
Google Cloud VPC Network Peering allows internal IP address connectivity across two Virtual Private Cloud (VPC) networks regardless of whether they belong to the same project or the same organization.

VPC Network Peering enables you to connect VPC networks so that workloads in different VPC networks can communicate internally. Traffic stays within Google's network and doesn't traverse the public internet.

VPC Network Peering is useful for:

* SaaS (Software-as-a-Service) ecosystems in Google Cloud. You can make services available privately across different VPC networks within and across organizations.
* Organizations with several network administrative domains can peer with each other.

VPC Network Peering gives you several advantages over using external IP addresses or VPNs to connect networks, including:

* Network Latency:
  * Connectivity that uses only internal addresses provides lower latency than connectivity that uses external addresses.
* Network Security:
  * Service owners do not need to have their services exposed to the public Internet and deal with its associated risks.
* Network Cost:
  * Google Cloud charges egress bandwidth pricing for networks using external IPs to communicate even if the traffic is within the same zone. If however, the networks are peered they can use internal IPs to communicate and save on those egress costs. Regular network pricing still applies to all traffic.

**Peering is NOT supported for legacy networks.**

Only directly peered networks can communicate. Transitive peering is not supported. In other words, if VPC network N1 is peered with N2 and N3, but N2 and N3 are not directly connected, VPC network N2 cannot communicate with VPC network N3 over VPC Network Peering.

At the time of peering, Google Cloud checks to see if there are any subnets with overlapping IP ranges between the two VPC networks or any of their peered networks. If there is an overlap, peering is not established. Since a full mesh connectivity is created between VM instances, subnets in the peered VPC networks can't have overlapping IP ranges as this would cause routing issues.

![network peering](images/network-peering-11.svg)

For more details on VPC Peering go [here](https://cloud.google.com/vpc/docs/vpc-peering)

[VPC Peering Lab](https://www.qwiklabs.com/focuses/964?parent=catalog)

### Shared VPC
Shared VPC allows an organization to connect resources from multiple projects to a common Virtual Private Cloud (VPC) network, so that they can communicate with each other securely and efficiently using internal IPs from that network. When you use Shared VPC, you designate a project as a host project and attach one or more other service projects to it. The VPC networks in the host project are called Shared VPC networks. [Eligible resources](https://cloud.google.com/vpc/docs/shared-vpc#resources_that_can_be_attached_to_shared_vpc_networks_from_a_service_project) from service projects can use subnets in the Shared VPC network.

**Shared VPC Admin**
Shared VPC Admins have the Compute Shared VPC Admin `compute.xpnAdmin` and Project IAM Admin `resourcemanager.projectIamAdmin` roles for the organization or one or more folders. They perform various tasks necessary to set up Shared VPC, such as enabling host projects, attaching service projects to host projects, and delegating access to some or all of the subnets in Shared VPC networks to Service Project Admins. A Shared VPC Admin for a given host project is typically its project owner as well.
A user assigned the Compute Shared VPC Admin role for the organization has that role for all folders in the organization. A user assigned the role for a folder has that role for the given folder and any folders nested underneath it. A Shared VPC Admin can link projects in two different folders only if the admin has the role for both folders.

**Service Project Admins**
When defining each Service Project Admin, a Shared VPC Admin can grant permission to use the whole host project or just some subnets:

* Project-level permissions:
  * A Service Project Admin can be defined to have permission to use all subnets in the host project if the Shared VPC Admin grants the role of `compute.networkUser` for the whole host project to the Service Project Admin. The result is that the Service Project Admin has permission to use all subnets in all VPC networks of the host project, including subnets and VPC networks added to the host project in the future.
  * https://cloud.google.com/vpc/docs/provisioning-shared-vpc#networkuseratproject

* Subnet-level permissions:
  * Alternatively, a Service Project Admin can be granted a more restrictive set of permissions to use only some subnets if the Shared VPC Admin grants the role of `compute.networkUser` for those selected subnets to the Service Project Admin. A Service Project Admin who only has subnet-level permissions is restricted to using only those subnets. After new Shared VPC networks or new subnets are added to the host project, a Shared VPC Admin should review the permission bindings for the compute.networkUser role to ensure that the subnet-level permissions for all Service Project Admins match the intended configuration.
  * https://cloud.google.com/vpc/docs/provisioning-shared-vpc#networkuseratsubnet

**Network and Security Admins**
Shared VPC Admins (`compute.xpnAdmin` and `resourcemanager.projectIamAdmin`) have full control over the resources in the host project, including administration of the Shared VPC network. They can optionally delegate certain network administrative tasks to other IAM members:
* Network Admin (`compute.networkAdmin`):
  * Shared VPC Admin define a Network Admin by granting an IAM member the Network Admin `compute.networkAdmin` role to the host project. Network Admins have full control over all network resources except for firewall rules and SSL certificates. The network admin role does not allow a user to create, start, stop, or delete instances
* Network User (`compute.networkUser`):
  * Can use VPC networks and subnets that belong to the host project (Shared VPC). For example, a network user can create a VM instance that belongs to a host project network but they cannot delete or create new networks in the host project.
* Network Viewer (`compute.networkViewer`):
  * Read-only access to all networking resources.
* Security Admin (`compute.securityAdmin`):
  * A Shared VPC Admin can define a Security Admin by granting an IAM member the Security Admin `compute.securityAdmin` role to the host project. Security Admins manage firewall rules and SSL certificates.

**Project Structure**
Shared VPC connects projects within the same organization. Participating host and service projects cannot belong to different organizations. Linked projects can be in the same or different folders, but if they are in different folders the admin must have Shared VPC Admin rights to both folders. Refer to the Google Cloud resource hierarchy for more information about organizations, folders, and projects.

A project that participates in a Shared VPC can be either:

* a **_host_** project:
  * contains one or more Shared VPC networks. A Shared VPC Admin must first enable a project as a host project. After that, a Shared VPC Admin can attach one or more service projects to it.
* a **_service_** project:
  * is any project that has been attached to a host project by a Shared VPC Admin. This attachment allows it to participate in Shared VPC. It's a common practice to have multiple service projects operated and administered by different departments or teams in your organization.

* Project-level permissions:
  * A Service Project Admin can be defined to have permission to use all subnets in the host project if the Shared VPC Admin grants the role of `compute.networkUser` for the whole host project to the Service Project Admin. The result is that the Service Project Admin has permission to use all subnets in all VPC networks of the host project, including subnets and VPC networks added to the host project in the future.
* Subnet-level permissions:
  * Alternatively, a Service Project Admin can be granted a more restrictive set of permissions to use only some subnets if the Shared VPC Admin grants the role of `compute.networkUser` for those selected subnets to the Service Project Admin. A Service Project Admin who only has subnet-level permissions is restricted to using only those subnets. After new Shared VPC networks or new subnets are added to the host project, a Shared VPC Admin should review the permission bindings for the `compute.networkUser` role to ensure that the subnet-level permissions for all Service Project Admins match the intended configuration.

## 2.2.b - Configuring network isolation and data encapsulation for N tier application design

If you want complete isolation between various applications, customers, etc., you could create multiple networks.

![multiple vpc](images/multiple-networks-1024x646.png)

You can have up to five networks per project, including the default network. Multiple networks within a single project can provide multi-tenancy, IP overlap, or isolation within the project itself. Just another option instead of having multiple projects.

## 2.2.c - Configuring app-to-app security policy

### VPC
Leverage firewall rules using tags, or specific service accounts with fine grained access.

Allow traffic from specific networks


### App Engine Security Best Practices

Leverage Identity-Aware Proxy (IAP) for limiting access to specific users [Configure IAP For GAE](https://www.qwiklabs.com/focuses/5562?parent=catalog#).
* Use internal for G-Suite accounts
* Use External for G-Mail accounts

**HTTPS Requests**
Use HTTPS requests to access to your App Engine app securely. Depending on how your app is configured, you have the following options:
* default service:
  * https://[PROJECT_ID].[REGION_ID].r.appspot.com
* specific service
  * https://[VERSION_ID]-dot-[SERVICE_ID]-dot-[PROJECT_ID].[REGION_ID].r.appspot.com

You can force HTTPS all the time by leveraging _Handlers_ within the application YAML configuration as shown below:

```
runtime: go112 # replace with go111 for Go 1.11
service: test-app
handlers:
- url: /.*
  script: auto
  secure: always
  redirect_http_response_code: 301

```
**Access Control**
Leverage IAM Access to restrict or grant access to App Engine. Assign roles to either service accounts or users.

IAM Roles:
* App Engine Admin:
  * R/W/M all app configs and settings
  * Use cases:
    * Owner/Admin
    * On-call engineer
    * Sys Admin
* App Engine Service Admin:
  * R/O access to app configs/settings
  * Write access to service-level and version-level settings, including traffic configs.
  * Cannot deploy
  * Use Cases:
    * Release Engineer
    * DevOps
    * On-call engineer
    * Sys Admin
* App Engine Deployer
  * R/O to all app configs and settings
  * Write access only to deploy and create new versions
  * Delete Old versions that are not serving traffic
  * Cannot modify and existing version, nor change traffic configs
  * Use Cases:
    * Deployment account
    * Release engineer
* App Engine View
  * R/O to all app configs and settings
  * Use Cases:
    * Need visibility into app but no need to modify
    * Audit type of role for compliance checking
* App Engine Code Viewer
  * R/O to all app configs, settings and deployed source code
  * Use Cases:
    * Need visibility into the app and its source code but not modify it
    * DevOps User needing to diagnose prod issues.

**App Engine Firewall**
Enables you to control access to your App Engine app through a set of rules that can either allow or deny requests from the specified ranges of IP addresses.

[Controlling App Access with Firewalls](https://cloud.google.com/appengine/docs/standard/go/creating-firewalls)

**Ingress Controls**
By default, your App Engine app receives all HTTP requests that are sent to its appspot URL or to a custom domain that you have configured for your app. For apps in the flexible environment, this includes requests from the internet as well as requests from a Virtual Private Cloud network that you can create in your app's Google Cloud project. Apps in the standard environment do not receive requests from a Virtual Private Cloud (VPC).

Use App Engine firewalls see https://cloud.google.com/appengine/docs/legacy/standard/python/application-security

### Anthos Service mesh

https://cloud.google.com/service-mesh/docs/security/anthos-service-mesh-security-best-practices




</details>

<details>
<summary> 2.3 Establishing private connectivity</summary>

## 2.3.a - Designing and configuring private RFC1918 connectivity between VPC networks and Google Cloud Projects (Shared VPC, VPC peering)

## 2.3.b - Designing and configuring RFC1918 connectivity between data centers and VPC network (IPSec and Cloud Interconnect)


### Cloud VPN
Cloud VPN securely connects your peer network to your Virtual Private Cloud (VPC) network through an [IPsec](https://wikipedia.org/wiki/IPsec) [VPN](https://wikipedia.org/wiki/Virtual_private_network) connection.

Traffic traveling between the two networks is encrypted by one VPN gateway, and then decrypted by the other VPN gateway. This protects your data as it travels over the internet. You can also connect two instances of Cloud VPN to each other.

![IPSec VPN](images/IPSec%20VPN.png)

Offers an SLA of 99.9% service availability. Supports Static Routes or Dynamic Routes (with the use of a Cloud Router). Supports IKEv1 and IKEv2 (Internet Key Exchange) using a shared secret (IKE pre-shared key).

Cloud VPN traffic will either traverse the public internet or can use a direct peering line to Google's Network (Cloud Interconnect).

Each _Cloud VPN_ can support up to 3 GBs when traffic is traversing a direct peering link, or 1.5 Gps when its traversing over the public internet.

**VPN with Static Routes**
![VPN Static Routes](images/VPN_Static_Routes.png)

**VPN with Dynamic Routes using Cloud Router**
![VPN Dynamic Routes](images/VPN_Dynamic_Routes.png)

New subnets in GCP or in the Peer network are discovered and shared, enabling connectivity between the two peers for both entire networks. No restart required.

Two types of configuration
* VPN Gateway:
  * A virtual VPN gateway running in Google Cloud managed by Google, using a configuration that you specify in your project, and used only by you. Each Cloud VPN gateway is a regional resource that uses one or more regional external IP addresses. A Cloud VPN gateway can connect to a peer VPN gateway.
* HA (High Availability) or Classic VPN
  * HA:
    * Supports only BGP (Border Gateway Protocol) Routing
    * External IPs created from a pool. No forwarding rules required.
    * Provides a 99.99% SLA when configured with two interfaces and two external IPs
* Classic:
  * External IPs and forwarding rules must be created
  * Static Routing (policy based, route based) or Dynamic Routing using Cloud Router with Border Gateway Protocol (BGP)
  * Provides a 99.99% SLA

### Cloud Interconnect
Network Connectivity provides two options for extending your on-premises network to your VPC networks in Google Cloud. You can create a dedicated connection (Dedicated Interconnect) or use a service provider (Partner Interconnect) to connect to VPC networks. When choosing an interconnect type, consider your connection requirements, such as the connection location and capacity.

Cloud Interconnect provides low latency, high availability connections that enable you to reliably transfer data between you on-premise network and GCP VPC Networks.

Types:
* Dedicated Interconnect:
  * A direct connection to Google.
  * Traffic flows directly between networks, not through the public internet.
  * Availble in 10 Gbps or 100 Gbps circuits with flexible interconnect attachment (VLAN) capacities from 50 Mbps to 50 Gbps.
  * BGP must be configured on your on-prem routers as well as Cloud Routers
  * Google Provides end-to-end SLA
* Partner Interconnect:
  * More points of connectivity through one of our supported service providers.
  * Traffic flows between networks through a service provider, not through the public internet.
  * Flexible capacities from 50 Mbps to 50 Gbps.
  * For layer 2 connections, BGP must be configured on your on-prem routers and Cloud Routers
  * For Layer 3 connections, the configurations of Cloud Routers and their peers is fully automated.
  * Google provides and SLA between Google Network and the Service Provider. E2E SLA depends on the Service Provider.

Choosing the right connection:
![Choose Cloud Interconnect](images/choose-interconnect.png)

## 2.3.c - Establishing private connectivity between VPC and Google APIs (Private Google Access, Private Google Access for on-premises hosts, Private Service Connect)

### Private Google API Access
Private Google API Access enables Compute Engine instances on a VPC subnet to reach
Google APIs and services using an internal IP address rather than an external IP address. Previously, you had to provide a public path for your internal Compute Engine instances (for example, an external IP address or a NAT gateway) to allow the instances to access Google APIs.

With Private Google Access, an API call is resolved to a public IP address, but the traffic is all internal and private. Network address translation is in Google's infrastructure and is transparent
to the user.

If Private Google Access is not enabled, an organization requires an external IP address to communicate with Google APIs. Although the communication is encrypted, this IP address can increase an organization’s risk by unnecessarily exposing its network to the internet.

When Private Google Access is enabled, VM instances in a subnet can reach the above APIs and services without needing an external IP address. Instead, VMs can use their internal IP addresses to access Google managed services.

Instances with external IP addresses are not affected when you enable the ability to access Google services from internal IP addresses. These instances can still connect to Google APIs and managed services.

The Cloud and Developer APIs and services that can be reached include, but are not limited to, the following:
* BigQuery
* Cloud Bigtable
* Container Registry
* Cloud Dataproc
* Cloud Datastore
* Cloud Pub/Sub
* Cloud Spanner
* Cloud Storage

Private Google Access does not apply to Cloud SQL. You do not get private connectivity to Cloud SQL when you use Private Google Access.

Private Goolge API access is enabled on VPC subnets but is disabled by default. You add this feature to your projects when you create a subnetwork or by modifying an existing subnetwork.

You must also ensure that any Compute Engine instance that accesses a Google API has a matching `default-internet-gateway` route set in its GCP-based network. All GCP networks have a `default-internet-gateway` route, unless the route has been manually deleted.

[Private Google Access and Cloud NAT Lab](https://www.qwiklabs.com/focuses/4362?parent=catalog)

* private.googleapis.com (199.36.153.8/3)
  * Enables API access to most Google APIs and services regardless of whether they are supported by VPC Service Controls. Includes API access to Maps, Google Ads, Google Cloud platform, and most other Google APIs, including the lists below. Does not support G Suite web applications.
  * Use private.googleapis.com to access Google APIs and services using a set of IP addresses only routable from within Google Cloud. Choose private.googleapis.com under these circumstances:
  * You don't use VPC Service Controls.
  * You do use VPC Service Controls, but you also need to access Google APIs and services that are not supported by VPC Service Controls.
* restricted.googleapis.com (199.36.153.4/30)
  * Use restricted.googleapis.com to access Google APIs and services using a set of IP addresses only routable from within Google Cloud. Choose restricted.googleapis.com when you only need access to Google APIs and services that are supported by VPC Service Controls — restricted.googleapis.com does not permit access to Google APIs and services that do not support VPC Service Controls.

#### Private Google Access to on-premises hosts

Private Google Access for on-premises hosts provides a way for on-premises systems to connect to Google APIs and services by routing traffic through a Cloud VPN tunnel or a VLAN attachment for Cloud Interconnect. Private Google Access for on-premises hosts is an alternative to connecting to Google APIs and services over the internet.

[Configuring Private Google Access for on-prem hosts](https://cloud.google.com/vpc/docs/configure-private-google-access-hybrid)

### Serverless VPC Access

Serverless VPC Access enables you to connect from a serverless environment on Google Cloud (Cloud Run (fully managed), Cloud Functions, or the App Engine standard environment) directly to your VPC network. This connection makes it possible for your serverless environment to access Compute Engine VM instances, Memorystore instances, and any other resources with an internal IP address. For example, this can be helpful in the following cases:

* You use Memorystore to store data for a serverless service.
* Your serverless workloads use third-party software that you run on a Compute Engine VM.
* You run a backend service on a Managed Instance Group in Compute Engine and need your serverless environment to communicate with this backend without exposure to the public internet.
* Your serverless environment needs to access data from your on-premises database through Cloud VPN.

Connection to a VPC network enables your serverless environment to send requests to internal DNS names and internal IP addresses as defined by RFC 1918 and RFC 6598. These internal addresses are only accessible from Google Cloud services. Using internal addresses avoids exposing resources to the public internet and improves the latency of communication between your services.

#### Serverless VPC Access Connector
Serverless VPC Access is based on a resource called a connector. A connector handles traffic between your serverless environment and your VPC network. When you create a connector in your Google Cloud project, you attach it to a specific VPC network and region. You can then configure your serverless services to use the connector for outbound network traffic.

When you create a connector, you also assign it an IP range. Traffic sent through the connector into your VPC network will originate from an address in this range. The IP range must be a CIDR /28 range that is not already reserved in your VPC network. An implicit firewall rule with priority 1000 is created on your VPC network to allow ingress from the connector's IP range to all destinations in the network.

Serverless VPC Access automatically provisions throughput for a connector in 100 Mbps increments depending on the amount of traffic sent through the connector. Automatically provisioned throughput can only scale up and does not scale down. A connector always has at least 200 Mbps provisioned and can scale up to 1000 Mbps. You can configure throughput scaling limits when you create a connector; note that actual throughput through a connector may exceed the provisioned throughput, especially for short traffic bursts.

IAM Roles:

* Serverless VPC Access Admin
  * `roles/vpcaccess.admin`
  * Full access to all Serverless VPC Access resources
* Serverless VPC Access User
  * `roles/vpcaccess.user`
  * User of Serverless VPC Access connectors
* Serverless VPC Access Viewer
  * `roles/vpcaccess.viewer`
  * Viewer of all Serverless VPC Access resources

![Serverless VPC Access](images/serverless-vpc-access.svg)

To enable this feature you need to enable the API:

```
gcloud services enable vpcaccess.googleapis.com
```

To create the connector:

```
gcloud compute networks vpc-access connectors create [CONNECTOR_NAME] \
--network [VPC_NETWORK] \
--region [REGION] \
--range [IP_RANGE]
```

[Configure VPC Access for CLoud Run](https://cloud.google.com/run/docs/configuring/connecting-vpc)
[Configure VPC Access for Cloud Functions](https://cloud.google.com/functions/docs/connecting-vpc)
Configure VPC Access for App Engine Standard](https://cloud.google.com/appengine/docs/standard/python/connecting-vpc)

### Private Service Connect

Private Service Connect allows private consumption of services across VPC networks that belong to different groups, teams, projects, or organizations. You can publish and consume services using IP addresses that you define and that are internal to your VPC network.

You can use Private Service Connect to access Google APIs and services, or managed services in another VPC network.

By default, if you have an application that uses a Google service, such as Cloud Storage, your application connects to the default DNS name for that service, such as `storage.googleapis.com`. Even though the IP addresses for the default DNS names are publicly routable, traffic sent from Google Cloud resources remains within Google's network.

With Private Service Connect, you can create private endpoints using global internal IP addresses within your VPC network. You can assign DNS names to these internal IP addresses with meaningful names like `storage-vialink1.p.googleapis.com` and `bigtable-adsteam.p.googleapis.com`. These names and IP addresses are internal to your VPC network and any on-premises networks that are connected to it using Cloud VPN tunnels or VLAN attachments. You can control which traffic goes to which endpoint, and can demonstrate that traffic stays within Google Cloud.

This option gives you access to all Google APIs and services that are included in the API bundles. If you need to restrict access to only certain APIs and services, Private Service Connect with consumer HTTP(S) service controls allows you to choose which APIs and services are made available, for supported regional service endpoints.

For more information about Private Service Connect configurations for accessing Google APIs, see use cases.

![Private Service Connect](https://cloud.google.com/static/vpc/images/private-service-connect-overview.svg)

This can also be used setup service endpoints for third part consumers to connect to applications behind an internal load balancer, as per [documentation](https://cloud.google.com/vpc/docs/private-service-connect#benefits-controls).

More details can be found [here](https://cloud.google.com/vpc/docs/private-service-connect).

* All APIs (all-apis): most Google APIs (same as private.googleapis.com).
* VPC-SC (vpc-sc): APIs that VPC Service Controls supports (same as restricted.googleapis.com).

IAM Roles required for using Private Service Connect:

To Create a service endpoint:
  * Compute Network Admin (`roles/compute.networkAdmin`)
  * Service Directory Editor (`roles/servicedirectory.editor`)
  * DNS Administrator (`roles/dns.admin`)

To configure google private access:
  * Compute Network Admin (`roles/compute.networkAdmin`)


**Setup Google Private Access for a subnet**

```
gcloud compute networks subnets update SUBNET_NAME \
--region=REGION \
--enable-private-ip-google-access
```

**Setup Private Service Connect**

```
gcloud compute addresses create ADDRESS_NAME \
  --global \
  --purpose=PRIVATE_SERVICE_CONNECT \
  --addresses=ENDPOINT_IP \
  --network=NETWORK_NAME
```

```
gcloud compute forwarding-rules create ENDPOINT_NAME \
  --global \
  --network=NETWORK_NAME \
  --address=ADDRESS_NAME \
  --target-google-apis-bundle=API_BUNDLE \
  [ --service-directory-registration=REGION_NAMESPACE_URI ]
```




## 2.3.d - Configuring Cloud NAT

Cloud NAT (network address translation) allows Google Cloud virtual machine (VM) instances without external IP addresses and private Google Kubernetes Engine (GKE) clusters to send outbound packets to the internet and receive any corresponding established inbound response packets.

Cloud NAT is a distributed, software-defined managed service. It's not based on proxy VMs or appliances. Cloud NAT configures the [Andromeda software](https://cloudplatform.googleblog.com/2014/04/enter-andromeda-zone-google-cloud-platforms-latest-networking-stack.html) that powers your VPC network so that it also provides source network address translation (SNAT) for VMs without external IP addresses. Cloud NAT also provides destination network address translation (DNAT) for established inbound response packets.

![traditional nat vs cloud nat](images/trad-nat-v-cloud-nat.svg)

Cloud NAT implements outbound NAT in conjunction with static routes in your VPC whose next hops are default internet gateway. In a basic configuration, a default route in your VPC network meets this requirement.

Cloud NAT does not implement unsolicited inbound connections from the internet. DNAT is only performed for packets that arrive as responses to outbound packets.

Types:
* **Public NAT**
  * Enables private resources (no public ips) to access the internet
  * Shares a pool of pub IPs assigning them as needed for secure outbound connections
* **Private NAT**
  * Facilitates private comms between different networks
  * Inter-VPC NAT:
    * Translates address between VPCs conencted to a central hub

**Creating a Cloud Router**

NOTE the Cloud Router MUST be in the same region as the instance using  Cloud NAT


```
gcloud compute routers create nat-router \
    --network custom-network1 \
    --region us-east4
```

Add a NATS configuration to the router:

```
gcloud compute routers nats create nat-config \
    --router-region us-east4 \
    --router nat-router \
    --nat-all-subnet-ip-ranges \
    --auto-allocate-nat-external-ips \
    --enable-logging
```


</details>

# Section 3 Ensuring data protection
<details>
<summary> 3.1 - Protecting sensitive data </summary>

## 3.1.a - Inspecting and redacting personally identifiable information (PII)

### Cloud Data Loss Prevention (DLP)
With over [120 built-in infoTypes](https://cloud.google.com/dlp/docs/infotypes-reference), Cloud DLP gives you the power to scan, discover, classify, and report on data from virtually anywhere. Cloud DLP has native support for scanning and classifying sensitive data in Cloud Storage, BigQuery, and Datastore and a streaming content API to enable support for additional data sources, custom workloads, and applications.

Cloud DLP using _information types - infoTypes_ to define what it scans. An `infoType` can be any type of sensitive data such as : age, email, credit card number.

A list of _built-in infoTypes_ can be found [here](https://cloud.google.com/dlp/docs/infotypes-reference).

Cloud DLP also allows you to define you own _custom infoType detector_ and will use this type to inspect and de-identify sensitive information that matches the pattern specified by this custom type.

There are three types of custom infoType detectors:

* _Regular custom dictionary detectors_:
  * simple words or phrases that Cloud DLP uses to match on.
  * use this type when you have a few hundred thousand words.
* _Stored custom dictionary detectors_:
  * generate by Cloud DLP from datasets stored in BigQuery or Cloud Storage.
  * Upto ten million words/phrases
* _Regular expressions(regex) detectors_:
  * enables matching on regex expression pattern

You can also _fine tune_ the scan results using _inspection rules_.

* _Exclusion rules_:
  * excluding false or unwanted findings
* _Hotword rules_:
  * increase the quantity or accuracy of findings returned by adding rules to a built-in or custom infoType detector.

Likelihood is determined by the number of mathcing elements a result contains:

* LIKELYHOOD_UNSPECIFIED
* VERY_UNLIKELY
* UNLIKELY
* POSSIBLE
* LIKELY
* VERY_LIKELY

**Custom infoType Example**

```
POST https://dlp.googleapis.com/v2/projects/[PROJECT_ID]/content:inspect?key={YOUR_API_KEY}

{
  "item":{
    "value":"Patients MRN 444-5-22222"
  },
  "inspectConfig":{
    "customInfoTypes":[
      {
        "infoType":{
          "name":"C_MRN"
        },
        "regex":{
          "pattern":"[1-9]{3}-[1-9]{1}-[1-9]{5}"
        },
        "likelihood":"POSSIBLE"
      }
    ]
  }
}
```

## De-Identification

Process of removing identifying information from data. The DLP API detects sensitive data such as personally identifiable information (PII) and then uses a de-identification transformation to mask, delete, or otherwise obscure the data.

The API uses the following methods for de-identification:

* Date Shifting
  - Randomly shift a set of dates but preserves the sequence and duration of a period of time
  - Done in context to an individual or an entity
  - Each individual's dates are shifted by and amount of time that is unique to that individual
* Generalization and Bucketing
  - Process of taking a distinguishing value and abstracting it into a more general, les distinguishing value
  - Attempts to preserve data utility while also reducing the identifiability of the data
  - DLP supports a generalization technique called _bucketing_
  - Group records into smaller buckets

## Authentication
* API Key:
  * Typically used when applications need Cloud DLP via REST API, which can be created via the [GCP Console](https://support.google.com/cloud/answer/6158862)
  * The key is past to the REST API via the `key` parameter:
    * `curl https://dlp.googleapis.com/v2/infoTypes?key=[YOUR_API_KEY]`
* Tokens using Service Accounts:
  * If the user is calling the API directly then `Bearer Token` should be used
    * Bearer Token:
      * Auth: `gcloud auth activate-service-account --key-file [KEY_FILE]`
      * Get Token: `gcloud auth print-access-token`
      * Use Token:
        `curl -s -H 'Content-Type: application/json' -H 'Authorization: Bearer [ACCESS_TOKEN]' 'https://dlp.googleapis.com/v2/infoTypes'`
  * If using the GCloud Client Libraries to call the Cloud DLP Api then `Application Default Credentials` SHOULD be used.
    * `export GOOGLE_APPLICATION_CREDENTIALS=[PATH_TO_KEY_FILE]`

## Content Related Mitigations
Mitigating data misuse, privacy violations, and handling sensitive, restricted, or unacceptable content is accomplished by following a three step process.

1. Classifying content
   * Using Cloud Natural Language API
     * classifies content into categories along with a confidence score
2. Scanning and redacting content
    * Scann all documents using Data Loss Prevention API for sensitive data before publication
    * Redact any sensitive data
3. Detecting unacceptable content
   * Using Video Intelligence API for monitoring and scanning of videos
   * Data Loss Prevention API can be used to detect sensitive data content before it is accidentially exposed to the public

### Redaction
Using the DLP REST api you can redact content based on configurations provided:

**Inspect**:
```
curl -s \
  -H "Authorization: Bearer [ACCESS_TOKEN]" -H "Content-Type: application/json" \
  https://dlp.googleapis.com/v2/projects/$PROJECT_ID/content:inspect \
  -d @[JSON_REQUEST]
```
This method will inspect the request json for any sensitive information based on the `infoTypes` provided in the `inspectConfig`.

Sample Request:
```
{
  "item":{
    "value":"My phone number is (206) 555-0123."
  },
  "inspectConfig":{
    "infoTypes":[
      {
        "name":"PHONE_NUMBER"
      },
      {
        "name":"US_TOLLFREE_PHONE_NUMBER"
      }
    ],
    "minLikelihood":"POSSIBLE",
    "limits":{
      "maxFindingsPerItem":0
    },
    "includeQuote":true
  }
}
```

Sample Response:

The response will return details about any infoTypes found in the text with a `liklyhood` value, which a category of how likely the text matched, and `offset` information, which is the location of the data within the text.

```
{
  "result": {
    "findings": [
      {
        "quote": "(206) 555-0123",
        "infoType": {
          "name": "PHONE_NUMBER"
        },
        "likelihood": "LIKELY",
        "location": {
          "byteRange": {
            "start": "19",
            "end": "33"
          },
          "codepointRange": {
            "start": "19",
            "end": "33"
          }
        },
        "createTime": "2018-07-03T02:20:26.043Z"
      }
    ]
  }
}
```

**DeIdentify**
**_redactConfig_**
This method will redact/remove the data in the request `item` the matches the provided `infoType` value in  the`inspectConfig`.

```
curl -s \
  -H "Authorization: Bearer [ACCESS_TOKEN]" -H "Content-Type: application/json" \
  https://dlp.googleapis.com/v2/projects/$PROJECT_ID/content:deidentify \
  -d @[REQUEST]
```

Sample Request:
```
{
  "item": {
     "value":"My email is test@gmail.com",
   },
   "deidentifyConfig": {
     "infoTypeTransformations":{
          "transformations": [
            {
              "primitiveTransformation": {
                "redactConfig": {

                }
              }
            }
          ]
        }
    },
    "inspectConfig": {
      "infoTypes": {
        "name": "EMAIL_ADDRESS"
      }
    }
}
```
Sample Response:

```
{
  "item": {
    "value": "My email is "
  },
  "overview": {
    "transformedBytes": "14",
    "transformationSummaries": [
      {
        "infoType": {
          "name": "EMAIL_ADDRESS"
        },
        "transformation": {
          "replaceWithInfoTypeConfig": {}
        },
        "results": [
          {
            "count": "1",
            "code": "SUCCESS"
          }
        ],
        "transformedBytes": "14"
      }
    ]
  }
}
```

**_replaceConfig_**
The basic replacement transformation (ReplaceValueConfig in the DLP API) replaces detected sensitive data values with a value that you specify. For example, suppose you've told Cloud DLP to use "[fake@example.com]" to replace all detected EMAIL_ADDRESS infoTypes, and the following string is sent to Cloud DLP

```
POST https://dlp.googleapis.com/v2/projects/[PROJECT_ID]/content:deidentify?key={YOUR_API_KEY}

{
  "item":{
    "value":"My name is Alicia Abernathy, and my email address is aabernathy@example.com."
  },
  "deidentifyConfig":{
    "infoTypeTransformations":{
      "transformations":[
        {
          "infoTypes":[
            {
              "name":"EMAIL_ADDRESS"
            }
          ],
          "primitiveTransformation":{
            "replaceConfig":{
              "newValue":{
                "stringValue":"[email-address]"
              }
            }
          }
        }
      ]
    }
  },
  "inspectConfig":{
    "infoTypes":[
      {
        "name":"EMAIL_ADDRESS"
      }
    ]
  }
}
```

Sample Response:
```
{
  "item":{
    "value":"My name is Alicia Abernathy, and my email address is [email-address]."
  },
  "overview":{
    "transformedBytes":"22",
    "transformationSummaries":[
      {
        "infoType":{
          "name":"EMAIL_ADDRESS"
        },
        "transformation":{
          "replaceConfig":{
            "newValue":{
              "stringValue":"[email-address]"
            }
          }
        },
        "results":[
          {
            "count":"1",
            "code":"SUCCESS"
          }
        ],
        "transformedBytes":"22"
      }
    ]
  }
}
```

**_replaceWithInfoTypeConfig_**
This transformation does the same thing as basic replacement, above, but it replaces the matched data with the value specified detected `infoType` value.

Using `characterMaskConfig` you can partially or completely mask the result of the detective sensitive data by replacing the value with a fixed single character, such as (asterisk)`*` or (hash)`#`.

Sample:

```
POST https://dlp.googleapis.com/v2/projects/[PROJECT_ID]/content:deidentify?key={YOUR_API_KEY}

{
  "item":{
    "value":"My name is Alicia Abernathy, and my email address is aabernathy@example.com."
  },
  "deidentifyConfig":{
    "infoTypeTransformations":{
      "transformations":[
        {
          "infoTypes":[
            {
              "name":"EMAIL_ADDRESS"
            }
          ],
          "primitiveTransformation":{
            "characterMaskConfig":{
              "maskingCharacter":"#",
              "reverseOrder":false,
              "charactersToIgnore":[
                {
                  "charactersToSkip":".@"
                }
              ]
            }
          }
        }
      ]
    }
  },
  "inspectConfig":{
    "infoTypes":[
      {
        "name":"EMAIL_ADDRESS"
      }
    ]
  }
}
```

Sample Response:
```
{
  "item":{
    "value":"My name is Alicia Abernathy, and my email address is ##########@#######.###."
  },
  "overview":{
    "transformedBytes":"22",
    "transformationSummaries":[
      {
        "infoType":{
          "name":"EMAIL_ADDRESS"
        },
        "transformation":{
          "characterMaskConfig":{
            "maskingCharacter":"#",
            "charactersToIgnore":[
              {
                "charactersToSkip":".@"
              }
            ]
          }
        },
        "results":[
          {
            "count":"1",
            "code":"SUCCESS"
          }
        ],
        "transformedBytes":"22"
      }
    ]
  }
}
```

DLP offers other forms of transformations that leverages encryption keys to encrypt any detected sensitive data, they are as follows:

* [Cryptographic Hashing](https://cloud.google.com/dlp/docs/transformations-reference#crypto-hashing)
  * Leverages SHA-256 based message authentication code on the input and replaces it with a hashed Base64 encode value.
  * This process is a one way hash change
* [Format Preserving encryption](https://cloud.google.com/dlp/docs/transformations-reference#fpe)
  * Leverages the [format-preserving encryption](https://en.wikipedia.org/wiki/Format-preserving_encryption) with [FFX mode](http://www.connect-community.org/blog/2016/4/28/ffx-modes-of-the-aes-encryption-algorithm-specified-in-nists-sp-800-38g) enabled to generate a token value and replaces detective sensitive data in the input. The token is same length as in the input value and uses the same alphabet. By leverage the additional `surrogateInfoType` element the token can be _re-Identified_ using the original encryption key.
* [Deterministic encryption](https://cloud.google.com/dlp/docs/transformations-reference#de)
  * Leverages [AES in Synthetic Initialization Vector Mode (AES-SIV)](https://tools.ietf.org/html/rfc5297) to generate a token value and replaces detective sensitive data found in the input. By leverage the additional `surrogateInfoType` element the token can be _re-Identified_ using the original encryption key.

Labs:

[Data Loss Prevention - Quick Lab](https://google.qwiklabs.com/focuses/600?catalog_rank=%7B%22rank%22%3A3%2C%22num_filters%22%3A0%2C%22has_search%22%3Atrue%7D&parent=catalog&search_id=6768410)

[Redacting Confidential Data within your pipelines in Cloud Data Fusion using Cloud DLP](https://www.qwiklabs.com/focuses/12373?catalog_rank=%7B%22rank%22%3A1%2C%22num_filters%22%3A0%2C%22has_search%22%3Atrue%7D&parent=catalog&search_id=6763461)

**Inspection Rules**
This helps refine the scan results that Cloud DLP returns by modifying the detection mechanism of a given infoType detector.

If you want to exclude or include more values from the results that are returned by a built-in infoType detector, you can create a new custom infoType from scratch and define all the criteria that Cloud DLP should look for.

There are two types of inspection rules:

* _Exclusion rules_:
  * help exclude false or unwanted findings
* _Hotword rules_:
  * help detect additional findings

Samples:

Exclusion Rules:
```
...
    "inspectConfig":{
      "ruleSet":[
        {
          "infoTypes":[
            {
              "name":"EMAIL_ADDRESS"
            }
          ],
          "rules":[
            {
              "exclusionRule":{
                "dictionary":{
                  "wordList":{
                    "words":[
                      "example@example.com"
                    ]
                  }
                },
                "matchingType": "MATCHING_TYPE_FULL_MATCH"
              }
            }
          ]
        }
      ]
    }
...
```

Or using regex patterns

```
...
    "inspectConfig":{
      "ruleSet":[
        {
          "infoTypes":[
            {
              "name":"EMAIL_ADDRESS"
            }
          ],
          "rules":[
            {
              "exclusionRule":{
                "regex":{
                  "pattern":".+@example.com"
                },
                "matchingType": "MATCHING_TYPE_FULL_MATCH"
              }
            }
          ]
        }
      ]
    }
...

```

You can also exclude specific infoTypes:

```
...
    "inspectConfig":{
      "infoTypes":[
        {
          "name":"DOMAIN_NAME"
        },
        {
          "name":"EMAIL_ADDRESS"
        }
      ],
      "customInfoTypes":[
        {
          "infoType":{
            "name":"EMAIL_ADDRESS"
          },
          "exclusionType":"EXCLUSION_TYPE_EXCLUDE"
        }
      ],
      "ruleSet":[
        {
          "infoTypes":[
            {
              "name":"DOMAIN_NAME"
            }
          ],
          "rules":[
            {
              "exclusionRule":{
                "excludeInfoTypes":{
                  "infoTypes":[
                    {
                      "name":"EMAIL_ADDRESS"
                    }
                  ]
                },
                "matchingType": "MATCHING_TYPE_PARTIAL_MATCH"
              }
            }
          ]
        }
      ]
    }
...
```

Hotword rules:

* You want to change likelihood values assigned to scan matches based on the match's proximity to a hotword. For example, you want to set the likelihood value higher for matches on patient names depending on the names' proximity to the word "patient."

```
...
  "inspectConfig":{
    "ruleSet":[
      {
        "infoTypes":[
          {
            "name":"PERSON_NAME"
          }
        ],
        "rules":[
          {
            "hotwordRule":{
              "hotwordRegex":{
                "pattern":"patient"
              },
              "proximity":{
                "windowBefore":50
              },
              "likelihoodAdjustment":{
                "fixedLikelihood":"VERY_LIKELY"
              }
            }
          }
        ]
      }
    ],
    "minLikelihood":"VERY_LIKELY"
  }
...
```

## Storage Scans
Cloud DLP supports scan data stored in Cloud Storage, Datastore and BigQuery.
When scanning data in Cloud Storage it supports scanning: binary, text, image, Word, PDF, and Apache Avro files.

Cloud DLP initiates a job that inspects the data at the give storage location.

Best practices:
* Choose data initially that poses the highest risk
* Cloud DLP MUST be able to access the data, service accounts and vpc service controls!
* Limit scope instead of all data. Use sampling and exclusion rules.
* Avoid using all infoTypes if they are not needed
* Schedule scans regularly. Scans will only inspect data since last scan

Findings can be persisted to BigQuery for later analysis.

Sample

Scanning data in Cloud Storage:
```
POST https://dlp.googleapis.com/v2/projects/[PROJECT-ID]/dlpJobs?key={YOUR_API_KEY}

{
  "inspectJob":{
    "storageConfig":{
      "cloudStorageOptions":{
        "fileSet":{
          "url":"gs://[BUCKET-NAME]/*"
        },
        "bytesLimitPerFile":"200",
        "fileTypes":[
          "TEXT_FILE"
        ],
        "filesLimitPercent":90,
        "sampleMethod": "RANDOM_START"
      },
      "timespanConfig":{
        "startTime":"2017-11-13T12:34:29.965633345Z",
        "endTime":"2018-01-05T04:45:04.240912125Z"
      }
    },
    "inspectConfig":{
      "infoTypes":[
        {
          "name":"PHONE_NUMBER"
        }
      ],
      "excludeInfoTypes":false,
      "includeQuote":true,
      "minLikelihood":"LIKELY"
    },
    "actions":[
      {
        "saveFindings":{
          "outputConfig":{
            "table":{
              "projectId":"[PROJECT-ID]",
              "datasetId":"[DATASET-ID]"
            },
            "outputSchema":"BASIC_COLUMNS"
          }
        }
      }
    ]
  }
}
```

For scanning Datastore use the `datastoreOptions` in the `storageConfig` element.

```
"inspectJob":{
    "storageConfig":{
      "datastoreOptions":{
        "kind":{
          "name":"Example-Kind"
        },
        "partitionId":{
          "namespaceId":"[NAMESPACE-ID]",
          "projectId":"[PROJECT-ID]"
        }
      }
    },
```

For scanning BigQuery use the `bigQueryOptions`:

```
"storageConfig":{
      "bigQueryOptions":{
        "tableReference":{
          "projectId":"[PROJECT-ID]",
          "datasetId":"[BIGQUERY-DATASET-NAME]",
          "tableId":"[BIGQUERY-TABLE-NAME]"
        },
        "rowsLimit": "1000",
        "sampleMethod": "RANDOM_START",
        "identifyingFields":[
          {
            "name":"person.contactinfo"
          }
        ]
      },
```


## 3.1.b - Configuring pseudonymization

Pseudonymization is a de-identification technique that replaces sensitive data values with cryptographically generated tokens. Pseudonymization is widely used in industries like finance and healthcare to help reduce the risk of data in use, narrow compliance scope, and minimize the exposure of sensitive data to systems while preserving data utility and accuracy.

Pseudonymization techniques enable either one-way or two-way tokens. A one-way token has been transformed irreversibly, while a two-way token can be reversed. Because the token is created using symmetric encryption, the same cryptographic key that can generate new tokens can also reverse tokens. For situations in which you don't need reversibility, you can use one-way tokens that use secure hashing mechanisms.

Cloud DLP supports three pseudonymization techniques for de-identification, and generates tokens by applying one of the three cryptographic transformation methods below to original sensitive data values:

**Deterministic encryption using AES-SIV**
An input value is replaced with a value that has been encrypted using the [AES-SIV](https://tools.ietf.org/html/rfc5297), Advanced Encryption Standard in Synthetic Initialization Vector mode, encryption algorithm with a cryptographic key, encoded using base64, and then prepended with a surrogate annotation, if specified. This method produces a hashed value, so it does not preserve the character set or the length of the input value. Encrypted, hashed values can be re-identified using the original cryptographic key and the entire output value, including surrogate annotation. Learn more about [the format of values tokenized using AES-SIV encryption](https://cloud.google.com/dlp/docs/pseudonymization#aes-siv).

```
{
  "item": {
    "value": "My name is Alicia Abernathy, and my email address is aabernathy@example.com."
  },
  "deidentifyConfig": {
    "infoTypeTransformations": {
      "transformations": [
        {
          "infoTypes": [
            {
              "name": "EMAIL_ADDRESS"
            }
          ],
          "primitiveTransformation": {
            "cryptoDeterministicConfig": {
              "cryptoKey": {
                "kmsWrapped": {
                  "cryptoKeyName": "projects/PROJECT_ID/locations/global/keyRings/dlp-keyring/cryptoKeys/dlp-key",
                  "wrappedKey": "WRAPPED_KEY"
                }
              },
              "surrogateInfoType": {
                "name": "EMAIL_ADDRESS_TOKEN"
              }
            }
          }
        }
      ]
    }
  },
  "inspectConfig": {
    "infoTypes": [
      {
        "name": "EMAIL_ADDRESS"
      }
    ]
  }
}
```

Re-identify request:

```
{
  "reidentifyConfig":{
    "infoTypeTransformations":{
      "transformations":[
        {
          "infoTypes":[
            {
              "name":"EMAIL_ADDRESS_TOKEN"
            }
          ],
          "primitiveTransformation":{
            "cryptoDeterministicConfig":{
              "cryptoKey":{
              "kmsWrapped": {
                "cryptoKeyName": "projects/PROJECT_ID/locations/global/keyRings/dlp-keyring/cryptoKeys/dlp-key",
                "wrappedKey": "WRAPPED_KEY"
              }
            },
              "surrogateInfoType":{
                "name":"EMAIL_ADDRESS_TOKEN"
              }
            }
          }
        }
      ]
    }
  },
  "inspectConfig":{
    "customInfoTypes":[
      {
        "infoType":{
          "name":"EMAIL_ADDRESS_TOKEN"
        },
        "surrogateType":{

        }
      }
    ]
  },
  "item":{
    "value": "My name is Alicia Abernathy, and my email address is TOKEN."
  }
}
```

[Demo](https://cloud.google.com/dlp/docs/inspect-sensitive-text-de-identify)
**Format preserving encryption**
An input value is replaced with a value that has been encrypted using the [FPE-FFX](https://en.wikipedia.org/wiki/Format-preserving_encryption) encryption algorithm with a cryptographic key, and then prepended with a surrogate annotation, if specified. By design, both the character set and the length of the input value are preserved in the output value. Encrypted values can be re-identified using the original cryptographic key and the entire output value, including surrogate annotation. (For some important considerations around using this encryption method, see [Format preserving encryption](https://cloud.google.com/dlp/docs/pseudonymization#fpe-ffx))

```
{
  "item": {
    "value": "My name is Alicia Abernathy, and my email address is aabernathy@example.com."
  },
  "deidentifyConfig": {
    "infoTypeTransformations": {
      "transformations": [
        {
          "infoTypes": [
            {
              "name": "EMAIL_ADDRESS"
            }
          ],
          "primitiveTransformation": {
            "crypto_replace_ffx_fpe_config": {
              "cryptoKey": {
                "kmsWrapped": {
                  "cryptoKeyName": "projects/PROJECT_ID/locations/global/keyRings/dlp-keyring/cryptoKeys/dlp-key",
                  "wrappedKey": "WRAPPED_KEY"
                }
              },
              "surrogateInfoType": {
                "name": "EMAIL_ADDRESS_TOKEN"
              }
            }
          }
        }
      ]
    }
  },
  "inspectConfig": {
    "infoTypes": [
      {
        "name": "EMAIL_ADDRESS"
      }
    ]
  }
}
```
Re-identify request:

```
{
  "reidentifyConfig":{
    "infoTypeTransformations":{
      "transformations":[
        {
          "infoTypes":[
            {
              "name":"EMAIL_ADDRESS_TOKEN"
            }
          ],
          "primitiveTransformation":{
            "crypto_replace_ffx_fpe_config":{
              "cryptoKey":{
              "kmsWrapped": {
                "cryptoKeyName": "projects/PROJECT_ID/locations/global/keyRings/dlp-keyring/cryptoKeys/dlp-key",
                "wrappedKey": "WRAPPED_KEY"
              }
            },
              "surrogateInfoType":{
                "name":"EMAIL_ADDRESS_TOKEN"
              }
            }
          }
        }
      ]
    }
  },
  "inspectConfig":{
    "customInfoTypes":[
      {
        "infoType":{
          "name":"EMAIL_ADDRESS_TOKEN"
        },
        "surrogateType":{

        }
      }
    ]
  },
  "item":{
    "value": "My name is Alicia Abernathy, and my email address is TOKEN."
  }
}
```

**Cryptographic hashing**
An input value is replaced with a value that has been encrypted and hashed using [Hash-based Message Authentication Code (HMAC)-Secure Hash Algorithm (SHA)-256](https://tools.ietf.org/html/rfc4634) on the input value with a cryptographic key. The hashed output of the transformation is always the same length and can't be re-identified. Learn more about [the format of values tokenized using cryptographic hashing](https://cloud.google.com/dlp/docs/pseudonymization#cryptographic-hashing).


## 3.1.c - Configuring format-preserving substitution

**Format preserving encryption**
An input value is replaced with a value that has been encrypted using the [FPE-FFX](https://en.wikipedia.org/wiki/Format-preserving_encryption) encryption algorithm with a cryptographic key, and then prepended with a surrogate annotation, if specified. By design, both the character set and the length of the input value are preserved in the output value. Encrypted values can be re-identified using the original cryptographic key and the entire output value, including surrogate annotation. (For some important considerations around using this encryption method, see [Format preserving encryption](https://cloud.google.com/dlp/docs/pseudonymization#fpe-ffx))

```
{
  "item": {
    "value": "My name is Alicia Abernathy, and my email address is aabernathy@example.com."
  },
  "deidentifyConfig": {
    "infoTypeTransformations": {
      "transformations": [
        {
          "infoTypes": [
            {
              "name": "EMAIL_ADDRESS"
            }
          ],
          "primitiveTransformation": {
            "crypto_replace_ffx_fpe_config": {
              "cryptoKey": {
                "kmsWrapped": {
                  "cryptoKeyName": "projects/PROJECT_ID/locations/global/keyRings/dlp-keyring/cryptoKeys/dlp-key",
                  "wrappedKey": "WRAPPED_KEY"
                }
              },
              "surrogateInfoType": {
                "name": "EMAIL_ADDRESS_TOKEN"
              }
            }
          }
        }
      ]
    }
  },
  "inspectConfig": {
    "infoTypes": [
      {
        "name": "EMAIL_ADDRESS"
      }
    ]
  }
}
```
Re-identify request:

```
{
  "reidentifyConfig":{
    "infoTypeTransformations":{
      "transformations":[
        {
          "infoTypes":[
            {
              "name":"EMAIL_ADDRESS_TOKEN"
            }
          ],
          "primitiveTransformation":{
            "crypto_replace_ffx_fpe_config":{
              "cryptoKey":{
              "kmsWrapped": {
                "cryptoKeyName": "projects/PROJECT_ID/locations/global/keyRings/dlp-keyring/cryptoKeys/dlp-key",
                "wrappedKey": "WRAPPED_KEY"
              }
            },
              "surrogateInfoType":{
                "name":"EMAIL_ADDRESS_TOKEN"
              }
            }
          }
        }
      ]
    }
  },
  "inspectConfig":{
    "customInfoTypes":[
      {
        "infoType":{
          "name":"EMAIL_ADDRESS_TOKEN"
        },
        "surrogateType":{

        }
      }
    ]
  },
  "item":{
    "value": "My name is Alicia Abernathy, and my email address is TOKEN."
  }
}
```

## 3.1.d - Restricting access to BigQuery datasets

### BigQuery Security
IAM Roles:
  * BigQuery Admin (`bigquery.admin`):
    * Create and read data
    * run jobs
    * set iam policies
  * BigQuery Data Owner (`bigquery.dataOwner`):
    * R/W access to data (tables and views)
    * can grant access to other users and groups by setting IAM policies
  * BigQuery Data Editor (`bigquer.dataEditor`):
    * R/W access to data
  * BigQuery Data Viewer (`bigquery.dataViewer`):
    * Read-only access to data
  * BigQuery Filtered Data Viewer (`bigquery.filteredDataViewer`):
    * Read-only access to filtered table data defined by a row access policy
  * BigQuery Job User (`bigquery.jobUser`):
    * Create and run jobs
    * no data access
  * BigQuery Metadata Viewer (`bigquery.metadataViewer`):
    * If applied to table or view allows reading metadata from a table or view
    * If applied to a dataset provides permissions to list tables and views in the dataset, read the metadata from the dataset's tables/views
    * If applied at the project or org level, follows same as applied to a dataset permissions but applies to all datasets in the project or org.
  * BigQuery User (`bigquery.user`):
    * Can run jobs
    * Create datasets
    * List tables
    * save queries
    * NO default access to data

A full list of predefined IAM roles can be found [here](https://cloud.google.com/bigquery/docs/access-control#bigquery).

The user who created the dataset is the owner.

Always best to assigned roles to groups.

BigQuery only supports _Customer-Managed Encryption Keys_(CMEK) for user controlled encryption

#### Dataset level Permissions

You can apply access controls during dataset creation by calling the `datasets.insert` API method.

Access controls can't be applied during dataset creation in the Google Cloud console, the `bq` command-line tool, or data definition language (DDL) statements.

You can apply access controls to a dataset after it is created in the following ways:

* Using the Google Cloud console.
* Using the GRANT and REVOKE DCL statements.
* Using the bq update command in the bq command-line tool.
* Calling the datasets.patch API method.
* Using the client libraries.

BQ SQL GRANT Command:

```
GRANT `roles/bigquery.dataViewer`
ON SCHEMA mydataset
TO 'user:joe@example.com';
```

BQ SQL Revoke Command:
```
REVOKE `roles/bigquery.dataViewer`
ON SCHEMA mydataset
FROM 'user:joe@example.com';
```

bq update command:

```
File containing access permissions (access.json)
{
 "access": [
  {
   "role": "READER",
   "specialGroup": "projectReaders"
  },
  {
   "role": "WRITER",
   "specialGroup": "projectWriters"
  },
  {
   "role": "OWNER",
   "specialGroup": "projectOwners"
  },
  {
   "role": "READER",
   "specialGroup": "allAuthenticatedUsers"
  },
  {
   "role": "READER",
   "domain": "domain_name"
  },
  {
   "role": "WRITER",
   "userByEmail": "user_email"
  },
  {
   "role": "WRITER",
   "userByEmail": "service_account_email"
  },
  {
   "role": "READER",
   "groupByEmail": "group_email"
  }
 ],
 ...
}

$ bq update \
--source path_to_file \
project_id:dataset
```
#### Table or View Level Access

You can set or update the access policy on a bq resources using the following:

* `bq set-iam-policy`
* `bq add-iam-policy-binding`
* `bq remove-iam-policy-binding`
* Using the Google console
* Calling `tables.setIamPolicy` API method
* Using `GRANT`, `REVOKE` BQ SQL statements


#### Authorized Views
Views to provide row or column level permissions to datasets.

To create `authorized views`, create a second dataset with different permissions from the frst. Add a view to the second dataset that selects the subset of data you want to expose from the first dataset.

Access control examples can be found [here](https://cloud.google.com/bigquery/docs/access-control-examples).

#### Optimizing Storage
You can control storage costs and optimize storage usage by setting the default table expiration for newly created tables in a dataset. If you set the property when the dataset is created, any table created in the dataset is deleted after the expiration period. If you set the property after the dataset is created, only new tables are deleted after the expiration period.

```
bq mk \
--time_partitioning_type=DAY \
--time_partitioning_expiration=259200 \
project_id:dataset.table
```

BigQuery Command Line Reference can be found [here](https://cloud.google.com/bigquery/docs/reference/bq-cli-reference).

## 3.1.e - Configuring VPC Service Controls

See networking sections...

## 3.1.f - Securing secrets with Secret Manager

### Secrets Management
GCP offers `Secret Manager` storage, management and access of secrets as binary blobs or text strings.

Secret Manager works well for storing configuration information such as database passwords, API keys, or TLS certificates needed by an application at runtime.

There are other third-party tools such as [Hashicorp Vault](https://www.vaultproject.io/) and [Berglas](https://github.com/GoogleCloudPlatform/berglas).

**Secrets Manager** encrypts secret data before its persisted to disk using AES-256 encryption scheme

**IAM Roles**
The following roles a needed in order to manage secrets:

![Secret Manager IAM](images/secretmanager_iams.png)

You can also you the Ch gsutil command to grant/update IAM policies:

```
gsutil iam ch user:john.doe@example.com:objectCreator gs://ex-bucket
```

Make a bucket publicly readable:

```
gsutil iam ch allUsers:objectViewer gs://ex-bucket
```

Or use the gsutil acl ch command to update ACLs

Grants everyone read access:
```
gsutil acl ch -u AllUsers:R gs://example-bucket/example-object
```

Individual user:
```
gsutil acl ch -u john.doe@example.com:WRITE gs://example-bucket
```

#### Secret Rotation
Secrets can be rotated by adding a new secret version to the secret. Any version of a secret can be accessed as long as it is enabled.

To prevent a secret from being used you should disable it.

A secret can be in one of the following states:

  * Enabled
    * active and accessible
  * Disabled
    * cannot be accessed but content still exists
    * Can be re-enabled
  * Destroyed
    * permanent
    * content is discarded
    * cannot be changed to another state

```
gcloud secrets versions enable | disable | destroy version-id --secret="secret-id"
```

#### Replication
Secrets have global names and globally replicated metadata, but the location where the secret payload data is stored can be controlled using the replication policy. Each secret has its own replication policy which is set at creation. The locations in the replication policy cannot be updated.

There are two replication types:

  * `Automatic`:
    * simplest configuration and recommended for most users
    * default policy
    * secret with automaticate policy can only be created if the the resource creation in `global` is allowed.
    * payload data is replicated without restriction.
  * `User Managed`:
    * payload data replicated to a user configured set of locations.
    * Supported Locations found [here](https://cloud.google.com/secret-manager/docs/locations).
    * a secret with a user managed replication policy can only be created if resource creation is allowed in the all selected locations.


## 3.1.g - Protecting and managing compute instance metadata

### Secure Boot
Secure Boot helps ensure that the system only runs authentic software by verifying the digital signature of all boot components, and halting the boot process if signature verification fails

Shielded VM instances run firmware which is signed and verified using Google's Certificate Authority, ensuring that the instance's firmware is unmodified and establishing the [root of trust](https://uefi.org/sites/default/files/resources/UEFI%20RoT%20white%20paper_Final%208%208%2016%20%28003%29.pdf) for Secure Boot. The [Unified Extensible Firmware Interface (UEFI) 2.3.1 firmware](https://uefi.org/sites/default/files/resources/UEFI_Secure_Boot_in_Modern_Computer_Security_Solutions_2013.pdf), securely manages the certificates that contain the keys used by the software manufacturers to sign the system firmware, the system boot loader, and any binaries they load. Shielded VM instances use UEFI firmware.

On each boot, the UEFI firmware verifies the digital signature of each boot component against the secure store of approved keys. Any boot component that isn't properly signed, or isn't signed at all, isn't allowed to run.

If this occurs, the VM instance's serial console log will have an entry containing the strings UEFI: Failed to load image and Status: Security Violation, along with a description of the boot option that failed. To troubleshoot the failure, disable Secure Boot by using the instructions in Modifying Shielded VM options so that you can boot the VM instance, diagnose and resolve the issue, then re-enable Secure Boot.


```
gcloud compute instances update VM_NAME \
    [--[no-]shielded-secure-boot] \
    [--[no-]shielded-vtpm] \
    [--[no-]shielded-integrity-monitoring]

```

#### Shielded VMs
By default, Shielded VM supports [Container-Optimized OS](https://cloud.google.com/container-optimized-os/docs), various distributions of Linux, and multiple versions of Windows Server. But if you require custom images for your application, you can still take advantage of Shielded VM.

**Copying custom image to Compute Engine**
```
gcloud compute images create [IMAGE_NAME] \
--source-disk [SOURCE_DISK] \
--source-disk-zone [ZONE] \
--platform-key-file=<file.der> \
--key-exchange-key-file=<file.der> \
--signature-database-file=<file.bin>,<file.der> \
--forbidden-database-file=<file.bin> \
--guest-os-features="UEFI_COMPATIBLE[,WINDOWS]"
```

### OS login

OS Login is the recommend connection option for most scenerios. This feature lets you use Compute Engine IAM users/roles to manage SSH access to Linux instances. You can add an extra layer of security by setting up OS Login with two-factor authentication, and manage access at the organization level by setting up organization policies.

**Setup OS Login**
```
gcloud compute project-info add-metadata \
    --metadata enable-oslogin=TRUE

gcloud compute instances add-metadata VM_NAME \
    --metadata enable-oslogin=TRUE

OR

gcloud compute instances create INSTANCE_NAME --zone=ZONE --metadata=enable-oslogin=TRUE
```

After you enable OS Login on one or more instances in your project, those VMs accept connections only from user accounts that have the necessary IAM roles in your project or organization.

If the user(s) do not have `roles/owner`, `roles/editor`, or `roles/compute.instanceAdmin` roles than grant the following:
* `roles/compute.osLogin`: which doesnt grant admin Permissions
* `roles/compute.osAdminLogin` : which grants admin Permissions
* `roles/compute.osLoginExternalUser`: grants access to an instance to user(s) that reside outside the organization

If your VM uses a service account, then each user that connects to the VM using SSH must have the ability to impersonate the service account. Granting the `roles/iam.serviceAccountUser` allows for impersonating a service account.


Use HTTPS and SSL for production Web Servers.
Configure Port Forwarding over SSH.
```
gcloud compute ssh example-instance \
    --project my-project \
    --zone us-central1-a \
    -- -L 2222:localhost:8888 -L 2299:localhost:8000
```

Connecting via Bastion Host to instances without external IPs:

![Bastion Host](images/bastion.png)

**Use Identity Aware Proxy for TCP Forwarding**

IAP's TCP forwarding feature allows users to connect to arbitrary TCP ports on Compute Engine instances. For general TCP traffic, IAP creates a listening port on the local host that forwards all traffic to a specified instance. IAP then wraps all traffic from the client in HTTPS. Users gain access to the interface and port if they pass the authentication and authorization check of the target resource's Identity and Access Management (IAM) policy.

![How IAP TCP Forwarding Works](images/iap-tcp-forwarding-diagram.png)

To configure IAP setup firewalls like such:

```
gcloud compute firewall-rules create allow-rdp-ingress-from-iap \
  --direction=INGRESS \
  --action=allow \
  --rules=tcp:3389 \
  --source-ranges=35.235.240.0/20
```
```
gcloud compute firewall-rules create allow-ssh-ingress-from-iap \
  --direction=INGRESS \
  --action=allow \
  --rules=tcp:22 \
  --source-ranges=35.235.240.0/20
```
```
gcloud compute firewall-rules create allow-ingress-from-iap \
  --direction=INGRESS \
  --action=allow \
  --rules=tcp:PORT \
  --source-ranges=35.235.240.0/20
```

Also grant permissions to use IAP:

```
gcloud projects add-iam-policy-binding [PROJECT_ID] \
    --member=user:[EMAIL ]\
    --role=roles/iap.tunnelResourceAccessor
```

Once IAP is configure you can use tunnel over ssh:

`gcloud compute ssh [INSTANCE_NAME]`

Or use the follow for IAP TCP tunnelling other ports:

```
gcloud compute start-iap-tunnel [INSTANCE_NAME] [INSTANCE_PORT] `
    --local-host-port=localhost:LOCAL_PORT `
    --zone=ZONE
```

If the instance(s) have no public IP configure a bastion host vm in order to connect to any private VM. The bastion host should be hardend and have necessary firewall rules to limit the source IPs that can connect to it.


</details>

<details>
<summary> 3.2 - Managing encryption at rest </summary>

## 3.2.a - Understanding use cases for Google default encryption, customer-managed encryption keys (CMEK), customer-supplied encryption keys (CSEK), Cloud External Key Manager (EKM), and Cloud HSM


Google Cloud Platform encrypts customer data stored at rest by default, with no additional action required from you. Data in Google Cloud Platform is broken into subfile chunks for storage, and each chunk is encrypted at the storage level with an individual encryption key. Google uses a common encryption library, [Keyczar](https://github.com/google/keyczar), to implement encryption across almost all GCP Platform products.

### Envelope Encryption
By default, at the storage layer, Google uses _Envelope Encryption_, with its internal kms service as a central keystore.

![Envelope Encryption](images/envelope_encryption_store.svg)

To encrypt data using envelope encryption:

* Generate a DEK locally.
  * You could do this with an open source library such as OpenSSL, specifying a cipher type and a password from which to generate the key. You can also specify a salt and digest to use, if desired.

* Use this DEK locally to encrypt your data.
  * As an example, you could use OpenSSL as shown in the encrypting the message example. For best practice, use 256-bit Advanced Encryption Standard (AES-256) cipher in Galois Counter Mode (GCM).

* Generate a new key in Cloud KMS, or use an existing key, which will act as the KEK. Use this key to encrypt (wrap) the DEK.

* Store the encrypted data and the wrapped DEK.

### Encryption at Rest
By default GCP encrypts all customers data stored at rest using the Advanced Encryption Standard (AES) algorithm using a unique data encryption key (DEK).

DEKs are encrypted with ("wrapped" by) key encryption keys (KEKs) and stored with the data.

![DEKs](images/deks.png)

By default, KEKs are stored using Cloud KMS and are fully managed by Google. Decrypting the data requires the unwrapped data encryption key (DEK) for the data chunk.

![KEKs](images/keks.png)

All data stored at the storage level is encrypted with AES256 by default.

Decrypting data requires the unwrapped data encryption key
(DEK) for the data chunk.

![Decryption](images/decrypting.png)

KEK rotation varies by service, the standard rotation period is 90 days.

RE-encryption of data is required at least once every 5 years. Best practice is more frequent re-encryption.

Google persists/stores up to 20 verisons of encrypted data.

### Layers of Encryption
Google uses several layers of encryption to protect customers data.

![Encryption Layers](images/encryption_layers.png)

For more details on GCP Encryption at Rest see the [whitepaper](https://cloud.google.com/security/encryption-at-rest/default-encryption#granularity_of_encryption_in_each_google_cloud_platform_product).

### Encryption in Transit
This type of encryption protects your data if communications are intercepted while data moves between your site and the cloud provider or between two services. This protection is achieved by encrypting the data before transmission; authenticating the endpoints; and decrypting and verifying the data on arrival. For example, Transport Layer Security (TLS) is often used to encrypt data in transit for transport security, and Secure/Multipurpose Internet Mail Extensions (S/MIME) is used often for email message security.

Google Cloud services accept requests from around the world using a globally distributed system called the Google Front End (GFE). GFE terminates traffic for incoming HTTP(S), TCP and TLS proxy traffic, provides DDoS attack countermeasures, and routes and load balances traffic to the Google Cloud services themselves.

GFEs proxy traffic to Google Cloud services. GFEs route the user's request over our network backbone to a Google Cloud service. This connection is authenticated and encrypted from GFE to the front-end of the Google Cloud service or customer application, when those communications leave a physical boundary controlled by Google or on behalf of Google.

TLS in the GFE is implemented with BoringSSL, which is a Google-maintained open-source implementation of TLS protocoal, that is mostly interface-compatible with OpenSSL. Table 1 shows the encryption protocols that GFE supports when communicating with clients.

|Protocol| Authentication | Key exchange | Encryption | Hash Functions|
|-------|---------------|-----------|--------|-----------|
|TLS 1.3 | RSA 2048 | Curve25519 | AES-128-GCM| SHA384 |
|TLS 1.2 | ECDSPA P-256 | P-256 (NIST secp256r1) |AES-256-GCM | SHA256 |
|TLS 1.1 | | | AES-128-CBC |SHA1|
|TLS 1.0 | | | AES-256-CBC | MD5 |
|QUIC | | | ChaCha20-Poly1305 | |
| | | |3DES | |

For more details on how Encryption In Transit works at Google see the following [whitepaper](https://cloud.google.com/security/encryption-in-transit).

### Cloud Storage Encyption
Cloud Storage always encrypts the customers data on the server before it is written to disk. Cloud storage manages server-side encryption keys on the clients behalf. It leverages AES-256 encryption by default.

Alternatively the client has the option of using their own encryption keys for encrypting their data in Cloud Storage.

These are the following options:

* _Server Side Encryption_:
  * **Customer-supplied encryption keys (CSEK)**:
    * client can create and manage their own encryption keys for server-side encryption, which act as and additional encryption layer on top of the standard Cloud Storag Encryption.
    * these keys ARE NOT stored on Googles servers nor do they manage the keys
    * Examples for creating and using CSEK's : https://cloud.google.com/storage/docs/encryption/using-customer-supplied-keys
    * **Currently Cloud Storage Transfer Service, Cloud Dataflow and Cloud Dataproc DO NOT support objects encrypted with CSEKs.**
    * You cannot use CSEKs on a storage bucket, only on individual objects.
    * More details on CSEKs: https://cloud.google.com/storage/docs/encryption/customer-supplied-keys
  * **Customer-managed encryption keys (CMEK)**:
    * client can generate and manage the keys using Cloud Key Management Service (KMS).
    * encryption and decryption is done using service accounts with IAM permissions:
      * `roles/cloudkms.cryptoEncrypter`
        * encrypting only
      * `roles/cloudkms.cryptoEncrypterDecrypter`
        * encrypt and decrypt
      * `roles/cloudkms.publickeyviewer`
        * verify data only
      * `roles/cloudkms.signerVerifier`
        * sign and verify data
      * `roles/cloudkms.admin`
        * manage a key
    * For a full list of Cloud KMS Permission see here [https://cloud.google.com/kms/docs/reference/permissions-and-roles].
* _Client-side encyption_:
  * encyption occurs before data is sent to cloud storage. Once data is landed in on the server it is also encrypted server side.

**NOTE: If CSEK or client-side encryption is use there is a caveat where if the keys are lost the data will no longer be readable.**

### Cloud KMS
Cloud Key Management Service allows you to create, import, and manage cryptographic keys and perform cryptographic operations in a single centralized cloud service. You can use these keys and perform these operations by using Cloud KMS directly, by using Cloud HSM or Cloud External Key Manager, or by using Customer-Managed Encryption Keys (CMEK) integrations within other Google Cloud services.

Ensure the user that is calling the encrypt and decrypt methods has the `cloudkms.cryptoKeyVersions.useToEncrypt` and `cloudkms.cryptoKeyVersions.useToDecrypt` permissions on the key used to encrypt or decrypt.

One way to permit a user to encrypt or decrypt is to add the user to the `roles/cloudkms.cryptoKeyEncrypter`, `roles/cloudkms.cryptoKeyDecrypter`, or `roles/cloudkms.cryptoKeyEncrypterDecrypter` IAM roles for that key. Please note that the `roles/cloudkms.admin` role does not provide these two permissions.

**NOTE: CryptoKeys and KeyRings cannot be deleted in Cloud KMS!**

### Command Line snippets

To enable Cloud KMS:
```
gcloud services enable cloudkms.googleapis.com
```
Create a keyring and cryptokey:
```
gcloud kms keyrings create $KEYRING_NAME --location global
```

```
gcloud kms keys create $CRYPTOKEY_NAME --location global \
      --keyring $KEYRING_NAME \
      --purpose encryption
```

Using the encryption endpoint you can send the base64-encoded text you want to encrypt to the specified key:

```
curl -v "https://cloudkms.googleapis.com/v1/projects/$DEVSHELL_PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:encrypt" \
  -d "{\"plaintext\":\"$PLAINTEXT\"}" \
  -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
  -H "Content-Type: application/json"
```

To save the encrypted data to a file use the following curl:

```
curl -v "https://cloudkms.googleapis.com/v1/projects/$DEVSHELL_PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:encrypt" \
  -d "{\"plaintext\":\"$PLAINTEXT\"}" \
  -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
  -H "Content-Type:application/json" \
| jq .ciphertext -r > 1.encrypted
```

The command line tool [jq](https://stedolan.github.io/jq/) will parse out the `ciphertext` property form the response and save to a file.

To verify the data you can call the `decrypt` endpoint:

```
curl -v "https://cloudkms.googleapis.com/v1/projects/$DEVSHELL_PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:decrypt" \
  -d "{\"ciphertext\":\"$(cat 1.encrypted)\"}" \
  -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
  -H "Content-Type:application/json" \
| jq .plaintext -r | base64 -d
```
Granting permissions to the keyring:

```
gcloud kms keyrings add-iam-policy-binding [KEYRING_NAME] \
    --location [LOCATION] \
    --member user:[USER_EMAIL] \
    --role [CLOUD_KMS_ROLE]
```
For the user managing Cloud KMS, that is, a member of an organization's IT security team: The two roles with the minimum permissions required to manage Cloud KMS via the Cloud Console are the predefined Project Editor (editor) role, or a custom role based on the Cloud KMS Admin `cloudkms.admin` role combined with the following permissions:
* `serviceusage.quotas.get`
* `serviceusage.services.get`
* `resourcemanager.projects.get`

You can grant or restrict the ability to perform specific cryptographic operations, such as rotating a key or encrypting data. You can grant IAM roles on:

* A key directly
* A key ring, inherited by all keys in that key ring
* A Google Cloud project, inherited by all keys in the project
* A Google Cloud folder, inherited by all keys in all projects in the folder
* A Google Cloud organization, inherited by all keys in folders in the


Types of encryption keys:

**Customer-managed encryption keys (CMEK)**
Docs: https://cloud.google.com/kms/docs/cmek

* Managed encryption keys using Cloud kms
* Doesnt unnecessarily provdie more security over Google's default encryption mechanism
* CMEK gives you more control over the lifecycle and management of your keys:
  - You can control Google's ability to decrypt data at rest by disabling the keys used to protect that data.
  - You can protect your data using a key that meets specific locality or residency requirements.
  - You can automatically or manually rotate the keys used to protect your data.
  - You can protect your data using a Cloud HSM key or a Cloud External Key Manager key, or an existing key that you import into Cloud KMS.

Two org policies constraints to help ensure CMEK usage:

* `constraints/gcp.restrictNonCmekServices` is used to require CMEK protection.
* `constraints/gcp.restrictCmekCryptoKeyProjects` is used to limit which Cloud KMS keys are used for CMEK protection.
  - Supported services:
    - Artifact registry
    - BigQuery
    - Cloud Bigtable
    - Cloud Composer
    - Compute Engine
    - GKE (Preview)
    - Dataflow
    - Cloud logging
    - Pub/Sub
    - Cloud Spanner
    - Cloud SQL
    - Cloud Storage


**Customer-supplied encryption keys (CSEK)**
Docs: https://cloud.google.com/docs/security/encryption/customer-supplied-encryption-keys

Customer-Supplied Encryption Keys (CSEK) are a feature in Google Cloud Storage and Google Compute Engine. If you supply your own encryption keys, Google uses your key to protect the Google-generated keys used to encrypt and decrypt your data.

Using CSEK in GCS (https://cloud.google.com/docs/security/encryption/customer-supplied-encryption-keys#cloud_storage):
![CSEK-GCS](https://cloud.google.com/static/docs/security/encryption/customer-supplied-encryption-keys/Diagram1.png)

* Add `encryption_key` and `decryption_key1` flag to you [boto configuration file](https://cloud.google.com/storage/docs/boto-gsutil) or pass it during execution of `gsutil` command `$ gsutil -o "GSUtil:decryption_key1=ENCRYPTION_KEY_FILE" cp...` or `$ gsutil -o "GSUtil:ecnryption_key=ENCRYPTION_KEY_FILE" cp...`

Using CSEK in GCE (https://cloud.google.com/docs/security/encryption/customer-supplied-encryption-keys#compute_engine):
![CSEK-GCE](https://cloud.google.com/static/docs/security/encryption/customer-supplied-encryption-keys/Diagram2.png)


**Cloud External Key Manager (EKM)**
Docs: https://cloud.google.com/kms/docs/ekm

Use when you have keys that you manage with [supported external key management partner](https://cloud.google.com/kms/docs/ekm#supported_partners). Integrates with Cloud KMS

![EKM](https://cloud.google.com/static/kms/images/cloud_ekm_encryption_diagram.svg)

Considerations:
* GCP has no control over availability of your externally-managed keys and cannot recover any keys
* Communication to external service over the internet can lead to problems with reliability, availability, and latency. For applications with low tolerance for these types of risks, consider using Cloud HSM or Cloud KMS to store your key material.
* Cloud EKM can be used with [Hosted Private HSM](https://cloud.google.com/kms/docs/hosted-private-hsm) to create a single-tenant HSM solution integrated with Cloud KMS. Choose a Cloud EKM partner that supports single-tenant HSMs and review the requirements at [Hosted Private HSM](https://cloud.google.com/kms/docs/hosted-private-hsm) to learn more.



**Cloud HMS**
Docs: https://cloud.google.com/kms/docs/hsm
Cloud HSM is a cloud-hosted Hardware Security Module (HSM) service that allows you to host encryption keys and perform cryptographic operations in a cluster of [FIPS 140-2 Level 3](https://csrc.nist.gov/publications/detail/fips/140/2/final) certified HSMs. Google manages the HSM cluster for you, so you don't need to worry about clustering, scaling, or patching. Because Cloud HSM uses Cloud KMS as its front end, you can leverage all the conveniences and features that Cloud KMS provides.

Creating a key in HMS:

```
gcloud kms keys create key \
    --keyring key-ring \
    --location location \
    --purpose "encryption" \
    --protection-level "hsm"
```

# Labs
[Getting Started With Cloud KMS](https://www.qwiklabs.com/focuses/1713?catalog_rank=%7B%22rank%22%3A1%2C%22num_filters%22%3A0%2C%22has_search%22%3Atrue%7D&parent=catalog&search_id=6747257)

[Encrypting a disk with Customer-Supplied Encryption Keys](https://docs.google.com/document/d/1xJRrSmC2EtSif6xaL0QaBxQ5CU9uR1DK1OMzr5xZ6Dg/edit#)

[Using Customer-Managed Encryption Keys with Cloud Storage and Cloud KMS](https://docs.google.com/document/d/1KvP7GjtqYVUKGgUs0QzO1jhf2MBlQ3GiA9_8NYSVMOs/edit#heading=h.t0mbi9us7mcl)

[Using Customer-Supplied Encryption Keys with Cloud Storage](https://docs.google.com/document/d/14AV9IgJXW_HYuii6JUUU0Ob0VN3hNMfzpQsfiz9K5Is/edit)


## 3.2.b - Creating and managing encryption keys for CMEK, CSEK, and EKM

**CMEK**

Symmetric key:
```
gcloud kms keys create key \
    --keyring key-ring \
    --location location \
    --purpose "encryption"
```

Asymmetric decryption key:

```
gcloud kms keys create key \
    --keyring key-ring \
    --location location \
    --purpose "asymmetric-encryption" \
    --default-algorithm "rsa-decrypt-oaep-2048-sha256"
```

Asymmetric signing key:
```
gcloud kms keys create key \
    --keyring key-ring \
    --location location \
    --purpose "asymmetric-signing" \
    --default-algorithm "rsa-sign-pkcs1-2048-sha256"
```

Set key rotation:
```
gcloud kms keys create key \
    --keyring key-ring \
    --location location \
    --purpose "encryption" \
    --rotation-period rotation-period \
    --next-rotation-time next-rotation-time
```

**EKM via VPC**

Symmetric encyption key:

```
gcloud kms keys create KEY \
    --keyring KEY_RING \
    --location LOCATION \
    --purpose "encryption" \
    --default-algorithm "external-symmetric-encryption" \
    --protection-level "external-vpc" \
    --skip-initial-version-creation \
    --crypto-key-backend EKM_CONNECTION
```

Asymmetric signnig key:
```
gcloud kms keys create KEY \
    --keyring KEY_RING \
    --location LOCATION \
    --purpose asymmetric-signing \
    --protection-level "external-vpc" \
    --skip-initial-version-creation \
    --default-algorithm ec-sign-p256-sha256
    --crypto-key-backend EKM_CONNECTION
```

Key verison:
```
gcloud kms keys versions create \
    --key KEY \
    --keyring KEY_RING \
    --location LOCATION \
    --ekm-connection-key-path EKM_CONNECTION_KEY_PATH
    --primary
```

**EKM via internet**
Symmetric encyption key:

```
gcloud kms keys create KEY_NAME \
    --keyring KEY_RING \
    --location LOCATION \
    --purpose encryption \
    --default-algorithm external-symmetric-encryption \
    --protection-level external \
    --skip-initial-version-creation
```

Asymmetric signnig key:
```
gcloud kms keys create KEY \
    --keyring KEY_RING \
    --location LOCATION \
    --purpose asymmetric-signing \
    --protection-level external \
    --skip-initial-version-creation \
    --default-algorithm ec-sign-p256-sha256
```

Key verison:
```
gcloud kms keys versions create \
    --key KEY_NAME \
    --keyring KEY_RING \
    --location LOCATION \
    --external-key-uri EXTERNAL_KEY_URI \
    --primary
```

By default, key versions in Cloud KMS spend 24hrs in the Scheduled for destruction before they are destroyed. To create a custom deletion schedule, with the following caveats:

* The duration is only configurable during key creation.
* Once specified, the duration for the key cannot be changed.
* The duration applies to all versions of the key created in the future.
* The minimum duration is 24 hours for all keys, except for import-only keys which have a minimum duration of 0.
* The maximum duration is 120 days.
* The default duration is 24 hours.

```
gcloud kms keys create key \
    --keyring key-ring \
    --location location \
    --purpose purpose \
    --destroy-scheduled-duration duration
```

**EKM**

Symmetric keys:
```
gcloud kms keys \
 create KEY_NAME \
 --keyring KEY_RING_NAME \
 --location LOCATION \
 --purpose encryption \
 --protection-level external \
 --skip-initial-version-creation \
 --default-algorithm external-symmetric-encryption
```

Asymmetric Key:
```
gcloud kms keys \
 create KEY_NAME \
 --keyring KEY_RING_NAME \
 --location LOCATION \
 --purpose asymmetric-signing \
 --protection-level external \
 --skip-initial-version-creation \
 --default-algorithm ec-sign-p256-sha256
```

Create new versions:
```
gcloud kms keys versions create \
 --key KEY_NAME \
 --keyring KEY_RING_NAME \
 --location LOCATION \
 --external-key-uri EXTERNAL_KEY_URI \
 --primary
```

## 3.2.c - Applying Google's encryption approach to use cases

## 3.2.d - Configuring object lifecycle policies for Cloud Storage

Cloud Storage is a service for storing your objects in Google Cloud. An object is an immutable piece of data consisting of a file of any format. You store objects in containers called buckets. All buckets are associated with a project, and you can group your projects under an organization.

You can enable versioning on the bucket to keep historical versions of all objects:

```
gsutil versioning set on | off gs:\\my-bucket
```

### Storage Types
There are several tiers or storage classes offered by Cloud Storage:

* STANDARD
  * >99.99 % availability in multi-region and dual regions
  * 99.99 % in regions
  * No min storage duration
  * Hot Frequent access data
* NEARLINE
  * 99.95 % in multi-regions and dual regions
  * 99.9% in regions  
  * min 30 days
  * lower storage cost than standard
  * higer cost for accessing
  * for infrequently accessed data
  * appropriate for backups
* COLDLINE
  * 99.95 % in multi-regions and dual regions
  * 99.9% in regions
  * min 90 days
  * Coldline storage is ideal for data you plan to read or modify at most once a quarter. Note, however, that for data being kept entirely for backup or archiving purposes, Archive storage is more cost-effective, as it offers the lowest storage costs.
* ARCHIVE
  * 99.95 % in multi-regions and dual regions
  * 99.9% in regions
  * min 365 days
  * high cost for accessing data
  * lowest storage fees
  * ideal for data that you will not touch for 1 year
  * DR scenerios

### Encrypting Data with gsutil

```
gsutil -o 'GSUtil:encryption_key=projects/PROJECT_ID/locations/LOCATION/keyRings/KEYRING/cryptoKeys/KEYNAME' \
       cp /some/local/file gs://my-bucket/
```

### Enabling logging within a bucket
 ```
 gsutil mb gs://bucket-for-logs
 gsutil acl ch -g [email_address]:W gs://bucket-for-logs
 gsutil defacl set project-private gs://bucket-for-logs
 gsutil logging set on -b gs://bucket-for-logs gs://[MAIN_BUCKET]
 ```

### Cloud Storage Permission and Access Control Lists (ACLs)
* Members can be granted access to Cloud Storage at the org , folder, project or bucket levels.
* Permissions flow down from higher levels.
* Cannot remove a permission at the lower level that was granted at a higher level.

#### Predefine storage roles
Roles can be added to member and service accounts at the project or bucket level.
![Predefined Storage Roles](images/predefine-storage-roles.png)

#### Storage role permissions
![Storage Role Permissions](images/storage_perms.png)

* `Storage Object Admin`:
  * provides full control of the Cloud Storage Objects.
* `Storage Object Creator`:
    * ability to get and list objects and projects and as well as create objects
* `Storage Object Viewer`:
  * ability to get and list objects get and list projects and list Cloud Storage objects

### ACLs
Access Control Lists (ACLs) allows you  to define who has access to individual buckets and objects, as well as what level of access they have.

ACLs can work in tandem with IAM to grant access to buckets and objects. A user needs either an IAM or an ACL to access a bucket or object.

In most cases IAM permissions should be used. If you want more finer grained access control over buckets and objects, then use ACLs.

To make a bucket public, grant `allUsers` the `Storage Object Viewer` role. To make an object public, grant `allUsers` the `Reader` access.

View current ACL:

`gsutil defacl get gs://[BUCKET_NAME]`

### Signed URLs
Signed URLs allow access to Cloud Storage without having to add a user to and ACL or IAM. They provide temporary access with a timeout. Caveat is that anyone with the signe url has access to the bucket and/or object(s).

**Creating a signed URL with gsutil**

```
glcoud iam service-accounts keys create ~/key.json --iam-account [EMAIL_ADDRESS]

gsutil signurl -d 10m ~/key.json gs://[GCS_BUCKET_NAME]/[FILE]
```

`-d` is the duration the url with be available for (example 10 min)

### Signed Policy Documents
Provides control on what can be uploaded to a bucket. Allows control over size, content type and other upload characteristics.

Example of Signed Policy Document:
![Signed Policy Doc](images/signed_policy_documents.png).

Requirements:
* Ensure the policy document is UTF-8 encoded
* Encode the policy document as a Base64 representation
* Sign your policy using RSA SHA-256 using the secret key provide from GCP Console
* Encode the message digest as a Base64 representation
* Add the policy document information to the HTML form.

### Cloud Storage Lifecyle Management
You can configure a set of rules that will trigger actions to either delete the object perminently or move it to a lower cost storage tier (Nearline, Coldline or Archive).

To enable Object Lifecycle Management via gsutil run :
```
gsutil lifecycle set [LIFECYCLE_CONFIG_FILE] gs://[BUCKET_NAME]
```

Sample Config File:
```
{
"lifecycle": {
  "rule": [
  {
    "action": {
      "type": "SetStorageClass",
      "storageClass": "NEARLINE"
    },
    "condition": {
      "age": 365,
      "matchesStorageClass": ["MULTI_REGIONAL", "STANDARD", "DURABLE_REDUCED_AVAILABILITY"]
    }
  },
  {
    "action": {
      "type": "SetStorageClass",
      "storageClass": "COLDLINE"
    },
    "condition": {
      "age": 1095,
      "matchesStorageClass": ["NEARLINE"]
    }
  }
]
}
}
```

### Data Retention Policies using Bucket Lock
You can include a retention policy when creating a new bucket, or you can add a retention policy to an existing bucket. Placing a retention policy on a bucket ensures that all current and future objects in the bucket cannot be deleted or overwritten until they reach the age defined by the policy.

Rententions Periods:
* A day is considered to be 86,400 seconds.
* A month is considered to be 31 days, which is 2,678,400 seconds.
* A year is considered to be 365.25 days, which is 31,557,600 seconds.

You can set a maximum retention period of 3,155,760,000 seconds (100 years).

**Locking a retention policy is irreversible**.

Bucket Lock can help with regulatory and compliance requirements such as those associated with FINRA, SEC and CFTC.

When a retention policy is locked, Cloud Storage automatically puts a `lien` on the to the `project.delete` permission where the bucket is contained. This means the the project cannot be deleted.


To apply a retention policy using `gsutil`:

```
gsutil retention set 600s gs://my-bucket
```
The above command applies a retention policy of 10 min.

To remove a retention policy:
```
gsutil retention clear gs://my-bucket
```

To lock a retention policy:
```
gsutil retention lock gs://my-bucket
```


## 3.2.e - Enable confidential computing

Confidential Computing is the protection of data in-use with hardware-based Trusted Execution Environment (TEE). TEEs are secure and isolated environments that prevent unauthorized access or modification of applications and data while they are in use. This security standard is defined by the Confidential Computing Consortium.

### End-to-end encryption
End-to-end encryption is comprised of three states.

* Encryption-at-rest protects your data while it is being stored.
* Encryption-in-transit protects your data when it is moving between two points.
* Encryption-in-use protects your data while it is being processed.

Confidential Computing provides the last piece of end-to-end encryption: encryption-in-use.

A Confidential VM is a type of Compute Engine virtual machine (VM) that enables enhanced performance and security for high-memory workloads using AMD Secure Encrypted Virtualization (SEV). Confidential VM includes inline memory encryption to secure processing of sensitive data in memory. Together with encryption at rest and encryption in transit, inline memory encryption allows you to keep your data and apps encrypted at all times. Learn more about [Confidential VM and Compute Engine](https://cloud.google.com/compute/confidential-vm/docs/about-cvm).

**DOES NOT SUPPORT LIVE MIGRATION**
**YOU CAN ONLY ENABLE CONFIDENTIAL COMPUTING ON A VM WHEN YOU FIRST CREATE THE INSTANCE.**

It has the following features and benefits:

* **Isolation**:
  - Encryption keys are generated by AMD Secure Processor (SP) during VM creation and reside solely within the AMD Sytem-On-Chip (SOC). These keys are not even accessible by Google, offering improved isolation.
* **Attestation**:
  - Confidential VM uses [Virtual Trusted Platform Module (vTPM)](https://trustedcomputinggroup.org/resource/trusted-platform-module-tpm-summary/) attestation. Every time an AMD SEV-based Confidential VM boots, a [launch attestation report event](https://cloud.google.com/compute/confidential-vm/docs/monitoring#about_launch_attestation_report_events) is generated.
* **High performance**:
  - AMD SEV offers high performance for demanding computational tasks. Enabling Confidential VM has little or not impact on most workloads, with only a 0-6% degradation in performance.

**Creating a Confidential VM**
```
gcloud compute instances create INSTANCE_NAME \
  --machine-type "MACHINE_TYPE" --zone "ZONE_NAME" \
  --confidential-compute --maintenance-policy=TERMINATE \
  --image-family=IMAGE_NAME \
  --image-project=IMAGE_PROJECT
```

SAMPLE:

```
gcloud compute instances create example-instance \
  --machine-type "n2d-standard-16" --zone "us-central1-f" \
  --confidential-compute --maintenance-policy=TERMINATE \
  --image="example-cvm-image" \
  --image-project="public-image-project"
```

**Using the AMD EPYC Milan processor**
To set your instance to the AMD EPYC Milan processor, include the `--min-cpu-platform="AMD Milan"` flag in the gcloud compute instances create command. Learn more about [Compute Engine and AMD EPYC Milan processors](https://cloud.google.com/blog/products/compute/3rd-gen-amd-epyc-comes-to-compute-engine-n2d-machine-family).

Command to verify confidential computing is enable : `$ dmesg | grep SEC | head`


</details>

# Section 4. Managing Operations in a Cloud Solution environment

<details>
<summary> 4.1 - Building and deploying secure infrastructure and applications </summary>

### 4.1.a - Automating security scanning for Common vulnerabilities and Exporsures (CVEs) through a CI/CD pipeline


![Container Analysis](https://cloud.google.com/static/container-analysis/images/ca-information-diagram.svg)

* Automatic Scanning with [Container Scanning API](https://cloud.google.com/container-analysis/docs/container-scanning-overview)
* Manual Scanning with the [On-Demand Scanning API](https://cloud.google.com/container-analysis/docs/on-demand-scanning)

**Container Scanning API**
When enabled, allows you to automate OS vulnerability detection, scanning each time you push an image to Container Registry or Artifact Registry.

Artifcat Registry:

```
gcloud artifacts docker images describe \
LOCATION-docker.pkg.dev/PROJECT_ID/REPOSITORY/IMAGE_ID:TAG \
--show-package-vulnerability

gcloud artifacts docker images describe \
LOCATION-docker.pkg.dev/PROJECT_ID/REPOSITORY/IMAGE_ID@sha256:HASH \
--show-package-vulnerability
```

Container Registry (subset of artifcat registry):
```
gcloud beta container images describe HOSTNAME/PROJECT_ID/IMAGE_ID@sha256:HASH \
--show-package-vulnerability
```


**On-Demand Scanning API**
Allows you to manually scan container images for OS vulnerabilities, either locally on your computer or remotely in Container Registry or Artifact Registry.
https://cloud.google.com/container-analysis/docs/ods-cloudbuild

Setup a Cloud Build Pipeline to check/scan :
```
steps:
   - id: build
     name: gcr.io/cloud-builders/docker
     entrypoint: /bin/bash
     args:
     - -c
     - |
       docker build -t us-central1-docker.pkg.dev/$_PROJECT_ID/ods-build-repo/ods-test:latest -f ./Dockerfile . &&
       docker image inspect us-central1-docker.pkg.dev/$_PROJECT_ID/ods-build-repo/ods-test:latest --format \
       '{{index .RepoTags 0}}@{{.Id}}' > /workspace/image-digest.txt &&
       cat image-digest.txt
   - id: scan
     name: gcr.io/google.com/cloudsdktool/cloud-sdk
     entrypoint: /bin/bash
     args:
     - -c
     - |
       gcloud artifacts docker images scan us-central1-docker.pkg.dev/$_PROJECT_ID/ods-build-repo/ods-test:latest \
       --format='value(response.scan)' > /workspace/scan_id.txt
   - id: severity check
     name: gcr.io/google.com/cloudsdktool/cloud-sdk
     entrypoint: /bin/bash
     args:
     - -c
     - |
       gcloud artifacts docker images list-vulnerabilities $(cat /workspace/scan_id.txt) \
       --format='value(vulnerability.effectiveSeverity)' | if grep -Fxq $_SEVERITY; \
       then echo 'Failed vulnerability check' && exit 1; else exit 0; fi
   - id: push
     name: gcr.io/cloud-builders/docker
     entrypoint: /bin/bash
     args:
     - -c
     - |
       docker push us-central1-docker.pkg.dev/$_PROJECT_ID/ods-build-repo/ods-test:latest
images: ['us-central1-docker.pkg.dev/$_PROJECT_ID/ods-build-repo/ods-test:latest']

```


### 4.1.b - Automating virtual machine image creation, hardening, and maintenance

https://cloud.google.com/compute/docs/images/image-management-best-practices

Automating using Packer : https://cloud.google.com/architecture/automated-build-images-with-jenkins-kubernetes

https://cloud.google.com/software-supply-chain-security/docs/create-secure-image-pipeline?hl=en




#### Secure Images
Define an Organization Policy that only allow compute engine VMs to be created from approved images and use only Trust images.

```
constraint: constraints/compute.trustedImageProjects
listPolicy:
  allowedValues:
    - projects/debian-cloud
    - projects/cos-cloud
  deniedValues:
    - projects/unwanted-images
```
Use Hardened custom OS images to help reduce the surface of vulnerability for the instance.

Subscribe to [gce-image-notifications](https://groups.google.com/forum/#!aboutgroup/gce-image-notifications) to recieve notifications about Compute Engine image update releases.

Compute Engine predefines the following curated IAM roles that you can use for image management:

* `roles/compute.imageUser`:
  * Permission to list, read, and use images in your requests, without having other permissions on the image.
* `roles/compute.storageAdmin`:
  * Permissions to create, modify, and delete disks, images, and snapshots.

As a best practice, Google recommends keeping all your custom images in a single project dedicated to hosting these images and nothing else.

#### Patch Managment
Use OS patch management to apply operating system patches across a set of Compute Engine VM instances (VMs).Long running VMs require periodic system updates to protect against defects and vulnerabilities.

The OS patch management service has two main components:

* Patch compliance reporting:
  *  which provides insights on the patch status of your VM instances across Windows and Linux distributions. Along with the insights, you can also view recommendations for your VM instances.
* Patch deployment:
  * which automates the operating system and software patch update process. A patch deployment schedules patch jobs. A patch job runs across VM instances and applies patches.

**Benefits**
* Create patch approvals. You can select what patches to apply to your system from the full set of updates available for the specific operating system.
* Set up flexible scheduling. You can choose when to run patch updates (one-time and recurring schedules).
* Apply advanced patch configuration settings. You can customize your patches by adding configurations such as pre and post patching scripts.
* Manage these patch jobs or updates from a centralized location. You can use the the OS patch management dashboard for monitoring and reporting of patch jobs and compliance status.


Running a patch job:

```
gcloud compute os-config patch-jobs execute \
    --instance-filter-all \
    --duration="1h30m" --reboot-config="DEFAULT" \
    --apt-dist --windows-exclusive-patches=4339284 \
    --yum-minimal --yum-security \
    --async
```

Instances filter examples:  https://cloud.google.com/compute/docs/os-patch-management/create-patch-job#example-instance-filters


Owners of a Cloud project have full access to run and manage patch jobs. For all other users, you need to grant permissions. You can grant one of the following granular roles:

`roles/osconfig.patchJobExecutor`: Contains permissions to run, cancel, get, and list patch jobs. It also contains permissions to view instance details for a patch job.
`roles/osconfig.patchJobViewer`: Contains permissions for read-only access to get and list patch jobs. It also contains permissions to view instance details for a patch job.

#### Service Accounts and IAMs
A default compute engine service account is created for every GCP project when Compute Engine API is enabled. The default SA has `Project Editor` role which can be dangerous as it has access to create and delete resources.

The default SA can be assigned to an instance created or you can specifiy another custom sa, which would require the correct permissions.

When an instance is assigned a service account, the VM authenticates using the identity of the service account when making calls to Google APIs.

Specifying _scopes_ can limit what the default service account can and cannot do.

Scopes:
* Allow default access:
  * Read-only access to storage
  * Access to Cloud Logging and Monitoring
* Allow full access:
  * can grant access to all Cloud APIs
  * Not best practice
  * Violates Least priviledge best practices
* Set access for each API:
  * Choose requirements for you application
  * Can grant individual access to specific Cloud Apis
  * Follows least priviledge best practices

Using the default account, the instance(s) must be stopped in order to change the scopes associated. If using a custom/user-managed service account, IAM roles can be changed without needing to stop instances.

```
gcloud compute instances set-scopes [INSTANCE_NAME] --scopes [SCOPES]
```
`--scopes compute-rw,storage-ro,etc`

From a security standpoint it is NOT recommended to use the default service account, instead create a new one that follows the princal of least privilege.

### 4.1.c - Automating container image creation, verification, hardening, maintenance, and patch Management

#### Binary Authorization
Binary Authorization is a service on Google Cloud that provides software supply-chain security for applications that run in the cloud.

It works with images that you deploy to GKE from Container Registry or another container image registry. With Binary Authorization, you can ensure that internal processes that safeguard the quality and integrity of your software have successfully completed before an application is deployed to your production environment.

To enable this service on a project run the following command:

```
gcloud services enable \
    container.googleapis.com \
    containeranalysis.googleapis.com \
    binaryauthorization.googleapis.com
```

To create a cluster with `Binary Authorization` enabled run:

```
gcloud container clusters create \
    --enable-binauthz \
    --zone [ZONE] \
    [CLUSTER_NAME]
```

A _policy_ in Binary Authorization is a set of rules that govern the deployment of container images to Google Kubernetes Engine (GKE). A policy has the following parts:

* Deployment rules
* List of exempt images

Each GCP project can have exactly ONE policy.

Sample Policy:

```
admissionWhitelistPatterns:
- namePattern: gcr.io/google_containers/*
- namePattern: gcr.io/google-containers/*
- namePattern: k8s.gcr.io/*
- namePattern: gke.gcr.io/*
- namePattern: gcr.io/stackdriver-agents/*
globalPolicyEvaluationMode: ENABLE
defaultAdmissionRule:
  evaluationMode: ALWAYS_ALLOW
  enforcementMode: ENFORCED_BLOCK_AND_AUDIT_LOG
name: projects/PROJECT_ID/policy
```

An _attestation_ is a digital document that certifies that GKE is allowed to deploy the container image.

An attestation is created after a container image is built. Each such container has a globally unique digest. A signer signs the container image digest using a private key from a key pair and uses the signature to create the attestation. At deploy time, the Binary Authorization enforcer uses the attestor's public key to verify the signature in the attestation. Typically one attestor corresponds to exactly one signer.

To enable attestations in Binary Authorization, your policy's `enforcementMode` is set to `REQUIRE_ATTESTATION`.

Creating attestations:

```
gcloud alpha container binauthz attestations create \
    --project="${ATTESTATION_PROJECT_ID}" \
    --artifact-url="${IMAGE_TO_ATTEST}" \
    --attestor="projects/${ATTESTOR_PROJECT_ID}/attestors/${ATTESTOR_NAME}" \
    --signature-file=/tmp/ec_signature \
    --public-key-id="${PUBLIC_KEY_ID}" \
    --validate
```

Using Cloud KMS:

```
gcloud beta container binauthz attestations sign-and-create \
    --project="${ATTESTATION_PROJECT_ID}" \
    --artifact-url="${IMAGE_TO_ATTEST}" \
    --attestor="${ATTESTOR_NAME}" \
    --attestor-project="${ATTESTOR_PROJECT_ID}" \
    --keyversion-project="${KMS_KEY_PROJECT_ID}" \
    --keyversion-location="${KMS_KEY_LOCATION}" \
    --keyversion-keyring="${KMS_KEYRING_NAME}" \
    --keyversion-key="${KMS_KEY_NAME}" \
    --keyversion="${KMS_KEY_VERSION}"
```

From a user's perspective, the Binary Authorization policy may incorrectly block an image or there may be another issue with the successful operation of the admission controller webhook.

In this "emergency" case, there is a "break glass" capability that leverages a specific annotation to signal to the admission controller to run the pod and skip policy enforcement.

Note: You will want to notify a security team when this occurs as this can be leveraged by malicious users if they have the ability to create a pod.
In this case, though, your response procedures can be started within seconds of the activity occurring. The logs are available in Stackdriver:

To run an unsigned nginx container with the "break glass" annotation, run:

```
cat << EOF | kubectl create -f -
apiVersion: v1
kind: Pod
metadata:
  name: nginx-alpha
  annotations:
    alpha.image-policy.k8s.io/break-glass: "true"
spec:
  containers:
  - name: nginx
    image: "nginx:latest"
    ports:
    - containerPort: 80
EOF
```
#### Container Best Practices
A full list of best practices can be found [here](https://cloud.google.com/blog/products/gcp/7-best-practices-for-building-containers).

Highlights:

* Single App Per Container
  * Ex (Apache/MySQL/PHP stack):
    * Each should be their own container
* Properly handle PID 1, signal handling and zombie processes
  * Handle SIGTERM/SIGKILL in you application
  * Lauch process using `CMD` or `ENTRYPOINT`
    * If additional preparation is needed before launching your process, launch a shell script using the `exec` command.
  * Docker and k8s can only handle signals to the process that has PID 1 inside a container
* Remove unnecessary tools
  * ex (netcat, tracing or debugging tools)
* Avoid running as root
  * ex disable use of sudo
* Launch Containers is RO model `--read-only` docker command flag or `readOnlyRootFilesystem` option in Kubernetes.
  * This can also be enforced using a [`PodSecurityPolicy`](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems)
* Build the smallest image as possible
  * [Reduce clutter in your image](https://cloud.google.com/solutions/best-practices-for-building-containers#reduce_the_amount_of_clutter_in_your_image).
* Use vulnerability scanning in Container Registry
* Enable process namespace sharing in kubernetes  
  - Process namespace sharing for a Pod can be enabled where kubernetes uses a single process namespace for all containers in that Pod
  - Kubernetes Pod infrastructure container becomes PID 1 and automatically reaps orphaned processes
* Use a speicialize init system
  - Init systems suche as `tini` created especially for containers that can be used to handle signals and reaps any zombie processes
* Optimize for the Docker build cache
  - Images are built layer by layer, and in a Dockerfile, each instruction creates a layer in the resulting image.
  - Docker build cache can accelerate the building of container images.
  - During a build, when possible, Docker reuses a layer from a previous build and skips a potentially costly step.
  - Docker can use its build cache only if all previous build steps used it.
* Scan images for vulnerabilities
  - Container Analysis API (On-Demand Scanning, )



</details>

<details>
<summary> 4.2 - Configuring logging, monitoring, and detection </summary>

### 4.2.a - Configuring and analyzing network logs (firewall rules, VPC flow logs, packet mirroring)

#### VPC Flow Logs
VPC Flow Logs records network flows sent from or received by VM instances.
VPC flow logs will only include traffic seen by a VM (e.g., if traffic was blocked by an egress rule, it will be seen but traffic blocked by an ingress rule, not reaching a VM, will not be seen.

The traffic will include:
* Network flows between VMs in the same VPC
* Network flows between VMs in a VPC network and hosts in your on-premises network that are connected via VPN or Cloud Interconnect
* Network flows between VMs and end locations on the Internet
* Network flows between VMs and Google services in production Protocols: you can monitor network flows for TCP and UDP.

These logs can be used to monitor network traffic to and from your VMs, forensics, real-time security analysis, and expense optimization.

You can view flow logs in Cloud Logging, and you can export logs to any destination that Cloud Logging export supports (Cloud Pub/Sub, BigQuery, etc.).

Flow logs are aggregated by connection, at a 5 second interval, from Compute engine instances and exported in real time. By subcribing to Cloud Pub/Sub, you can analyze flow logs using real-time streaming.

VPC Flow Logs service is disabled by default on all VPC subnets. When enabled it applies to all VM instances in the subnet.

Logs are stored in Logging for 30 days by default.

**Log sampling and processing**
Google Cloud samples packets that leave and enter a VM to generate flow logs. Not every packet is captured into its own log record. About 1 out of every 30 packets is captured, but this sampling rate might be lower depending on the VM's load. You cannot adjust this rate.

After the flow logs are generated, Google Cloud processes them according to the following procedure:

1. **Filtering**: You can specify that only logs that match specified criteria are generated. For example, you can filter so that only logs for a particular VM or only logs with a particular metadata value are generated and the rest are discarded.
2. **Aggregation**: Information for sampled packets is aggregated over a configurable aggregation interval to produce a flow log entry. Time interval can be set to either: 5 seconds (default), 30 seconds, 1, 5, 10 or 15 minutes
3. **Flow log sampling**: This is a second sampling process. Flow log entries are further sampled according to a configurable sample rate parameter. Rate can be configured: 0.5 (50%) is default, 1.0 (100% all logs kept) down to 0 where no logs are kept.
4. **Metadata**: If disabled, all Metadata annotations are discarded. If you want to keep metadata, you can specify that all fields or a specified set of fields are retained. Refer to [metadata annotations](https://cloud.google.com/vpc/docs/flow-logs#metadata) for details.
5. **Write to Logging**: The final log entries are written to Cloud Logging.

To log flows between Pods on the same Google Kubernetes Engine (GKE) node, you must enable Intranode visibility for the cluster by ussing the following command:

```
gcloud container clusters create CLUSTER_NAME \
    --region=COMPUTE_REGION \
    --enable-intra-node-visibility

or

gcloud container clusters update CLUSTER_NAME \
    --enable-intra-node-visibility
```

Use the `--no-enable-intra-node-visibility` flag when updating a cluster to disbale intranode visibility.

Enabling VPC Flow Logs can be done via Console (at any time) using the CLI.

```
gcloud compute networks subnets create|update subnet-name \
    --enable-flow-logs \
    [--logging-aggregation-interval=aggregation-interval \
    [--logging-flow-sampling=0.0...1.0] \
    [--logging-filter-expr=expression] \
    [--logging-metadata=(include-all | exclude-all | custom)] \
    [--logging-metadata-fields=fields] \
    [other flags as needed]
```

Disbaling VPC flow logs:
```
gcloud compute networks subnets update SUBNET_NAME \
    --no-enable-flow-logs
```

[VPC Flow Log Lab](https://www.qwiklabs.com/focuses/1236?parent=catalog)

#### VPC Flow Logs Org policies

Org Admins can set the `constraints/compute.requireVpcFlowLogs` constraint to require that VPC flow logs is enabled for all subnets. Sampling rates can be set to either of the the following:

| Policy Value | Sample rate |
| ------------ | ----------- |
| ESSENTIAL    | Greater than or equal to 0.1 (10%) and less than 0.5 (50%)|
| LIGHT   | Greater than or equal to 0.5 (50%) and less than 1.0 (100%)|
| COMPREHESIVE   | Equal to 1.0 (100%)   |

These policy values can be combined:

| Sample rate | Values to include in constraint |
| ----------  | ------------------------------- |
| At least 0.1 (10%) | ESSENTIAL, LIGHT, and COMPREHESIVE   |
| At least 0.5 (50%) | LIGHT and COMPREHESIVE   |
| 1.0 (100%)   | COMPREHESIVE   |

Configuring VPC Flow log constraint:

```
gcloud org-policies describe \
    compute.requireVpcFlowLogs \
    [ --organization=ID | --folder=ID | --project=ID ]

** /tmp/policy.yaml **
name: organizations/ID/policies/compute.requireVpcFlowLogs
    spec:
     rules:
     - values:
         allowedValues:
         - ESSENTIAL
         - LIGHT
         - COMPREHENSIVE

gcloud org-policies set-policy /tmp/policy.yaml
```


#### Firewall Rules logging
Firewall Rules Logging allows you to audit, verify, and analyze the effects of your firewall rules. For example, you can determine if a firewall rule designed to deny traffic is functioning as intended. Logging is also useful if you need to determine how many connections are affected by a given firewall rule. Firewall rule logs are created in the project that hosts the network containing the VM instances and firewall rules. With Shared VPC, VM instances are created in service projects, but they use a Shared VPC Network located in the host project. Firewall rules logs are stored in that host project.

**Enable**
```
gcloud compute firewall-rules update NAME \
    --enable-logging
    --logging-metadata=LOGGING_METADATA
```

**Disable**
```
gcloud compute firewall-rules update NAME \
    --no-enable-logging
```

Querying firewall rules in Logs Explorer

```
resource.type="gce_subnetwork"
logName="projects/PROJECT_ID/logs/compute.googleapis.com%2Ffirewall"

or

resource.type="gce_subnetwork"
logName="projects/PROJECT_ID/logs/compute.googleapis.com%2Ffirewall"
resource.labels.subnetwork_name="SUBNET_NAME"

or

resource.type="gce_subnetwork"
logName="projects/PROJECT_ID/logs/compute.googleapis.com%2Ffirewall"
jsonPayload.instance.vm_name="INSTANCE_NAME"
```

#### Packet mirroring
Packet Mirroring clones the traffic of specified instances in your Virtual Private Cloud (VPC) network and forwards it for examination. Packet Mirroring captures all traffic and packet data, including payloads and headers. The capture can be configured for both egress and ingress traffic, only ingress traffic, or only egress traffic.

The mirroring happens on the virtual machine (VM) instances, not on the network. Consequently, Packet Mirroring consumes additional bandwidth on the VMs.

Packet Mirroring is useful when you need to monitor and analyze your security status. It exports all traffic, not only the traffic between sampling periods. For example, you can use security software that analyzes mirrored traffic to detect all threats or anomalies.

Use Packet Mirroring to mirror traffic to and from particular VM instances. You can use the collected traffic to help you detect security threats and monitor application performance. Mirrored traffic is sent to VMs where you have installed appropriate software. See [Packet mirroring partner providers](https://cloud.google.com/vpc/docs/packet-mirroring-partners) for a list of vendors who supply software.

![Packet Mirroring Same Network](https://cloud.google.com/static/vpc/images/packet-mirroring/same-network.svg)

![Packet Mirror peered network](https://cloud.google.com/static/vpc/images/packet-mirroring/peer-network.svg)

![Packet Mirroring Shared VPC](https://cloud.google.com/static/vpc/images/packet-mirroring/service-project.svg)

**IAM Roles**

* `compute.packetMirroringUser`: grants user permission to create, update, and delete packet mirroring policies. To use Packet mirroring this roles is reqired by users.
* `compute.packetMirroringAdmin`: grants users persmission to mirror particular resources. Even if users have permissions to create a packet mirrroring policy, they still require persmission to mirror related sources. Use this role in projects where the owner of a policy might not have any permissions.

**Create a mirroring policy**
You must have an internal TCP/UDP load balancer that is configured for packet mirroring, and it must be located in the same region as the instances that you're mirroring. All traffic from mirrored sources is sent to the collector instances that are behind the load balancer.

Create the forwarding rule for the internal TCP/UDP load balancer, use the --is-mirroring-collector flag:
```
gcloud compute forwarding-rules create COLLECTOR_RULE \
    --region=REGION \
    --load-balancing-scheme=internal \
    --backend-service=COLLECTOR_BACKEND_SERVICE \
    --ports=all \
    --is-mirroring-collector \
    --network=NETWORK
```

Create the packet mirroring policy:
```
gcloud compute packet-mirrorings create POLICY_NAME \
  --region=REGION \
  --network=NETWORK_NAME \
  --collector-ilb=FORWARDING_RULE_NAME \
  [--mirrored-subnets=SUBNET,[SUBNET,...]] \
  [--mirrored-tags=TAG,[TAG,...]] \
  [--mirrored-instances=INSTANCE,[INSTANCE,...]] \
  [--filter-cidr-ranges=ADDRESS_RANGE,[ADDRESS_RANGE,...]] \
  [--filter-protocols=PROTOCOL,[PROTOCOL,...]] \
  [--filter-direction=DIRECTION]
```

`PROTOCOL` is an IP protocol to mirror. Valid values are tcp, udp, icmp, esp, ah, ipip, sctp, or an IANA protocol number. You can provide multiple protocols in a comma-separated list. If --filter-protocols is omitted, all protocols are mirrored.

`DIRECTION` is the direction of the traffic to be mirrored relative to the VM. By default, this is set to BOTH, which means that both ingress and egress traffic is mirrored. You can restrict which packets are captured by specifying INGRESS to capture only ingress packets or EGRESS to capture only egress packets.

Disbale / Enable a packet mirroring policy to stop or start collection

```
gcloud compute packet-mirrorings update POLICY_NAME \
  --region=REGION \
  --no-enable

or

gcloud compute packet-mirrorings update POLICY_NAME \
  --region=REGION \
  --enable
```

Delete a packet mirror policy:

```
gcloud compute packet-mirrorings delete POLICY_NAME \
  --region=REGION \
```


### 4.2.b - Designing an effective logging strategy

Cloud Logging is a fully managed service that allows you to store, search, analyze, monitor, and alert on logging data and events from Google Cloud and Amazon Web Services.

Using Cloud Logging includes access to the [BindPlane service](https://bluemedora.com/products/bindplane/bindplane-for-stackdriver/), which you can use to collect logging data from over 150 common application components, on-premises systems, and hybrid cloud systems.

The [Legacy Logging Agent](https://cloud.google.com/logging/docs/agent/logging?_gl=1*1hxxzo6*_up*MQ..&gclid=Cj0KCQjwjNS3BhChARIsAOxBM6p7uZWJOQBlsjeu7HM1eYG9JE_4jsiKUj-Wr2W7TmfIYEcGzac_v1kaAhMQEALw_wcB&gclsrc=aw.ds), an application based on [fluentd](https://www.fluentd.org/), which runs on VMs in order to stream logs into Cloud Logging.

The [OpsAgent](https://cloud.google.com/logging/docs/agent/ops-agent?_gl=1*1hxxzo6*_up*MQ..&gclid=Cj0KCQjwjNS3BhChARIsAOxBM6p7uZWJOQBlsjeu7HM1eYG9JE_4jsiKUj-Wr2W7TmfIYEcGzac_v1kaAhMQEALw_wcB&gclsrc=aw.ds), is the preferred and primary agent for collecting telemetry from Compute Engine instances

Use structure logging, as shown below:

```
{
  "insertId": "42",
  "jsonPayload": {
    "message": "There was an error in the application",
    "times": "2019-10-12T07:20:50.52Z"
  },
  "httpRequest": {
    "requestMethod": "GET"
  },
  "resource": {
    "type": "k8s_container",
    "labels": {
      "container_name": "hello-app",
      "pod_name": "helloworld-gke-6cfd6f4599-9wff8",
      "project_id": "stackdriver-sandbox-92334288",
      "namespace_name": "default",
      "location": "us-west4",
      "cluster_name": "helloworld-gke"
    }
  },
  "timestamp": "2020-11-07T15:57:35.945508391Z",
  "severity": "ERROR",
  "labels": {
    "user_label_2": "value_2",
    "user_label_1": "value_1"
  },
  "logName": "projects/stackdriver-sandbox-92334288/logs/stdout",
  "operation": {
    "id": "get_data",
    "producer": "github.com/MyProject/MyApplication",
    "first": true
  },
  "trace": "projects/my-projectid/traces/06796866738c859f2f19b7cfb3214824",
  "sourceLocation": {
    "file": "get_data.py",
    "line": "142",
    "function": "getData"
  },
  "receiveTimestamp": "2020-11-07T15:57:42.411414059Z",
  "spanId": "000000000000004a"
}
```

You can write structured logs to Logging in several ways:

* Using the Cloud Logging API to write log entries
  - https://cloud.google.com/logging/docs/samples/logging-write-log-entry
* Using Cloud Logging client libraries
  * https://cloud.google.com/logging/docs/reference/libraries
* Using the Google Cloud CLI to write log entries
  * `gcloud logging write LOG_NAME '{"key" : "value"} --payload-type=json'`
* Using the BindPlane service to ingest logs
  * https://docs.bindplane.observiq.com/docs/getting-started
* Write logs by using an agent (OpsAgent or Legacy Cloud Logging Agent)

App Engine (Standard and Flexibile) has built-in support for writing logs to Cloud Logging.

Google Kubernetes Engine (GKE) node instances have built-in support also for writing to Cloud Logging. [Cloud Operations for GKE](https://cloud.google.com/monitoring/kubernetes-engine/installing) can be enabled on new or existing cluster to add cluster wide logging.

Cloud Run and Cloud Functions (HTTP and Background) have built-in support for writing logs to Cloud Logging.

**Ops Agent**

Requires the `roles/osconfig.osPolicyAssignmentEditor` to install and configure Ops Agent

OpsAgent is the primary agent for collecting telemetry from you compute engine instances. Combines the collection of logs, metrics, and traces into a single process.

Uses [Fluent Bit](https://fluentbit.io/) for logs, which supports high-throughput logging, and the [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/) for metrics and traces.

Leverages YAML for configuration

Can be installed on Dataproc clusters that use image version 2.2 and later to collect syslog logs and host metrics. 

[Supported OS](https://cloud.google.com/stackdriver/docs/solutions/agents/ops-agent#supported_operating_systems)

[Install OpsAgent](https://cloud.google.com/stackdriver/docs/solutions/agents/ops-agent/install-index)

VM Manager uses OS configuration policies to manage Ops Agent installation. . A configuration policy is applied to a VM by using a mapping called an assignment ID, which looks like the following example:
`goog-ops-agent-v2-x86-template-1-0-0-ZONE`

Build-in configuration
```
logging:
  receivers:
    syslog:
      type: files
      include_paths:
      - /var/log/messages
      - /var/log/syslog
  service:
    pipelines:
      default_pipeline:
        receivers: [syslog]
metrics:
  receivers:
    hostmetrics:
      type: hostmetrics
      collection_interval: 60s
  processors:
    metrics_filter:
      type: exclude_metrics
      metrics_pattern: []
  service:
    pipelines:
      default_pipeline:
        receivers: [hostmetrics]
        processors: [metrics_filter]
```

To override the built-in configuration, you add new configuration elements to the user configuration file. Put your configuration for the Ops Agent in the following files:

* For Linux: /etc/google-cloud-ops-agent/config.yaml
* For Windows: C:\Program Files\Google\Cloud Operations\Ops Agent\config\config.yaml

The `receiver` element contains a set of receivers which describes how to retrieve the logs,for example, by tailing files, by using a TCP port, or from the Windows Event Log.

Each receiver includes a `type` element the following are the valid types:
* `files`: 
  * Collect logs by tailling files on disk
  * Additional Options:
    * `include_paths`: (Required), list of filesystem paths to read
    * `exclude_paths`: list of fs paths to exclude
    * `record_log_file_path`: (true|false), if true then the path to the specific file from which the log record was obtained appears in the output log entry as the value of the
    * `wildcard_refresh_interval`: The interval at which wildcard file paths in include_paths are refreshed
* `fluent_forward`: 
  * (Ops Agent versions 2.12.0 and later)
  * Collect logs sent via the Fluent Forward protocol over TCP
  * Additional Options:
    * `listen_host`: An IP address to listen on. The default value is 127.0.0.1.
    * `listen_port`: A port to listen on. The default value is 24224.
* `tcp`:
  * Ops Agent version 2.3+
  * Collects logs in JSON by listening to a TCP port
  * Additional Options:
    * `format`: Required. Log format. Supported value: json.
    * `listen_host`: Optional. An IP address to listen on. The default value is 127.0.0.1.
    * `listen_port`: Optional. A port to listen on. The default value is 5170.
* Linux Only
  * `syslog`: 
    * Collect Syslog messages over TCP or UDP
    * Additional Options:
      * `transport_protocol`: Optional. Supported values: tcp, udp. The default is tcp.
      * `listen_host`: Optional. An IP address to listen on. The default value is 0.0.0.0.
      * `listen_port`: Optional. A port to listen on. The default value is 5140.
  * `systemd_journald`
    * Ops Agent 2.4+
    * Collect systemd journal logs from the systemd-journald service
* Windows Only
  * `windows_even_log`: 
    * Collect Windows Event Logs using the Windows Event Log API
    * Additional Options:
      * `channels`: Required. A list of Windows Event Log channels from which to read logs.
      * `receiver_version`: Optional. Controls which Windows Event Log API to use. Supported values are 1 and 2. The default value is 1.
      * `render_as_xml`: Optional. If set to true, then all Event Log fields, except for jsonPayload.Message and jsonPayload.StringInserts, are rendered as an XML document in a string field named jsonPayload.raw_xml. The default value is false. This cannot be set to true when receiver_version is 1.


**Legacy Logging Agent**

Cloud Logging Agent, `google-fluentd`, is a modified version of [fluentd](https://www.fluentd.org/) log data collector.

How Cloud Logging Agent Works:
![Logging Agent](https://cloud.google.com/static/logging/docs/images/logging-agent-operation.png)

If your VMs are running in Google Kubernetes Engine or App Engine, the agent is already included in the VM image, so you can skip this page.

The VM images for Compute Engine and Amazon Elastic Compute Cloud (EC2) don't include the Logging agent so you need to install it. The agent runs under both Linux and Windows.

![Logging Agent](images/logging-agent-operation.png)

The agent is supported on GCP Compute Engine instances and AWS EC2 instances, which sends logs to an [AWS Connector Project](https://cloud.google.com/monitoring/accounts#account-project) in GCP.



**Install Cloud Logging Agent**

Linux:

```
curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh --also-install
```

Windows:

```
(New-Object Net.WebClient).DownloadFile("https://dl.google.com/cloudagents/windows/StackdriverLogging-v1-19.exe", "${env:UserProfile}\StackdriverLogging-v1-19.exe")
& "${env:UserProfile}\StackdriverLogging-v1-19.exe"
```

**Enable Strucuture Logging**

Linux:

```
sudo yum remove -y google-fluentd-catch-all-config
sudo yum install -y google-fluentd-catch-all-config-structured
sudo service google-fluentd restart


OR

sudo apt-get remove -y google-fluentd-catch-all-config
sudo apt-get install -y google-fluentd-catch-all-config-structured
sudo service google-fluentd restart
```

windows

```
Restart-Service -Name StackdriverLogging
```

#### Log Storage

GCP leverages the _Logs Router_, which checks the log entry against a set of rules to determine which logs to discard, write/ingest/store in Cloud Logging and which logs to route to other destinations using _sinks_. The supported sink destinations are:

* Cloud Storage: JSON Files stored in GCS buckets; provides inexpensive, long-term storage
* BigQuery: Tables created in BigQuery datasets; provides big data analysis capabilities
* Pub/Sub: JSON-formatted messages delivered to Pub/Sub Topics; supports third-party integrations, such as Splunk, with Logging
* Cloud Logging: Log entries held in log buckets; provides storage in Cloud Logging with customizable retention periods.


![Cloud Logging Storage](https://cloud.google.com/static/logging/docs/images/routing-overview-17-09-21.png)

**Log Exclusions**

There are 2 kinds of exclusions:
* Exclusion Filters:
  * based on a filter expression
* Resource-type exclusions:
  * block all logs from a specific resource types

[Creating Exclusions](https://cloud.google.com/logging/docs/exclusions)

Logs entries can be exported to Cloud Storage, BigQuery or Pub/Sub before they are excluded and they are logs are lost forever.

**Log Retention Periods**
Two log buckets

* _Required
  * [Admin Activity audit logs](https://cloud.google.com/logging/docs/audit#admin-activity), [System Event audit logs](https://cloud.google.com/logging/docs/audit#system-event) and [Access Transparency logs](https://cloud.google.com/logging/docs/audit/access-transparency-overview)
    * Logs generated by Google personnel when they user uploaded content into any service that supports Access Transparency Logs see this [list](https://cloud.google.com/logging/docs/audit/access-transparency-services).
  * 400 day retention
  * Not configurable
* _Default
  * All other ingested logs
  * rentention
    * 7 days on Basic and 30 days on Premium
  * Configurable upto 3650 days
  *  `gcloud beta logging buckets update _Default --location=global --retention-days=[RETENTION_DAYS]`


See [IAM Documentation](https://cloud.google.com/logging/docs/access-control) for all Cloud Logging Roles/Permissions

Setup


### 4.2.c - Logging, monitoring, responding to, and remediating security incidents

#### Cloud Monitoring and Alerting
Cloud Monitoring uses _Workspaces_ to organize monitoring information contained in one or more GCP projects or AWS Accounts.

Each workspace has a _host project_.The host project is the Google Cloud project used to create the Workspace. The name of the Workspace is set to the name of host project. **This isn't configurable.**

A _Workspace_ can be configured to monitor up to 100 GCP projects and AWS accounts.

![Cloud Monitoring Workspaces](images/Workspaces-1.0c.png)

#### Cloud Monitoring Agent
The Cloud Monitoring agent is a [collectd](https://collectd.org/)-based daemon that gathers system and application metrics from virtual machine instances and sends them to Monitoring. By default, the Monitoring agent collects disk, CPU, network, and process metrics.

The Cloud Monitoring agent is s optional but recommended to be installed on all VMs (GCE and AWS EC2) that you wish to monitor. Monitoring can access some instance metrics without the Monitoring agent, including CPU utilization, some disk traffic metrics, network traffic, and uptime information. Monitoring uses the Monitoring agent to access additional system resources and application services in virtual machine (VM) instances. If you want these additional capabilities, you should install the Monitoring agent.


* App-Engine Standard has built-in Monitoring support, no agent required.
* App Engine Flexible, Dataflow, Dataproc have pre-installed agents with service-specific configurations
* GKE
  * has Cloud Operations for GKE pre-installed which offers monitoring and logging enabled by default

#### Alerting
Cloud Monitoring allows alerting to give timely awareness to problems in you cloud apps so they can be resolved quickly.

This is accomplished by setuping _Alerting Policies_. Each policies contains:
  * Conditions:
    * identify when a resource or a group of resources are in a state that require action to be taken.
    * Type of conditions can be found [here](https://cloud.google.com/monitoring/alerts/types-of-conditions).
  * Notifications:
    * Where to send the alert to:
      * Email
      * Page Duty
      * Slack
      * SMS
      * Webhooks
      * Pub/Sub
  * Documentation:
    * Any details around how to solve the issue.

In order to create alerting policies the user must have one of the following IAM roles assigned:
  * `roles/monitoring.alertPolicyEditor`
  * `role/monitoring.editor`
  * `role/monitoring.admin`
  * `role/owner`



### 4.2.d - Exporting logs to external systems

#### Exporting Logs
Exporting involves writing a filter that selects the log entries you want to export, and choosing a destination in Cloud Storage, BigQuery, Pub/Sub, or Cloud Logging. The filter and destination are held in an object called a sink. Sinks can be created in Google Cloud projects, organizations, folders, and billing accounts.

To create sinks, the user must have the IAM roles of `role/owner` or `role/logging.configWriter`.

Logging export scenerios and best practices can be found [here](https://cloud.google.com/solutions/design-patterns-for-exporting-stackdriver-logging).

When logs are exported to BigQuery, dated tables are created to hold log entries and log entries are placed in the tables whose names are based on the entries' log names.

#### Exporting logs to external systems
* Splunk
  * [Pub/Sub logs To Splunk via Dataflow](https://cloud.google.com/solutions/exporting-stackdriver-logging-for-splunk#deploy_splunk_dataflow_template)
    * create a Dataflow job that pulls messages from the previously created Pub/Sub subscription, converts payloads into Splunk HEC event format, and forwards them to Splunk HEC.
  * [Splunk-Add on For Google Cloud](https://cloud.google.com/solutions/exporting-stackdriver-logging-for-splunk#configure_splunk_add-on_for_gcp)
    * The Splunk Add-on for Google Cloud uses the Pub/Sub topic and a service account in Google Cloud. The service account is used to generate a private key that the add-on uses to establish a Pub/Sub subscription and ingest messages from the logging export topic. The appropriate IAM permissions are required to allow the service account to create the subscription and list the components in the Pub/Sub project that contains the subscription.
* ElasticSearch:
  *  The [Elastic Stack](https://www.elastic.co/products) has multiple solutions for ingesting data into an Elasticsearch cluster. [Logstash](https://www.elastic.co/products/logstash) and [Beats](https://www.elastic.co/products/beats) are the core products used for collecting, transforming, and ingesting data. Choosing between Logstash and Beats depends on your data volume, ingest rates, and latency requirements. This solution focuses on the Logstash component of the Elastic Stack because Logstash is the most flexible option for working with logs exported from Logging.
     *  Logstash
        *  Use [Pub/Sub input plugin](https://github.com/logstash-plugins/logstash-input-google_pubsub) and [Cloud Storage input plugin](https://github.com/josephlewis42/logstash-input-google_cloud_storage) to integrate with Logstash.



### 4.2.e - Configuring and analyzing Google Cloud Audit logs and data access Logs

Google Cloud services write audit logs to help you answer the questions, "Who did what, where, and when?" within your Google Cloud resources. Your Google Cloud projects contain only the audit logs for resources that are directly within the Cloud project. Other Google Cloud resources, such as folders, organizations, and billing accounts, contain the audit logs for the entity itself.

Audit Logs are comprised of the following two type which are stored in Cloud Logging:
* **Admin Activity Logs**: Includes "admin write" operations that write metadata or configuration information. You can't disable Admin Activity audit logs.
* **Data Access audit logs**: Includes "admin read" operations that read metadata or configuration information. Also includes "data read" and "data write" operations that read/write user-provided data. Data Access audit logs are disabled by default and aren't written unless explicitly enabled (the exception is Data Access audit logs for BigQuery, which can't be disabled).

**IAM Permissions and Roles**
* `roles/logging.viewer`: read/only access to Admin Activity, Policy Denied, and System Event audit logs. You cannot view any Data Access Logs.
* `roels/logging.privateViewer`: includes permissions from `roles/logging.viewer` plus the ability to read Data Access logs in the `_Required` and `_Default` buckets.

Reading Audti logs using gcloud:
```
gcloud logging read "logName : projects/PROJECT_ID/logs/cloudaudit.googleapis.com" \
    --project=PROJECT_ID | --folder=FOLDER_ID | --organization=ORG_ID | --billing-account=BILLING_ACCOUNT_ID
```

**Configuring Data Access Audit logs**
https://cloud.google.com/logging/docs/audit/configure-data-access

The audit log configuraion consists of a list of _AuditConfig_ objects. Each object configures teh logs for one service, or it establishes a broader configuration for all services. Looks like the following:

```
{
  "service": SERVICE,
  "auditLogConfigs": [
    {
      "logType": "ADMIN_READ"
      "exemptedMembers": [ PRINCIPAL,]
    },
    {
      "logType": "DATA_READ"
      "exemptedMembers": [ PRINCIPAL,]
    },
    {
      "logType": "DATA_WRITE"
      "exemptedMembers": [ PRINCIPAL,]
    },
  ]
},
```

The following applies for _allServices_ as well as a fine grain exemption for cloud sql:

```
"auditConfigs": [
  {
    "auditLogConfigs": [
      {
        "logType": "ADMIN_READ"
      },
      {
        "logType": "DATA_WRITE"
      },
      {
        "logType": "DATA_READ"
      }
    ],
    "service": "allServices"
  },
  {
    "auditLogConfigs": [
      {
        "exemptedMembers": [
          "499862534253-compute@developer.gserviceaccount.com"
        ],
        "logType": "ADMIN_READ"
      }
    ],
    "service": "cloudsql.googleapis.com"
  }
],
```

Use the [setIamPolicy API](https://cloud.google.com/resource-manager/reference/rest/v1/projects/setIamPolicy#http-request) to update the policy binding:

```
{
  "auditConfigs": [
    {
      "auditLogConfigs": [
        {
          "logType": "ADMIN_READ"
        },
        {
          "logType": "DATA_WRITE"
        },
        {
          "logType": "DATA_READ"
        }
      ],
      "service": "allServices"
  },
  "bindings": [
  {
    "members": [
      "user:colleague@example.com"
    ],
    "role": "roles/editor"
  },
  {
    "members": [
      "user:myself@example.com"
    ],
    "role": "roles/owner"
  }
],
"etag": "BwUsv2gimRs="
"version": 1
```

Using gcloud:

```
--> tmp/policy.YAML

auditConfigs:
- auditLogConfigs:
  - logType: DATA_WRITE
  service: cloudsql.googleapis.com
bindings:
- members:
  - user:colleague@example.com
  role: roles/editor
- members:
  - user:myself@example.com
  role: roles/owner
etag: BwVM-FDzeYM=
version: 1

$ gcloud projects set-iam-policy PROJECT_ID /tmp/policy.yaml

or using json

$ gcloud projects set-iam-policy PROJECT_ID --format=json >/tmp/policy.json


```

_biindings_ and _etag_ MUST always be present as per https://cloud.google.com/logging/docs/audit/configure-data-access#updatemask.



### 4.2.f - Configuring Log exports (log sinks, aggregated sinks, logs router)

**IAM Roles/Permissions**

You have one of the following IAM roles for the Google Cloud organization or folder from which you're routing logs.

* Owner (roles/owner)
* Logging Admin (roles/logging.admin)
* Logs Configuration Writer (roles/logging.configWriter)

**Create Logging Sinks - Command Line Samples**

```
gcloud logging sinks create  NEW_SINK_NAME  DESTINATION  --log-filter="..." ...
```
The above command is the general gcloud command to create a sink for exporting logs.

You can leverage one of the following additional flags `--folder`,`--billing-account`, and `--organization` to export logs from those resources. NOTE that by default, using these flags restricts the sink to exporting only the logs held in the named folder, organization, or billing account.

If you additionally add the `--include-children` flag, then the sink becomes an `aggregated` sink and the sink exports logs from all folders and projects contained within the named resource, subject to the filter in the `--log-filter` flag.

Also note that Billing accounts don't contain folders or projects, so `--include-children` has no effect with `--billing-account`.


For example, if you're creating an aggregated sink at the folder level and whose destination is a BigQuery dataset, your command might look like the following:

```
gcloud logging sinks create SINK_NAME \
bigquery.googleapis.com/projects/PROJECT_ID/datasets/DATASET_ID --include-children \
--folder=FOLDER_ID --log-filter="logName:activity"
```

Filter queries:

```
logName:"projects/PROJECT_ID/logs" AND
resource.type=RESOURCE_TYPE AND
resource.labels.instance_id=INSTANCE_ID

OR

logName:("projects/PROJECT_A_ID/logs/" OR "projects/PROJECT_B_ID/logs/") AND ...

OR

logName:"folders/FOLDER_ID/logs/" AND ...

OR

logName:"organizations/ORGANIZATION_ID/logs/" AND ...
```

When you create a sink, Logging creates a new service account for the sink, called a unique writer identity. Your sink destination must permit this service account to write log entries. You can't manage this service account directly as it is owned and managed by Cloud Logging. The service account is deleted if the sink gets deleted.

To route logs to a resource protected by a service perimeter, you must add the service account for that sink to an access level and then assign it to the destination service perimeter. This isn't necessary for non-aggregated sinks. For details, see [VPC Service Controls: Cloud Logging](https://cloud.google.com/vpc-service-controls/docs/supported-products#logging).

**Get the service account from the `writerIdentity` field in the sink**

```
gcloud logging sinks describe SINK_NAME
```

Should look something like this:

```
serviceAccount:p123456789012-12345@gcp-sa-logging.iam.gserviceaccount.com
```

Setup the IAM policy (this example routing logs between Logging buckets in different Cloud projects):

```
{
"bindings": [
 {
   "members": [
     "user:username@gmail.com"
   ],
   "role": "roles/owner"
 },
 {
   "members": [
     "SERVICE_ACCOUNT"
   ],
   "role": "roles/logging.bucketWriter",
   "condition": {
       "title": "Bucket writer condition example",
       "description": "Grants logging.bucketWriter role to service account SERVICE_ACCOUNT used by sink SINK_NAME",
       "expression":
         "resource.name.endsWith(\'locations/global/buckets/BUCKET_ID\')"
   }
 }
],
"etag": "BwWd_6eERR4=",
"version": 3
}

$ gcloud projects set-iam-policy DESTINATION_PROJECT_ID output.json
```

### 4.2.g - Configuring and monitoring Security Command Center (Security Health Analytics, Event Threat Detection, Container Threat Detection, Web Security Scanner)

#### Cloud Security Command Center
Security Command Center is the canonical security and risk database for Google Cloud. Security Command Center is an intuitive, intelligent risk dashboard and analytics system for surfacing, understanding, and remediating Google Cloud security and data risks across an organization. This is the Security Information and Event Management (SIEM) solution in GCP.

##### Tiers
* Standard Features
  * [Security Health Analytics](https://cloud.google.com/security-command-center/docs/concepts-security-health-analytics-overview)
    * Managed vulnerability assessment scanning for Google Cloud that can automatically detect the highest severity vulnerabilities and misconfigurations for GCP assets.
      - In Standard Tier the following finding types are included:
        - DATAPROC_IMAGE_OUTDATED
        - LEGACY_AUTHORIZATION_ENABLED
        - MFA_NOT_ENFORCED
        - NON_ORG_IAM_MEMBER
        - OPEN_CISCOSECURE_WEBSM_PORT
        - OPEN_DIRECTORY_SERVICES_PORT
        - OPEN_FIREWALL
        - OPEN_GROUP_IAM_MEMBER
        - OPEN_RDP_PORT
        - OPEN_SSH_PORT
        - OPEN_TELNET_PORT
        - PUBLIC_BUCKET_ACL
        - PUBLIC_COMPUTE_IMAGE
        - PUBLIC_DATASET
        - PUBLIC_IP_ADDRESS
        - PUBLIC_LOG_BUCKET
        - PUBLIC_SQL_INSTANCE
        - SSL_NOT_ENFORCED
        - WEB_UI_ENABLED
  * [Web Security Scanner custom scans](https://cloud.google.com/security-command-center/docs/how-to-web-security-scanner-custom-scans)
    - In standard tier, Web Security Scanner supports custom scans of deployed applications with public URLs and IP addresses that aren't behind a firewall. Scans are manually configured, managed, and executed for all projects, and support a subset of categories in the [OWASP Top Ten](https://owasp.org/www-project-top-ten/).
  * [Security Command Center errors](https://cloud.google.com/security-command-center/docs/concepts-scc-errors)
    - Security Command Center provides detection and remediation guidance for configuration errors that prevent Security Command Center and its services from functioning properly.
  * Support for granting IAM access roles at the Org Level
  * Access to integrated Google Cloud services, including the following:
    - Cloud dlp
    - Cloud Armour
    - [Anomaly Detection](https://cloud.google.com/security-command-center/docs/concepts-security-sources#anomaly_detection)
      * Potential findings:
        * Leaked Service Account Creds
        * Potential Compromised Machine
        * Resource(s) used for cryptomining
        * Resource(s) used for outbound intrusion
        * Resource(s) used for phishing
    - [Integration with BigQuery](https://cloud.google.com/security-command-center/docs/how-to-analyze-findings-in-big-query) for exporting findings
    - Integration with Foresti Security
      - See below for details

* Premium Feature (Includes all Standar Tier features and addes the following)
  * [Event Threat Detection](https://cloud.google.com/security-command-center/docs/concepts-event-threat-detection-overview))
    * Uses log data to discover the following:
      * Brute force SSH
      * Cryptomining
      * IAM abuse (anomalous grant)
      * Malware
      * Phising
      * Data exfiltration
      * Outgoing DoS
      * Workspace threats
        - Leaked passwords
        - Attempted account breaches
        - Changes to 2-step verification settings
        - Changes to SSO settings
        - Government-backed attacks
    * If an event is found a `Finding` is written to Security Command Center and to a Cloud Log Project.
  * [Container Threat Detection](https://cloud.google.com/security-command-center/docs/concepts-container-threat-detection-overview)
    * Detects the following common runtime attacks:
      * Added Binary executed
      * Added Library loaded
      * Malicious Script executed
      * Reverse Shell
  * [Security Health Analytics](https://cloud.google.com/security-command-center/docs/concepts-vulnerabilities-findings):
    - The Premium tier includes managed vulnerability scans for all Security Health Analytics detectors (140+) and provides monitoring for many industry best practices, and compliance monitoring across your Google Cloud assets. These results can also be reviewed in a Compliance dashboard and exported as manageable CSVs.
    - In premium tier SHA includes additional monitoring and reporting for
      * CIS 1.0, 1.2, 1.1
      * PCI DSS v3.2.1
      * NIST 800-53
      * ISO 27001
  * [Web Security Scanner](https://cloud.google.com/security-command-center/docs/concepts-web-security-scanner-overview)
    * Includes all standard tier features and additional detectors that support catego in the OWASP Top Ten.
    * Also adds support for [managed scans](https://cloud.google.com/security-command-center/docs/concepts-web-security-scanner-overview#managed_scans) that are automatically configured. These scans identity the following sec vulnerabilities in your google cloud apps:
      - Cross-site scripting (XSS)
      - Flash Injection
      - Mixed-content (HTTPS & HTTP)
      - Clear text passwords
      - Usage of insecure JavaScript libraries
    * See Below for Details
  * [VM Threat Detection](https://cloud.google.com/security-command-center/docs/concepts-vm-threat-detection-overview)
    * Managed service that scans Compute Engine projects and vm instances to detect unwanted applications, such as cryptocurrency mining software, running in VMs. It ingests metadata from the hypervisor into the guest VM's live memory without pausing operations and writes findings to SCC. Including a list of application names, per-process CPU usage, hashes of memory pages, CPU hardware performance counters, and information about executed machine code to determine whether any application matches known cryptomining signatures.
    * Detects the following common threats and observations:
      - Execution: Cryotocurrency Mining Hash Match
      - Exection: Cryptocurrency Mining YARA Rule
      - Exection: Cryptocurrency Mining Combine Detection (Hash matching & YARA Rule)
    * VMTD Disable: Inidicates Threat detection is disabled
  * The Premium tier includes support for granting users IAM roles at the organization, folder, and project levels.
  * The Premium tier includes the [Continuous Exports](https://cloud.google.com/security-command-center/docs/how-to-export-data#continuous_exports) feature, which automatically manages the export of new findings to Pub/Sub.




#### Forseti
Forseti gives you tools to understand all the resources you have in Google Cloud Platform (GCP). The core Forseti modules work together to provide complete information so you can take action to secure resources and minimize security risks.

* Inventory:
  - Saves an inventory snapshot of your GCP resources to CLoud SQL
  - Understand current resources in GCP
  - can be configured to run and update snapshot as often as you want
  - send email notifications when resource snapshots have been updated
* Scanner:
  - Periodically compares the rules of GCP resource policies against the policies collected by Inventory, and saves the output for your review into Cloud SQL or Cloud Storage
* Explain:
  - helps you understand, test, and develop Cloud Identity and Access Management (Cloud IAM) policies.
* Enforcer :
  - uses policies you create to compare the current state of your Compute Engine firewall to the desired state.
  - an on-demand command-line tool that compares policies in batch mode over all managed projects or against selected projects.
  - if differences are found, it uses Google Cloud APIs to change resource policy state to match the state you define.
* Notifier :
  - keeps you up to date about Forseti findings and actions by send email notifications.

By default, Forseti is designed to be installed with complete organization access, and run with the organization as the root node in the resource hierarchy.

But, you also have the option to run Forseti on a subset of resources:

  1. if you are Org Admin, and you want to run Forseti on a specific folder
  2. if you are Folder Admin, and you want to run Forseti on a specific folder
  3. if you are Project Admin, and you want to run Forseti on projects that are only owned by you.

**NOTE: Inventory, Data Model, and Scanner will be supported for use on these subset of resources, but Explain will not be supported.**

The following Google APIS MUST be enabled in order to use Forseti:

* `cloudresourcemanager.googleapis.com`
* `serviceusage.googleapis.com`
* `compute.googleapis.com`
* `cloudasset.googleapis.com`

```
gcloud services enable \
    cloudresourcemanager.googleapis.com \
    serviceusage.googleapis.com \
    compute.googleapis.com \
    cloudasset.googleapis.com \
      --project "${PROJECT_ID}"
```

##### Deploying Foseti
Foreseti can be deployed into either Google Compute Engine or a Google Kubernetes Engine Cluster.

The easiest way to deploying it is through the terraform scripts provided by Foresti Security.

Service Account and required APIs can be set up by leveraging the provided script on the [Foreseti Terrafrom Github Repository](https://github.com/forseti-security/terraform-google-forseti/blob/master/helpers/setup.sh).

```
git clone --branch modulerelease522 --depth 1 https://github.com/forseti-security/terraform-google-forseti.git
```

```
cd terraform-google-forseti
```
```
. ./helpers/setup.sh -p PROJECT_ID -o ORG_ID
```

The above script will create a service account call `cloud-foundation-forseti-<suffix>`, assign it the required roles/permissions and download the service account credentials to `${PWD}/crendentials.json`.

**NOTE: you could also lever the `-f HOST_PROJECT_ID` flag to provision Foreseti into a `Shared VPC Hoste Project`**

Sample `maint.tf`

```
module "forseti" {
  source  = "terraform-google-modules/forseti/google"
  version = "~> 5.2.0"

  gsuite_admin_email       = "superadmin@yourdomain.com"
  domain                   = "yourdomain.com"
  project_id               = "my-forseti-project"
  org_id                   = "2313934234"

  config_validator_enabled = "true"
}
```

##### Configurations
Forseti configurations are global and module-specific settings. Configurations are centrally maintained in the `forseti-security/configs/server/forseti_server_conf.yaml` file that’s organized into module-specific sections. A sample can be found [here](https://github.com/forseti-security/forseti-security/blob/master/configs/server/forseti_conf_server.yaml.sample).

In GCP this configuration file lives in a pre-configured Forseti Cloud Storage Bucket. It is picked up every time Forseti runs (via cronjob).

**Configure to send data to Security Command Center (Cloud SCC)**

Forseti can be configured to send violations events to Cloud SCC.

Use the following steps:

  1. Select `Add Security Source` on the Cloud SCC Dashboard
  2. Find and select the `Forseti Cloud SCC Connector` in Cloud Marketplace.
  3. Follow the step-by-step on-boarding flow triggered from the Forseti card.
       1. Choose the project that is hosting Forseti
       2. Use exists Forseti SA
  4. Enable the Cloud SCC API in the Forseti Project either via UI or CLI
       1. `gcloud services enable securitycenter.googleapis.com`


#### Web Security Scanner (Formerly Cloud Security Scanner)
Web Security Scanner identifies security vulnerabilities in your App Engine, Google Kubernetes Engine (GKE), and Compute Engine web applications. It crawls your application, following all links within the scope of your starting URLs, and attempts to exercise as many user inputs and event handlers as possible. Currently, Web Security Scanner only supports public URLs and IPs that aren't behind a firewall.

It can automatically scan and detect five common vulnerabilities, including cross-site scripting, Flash injection, mixed content (HTTP in HTTPS), clear text passwords (invalid content-type or without `X-Content-Type-Options: nosniff`) and any outdated/insecure libraries.

The Scanner does the following:

  * Navigates every link it finds (except those excluded)
  * Activates every control and input
  * Logs in with specified credentials
  * User-agent and maximum request rate (Queries Per Second "QPS") can be configured
  * Scanner is optimized to avoid false positives

Scheduling the Scanner:
  * Scans can be scheduled or manually initiated
  * Scans can be configured to run on a preset schedule
  * Scan duration scales with size and complexity of application; large apps can take hours to complete

Finding from security scans can be found [here](https://cloud.google.com/security-command-center/docs/concepts-web-security-scanner-overview#scan_findings).

Security Scanner generates real load against your application and can also generate state data in the application.

In order to avoid unwanted impacts :

* Run scans in a test environment
* Use established test accounts
* Block specific UI elements
* Block specific URLs
* Use Backup Data

Labs:

[Getting Started with Cloud Security Scanner](https://google.qwiklabs.com/focuses/1715?catalog_rank=%7B%22rank%22%3A3%2C%22num_filters%22%3A0%2C%22has_search%22%3Atrue%7D&parent=catalog&search_id=6762807)

#### Mute Findings in Security Command center

Mute Findings is a volume management feature in Security Command Center that lets you manually or programmatically hide irrelevant findings, and create filters to automatically silence existing and future findings based on criteria you specify.

Mute Findings works differently than existing volume management solutions. Security Health Analytics lets you use dedicated security marks to [add assets to allowlists](https://cloud.google.com/security-command-center/docs/how-to-use-security-health-analytics#allowlist-assets), which stops detectors from creating security findings for specific assets. Security Command Center also lets you [disable detectors](https://cloud.google.com/sdk/gcloud/reference/alpha/scc/settings/services/modules/disable).

However, Mute Findings offers several advantages over allowlists and disabling detectors:

  * You can mute findings without locating their underlying assets.
  * Findings that aren't attached to any resources can be muted.
  * You can create custom filters to fine-tune mute functionality.
  * Muting findings doesn't stop underlying assets from being scanned. Findings are still generated but remain hidden until you decide to view them.

  To use Mute Findings, you need one of the following Identity and Access Management (IAM) roles at the organization, folder, or project level:

  * View mute rules:
    - Security Center Admin Viewer (roles/securitycenter.adminViewer)
    - Security Center Settings Viewer (roles/securitycenter.settingsViewer)
    - Security Center Mute Configurations Viewer (roles/securitycenter.muteConfigsViewer)
  * View, create, update, and delete mute rules:
    - Security Center Admin (roles/securitycenter.admin)
    - Security Center Admin Editor (roles/securitycenter.adminEditor)
    - Security Center Settings Editor (roles/securitycenter.settingsEditor)
    - Security Center Mute Configurations Editor (roles/securitycenter.muteConfigsEditor)
  * Manually mute findings:
    - Security Center Findings Editor (roles/securitycenter.findingsEditor)

  You can also create and grant custom roles with some or all of the following permissions:

  * Mute rule read permissions
    - securitycenter.muteconfigs.get
    - securitycenter.muteconfigs.list
  * Mute rule write permissions
    - securitycenter.muteconfigs.create
    - securitycenter.muteconfigs.update
    - securitycenter.muteconfigs.delete
  * Finding write permissions
    - securitycenter.findings.setMute
    - securitycenter.findings.bulkMuteUpdate

Mute/Unmute individual findings (using glcoud):
```
gcloud scc findings set-mute FINDING_ID \
  --RESOURCE=RESOURCE_ID \
  --source=SOURCE_ID \
  --mute=MUTED|UNMUTED
```

Bulk mute findings:
```
gcloud scc findings bulk-mute \
    --RESOURCE=RESOURCE_ID \
    --filter="FILTER"
```

For example, to mute all existing low-severity `OPEN_FIREWALL` and `PUBLIC_IP_ADDRESS` findings in the internal-test project, your filter can be `"category=\"OPEN_FIREWALL\" OR category=\"PUBLIC_IP_ADDRESS\" AND severity=\"LOW\" AND resource.project_display_name=\"internal-test\""`.

**Create mute rules**
Mute rules are Security Command Center configurations that use filters you create to automatically mute future findings based on criteria you specify. New findings that match mute filters are automatically muted on an ongoing basis. A single organization can create a maximum of 1,000 mute rules.

```
gcloud scc muteconfigs create RULE_NAME \
  --RESOURCE=RESOURCE_ID \
  --description=RULE_DESCRIPTION \
  --filter=FILTER
```
Supports `list`, `update`, `get`, and `delete` commands.

</details>

## Section 5. Ensuring Compliance
<details>
<summary>5.1 Determining regulatory requirements for the cloud</summary>

### 5.1.a - Determining concerns relative to compute, data, and network

### 5.1.b - Evaluating security shared responsibility model

#### Google's Shared Responsibility Model

![Shared Responsibility Model](images/GCP%20Shared%20Security%20Responsiblity.png)

When an application is moved to Google Cloud Platform, Google handles many lower layers of infrastructure and security, such as Hardware, storage encryption and networking and network security. The upper layers of security remain the customer's responsibility.

##### Data Access
You must control who has access to your data. This is done through Identityf Access Management (IAM) permissions, Access Control Lists (ACLs) and Firwall rules/security groups.

Another options is to expose your data through REST APIs, in this case Authentication information MUST be provided with the request in order to validate access.

##### Security Assessments
Performing a vulnerability assessments or pen test against your cloud resources may be required.

GCP does not require notification to perform pen testing, however it must abide and conform to the Cloud Platform Acceptable Use Policy and the Terms of service.

GPC also provides some security assessment services such as :
    * Web Security Scanner
    * Forseti Security

### 5.1.c - Configuring security controls within the cloud environments

VPC Service perimeters



### 5.1.d - Limiting compute and data for regulatory Compliance

### 5.1.e - Determining the Google Cloud environment in scope for regulatory compliance

#### Standards, Regulations and Certifications

GDPR, SOC 1/2/3, FedRAMP, HIPAA, etc see the [GCP Security Compliance Page](https://cloud.google.com/security/compliance) for more details.

##### FIPS 140-2
[Federal Information Processing Standard (FIPS) Publication 140-2](https://csrc.nist.gov/csrc/media/publications/fips/140/2/final/documents/fips1402.pdf) is a security standard that sets forth requirements for cryptographic modules, including hardware, software, and/or firmware, for U.S. federal agencies.

GCP uses a FIPS 140-2 validated encryption module called [BoringCrypto (certificate 3318)](https://csrc.nist.gov/projects/cryptographic-module-validation-program/Certificate/3318) in there production environment. This means that both data in transit to the customer and between data centers, and data at rest are encrypted using FIPS 140-2 validated encryption.

NOTE:
* Google's Local SSD does not have FIPS 140-2 validation, so you need to roll you own if required.
* Google encrypts traffic between VMs that travel between Google's data centers with NIST-approved encryption algorithms, but not FIPS
* Apps built and operated in GCP, must include there own FIPS cryptographic module implementation.

##### PCI Compliance
* App Engine and Cloud Functions
  * Ingress firewall rules are available
  * Egress rules are currently not available
  * Alternative use Compute Engine and GKE
  * SAQ A-EP, SAQ-D Type merchants must provide compensating controls to meet thg requirements

* Cloud Storage
  * PAN (Primary Account Number) MUST be unreadible anywhere it is stored.
    * Leverage Cloud DLP to encrypt if needed

Self-Assessment Questionnaire (SAQ) outlines criteria that you must address to comply with PCI DSS.

SAQ Types:
* A:
  * Merchants that have fully outsourced payment card processing to a third-party site.
  * Customers leaves your site, complete payment and return
  * Company does NOT touch card info
* A-EP:
  * Merchants that outsource payment processing to a third-party provider, but who can access customer card data at any point in the process.
* D:
  * Merchants that accept payments online and don't qualify for SAQ A or SAQ A-EP. This type includes all merchants that call a payment processor API from their own servers, regardless of tokenization.

##### Payment Processing Environments
* Creating a new Google Cloud account to isolate your payment-processing environment from your production environment.
  * To simplify access restriction and compliance auditing, create a production-quality, payment-processing environment that is fully isolated from your standard production environment and any dev/QA environments
* Restricting access to your environment.
  * Allow payment-processing environment access only to individuals who deploy your payment system code or manage your payment system machines (principle of least priviledge).
* Setting up your virtual resources.
* Designing the base Linux image that you will use to set up your app servers.
* Implementing a secure package management solution

##### PCI DSS Compliance on GKE

[PCI GKE Blueprint](https://github.com/GoogleCloudPlatform/pci-gke-blueprint)

#### ISO Standards

* ISO/IEC 27001:
  * outlines and provides the requirements for an information security management system (ISMS), specifies a set of best practices, and details the security controls that can help manage information risks.
* ISO/IEC 27017:
  * gives guidelines for information security controls applicable to the provision and use of cloud services by providing:
    * Additional implementation guidance for relevant controls specified in ISO/IEC 27002
    * Additional controls with implementation guidance that specifically relate to cloud services
  * provides controls and implementation guidance for both cloud service providers like Google and cloud service customers.
    * Who is responsible for what between the cloud service provider and the cloud customer
    * The removal/return of assets when a contract is terminated
    * Protection and separation of the customer’s virtual environment
    * Virtual machine configuration
    * Administrative operations and procedures associated with the cloud environment
    * Customer monitoring of activity within the cloud
    * Virtual and cloud network environment alignment
* ISO/IEC 27018:
  * relates to one of the most critical components of cloud privacy: the protection of personally identifiable information (PII).
* ISO/IEC 27701:
  * a global privacy standard that focuses on the collection and processing of personally identifiable information (PII). This standard was developed to help organizations comply with international privacy frameworks and laws, and focuses on three main factors :
    * Extends the requirements of ISO/IEC 27001 and ISO/IEC 27002 to include data privacy;
    * Provides a framework for implementing, maintaining, and continuously improving a Privacy Information Management System (PIMS);
    * Includes requirements and guidance for organizations acting as PII controllers and PII processors.
  * ISO/IEC 27110:
    - specifies that all  cybersecurity frameworks should have the following concepts: Identify, Protect, Detect, Respond, Recover. It also outlines the distinction between Information Security and Cybersecurity. These guidelines align with the [NIST Cybersecurity  Framework (CSF)](https://services.google.com/fh/files/misc/gcp_nist_cybersecurity_framework.pdf).
    - **Identify**: The Identify concept addresses people, policies, processes and technology when defining the scope of activities.
    - **Protect**: The Protect concept can contain many categories and activities related to the safeguarding of assets against intentional or unintentional misuse.
Detect: The Detect concept can include traditional asset monitoring and attack detection.
Respond: The Respond concept can include the traditional incident response concepts as well as policies, procedures and plans.
Recover: The activities in the Recover concept define the restoration and communication related activities after a cybersecurity event.
Google's security risk management capabilities are audited as part of ISO/IEC 27001/27002 (Information Security Management), ISO/IEC 27017 (Cloud Security),  FedRAMP, and NIST 800-53, which align with the conceptual framework and recommended guidance specified in ISO/IEC 27110 (Identify, Protect, Detect, Respond, Recover).


</details>




[^1]: Taken from the GCP Security Engineer Documentation (https://cloud.google.com/certification/cloud-security-engineer)
