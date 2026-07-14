# Security Services

## G-Suite 2-Step Verification

Google Supports MFA factors, providing different levels of assurance and convenience:

* SMS/Voice
  - Vunerable to Phishing, [Signal System 7 (SS7)](https://www.techtarget.com/whatis/definition/SS7-attack) vulnerability, [SIM Swap Attacks](https://en.wikipedia.org/wiki/SIM_swap_scam)
* Backup Codes
  - Vulnerable to phishing
* Authenticator (TOTP)
  - - Vulnerable to phishing
* Google Prompt (Mobile Push)
  - Vulnerable to phishing
* FIDO U2F Keys
  - Phishing-resistent

[Setup 2-Step Verification](https://support.google.com/cloudidentity/answer/175197?hl=en&ref_topic=2759193#zippy=%2Csecurity-keys)

## Certificate Authority Service

Certificate Authority Service (CAS) is a highly available, scalable Google Cloud service that enables you to simplify, automate, and customize the deployment, management, and security of private certificate authorities (CA).

The purpose of a public key infrastructure (PKI) to issue certificates is largely dependent on the environment in which the PKI-issued certificates will be used. For common internet-facing services, such as a website or host where visitors to the site are largely unknown to the host, a certificate that is trusted by the visitor is required to ensure a seamless validation of the host. If a visitor’s browser hasn’t been configured to trust the PKI from which the certificate was issued, an error will occur. To facilitate this process, publicly trusted certificate authorities issue certificates that can be broadly trusted throughout the world. However, their structure, identity requirements, certificate restrictions, and certificate cost make them ineffective for certificate needs within an organizational or private ecosystem, such as the internet of things (IoT) or DevOps.

Organizations that have a need for internally trusted certificates and little to no need for externally trusted certificates can have more flexibility, control, and security in their certificates without a per-certificate charge from commercial providers.

A private PKI can be configured to issue the certificates an organization needs for a wide range of use cases, and can be configured to do so on a large scale, automated basis. Additionally, an organization can be assured that externally issued certificates cannot be used to access or connect to organizational resources.

The Google Cloud Certificate Authority Service (CAS) allows organizations to establish, secure and operate their own private PKI. Certificates issued by CAS will be trusted only by the devices and services an organization configures to trust the PKI.

![CAS](https://storage.googleapis.com/gweb-cloudblog-publish/images/cas_1.max-600x600.jpg)

### CA pools

A certificate authority (CA) pool is a collection of mulitple CA's with a common certificate issuance policy and  Access Management (IAM) policy. CA pools provide the ability to rotate trust chains without any outage or downtime for their payloads.

Their is an enforced limit of the number of requests that can be sent to the CA service. For example, the usage limit for the `createCertificate` request for a DevOps CA is 25 Queries Per Second (QPS). To increase the total effective QPS, you must have mulitple CAs in a CA pool. A CA pool increase the total effective QPS by distributing the incoming certifcate requests across all CAs in the `ENABLED` state.

Their are two tiers for CA pools:

* DevOps
  - Focused on high volume, short-lived certificate issuance (microservice-based applications)
  - QPS of 25
  - Does not support Customer-managed CA key, supported through KMS
  - Does not support listing, describing and revoking of Certificates
  - Supports HSM for CA key
* Enterprise
  - Focused on lower volume, long-lived certificate issuance which is normally found in devices and user identity where lifecycle management is important (IoT, IAM, etc)
  - QPS of 7
  - Supports Customer-managed CA key, supported through KMS
  - Supports listing, describing and revoking of Certificates
  - Supports HSM for CA key

When creating a CA pool, if the `TIER` is not specified than defaults to Enterprise.

#### Creating a CA pool

Before being able to create a CA pool you must have the CA Service Operations Manager (`roles/privateca.caManager`) IAM role.

**gcloud**
`gcloud privateca pools create POOL_NAME --tier=TIER_NAME --location [LOCATION]`

**terraform**
```
resource "google_privateca_ca_pool" "default" {
  name = "my-pool"
  location = "us-central1"
  tier = "ENTERPRISE"
  publishing_options {
    publish_ca_cert = true
    publish_crl = true
  }
  labels = {
    foo = "bar"
  }
}
```

#### Creating a CA

Before being able to create a CA pool you must have the CA Service Operations Manager (`roles/privateca.caManager`) or CA Service Admin (`roles/privateca.admin`) IAM role.

##### Root CA

A root CA has a self-signed certificate that you must distribute to the trust stores of you clients. It is also at the top of the certificate chain. No other CA can revoke the CA certificate. The CRL of the root CA applies only to the other certificats the root CA issued, but not itself.

**gcloud**
```
gcloud privateca roots create [ROOT_CA_ID] --pool=[POOL_ID] \
  --key-algorithm=[KEY_ALGORITHM] \
  --subject="CN=my-ca, O=Test LLC"
```

The `--key-algorithm` flag is used for creating a CLoud KMS key. This flag is optional, if not specified the key algorithm defaults to `rsa-pkcs1-4096-sha256`. It must be one of the following:
`ec-p256-sha256`, `ec-p384-sha384`, `rsa-pkcs1-2048-sha256`, `rsa-pkcs1-3072-sha256`, `rsa-pkcs1-4096-sha256`, `rsa-pss-2048-sha256`, `rsa-pss-3078-sha256`, `rsa-pss-4096-sha256`

For more information on which Key Algorithim to use please refer to the [official documentation](https://cloud.google.com/certificate-authority-service/docs/choosing-key-algorithm)

Other imformation on this command can be found in the official documentation , [here](https://cloud.google.com/sdk/gcloud/reference/beta/privateca/roots/create#--key-algorithm).

By default the CA is created in the `STAGED` state, to enable a CA by default you can include the `--auto-enable` flag.

If you want to use a customer-managed Cloud Storage bucket for publishing CA certificates and CRLs, add `--bucket [BUCKET_NAME]`.

**CA States**

| CA State | Can Issue Certificates? | Included in CA Pool certificate issuance rotation? | Included in CA pool Trust Anchor? | Can revoke certificates and publish CRLs? | Is billed? |
|:----------:|:---------:|:--------:|:----------:|:-------:|:-------:   |
| Enabled | Yes | Yes | Yes | Yes | Yes |
| Disabled | No | No | Yes | Yes | Yes |
| Staged | Yes * | No | Yes | Yes | Yes |
| Awaiting user activiation | No | No | No | No | No |
| Deleted | No | No | No | No | No |

Note: CAs in the `STAGED` state cannot issue certificates through CA pool load-balancing. The can only issue certificates when requested directly by clients.

**terraform**

```
resource "google_privateca_certificate_authority" "default" {
  // This example assumes this pool already exists.
  // Pools cannot be deleted in normal test circumstances, so we depend on static pools
  pool = "ca-pool"
  certificate_authority_id = "my-certificate-authority"
  location = "us-central1"
  deletion_protection = "true"
  config {
    subject_config {
      subject {
        organization = "HashiCorp"
        common_name = "my-certificate-authority"
      }
      subject_alt_name {
        dns_names = ["hashicorp.com"]
      }
    }
    x509_config {
      ca_options {
        is_ca = true
        max_issuer_path_length = 10
      }
      key_usage {
        base_key_usage {
          digital_signature = true
          content_commitment = true
          key_encipherment = false
          data_encipherment = true
          key_agreement = true
          cert_sign = true
          crl_sign = true
          decipher_only = true
        }
        extended_key_usage {
          server_auth = true
          client_auth = false
          email_protection = true
          code_signing = true
          time_stamping = true
        }
      }
    }
  }
  lifetime = "86400s"
  key_spec {
    algorithm = "RSA_PKCS1_4096_SHA256"
  }
}
```

**Delete CA Pool**
You can delete a CA pool only after you have permanently deleted all CAs within that CA pool. CA Service permanently deletes a CA after a 30-day grace period from when the deletion process is initiated
```
gcloud privateca pools delete POOL_ID
```

#### Managing CA State

**Enable**
`gcloud privateca roots enable CA_ID --pool POOL_ID`

**Disbale**
`gcloud privateca roots disable CA_ID --pool POOL_ID`

**Deleting**

NOTE: The CA must be in the `DISBALED`, `STAGED`, or `AWAITING_USER_ACTIVATION` state before deletion can occur. The CA must **NOT** contain any active certificates, these must be revoked prior to deleting the CA, the active certificates cannot be revoked after the CA is deleted. Using this command will put the CA in a 30-day grace period where you can restore it prior to its permanent deletion. After the 30 day grace period the CA Service will permanently delete the CA and all nested artificats, such as certificates and certificate revocation lists (CRLS). The CA is not billed during the grace period. However if you undelete the CA, you will be charged at the CA's billing tier for the time the CA existed in the `DELETED` state.

`gcloud privateca roots delete CA_ID --pool=POOL_ID`

You can use the `--ignore-active-certificates` to delete the CA even if the CA has active certificates.

**Restoring a CA**

`gcloud privateca roots undelete CA_ID --pool POOL_ID`

### Requesting a certificate

Before being able to request a certificate from the Certificate Authority Service you must have the CA Service Certificate Requester (`roles/privateca.certificateRequester`) or CA Service Certificate Manager (`roles/privateca.certificateManager`) IAM role(s).


You can request a certificate using the following methods:

1. Generate your own private/public key and submit a Certificate Signing Request (CSR).
2. Have CA Service create a private/public key for you.
3. Use an existing Cloud Key Management Service (Cloud KMS) key.

**Using CSR**

```
gcloud privateca certificates create CERT_ID \
     --issuer-pool POOL_ID \
     --csr CSR_FILENAME \
     --cert-output-file CERT_FILENAME \
     --validity "P30D"
```
Replace the following:

* CERT_ID: The unique identifier of the certificate.
* POOL_ID: The name of the CA pool.
* CSR_FILENAME: The file that stores the PEM-encoded CSR.

The `--validity` flag defines the duration the certificate is valid. It is an optional flag whose default value is 30 days.

**Using an auto-generated key**

This command requires the [Python Cryptographic Authority (PyCA)](https://cloud.google.com/kms/docs/crypto) library be installed on you machine.

```
gcloud privateca certificates create \
  --issuer-pool POOL_ID \
  --generate-key \
  --key-output-file KEY_FILENAME \
  --cert-output-file CERT_FILENAME \
  --dns-san "DNS_NAME" \
  --use-preset-profile "CERTIFICATE_PROFILE"
```

Replace the following:

* POOL_ID: The name of the CA pool.
* KEY_FILENAME: The path where the generated private key file must be written.
* CERT_FILENAME: The path where the PEM-encoded certificate chain file must be written. The certificate chain is ordered from end-entity to root.
* DNS_NAME: One or more comma-separated DNS subject alternative names (SANs).
* CERTIFICATE_PROFILE: The unique identifier of the certificate profile. For example, use leaf_server_tls for end-entity server TLS.

The gcloud command mentions the following flags:

`--generate-key`: Generates a new RSA-2048 private key on your machine.

You can also use any combination of the following flags:
* `--dns-san`: Lets you pass one or more comma-separated DNS SANs.
* `--ip-san`: Lets you pass one or more comma-separated IP SANs.
* `--uri-san`: Lets you pass one or more comma-separated * URI SANs.
* `--subject`: Lets you pass an X.501 name of the certificate subject.

**Using an exsiting Cloud KMS Key**

```
gcloud privateca certificates create \
  --issuer-pool POOL_ID \
  --kms-key-version projects/PROJECT_ID/locations/LOCATION_ID/keyRings/KEY_RING/cryptoKeys/KEY/cryptoKeyVersions/KEY_VERSION \
  --cert-output-file CERT_FILENAME \
  --dns-san "DNS_NAME" \
  --use-preset-profile "leaf_server_tls"
```

Replace the following:

* POOL_ID: The name of the CA pool.
* PROJECT_ID: The project ID.
* LOCATION_ID: The location of the key ring.
* KEY_RING: The name of the key ring where the key is located.
* KEY: The name of the key.
* KEY_VERSION: The version of the key.
* CERT_FILENAME: The path of the PEM-encoded certificate chain file. The certificate chain file is ordered from end-entity to root.
* DNS_NAME: Comma-separated DNS SANs.

### Performing operations with certificates

**Issue a certificate from a specific CA in a CA Pool**

```
gcloud privateca certificates create \
  --issuer-pool POOL_ID \
  --ca CA_ID \
  --generate-key \
  --key-output-file KEY_FILENAME \
  --cert-output-file CERT_FILENAME \
  --dns-san "DNS_NAME" \
  --use-preset-profile "leaf_server_tls"
```

To target a specific CA in the CA pool for certificate issuance, use the `--ca` flag to specify the CA_ID of the CA that must issue the certificate.

**Viewing issued certificates**

`gcloud privateca certificates list --issuer-pool ISSUER_POOL --ca CA_NAME`

`gcloud privateca certificates list --location LOCATION`

**View details for a single certificate**

`gcloud privateca certificates describe CERT_NAME \
    --issuer-pool POOL_ID`

**Export PEM-encoded X.509 cert chain**

```
gcloud privateca certificates export CERT_NAME \
    --issuer-pool POOL_ID \
    --include-chain \
    --output-file certificate-file
```

### Certificate templates

You can use a certificate template when you have a well-defined certificate issuance scenario. You can use certificate templates to enable consistency across certificates issued from different CA pools. You can also use a certificate template to restrict the kinds of certificates that different individuals can issue.

The following code sample mentiones all the predefined fields in a certificate template:

```
keyUsage:
  baseKeyUsage:
    digitalSignature: true
    keyEncipherment: true
    contentCommitment: false
    dataEncipherment: false
    keyAgreement: false
    certSign: false
    crlSign: false
    encipherOnly: false
    decipherOnly: false
  extendedKeyUsage:
    serverAuth: true
    clientAuth: false
    codeSigning: false
    emailProtection: false
    timeStamping: false
    ocspSigning: false
caOptions:
  isCa: true
  maxIssuerPathLength: 1
policyIds:
- objectIdPath:
  - 1
  - 2
  - 3
additionalExtensions:
- objectId:
    objectIdPath:
    - 1
    - 2
    - 3
  critical: false
  value: "base64 encoded extension value"

```

**gcloud**

```
gcloud privateca templates create TEMPLATE_ID \
  --copy-subject \
  --copy-sans \
  --identity-cel-expression <expr> \
  --predefined-values-file FILE_PATH \
  --copy-all-requested-extensions \
  --copy-extensions-by-oid <1.2.3.4,5.6.7.8> \
  --copy-known-extensions <ext1,ext2>
```

### Certificate issuance policy

A certificate issuance policy lets you specify the subject and subject alternative names (SANs) that can be included in the issued certificates. You can specify the certificate issuance policy while creating a CA pool or you can update an existing CA pool to add an issuance policy.

**policy.yaml**
```
identityConstraints:
  allowSubjectPassthrough: true
  allowSubjectAltNamesPassthrough: true
```

**gcloud**

```
gcloud privateca pools update POOL_NAME \
  --issuance-policy policy.yaml
```

Other examples go [here](https://cloud.google.com/certificate-authority-service/docs/use-issuance-policy).

### Usage

[Use CA Service with Anthos Service Mesh](https://cloud.google.com/service-mesh/docs/unified-install/install-anthos-service-mesh#install_ca_service)
[Use CA Service with Traffice Director - Envoy](https://cloud.google.com/traffic-director/docs/security-envoy-setup)
[Use CA Service with Traffic Director - gRPC](https://cloud.google.com/traffic-director/docs/security-proxyless-setup)
[Deploying public key infrastructure](https://services.google.com/fh/files/misc/deploying_public_key_infrastructure_with_cas.pdf)

## Cloud IDS

Cloud IDS is an intrusion detection service that provides threat detection for intrusions, malware, spyware, and command-and-control attacks on your network. Cloud IDS works by creating a Google-managed peered network with mirrored VMs. Traffic in the peered network is mirrored, and then inspected by Palo Alto Networks threat protection technologies to provide advanced threat detection. You can mirror all traffic or you can mirror filtered traffic, based on protocol, IP address range, or ingress and egress.

Cloud IDS provides full visibility into network traffic, including both north-south and east-west traffic, letting you monitor VM-to-VM communication to detect lateral movement. This provides an inspection engine that inspects intra-subnet traffic.

You can also use Cloud IDS to meet your advanced threat detection and compliance requirements, including [PCI 11.4](https://www.pcisecuritystandards.org/pdfs/pci_ssc_quick_guide.pdf).

Cloud IDS is subject to Google Cloud's [Data Processing and Security Terms](https://cloud.google.com/terms/data-processing-terms).

While Cloud IDS includes all the functionality that helps you maintain compliance, Cloud IDS itself is still being audited and is not yet compliance certified. Also note that Cloud IDS detects and alerts on threats, but does not take action to prevent attacks or repair damage. You can use products like Google Cloud Armor to take action on the threats that Cloud IDS detects.

![Architecture](https://storage.googleapis.com/gweb-cloudblog-publish/images/1_-_cloudds.max-2800x2800.jpg)

### IDS endpoints

An IDS endpoint is a zonal resource, used by Cloud IDS, that can inspect traffic from any zone in its regional. Each IDS endpoint recieves mirrore traffic and performs threat detection analysis.

```
gcloud ids endpoints create ENDPOINT_NAME \
  --network=VPC_NETWORK \
  --zone=ZONE \
  --severity=SEVERITY \
 [--no-async] \
 [GCLOUD_WIDE_FLAG...]
```

Severity Flags:
* INFORMATIONAL
* LOW
* MEDIUM
* HIGH
* CRITICAL

**Packet mirroring**

Once the IDS endpoint is establish you must attach one or more _packet mirroring policies_ to it. These policies send traffic to a single IDS enpoint for inspection. The packet mirroring logic sends all traffic from individual VMs to Google-managed IDS VMs.

```
gcloud compute packet-mirrorings create POLICY_NAME \
--region=REGION --collector-ilb=ENDPOINT_FORWARDING_RULE \
--network=VPC_NETWORK --mirrored-subnets=SUBNET
```

_ENDPOINT_FORWARDING_RULE_ is the IDS enpoint url which can be retrieved through the console or using the following command:

```
gcloud ids endpoints describe ENDPOINT_NAME
```

To delete an endpoint run the following command:

```
gcloud ids endpoints delete ENDPOINT_NAME \
   [--project=PROJECT_ID] \
   [--zone=ZONE] \
   [--no-async] \
   [GCLOUD_WIDE_FLAG...]
```

### Advanced threat detection

Cloud IDS threat detection capabilities are powered by the following Palo Alto Networks threat prevention technologies.

### Limitations

Cloud IDS DOES NOT SUPPORT VPC Service Controls


## reCAPTCHA Enterprise

reCAPTCHA Enterprise is built on the existing reCAPTCHA API and it uses advanced risk analysis techniques to distinguish between humans and bots. With reCAPTCHA Enterprise, you can protect your site from spam and abuse, and detect other types of fraudulent activities on the sites, such as credential stuffing, account takeover (ATO), and automated account creation. reCAPTCHA Enterprise offers enhanced detection with more granular scores, reason codes for risky events, mobile app SDKs, password breach/leak detection, Multi-factor authentication (MFA), and the ability to tune your site-specific model to protect enterprise businesses.

### When to use reCAPTCHA Enterprise
reCAPTCHA Enterprise is useful when you want to detect automated attacks or threats against your website. These threats typically originate from scripts, mobile emulators, bot software, or humans.

### How reCAPTCHA works

![reCAPTCHA workflow](https://cloud.google.com/static/recaptcha-enterprise/images/sequence_diagramv1.svg

When reCAPTCHA Enterprise is deployed in your environment, it interacts with the customer backend/server and customer web pages.

When an end user visits the web page, the following events are triggered in a sequence:

  1. The browser loads the customer web page stored on the backend/web server, and then loads the reCAPTCHA JavaScript from reCAPTCHA Enterprise.
  2. When the end user triggers an HTML action protected by reCAPTCHA such as login, the web page sends signals that are collected in the browser to reCAPTCHA Enterprise for analysis.
  3. reCAPTCHA Enterprise sends an encrypted reCAPTCHA token to the web page for later use.
  4. The web page sends the encrypted reCAPTCHA token to the backend/web server for assessment.
  5. The backend/web server sends the create assessment (assessments.create) request and the encrypted reCAPTCHA token to reCAPTCHA Enterprise.
  6. After assessing, reCAPTCHA Enterprise returns a score (from 0.0 through 1.0) and reason code (based on the interactions) to the backend/web server.
  7. Depending on the score, you (developer) can determine the next steps to take action on the user.
