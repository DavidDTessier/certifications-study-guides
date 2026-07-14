![Logo](https://miro.medium.com/v2/resize:fit:520/1*ik9N6EPd6H6ElO3R_N-Suw.png)
# Google Cloud - Professional Cloud Architect Certification

[^1] A Google Cloud Certified Professional Cloud Architect enables organizations to leverage Google Cloud technologies. Through an understanding of cloud architecture and Google technology, this individual designs, develops, and manages robust, secure, scalable, highly available, and dynamic solutions to drive business objectives. The Cloud Architect should be proficient in all aspects of enterprise cloud strategy, solution design, and architectural best practices. The Cloud Architect should also be experienced in software development methodologies and approaches including multi-tiered distributed applications which span multicloud or hybrid environments.

[Link to the exam guide](https://cloud.google.com/learn/certification/guides/professional-cloud-architect)

The Professional Cloud Architect certification exam assesses your ability to:

* Design and plan a cloud solution architecture
* Manage and provision the cloud solution infrastructure
* Design for security and compliance
* Analyze and optimize technical and business processes
* Manage implementations of cloud architecture
* Ensure solution and operations reliability

Case Studies that are covered as part of the exam:

* [EHR Healthcare](https://services.google.com/fh/files/blogs/master_case_study_ehr_healthcare.pdf)
* [Helicopter Racing League](https://services.google.com/fh/files/blogs/master_case_study_helicopter_racing_league.pdf)
* [Mountkirk Games](https://services.google.com/fh/files/blogs/master_case_study_mountkirk_games.pdf)
* [TerramEarth](https://services.google.com/fh/files/blogs/master_case_study_terramearth.pdf)

# Section 1: Designing and planning a cloud solution architecture

## 1.1 Designing a solution infrastructure that meets business requirements. 

### Business use cases and product strategy
* [Google Cloud Architecture Framework](https://cloud.google.com/architecture/framework)
    * provides recommendations and describes best practices to help architects, developers, administrators, and other cloud practitioners design and operate a cloud topology that's secure, efficient, resilient, high-performing, and cost-effective. The Google Cloud Architecture Framework is our version of a well-architected framework.
* [Best practices for enterprise organizations](https://cloud.google.com/docs/enterprise/best-practices-for-enterprise-organizations)
* [Implementing policies for customer use cases](https://cloud.google.com/solutions/policies/implementing-policies-for-customer-use-cases)
* [Mapping Organization with Google Cloud Resource Hierarchy](https://cloud.google.com/blog/products/gcp/mapping-your-organization-with-the-google-cloud-platform-resource-hierarchy)

### Cost optimization
* [Performance and cost optimizations](https://cloud.google.com/architecture/framework/performance-cost-optimization)
* GKE cost optimization
    * https://cloud.google.com/architecture/best-practices-for-running-cost-effective-kubernetes-applications-on-gke
    * Right-size you GKE Workload at scale
        * CPU
            * Over provision
                * Risk - Cost: Increases the cost of you workloads by reserving unnessary resources
            * Under provision
                * Risk - Performance: Can cause workloads to slow down or become unresponsive
            * Not set
                * Risk - Reliability: CPU can throttle to 0 causing your workloads to become unresponsive
        * Memory
            * Over provision
                * Risk - Cost: Increases the cost of your workloads by reserving unnecessary resoruces
            * Under provision
                * Risk - Reliability: Can cause applications to terminate with an out of memroy (OOM) error
            * Not set
                * Risk - Reliability: kublet can stop you Pods, at any time, and mark them as failed
* One measure of costs is total cost of ownership (TCO). 
    * TCO is the combination of all expenses related to maintaining a service, which can include the following:
        * Software licensing costs
        * Cloud computing costs, including infrastructure and managed services
        * Cloud storage costs
        * Data ingress and egress charges
        * Cost of DevOps personnel to develop and maintain the service
        * Cost of third-party services used in an application
        Charges against missed service-level agreements
        * Network connectivity charges, such as those for a dedicated connection between an on- premises data center and Google Cloud
* Some of the ways to reduce costs while meeting application design requirements include managed services, using preemptible virtual machines, and data lifecycle management. Google also offers sustained uses discounts and reserved VMs, which can help reduce costs.

### Supporting the application design
* [Google Cloud system design considerations](https://cloud.google.com/architecture/framework/design-considerations)

### Integration with external systems
* [Using APIs from an External network](https://cloud.google.com/vpc/docs/configure-private-google-access-hybrid)

### Movement of data
* Data lifecycle
    * has four key steps:
        * _Ingest_: 
            * The first stage is to pull in the raw data, such as streaming data from devices, on-premises batch data, app logs, or mobile-app user events and analytics.
            * App: 
                * Data from app events, such as log files or user events, is typically collected in a push model, where the app calls an API to send the data to storage.
            * Streaming: 
                * The data consists of a continuous stream of small, asynchronous messages.
                * Telemetry data: via Cloud Pub/Sub or Clearblade Cloud IoT
                    * Topics are how Cloud Pub/Sub organizes message streams. Apps streaming data to Cloud Pub/Sub target a topic. When it receives each message, Cloud Pub/Sub attaches a unique identifier and timestamp.
            * Batch: 
                * Large amounts of data are stored in a set of files that are transferred to storage in bulk.
        * _Store_: 
            * After the data has been retrieved, it needs to be stored in a format that is durable and can be easily accessed.
        * _Process and analyze_: 
            * In this stage, the data is transformed from raw form into actionable information.
            * Use Cloud Dataflow, 
        * _Explore and visualize_: 
            * The final stage is to convert the results of the analysis into a format that is easy to draw insights from and to share with colleagues and peers.
            * BigQuery
* [Database Solutions](https://cloud.google.com/products/databases)
* [Choosing the right database](https://cloud.google.com/blog/topics/developers-practitioners/your-google-cloud-database-options-explained)
    * ![Database Choice](https://storage.googleapis.com/gweb-cloudblog-publish/images/Which-Database_v03-22-23.max-2000x2000.jpg)
* Data Transfer Options
    * [Storage Transfer Service](https://cloud.google.com/storage-transfer/docs/overview)
        * supports AWS S3 and Azure Blob Storage
        * recommended when moving to from/other cloud providers data to GCS
        * recommended when moving large amounts of data (greater than 1 TB) between GCS buckets or from on-prem to GCS
    * [gsutil](https://cloud.google.com/storage/docs/gsutil)
        * recommended when moving data between GCS buckets (less than 1 TB)
        * recommended when moving data from on-premise to GCS (less than 1 TB)
        * `gsutil rsync` --> transfers data between Cloud Storage and other providers/file systems (small data sets)
    * [Transfer Appliance](https://cloud.google.com/transfer-appliance/docs/4.0/procedure-guide)
        * recommend to move or back up your on-premises data if you have poor or no internet connectivity.
    * [BigQuery Data Transfer Service](https://cloud.google.com/bigquery/docs/dts-introduction)
        * automates data movement into BigQuery on a scheduled, managed basis. 
        * can be used to initiate data backfills to recover from any outages or gaps. 
        * Currently, you cannot use the BigQuery Data Transfer Service to transfer data out of BigQuery.
        * can be access via
            * [Google Cloud Console](https://cloud.google.com/bigquery/docs/bigquery-web-ui)
            * [bq command-line tool](https://cloud.google.com/bigquery/docs/reference/bq-cli-reference)
            * [BigQuery Data Transfer Service API](https://cloud.google.com/bigquery-transfer/docs/reference/datatransfer/rest)

### Design decision trade-offs
* To reduce cost look at reduced levels of service
    * Examples:
        * Using preemptible virtual machines instead of standard virtual machines 
             * shutdown anytime anytime google
             * will be shut down after running for 24 hrs
             * GCP will signal a vm before shutting down, which it will 30 seconds for a graceful shutdown
             * meant for for stateless operations 
             * if used for state storage use Cloud Memorystore or other storage
        * Using standard tier networking instead of Premium tier
            * Standard has no global SLA and Cloud Load Balancing is limited to regional. Also traffic traverses the public internet
            * Premium has global SLAs and offers global load balancing, traffic stays on the google network
        * Using Pub/Sub Lite instead of Pub/Sub
            * Pub/Sub provides for per-message parallelism, automatic scaling, and global routing. Ser- vice endpoints are global and regional.
            * Pub/Sub Lite offers lower availability and durability than Pub/Sub. Messages replication is limited to a single zone unlike Pub/Sub, which provides multizone replication in a single region. Pub/Sub Lite service endpoints are regional, not global. The Lite service also requires users of the service to manage resource capacity.
        * Using Durable Reduced Availability Storage

### Build, buy, modify, or deprecate
* 

### Success measurements (e.g., key performance indicators [KPI], return on investment [ROI], metrics)
* [KPIs for APIs - How Metrics change over time](https://cloud.google.com/blog/products/api-management/kpis-for-apis-how-metrics-change-over-time)
* Return On Investment (ROI) 
    * ​ROI = [(value of investment – cost of investment) /cost of investment] * 100
    * For example, if a company invests $100,000 in new equipment and this investment generates a value of $145,000, then the ROI is 45 percent.
    * In cloud migration projects, the investment includes the cost of cloud services, employee and contractor costs, and any third-party service costs. The value of the investment can include the expenses saved by not replacing old equipment or purchasing new equipment, savings due to reduced power consumption in a data center, and new revenue generated by applications and services that scale up in the cloud but were constrained when run on-premises
* Total Cost of Ownership (TCO) 
    * TCO is the combination of all expenses related to maintaining a service, which can include the following: 
    * Software licensing costs
    * Cloud computing costs, including infrastructure and managed services
    * Cloud storage costs
    * Data ingress and egress charges 
    * Cost of DevOps personnel to develop and maintain the service
    * Cost of third-party services used in an application
    * Charges against missed service-level agreements
    * Network connectivity charges, such as those for a dedicated connection between an on-premises data center and Google Cloud
    * While you will want to minimize the TCO, you should be careful not to try to minimize the cost of each component separately. 
        * For example, you may be able to reduce the cost of DevOps personnel to develop and maintain a service if you increase your spending on managed services. 
    * Also, it is generally a good practice to find a feasible technical solution to a problem before trying to optimize that solution for costs. 
    * Some of the ways to reduce costs while meeting application design requirements include managed services, preemptible virtual machines, and data lifecycle management. Google also offers sustained usage discounts and reserved VMs, which can help reduce costs.
* Key Performance Indicators (KPIs)
    * Project KPIs
        * example measure the progress of a cloud migration project, may include the volume of data migrate, number of servers migrated
    * Operations KPIs
        * Line-of-business managers may use KPIs to measure how well operations are running.
        * 

* 
### Compliance and observability
* [Security, privacy, and compliance](https://cloud.google.com/architecture/framework/security-privacy-compliance)
* Laws and Regulations
    * Health Insurance Portability and Accountability Act (HIPAA)
        * a US healthcare regulation
        * addresses privacy security of medical information in the United States.
    * Children’s Online Privacy Protection Act (COPPA)
        * a U.S. law that regulates websites that collect personal information to protect children under the age of 13.
    * Sarbanes–Oxley Act (SOX)
        * a financial reporting regulation
        * regulates business reporting of publicly traded com- panies to ensure the accuracy and reliability of financial statements to mitigate the risk of corporate fraud. This is a U.S. federal regulation
    * Payment Card Industry Data Security Standard (PCI DSS)
        * an industry security stan- dard that applies to businesses that accept payment cards. The regulation specifies secu- rity controls that must be in place to protect cardholders’ data.
        * a data protection regulation for credit card processing
    * General Data Protection Regulation (GDPR)
        * defines privacy protections for people in and citizens of the European Union.
* CIA 
    * Confidentiality
        * limit access to data
        * using HTTPS, Cloud KMS, IAM
    * Availability
        * ensure users have access to a system
        * DDoS protections (i.e Cloud Armor)
    * Integrity
        * protecting data 
        * Access controls
            * App Engine has roles for admins, code viewers, deployers, and others
            * principle of least priviledge
            * grant access according to common business roles
        * Network Security
            * Firewall, VPC Service Controls


## 1.2 Designing a solution infrastructure that meets technical requirements. 

### High availability and failover design
* [HA Configuration Overview](https://cloud.google.com/sql/docs/mysql/high-availability)
* HA → continuous operation of a system at sufficient capacity to meet demands of ongoing workloads
* Availability is usually measured as a percent of time that a system is available and responding to requests with latency not exceeding some certain threshold
    * 99.00 → 14.4 min downtime/day, 1.68 hours/week, 7.31 hours/mth
    * 99.90 → 1.44 mins/day, 10.08 mins/week, 43.83 mins/mth
    * 99.99 → 8.64 secs/day, 1.01 mins/week, 4.38 mins/mth
    * 99.999 → 864 msec/day, 6.05 secs/week, 26.3 secs/mth
    * 99.9999 → 86.4 msecs/day, 604.8 msecs/week, 2.63 secs/mth
* Plan for failures
    * Failures can occur at multiple points in an application stack:
        * An application bug
        * A service that the application depends on is down A database disk drive fills up
        * A network interface card fails
        * A router is down
        * A network engineer misconfigures a firewall rule
* Compensate for hardware failures with redundancy
    * Instance groups and load balancers
    * Regional storage 
    * mutli-disk writes
* Compensate for software and configuration errors using DevOps best practices
    * Code reviews
    * Canary deployments, where a small portion of a system’s workload is routed to a new version of the system which allows testing of the code under production conditions without exposing all users to the new code.
    * Automating infrastructure by treating infrastructure as code
* Compute Availability
    * HA in Compute Engine
        * Hardware redundancy and Live Migration
            * large number of phyiscal server in GCP provide redundancy for hardware failures, if a phyiscal server fails others are available to replace it
            * Live Migration
                * allows VMs to move to other phyiscal servers when there is a problem with a physical server or scheduled maintanence occurs.
                * also used when network or power systems are down, security patches need to be applied or configurations needed to be modified.
                * not avaialble for preemptible VMs as they are not designed to be HA
                * currently VMs with GPUs attached are not available to live migrate
        * Managed Instance Groups (MIGs)
            * cluster VMs all running the same services in the same configuration
            * uses an Instance Template to specify the configuration of each VM in the group, it specifies the machine type, boot disk image, and other VM configuration details
            * if a vm in the group fails, another one will be created using the template
            * also provide other features to help improve availability such as detecting application health using application-specific health checks
                * if the VM fails the health check, the MIG will kill the failing instance and create a new instance, this is called _autohealing_
            * uses load balancing to distribute workload accross instances
            * instance groups can be configured as regional instance groups which distributes instances accross multiple zones, if there is a failure in a zone the application can continue to run in the other zones
        * Mulitple Regions and Global Load Balancing
            * regional instance groups, 
            * load balancers such as HTTP(s), SSL Proxy or TCP Proxy for global load balancing
    * HA in Kubernetes Engine
        * Kubernetes Enginer or GKE is a managed kubernetes service that is used for container orchestration
        * designed to provide ha containerized services
        * VMs in GKE clusters are members of a managed instance group so they have all the HA features described above
        * kubernetes continually monitors the state of the containers and pods
        * pods are the smallest unit of deployment and usually have one continer but in some cases may have two or more tightly coupled containers
        * if pods are not functionnig correctly they will be shut down and replaced
        * kubernetes collects statistics such as number of desired pods and number of available pods, which can be reported to Cloud Monitoring
        * GKE clusters can be zonal or regional
        * to improve availability you can create a regional cluster in GKE, the managed service that distributes the underlying VMs across multiple zones within a region
        * GKE replicates control plane servers and nodes across resource controller and when deployed to mulitple zones provides continued availability in the even of a zone failure
    * HA in App Engine and Cloud Functions
        * App Engine and Cloud Functions are fully managed computed services
        * users are not responsible for maintaining the availbaility of the compute resources
        * GCP ensures the HA of these services
        * uses need to leverages proper software engineering and devops practices to help improve application availability
* Availability vs Durability 
    * Durability is a measure of the probability that a storage object will be inaccessible at some point in the future.
    * A storage system can be HA but not durable
        * Local SSD is an example of this
        * Persistent SSD or Cloud Filestore are HA and Durable
    * Availability of Object, File, and Block Storage
        * Cloud Storage (Object) is fully managed object storage service
        * Google maintains HA of the service
        * Cloud Filestore, fully managed, provides filesystem storage that is available across the network
        * Peristent Disks(PDs) are SSDs and hard disk drives that can be attached to VMs
            * these disks provide block storage so that they can be used to implement filesystems and database storage
            * PDs continue to exist even after the VM is shut down.
            * one way to enable HA is by supporting online resizing
            * GCP offers zonal and regional PDs, regional PDs are replicated in two zones within a region
            * Categories
                * Zonal Standard PD
                    * effecient and reliable
                    * stores up to 64 Tb
                    * better than 99.99 % durability
                * Regional Standard PD
                    * like zonal but replicated across two zones in a region
                * Zonal Balanced PD
                    * higher IOPS rates than standard
                    * better than 99.999 % durability
                * Regional Balanced PD
                    * like zonal balanced but replicated across two zones in a region
                * Zonal SSD PD
                    * higher IOPS rates than balanced or standard
                    * better than 99.999 % durability
                * Regional SSD
                    * same as zonal ssd, but replicated
                * Zonal Extreme PD
                    * highest-performance block storage option
                    * better than 99.9999 % durability
        * Availability of Databases
            * GCP users can choose between running database servers in VMs that they managed or using one of the managed database services
            * Self-Managed Databases
                * need to consider how to maintain availability if the database server or underlying VM fails. Redundancy is the common approach to ensuring availability in databases. How you configure multiple database servers will depend on the database system you are using.
                    * For example PostgreSQL has several options for using combinations of primary servers, hot standby and warm standby servers. A hot standby can take over immediately in the event of a primary server failure. A warm standby may be slightly behind in reflecting all transaction. PostgreSQL employs several methods for enabling failover:
                        * _Shared disk_
                            * multiple databases share a disk, if primary server fails, the standby starts to use the shared disk
                        * _Filesystem replication_
                            * changes in the master server filesystem are mirrored on the failover server's filesystem
                        * _Synchronous multimaster replication_
                            * each server accepts and propagates changes to other servers
            * Managed Databases
                * Fully managed and serverless databases, such as Cloud Firestore and BigQuery are highly available and Google attends to all of the deployment and configurations details to ensure high availability
                * Datasbase servers such as Cloud SQL and BigTable require users to specify some server configuration options to make them more or less high available based on the use of regional replication
                    * Example, BigTable regional replication enables primary-primary replication among clusters in different zones. This means both clusters can accept reads and writes, and changes are propagated to the other cluster. Additionally regional replication replicates other changes such as updating data or adding/removing column families and adding or removing tables
                * In general, the availability of databases is based on the number of replicas and their distribution. The more replicas and the more they are dispersed across zones, the higher the availability.
        * Availability of Caching
            * Caches are typically optimized for low latency and often come with low durability. Snapshots of the state of a cache may be saved to persistent storage to provide a point of recovery, but such snapshots are not as general purpose as a database table saved to persistent disk.
            * Cloud Memorystore is a HA cache service in GCP which supports Memcached and Redis
        * Network Availability
            * Two primary ways to improve network availability
                * Use redundant network connections
                    * used to increase connectivity availability between an on-premise data center and Google's data center.
                    * [Dedicated Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect/concepts/dedicated-overview),    
                        * used with a minimum of 10 Gbps throughput and traffic does not traverse the public internet.
                        * usage is possible when both your network and the Google Cloud network have a point of presence in a common location, such as a data center. 
                    * [Partner Inconnect](https://cloud.google.com/network-connectivity/docs/interconnect/concepts/partner-overview).
                        * use when your data center is not in a common location as Google Cloud's network
                        * provision a network link between your data center and a Google network point of presence that is closest to you. 
                        * Traffic flows through a telecommunication provider's network from your data center to Google's network. 
                        Traffic does not travel of the internet
                    * [Cloud VPN](https://cloud.google.com/network-connectivity/docs/vpn/concepts/overview)
                        * can also be used when sending data over the internet is not a problem. * You should choose among these options based on cost, security, throughput, latency, and availability considerations. 
                        * Google Cloud offers a high availability VPN, known as HA VPN, which uses redundant connections and offers a 99.99 percent SLA.
                * Use [Premium Tier Networking](https://cloud.google.com/network-tiers)
                    * Data within the GCP can be transmitted among regions using the public internet or Google’s internal network.
                    * Standard Tier use the public internet
                    * Premium tier leverages Google's internal network which is designed for high availability and low latency and should be considered if global network availability is a concern
                        * Note if you need Globla Load Balancing then you must use Premium Tier
       
### Elasticity of cloud resources with respect to quotas and limits
* [Working with Quotas](https://cloud.google.com/docs/quota)

### Scalability to meet growth requirements
* [Reliability](https://cloud.google.com/architecture/framework/reliability)
* Scalability is the process of adding and removing infrastructure resources to meet workload demands efficiently.
    * VMs in a managed instance group scale by adding or removing instances to/from the group
    * K8s scales pods based on load and configuration parameters
    * NoSQL databases scale horizontally but this introduces issues around consistency
    * Relational databases can scale horizontally but that requires server clock synchronization if strong consistency is required among all nodes. Cloud Spanner uses the TrueTime service, which depends on atomic clocks and GPC signals to track time.
    * As a general rule, scaling stateless applications horizontally is straightforward. Stateful applications are difficult to scale horizontally, and vertical scaling is often the first choice when stateful applications must scale. Alternatively, stateful applications can move state information out of the individual containers or VMs and store it in a cache, like Cloud Memorystore, or in a database. This makes scaling horizontally less challenging
    * Scaling Compute in Compute Engine
        * using managed instance groups which supports autoscaling
        * Adding VMs to a managed instance group is known as _scaling out_ or _scaling up_. Removing VMs from a managed instance group is known as _scaling in_ or _scaling down_.
        * autoscaling is not available for stateful configurations
        * Unmanaged Instance Groups do not support autoscaling
        * Compute Engine autoscaling should not be used by managed instance groups owned by Kubernetes Engine; cluster autoscaling should be used in those cases.
        * Autoscaling can be configured to scale bases on serveral attributes, including the following:
            * Average CPU utlization
            * HTTP load balancing utilization
            * Customer monitoring metrics
        * In addition to autoscaling based on metrics, you can also schedule autoscaling based on time using a scaling schedule. A scaling schedule has a capacity, which is the minimum number of required VMs, and a schedule that includes a start time, duration, and recurrence frequency, such as daily or weekly.
        * When adding a VM to a managed instance group, the application running on the VM will take some time to initialize. This is known as the cooldown period. Autoscalers will use data from VMs in a cooldown period for scale-in decisions but not scale-out decisions. By default, the cooldown period is 60 seconds, but that can be changed.
        * You can control scale-in oper- ations by specifying a maximum allowed reduction in VMs within a specified time period known as the trailing time window. The trailing time window is the time window the auto- scaler monitors for making scaling decisions. The autoscaler does not resize below the peak size less the maximum allowed reduction in VMs.
    * Scaling Compute in Kubernetes Engine
        * Pods are the smallest computational resource
        * Pods contain containers, usually only one but could be more, and run on nodes, which are VMs in managed instance groups
        * Containers in the same pod should have the same scaling characteristics since they will be scaled up and down together
        * a deployment specifies updates for pods and ReplicaSets, which are sets of identically configured pods running at some point in time. 
        * canary deployment is when a small amount of traffic is sent to a new verions of a deployment to test new code in a production environment without exposing all users to the new code
        * applications running a set of pods can be exposed using a service, which provides a stable abstraction for accessing an application runining in a deployment, which can have pods and associated IP addresses that change
        * kubernetes can scale the number of nodes in a cluster, the number of replicas and pods running a deployment.
        * GKE automatically scales the size of the cluster based on load, if a new pod is created and there are not enough resources in the cluster to run the pod, then the autoscaler will add a node
        * Nodes exist within node pools, which are nodes with the same configuration
        * specify the min / max number of replicas and a target that specifies a resource like CPU utilization and a threshold such as 80% in a deployment to allow the autoscaler to scale the replicaset
        * since k8s 1.9 custom metrics can be specified in Cloud Metrics as a target
    * Scaling Storage Resources
        * least scalable system is locally attached SSD on VMs and is not considered a persistent storage option, as data will be retain during reboots and live migrations, but is lost when the VM is terminated or stopped
        * local data is lost from preemptible VMs when they are preempted
        * Zonal and regional persistent disks and persistent SSDs can currently scale up to 64 TB per VM instance
        * consider read/write performance when scaling persistent storage, standard disks have a max sustained read IO operations per second (IOPS) of 0.75 per gigabyte and write IPOS of 1.5 per gigabyte.
        * Persisten SSDs have a max sustained read/write IOPS of 30 per gigabyte
        * Persistent disks are well suited for large-volume batch processing when low-cost and high-storage volume are important, such as running a Database on a VM
        * Adding storage is a two step process. You will need to allocate persistent storage and then issue operating system commands to make the storage available to the filesystem. The commands are operating system specific.
            * https://cloud.google.com/compute/docs/disks/resize-persistent-disk
        * Cloud storage and BigQuery ensure storage is available as needed, with BigQuery even if you do not scale storage directly you may want to consider partitioning data to improve performance of queries.
        * Partitioning organizes data in a way that allows the query processor to scan smaller amounts of data to answer a query
            * Example: 
                * Analysts typically analyze data at the week and month levels. If the data is partitioned by week or month, the query processor would scan only the partitions needed to answer the query. Data that is outside the date range of the query would not have to be scanned. Since BigQuery charges by the amount of data scanned, this can help reduce costs.
            * https://cloud.google.com/bigquery/docs/partitioned-tables
    * Network Design for Scalability
        * connectivity between on-premise data centers and google data centers doesnt scale like compute and storage, you must plan for what is the upper limit of what will be needed
        * you should also plan for peak capacity
* Reliability
    * measurement of the likelihood of a system being available and able to meet the needs of the load on the system
    * Example measurements
        * Total System Uptime
            * difficult when dealing with distributed systems (microsservices)
            * so this is not an ideal measurement
        * Successful request rate
            * percentage of all application requests that are successufully responded to.
    * Reliability Engineering
        * Identify how to monitor services
        * Considering alerting conditions
        * Using existing incident response procedures with the new system
        * Implementing a system for tracking outages and performing post-mortems


### Performance and latency
* [Performance and cost optimization](https://cloud.google.com/architecture/framework/performance-cost-optimization)

## 1.3 Designing network, storage, and compute resources. 

### Integration with on-premises/multicloud environments
* [Hybrid and multi-cloud architecture patterns](https://cloud.google.com/architecture/hybrid-and-multi-cloud-architecture-patterns)
* [Anthos](https://docs.google.com/document/d/1foNe_eyaCqFCnzYbXX7S3w0qQsNkbpnd_suFW6r_3zw/edit?usp=sharing)

### Cloud-native networking (VPC, peering, firewalls, container networking)
* [Networking Options](https://docs.google.com/document/d/1FsZ3MzfUa1gB1KJ9fIkEl3BJR9tzDZGWfEtr1tCZ1Uk/edit?usp=sharing)
* [VPC network overview](https://cloud.google.com/vpc/docs/vpc)
* [VPC Peering](https://cloud.google.com/vpc/docs/vpc-peering)
* [Cloud Firewall](https://cloud.google.com/firewall/docs/about-firewalls)
    * Policies
        * group several firewall rules so that you can update them all at once, effectively controlled by Identity and Access Management (IAM) roles. 
        * These policies contain rules that can explicitly deny or allow connections, as do Virtual Private Cloud (VPC) firewall rules.
        * Types
            * [Hierarchial firewall policies](https://cloud.google.com/firewall/docs/firewall-policies)
                * group rules into a policy object that can apply to many VPC networks in one or more projects. You can associate hierarchical firewall policies with an entire organization or individual folders.
            * [Global network firewall policies](https://cloud.google.com/firewall/docs/network-firewall-policies)
                * group rules into a policy object applicable to all regions (global). 
                * After you associate a global network firewall policy with a VPC network, the rules in the policy can apply to resources in the VPC network.
            * [Regional network firewall policies](https://cloud.google.com/firewall/docs/regional-firewall-policies)
                * group rules into a policy object applicable to a specific region. 
                * After you associate a regional network firewall policy with a VPC network, the rules in the policy can apply to resources within that region of the VPC network.
    * Policy and rule evaluation order
        * Rules in hierarchical firewall policies, global network firewall policies, regional network firewall policies, and VPC firewall rules are implemented as part of the VM packet processing of the [Andromeda network virtualization stack](https://www.usenix.org/system/files/conference/nsdi18/nsdi18-dalton.pdf). Rules are evaluated for each network interface (NIC) of the VM.
        * The applicability of a rule doesn't depend on the specificity of its protocols and ports configuration. For example, a higher priority allow rule for all protocols takes precedence over a lower priority deny rule specific to TCP port 22.
        * In addition, the applicability of a rule doesn't depend on the specificity of the target parameter. 
            * For example, a higher priority allow rule for all VMs (all targets) takes precedence even if a lower priority deny rule exists with a more specific target parameter; for example—a specific service account or tag.
        * ![Order](https://cloud.google.com/static/firewall/images/firewall-policies/hfw3-2.svg)
    * Tags
        * let you define sources and targets in global network firewall policies and regional network firewall policies.
        * also referred to as _secure tags_ in global and regional network firewall policies
        * can be created in an organization or project
        * key value pairs
        * different from network tags
            * network tags are  are simple strings, not keys and values, and don't offer any kind of access control
            * comparison between Tags and network tags can be found [here](https://cloud.google.com/firewall/docs/tags-firewalls-overview#differences)
        * Creating and Manageing Tags
            * Requires Roles
                * Tag Viewer
                    * view tag definitions and tags that are attached to resources
                    * `roles/resourcemanager.tagView`
                    * Permissions
                        * `resourcemanager.tagKeys.get`
                        * `resourcemanager.tagKeys.list`
                        * `resourcemanager.tagValues.list`
                        * `resourcemanager.tagValues.get`
                        * `listTagBindings` for the appropriate resource type. 
                            * For example, `compute.instances.listTagBindings` for viewing tags attached to Compute Engine instances.
                        * `listEffectiveTags` for the appropriate resource type. 
                            * For example, `compute.instances.listEffectiveTags` for viewing all tags attached to or inherited by Compute Engine instances.
                * Tag Admin
                    * create, update, and delete tag definitions
                    * `roles/resourcemanager.tagAdmin`
                    * Permissions
                        * `resourcemanager.tagKeys.create`
                        * `resourcemanager.tagKeys.update`
                        * `resourcemanager.tagKeys.delete`
                        * `resourcemanager.tagKeys.list`
                        * `resourcemanager.tagKeys.get`
                        * `resourcemanager.tagKeys.getIamPolicy`
                        * `resourcemanager.tagKeys.setIamPolicy`
                        * `resourcemanager.tagValues.create`
                        * `resourcemanager.tagValues.update`
                        * `resourcemanager.tagValues.delete`
                        * `resourcemanager.tagValues.list`
                        * `resourcemanager.tagValues.get`
                        * `resourcemanager.tagValues.getIamPolicy`
                        * `resourcemanager.tagValues.setIamPolicy`
                * Tag User
                    * add and remove tags that are attached to resource
                    * `roles/resourcemanager.tagUser`
                    * Permissions
                        * Permissions required for the resource you're attaching the tag value
                            * Resource-specific `createTagBinding` permission, 
                                * such as `compute.instances.createTagBinding` for Compute Engine instances.
                            * Resource-specific `deleteTagBinding` permission, 
                                * such as `compute.instances.deleteTagBinding` for Compute Engine instances.
                        * Permissions required for the tag value:
                            * `resourcemanager.tagValueBindings.create`
                            * `resourcemanager.tagValueBindings.delete`
                        * Permissions that let you view projects and tag definitions:
                            * `resourcemanager.tagValues.get`
                            * `resourcemanager.tagValues.list`
                            * `resourcemanager.tagKeys.get`
                            * `resourcemanager.tagKeys.list`
                            * `resourcemanager.projects.get`
                    * Create a new Tag
                        * `gcloud resource-manager tags keys create SHORT_NAME --parent=RESOURCE_ID`
                            * SHORT_NAME: maximum length of 63 characters, also the permitted character set for the shortName includes UTF-8 encoded Unicode characters except single quotes ('), double quotes ("), back slashes ('\'), and forward slashes ('/').
                            * RESOURCE_ID: parent organization (`organizations/12344505`) or project (`project/test-project123`, or `project/234566789`)
                    * View a tag
                        * `gcloud resource-manager tags keys describe TAGKEY_NAME`
                            * TAGKEY_NAME is the permanent ID or namespace name of the tag key
                                * `tagKeys/12345` or `project-id/environment`
                    * Add values
                        * `gcloud resource-manager tags values create TAGVALUE_SHORTNAME --parent=TAGKEY_NAME`
                    * Retrieve tag value
                        * `gcloud resource-manager tags values describe TAGVALUE_NAME`
                    * Managing Tags
                        * https://cloud.google.com/resource-manager/docs/tags/tags-creating-and-managing#gcloud

### Choosing data processing technologies
* hhttps://docs.google.com/document/d/15XChdvKqniRd__UE5iN16MUejUQ8oT6EuWZkD1MVAds/edit?usp=sharing

### [Choosing appropriate storage types (e.g., object, file, databases)](https://cloud.google.com/blog/topics/developers-practitioners/your-google-cloud-database-options-explained)

* Cloud Storage Classes
    * Standard
        * Hot active, frequently access
    * Multiregional or dual-region storage
        * HA or global data access
    * Nearline
        * data will not be accessed more than once a month and stored for 30 days
    * Coldline
        * stored atleast 90 days and access no more than once every three months
    * Archive
        * data accessed not more than once a year
    * Additional
        * Multi-Regional or dual-region Storage
            * Equivalent to Standard storage, except Multi-Regional storage can only be used for objects stored in [multi-regions](https://cloud.google.com/storage/docs/locations#location-mr) or [dual-regions](https://cloud.google.com/storage/docs/locations#location-dr).
        * Regional
            * Equivalent to Standard storage, except Regional storage can only be used for objects stored in [regions](https://cloud.google.com/storage/docs/locations#location-r).
        * Durable Reduced Availability (DRA)
            * Similar to Standard storage except:
                * DRA has higher pricing for operations.
                * DRA has lower performance, particularly in terms of availability (DRA has a 99% availability SLA).
            * You can move your data from DRA to other storage classes by [performing a storage transfer](https://cloud.google.com/storage-transfer/docs/create-manage-transfer-console).
* ![Database Choice](https://storage.googleapis.com/gweb-cloudblog-publish/images/Which-Database_v03-22-23.max-2000x2000.jpg)
* https://docs.google.com/document/d/1T_zkjpUQCAAX5q3XCer_xjSO4BVBwkXEt8TcEnoLMPY/edit?usp=sharing

### Choosing compute resources (e.g., preemptible, custom machine type, specialized workload)
* https://cloud.google.com/compute/docs/choose-compute-deployment-option
* https://docs.google.com/document/d/1VONbhuecrB6LUPaIw-aD696nA20jkhKQRcIQxtI7soE/edit#heading=h.2mikt2pcepm
* ![Decision Tree](https://cloud.google.com/static/compute/images/migs-decision-tree.svg)


### Mapping compute needs to platform products
* https://jayendrapatil.com/google-cloud-compute-options/

## 1.4 Creating a migration plan (i.e., documents and architectural diagrams). 

* Planning a migration should use a five-step migration:
    * Integrating cloud services with existing systems
        * Five steps process
            * Estimate
                * use migration center to rapidly generate an estimated cost for the migration
                * https://cloud.google.com/migration-center/docs/generate-estimate
            * Discover
                * Tools to discover assets
                    * [Migration Center discovery client CLI (mdc)](https://cloud.google.com/migration-center/docs/discovery-client-cli-overview)
                * Run a discovery of your environment
                    * https://cloud.google.com/migration-center/docs/start-asset-discovery
                    * [Run an inventory discovery](https://cloud.google.com/migration-center/docs/run-inventory-discovery)
                        * vSphere
                            * `./mcdc discover vsphere --url https://VSPHERE_URL -u USERNAME --path DATACENTER/HOST/CLUSTER`
                        * RVTools
                            * `./mcdc discover rvtools REPORT_NAME.xlsx`
                        * AWS 
                            * `./mcdc discover aws -r REGION`
                    * [Run a guest discovery](https://cloud.google.com/migration-center/docs/run-guest-discovery)
                        * scan and collect data about the running applications which includes both virtual machine (VM) instances and physical servers. It also collects data about the machine configuration, hardware, network, as well as open files, services, and processes.
                    * Automatically Scan Infrastructure
                        * [Install client on infra - reqs](https://cloud.google.com/migration-center/docs/installation-requirements)
                        * [Install discovery client process](https://cloud.google.com/migration-center/docs/installation-process)
                            * client lets you collect data in two different ways
                                * offline
                                    * stores collected data locally and can work without internet connectivity. You can then send the data to migration center to complete the process
                                * online
                                    * sends collected data automatically to migration center 
                        * [Collection Methods](https://cloud.google.com/migration-center/docs/collection-methods)
                        * [Target Assessment Requirements](https://cloud.google.com/migration-center/docs/target-assets-requirements)
                    * [Manually import data](https://cloud.google.com/migration-center/docs/manual-import-overview)
                        * [Import From other cloude](https://cloud.google.com/migration-center/docs/import-data-cloud-providers)
                            * Currently only supports Azure and AWS
                                * [Script for Azure](https://github.com/GoogleCloudPlatform/azure-to-stratozone-export)
                                * [Script for AWS](https://github.com/GoogleCloudPlatform/aws-to-stratozone-export)
                        * [Import from RVTools](https://cloud.google.com/migration-center/docs/import-data-rvtools)
            * Assessment
                * Take inventory of apps and infra
                * Document consideration for moving each including issues with compliance, licensing and dependencies
                * [Run offline assessment](https://cloud.google.com/migration-center/docs/run-offline-assessment)
                    * using `./mcdc report` command 
                * [Additional Assessment Tools](https://cloud.google.com/migration-center/docs/discovery-assessment-tools)
            * Plan 
                * https://cloud.google.com/migration-center/docs/migration-planning-overview
                * should focus on defining the foundations of your cloud envi- ronment, including the resource organization hierarchy, identities, groups, and roles.
            * Execute/Migrate
                * https://cloud.google.com/migration-center/docs/migration-execution
            * Pilot / PoC
                * Migrate one or two apps in an effort to learn about the cloud
                * Gain experience developing for the cloud
                * Learn the level of effort to setup networking and security
            * Data migration
                * Begin moving data to the cloud
                * Consider which apps are dependant on specific data sources
                * Understand the level of security required for each data sources
                * Decide whether using gsutil or transfer service will be used
            * Application migration
                * Either life/shift or modernization
            * Optimization
                * Add logging, reliability
        * Migrating systems and data
            * Planning for systems migrations
                * Consider criticality of systems 
                    * Tier 1 are highly critical systems that have huge business impact that cant afford any delay or degradation
                    * Tier 2 are moderately import apps such as batch processing jobs that can tolerate some delay or degradation
                    * Tier 3 are all other applications
            * Dependent systems
                * Is there automated deployments
            * Data Governance
                * understand regulations
            * Planning migration of object storage
                * Plan structure of buckets
                * Determine role and access controls
                * Tier (archive (coldline), nearline or standard)
                * Cost and time of migration to cloud storage
                * Plan the order in which data will be transferred
                * Determine the method (gsutil, cloud storage transfer service, etc)
            * When transferring data from an on-premises data center, transferring with gsutil is a good option when the data volume is less than 10 TB of data and network bandwidth is at least 100 Mbps. If the volume of data is over 20 TB, the Google Transfer Appliance is recommended. When the volume of data is between 10 TB and 20TB, consider the time needed to transfer the data at your available bandwidth. If the cost and time requirements are acceptable, use gsutil; otherwise, use the Google Transfer Appliance. 
            * Relational Data
                * Either use an export of the database and transfer the data to the cloud and import into the cloud instance of the database
                * This requires the database to be unavailable during the migration
                * Another option is to create a replica of the database in GCP
                    * primary/replica or leader/follower
                        * This is generally the preferred method
                        * Once the database is sychronized the applications can be configured to point to the cloud database

### Software license mapping
* [Build app inventory](https://cloud.google.com/architecture/migration-to-gcp-assessing-and-discovering-your-workloads#building_an_inventory_of_your_apps)
* [Bring your own licenses (BYOL)](https://cloud.google.com/compute/docs/nodes/bringing-your-own-licenses)
* Pay-as-you-Go/metered model
    * Vendors charge per usage
* Google has outlined the following steps for bring- ing an existing license to Google Cloud:
    1. Prepare images according to license requirements.
    2. Activate licenses.
    3. Import virtual disk files and create images.
    4. Create sole-tenant node templates.
    5. Create sole-tenant node groups.
    6. Provision VMs on the node groups with the virtual disk files.
    7. Track license usage.
    8. Report license usage to your vendor.
* You can install the IAP Desktop tool (github.com/GoogleCloudPlatform/iap-desktop/releases/tag/2.21.681) to help monitor and report on your license usage on sole-tenant nodes.

### Network planning
* VPC infrastructure is built on Google’s software-defined networking platform. Google manages the underlying software and hardware that implement VPCs.
* Broken down into four broad categories of planning
    * VPCs
        * Networks
            * Networks are private RFC 1918 address spaces. 
            * These are networks that use one of three ranges.
                * 10.0.0.0 to 10.255.255.255, with 16,777,216 available addresses 
                * 172.16.0.0 to 172.31.255.255, with 1,048,576 available addresses 
                * 192.168.0.0 to 192.168.255.255, with 65,546 available addresses
            * create subnets to group resources by region
        * Subnets
            * GCP Networking can automatically manage
            * Automatically managed subnets are useful when you want a subnet in each region and you are not connecting to other networks
            * Create you own using custom mode networks
                * In general, it is recommended that you manage your own subnets, which are called custom mode networks. These provide you with complete control over which regions have subnets and the address ranges of each subnet.
        * IP addresses
            * VM instances can support 2 IP addresses: 
            * One internal
                * Used for traffic within a VPC network
            * One external - Optional 
                * Used to communicate with external networks
            * May be ephemeral or static
                * Use static if you need a consistent long-term IP, for example, a public website or API endpoint.
        * Routes
             * Rules for forwarding traffic
            * Some are generated automatically when VPCs are created
            * Custom routes can be created, if you want to implement many-to-one NAT or transparent proxies
            * Routes between subnets are created by default
        * Virtual private networks (VPNs)
             * Provided by the Cloud VPN service which links you GCP VPC to an on-premise network
            * Uses IPSec tunnel to secure transmission.
            * Single VPN gateway can sustain up to 3 Gbps.
    * Access Controls
        * Pre-defined roles
        * Network Admin: 
            * `roles/compute.networkAdmin`
            * For full permissions to manage network resources 
        * Network Viewer: 
            * `roles/compute.networkViewer`
            * For read-only access to network resources 
        * Security Admin: 
            * `roles/compute.securityAdmin`
            For managing firewall rules, SSL certificates , and also to configure [Shielded VM](https://cloud.google.com/compute/shielded-vm/docs) settings
        * Compute Instance Admin: 
            * `roles/compute.instanceAdmin.v1`
            * Full control of Compute Engine instances, instance groups, disks, snapshots, and images. Read access to all Compute Engine networking resources.
            * If you grant a user this role only at an instance level, then that user cannot create new instances.
        * Compute Instance Admin (beta):
            * `roles/compute.instanceAdmin`
            * Permissions to create, modify, and delete virtual machine instances. This includes permissions to create, modify, and delete disks, and also to configure [Shielded VM](https://cloud.google.com/compute/shielded-vm/docs) settings.
            * If the user will be managing virtual machine instances that are configured to run as a service account, you must also grant the `roles/iam.serviceAccountUser` role.
            * Lowest-level resources where you can grant this role:
                * Disk
                * Image
                * Instance
                * Instance template
                * Snapshot Beta
    * Scaling
        * Load Balancing
        * Managed Instance groups
        * CDN
        * Cloud DNS
    * Connectivity
        * Hybrid (VPN)
        * Dedicated/Partner/Cross-Cloud Interconnect


       

    

Testing and proofs of concept

### Dependency management planning
* [Build app inventory](https://cloud.google.com/architecture/migration-to-gcp-assessing-and-discovering-your-workloads#building_an_inventory_of_your_apps)
* [Google Cloud Migration Center](https://cloud.google.com/migration-center/docs/migration-center-overview)
    * lets you generate a rapid cost estimate of your future cloud costs based on the size and configuration of the resources in your current on-premises environment. This lets you and your organization take some guesswork out of future cloud budgets.
* [Specifying Dependencies](https://cloud.google.com/appengine/docs/legacy/standard/go111/specifying-dependencies)

## 1.5 Envisioning future solution improvements. 

### Cloud and technology improvements
* [GCP Release Notes and Updates](https://cloud.google.com/release-notes)

### Evolution of business needs

### Evangelism and advocacy
* https://cloud.google.com/blog/products/api-management/api-team-best-practices-developers-evangelists-and-champions

# Section 2: Managing and provisioning a solution infrastructure

## 2.1 Configuring network topologies
### OSI Model
* [Open Source Interconnection (OSI) Model](https://en.wikipedia.org/wiki/OSI_model)
    * conceptual model from the [International Organization for Standardization (ISO)](https://en.wikipedia.org/wiki/International_Organization_for_Standardization)
    * provides a common model to describe communication system
    * paritions the flow of data in sevent abstraction layers, which are as follows:
        * Layer 1 - Physical
            * represents the physical base of the network, including cables, radio frequency, voltages, and other aspects of the physical implementation of networking.
            * Layer 2 - Data Link
                * handles data transfer between two nodes in a network as well as error correction for the physical layer. 
                    * has two sublayers
                        * Media Access Con- trol (MAC)
                        * Logical Link Control (LLC). 
                    * Switches often, but not always, operate at layer 2.
            * Layer 3 - Network
                * manages packet forwarding using routers. 
                * The IP protocol exists at layer 3.
            * Layer 4 - Transport
                * controls data transfer between systems. 
                * manages how the amount of data is sent and where to send it. 
                * The Transmission Control Protocol (TCP) and the User Datagram Protocol (UDP) operate at layer 4.
            * Layer 5 - Session
                * manages sessions or interactions over time between applications. 
                * The handshake portion of Transport Layer Security (TLS) operates at layer 5.
            * Layer 6 - Presentation
                * manages the mapping from application representations to network representations. 
                * Encryption and decryption of network traffic is performed at layer 6.
            * Layer 7 - Application
                * top layer of the OSI network model
                * provides functionality for applications, like web browsers, to access lower-level network services.  
* [Virtual Private Cloud (VPC) Network]
    * a virtual version of a physical network that is implemented inside of Google's production network by using [Andromeda](https://www.usenix.org/system/files/conference/nsdi18/nsdi18-dalton.pdf)
    * provides the following capabilities:
        * Provides connectivity for your Compute Engine virtual machine (VM) instances
        * Offers native internal passthrough Network Load Balancers and proxy systems for internal Application Load Balancers.
        * Connects to on-premises networks by using Cloud VPN tunnels and VLAN attachments for Cloud Interconnect.
        * Distributes traffic from Google Cloud external load balancers to backends
    * default Maximum Transmission Unit (MTU) of 1460 bytes this can be configured to be a different value
        * MTU is the size, in bytes, of the largest packet supported by a network layer protocol (includeing both headers and data)
        * can be configured to support an MTU of 1500 (standard Ethernet) up to 8896 (jumbo frames) or down to 1300 (https://cloud.google.com/vpc/docs/mtu#valid_mtus)
        * use the `--mtu=MTU` flag on the `gcloud compute networks update` command
    * global resource    
    * can be partitioned into smalller subnetworks, known as subnets
    * [Subet](https://cloud.google.com/vpc/docs/subnets)
        * regional resource   
        * creating subnets you specify a range of IP addresses, resource that need an IP will recieve on from that range, each subnet in a VPC
        * Internet Protocol (IP) address
            * identifier for a device, virtual device, or service on a network using the IP protocol
            * designed to support forwarding of network packets along routes from source to destination
            * can be specified in :
                * [IPv4](https://en.wikipedia.org/wiki/Internet_Protocol_version_4)
                    * use four octets, such as 192.168.20.10
                    * 32 bit address
                * [IPv6](https://en.wikipedia.org/wiki/IPv6)
                    * use eight 16-bit blocks such as FE80:0000:0000:0000:0202:B3FF:FE1E:8329
                    * 128 bit address
        * each subnet in a VPC should have distinct, nonoverlapping IP ranges
        * IP ranges are specified using the [Classless Inter-Domain Routing (CIDR)](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation, which is a method for allocating IP addresses and for IP routing
            * format is as an example 172.16.0.0/12, the / is followed by an integer of 1 to 32 which specifies the number of bits used to identify the network and the remaining bits are used to determine the host address
            * example 172.16.0.0/12
                * would mean the first 12 bits of the IP address specify the network, known as the _subnet mask_
                * the /12 represents the _subnet mask_ and the remaining 20 bits are used for host addresses, since there are 20 bits available, there can be 1,048,574 IP address in that range
            * CIDR addressing was adopted in 1993 under RFCs 1518 and 1519 and replaced classful networking, which specified three classes of unicast networks A, B, and C. There was a Class D for multicast networking and a Class E for experimental purposes as well. CIDR was adopted to help avoid IPv4 address exhaustion and help control the growth of routing tables.
            * RFCs are technical specifications for the internet defined the Internet Engineering Task Force. 
        * Classful three classes:
            * Class A
                * Range: 0.0.0.0-127.255.255.255
                * Most-Significant Bits: 0
                * Network Prefix size: 8
                * Host Identifier: 24
            * Class B
                * Range: 128.0.0.0-191.255.255.255
                * Most-Significant Bits: 10
                * Network Prefix size: 16
                * Host Identifier: 16
            * Class C
                * Range: 192.0.0.0-223.255.255.255
                * Most-Significant Bits: 110
                * Network Prefix size: 24
                * Host Identifier: 8
            * Class D (multicast)
                * Range: 224.0.0.0-225.255.255.255
                * Most-Significant Bits: 1110
                * Network Prefix size: -
                * Host Identifier: -
            * Class E (reserved)
                * Range: 224.0.0.0-225.255.255.255
                * Most-Significant Bits: 1111
                * Network Prefix size: -
                * Host Identifier: -
    * [Routes](https://cloud.google.com/vpc/docs/routes)
        * determines how to route traffic within the VPC or across subnets
        * VPC can learn regional routes only or multi-regional or global routes, depending on how its configured
        * Dynamic Routes
            * routes added and removed automatically based on learned routes from Cloud Routers
        * Static Routes
            * static route next hop
            * manually administrated
        * `gcloud compute routes` command
    * Modes
        * default
            * automatically created when you enable a project
            * can be turned of using organization policy contraints, `compute.skipDefaultNetworkCreation`
        * auto-mode
            * creates a subnet in every region when enabled
            * all use a specific IP range, 10.128.0.0/9
        * custom
            * used for production environments with full control of subnetting
    * reserves four IP addresses from each subnet and the smallest allow subnet is /29 in GCP
    * Private vs Public Addressing
        * private are non-internet routable addresses that are reserved for internal use
        * public are used when we want to communicate with the internet or internet-routable addresses
        * to use a public IP address with private IP addresses, use _network address translation (NAT)_ which is used to reduce the numnber of public IP addresses needed in a network
        * [Internet Engineering Task Force (IETF)](https://www.ietf.org/) has defined three IP address ranges s private:
            * 10.0.0.0/8 : 10.0.0.0 to 10.255.255.255
                * has 16,777,216 addresses
            * 172.16.0.0/12 : 172.16.0.0 to 172.31.255.255
                * has 1,048,576 addresses
            * 192.168.0.0/16 : 192.168.0.0 to 192.168.255.255
                * 65,536 addresses
    * [Firewall Rules](https://cloud.google.com/firewall/docs/firewalls)
        * control network traffic by blocking or allowing into (ingress) or out of (egress) a network, subnet or device
        * global resoruce assigned to VPCs, apply to all VPC subnets in all regions
        * stateful
            * traffic allow through in either direction must return to the matching connection (this cannot be blocked for response)
            * return traffic must match teh 5-tuple (source IP, destination IP, source port, destination port, and protocol) of the accepted traffic, but the source and destination addresses and ports are reversed
            * The maximum number of tracked connections in the firewall rule table depends on the number of stateful connections supported by the machine type of the instance. If the maximum number of tracked connections is exceeded, tracking is stopped for the connections that have the longest idle interval to let new connections be tracked. 
        * [Tags](https://cloud.google.com/firewall/docs/tags-firewalls-overview)
            * key and values
            * requires the `roles/resourcemanager.tagAdmin` to manage tags
            * define sources and targets in global network firewall policies and regional network firewall policies  
            * different from network tags, which are simple strings and do not offer any kind of access control
            * [Comparison betweek Tags and network tags](https://cloud.google.com/firewall/docs/tags-firewalls-overview#differences)
            * when used with firewall policies they must be designated with a `GCE_FIREWALL` purpose
            * [Create the Tag keys and values](https://cloud.google.com/firewall/docs/use-tags-for-firewalls#create-tags)
            * [Create a firewall policy rule with Tags](https://cloud.google.com/firewall/docs/use-tags-for-firewalls#rules-with-tags)
        * [Address groups](https://cloud.google.com/firewall/docs/address-groups-firewall-policies)
            * combine multiple IP addresses and IP ranges into a single named logical unit which can then bed use across multiple rules in the same or different firewall policies
            * requires the `roles/compute.networkAdmin` and `roles/compute.securityAdmin` to manage and `roles/compute.networkUser` to discover and view
            * Types
                * Project-scoped address groups
                    * define your own list of IP addresses to be used within a project or a network to block or allow a list of changing IP addresses
                    * used in the firewall rules for network firewall policies
                    * container type for project-scoped address groups is always set to project.
                * Organization-scoped address groups
                    * define a central list of IP addresses that can be used in high-level firewall rules to provide consistent control for the entire organization and reduce the overhead for individual network and project owners to maintain common lists, such as trusted services and internal IP addresses.
                    * specify the `--organization ORG` flag
            * `gcloud network-security address-groups create` --> see https://cloud.google.com/firewall/docs/use-address-groups-firewall-policies#create_an_address_group
        * can be used to control traffic between regions in a VPC
        * a VPC has two implied firewall rules that are defined, which can have its behavior changed by defining additional firewall rules with higher (lower number) priority
            * one blocks all incoming (ingress) traffic (priority 65535)
            * another that allows all outgoing (egress) traffic (priority 65535)
        * have a priority specified by an integer from 0 to 65535, 0 being the highest and 65535 being the lowest
        * four default rules assigned to the default network in a VPC which cannot be deleted, all have priority of 65534 (second lowest)
            * `default-allow-internal`
                * allows ingress connections for all protocols and ports among instances in the network.
            * `default-allow-ssh` 
                * allows ingress connections on TCP port 22 from any source to any instance in the network. 
                * This allows users to ssh into Linux servers.
            * `default-allow-rdp` 
                * allows ingress connections on TCP port 3389 from any source to any instance in the network. * lets users use Remote Desktop Protocol (RDP) developed by Microsoft to access Windows servers.
            * `default-allow-icmp` 
                * allows ingress ICMP traffic from any source to any instance in the network.
        * when creating a firewall rule you specify additional properties:
            * `direction of traffic`: 
                * This is either ingress or egress.
            * `action`: 
                * This is either allow or deny traffic.
            * `target`: 
                *  This defines the instances to which the rule applies.
            * `source`: 
                * This is for ingress rules or the destination for egress rules.
            * `protocol specification`: 
                * This includes TCP, UDP, or ICMP, for example.
            * `port number`: 
                * A communication endpoint associated with a process.
            * `enforcement status`: 
                * This allows network administrators to disable a rule without having to delete it.
        * [Best Practices for firewall rules](https://cloud.google.com/firewall/docs/firewalls#best_practices_for_firewall_rules)
        * [Google's automatic block and limited traffic](https://cloud.google.com/firewall/docs/firewalls#blockedtraffic)
        * Google always allows communication between a VM instance and its corresponding metadata server at `169.254.169.254`, see [always allowed traffic](https://cloud.google.com/firewall/docs/firewalls#alwaysallowed)
        * [Create VPC firewall rules](https://cloud.google.com/firewall/docs/using-firewalls#creating_firewall_rules) (`gcloud compute firewall-rules` command)
    * [Shared VPC](https://cloud.google.com/vpc/docs/shared-vpc)
        * connect resources from multiple projects to a common VPC network using private IP addresses.
        * one host project and one or more service projects
        * host and service projects must be in the same organization with one exception for service projects during migrations, in which case the service project may be in a different organization
        * Concepts
            * Host Project
                * contains one or more Shared VPC networks, centrally shared VPC network
                * two sharing options for subnets
                    * all subnets are shared 
                    * individual subnets are shared
            * Service Project
                * any project that has been attached to a host project by a Shared VPC admin
        * Organization Policy Constraints
            * `constraints/compute.restrictSharedVpcHostProject`
                * used to limit the set of host projects to which a non-host project(s) in a folder or organization can be attached
            * `constraints/compute.restrictSharedVpcSubnetworks`
                * specifies the Shared VPC subnets that a service project can access at the project, folder, or organization level
        * IAM Roles
            * Org Admin: 
                * `roles/resourcemanager.organizationAdmin`
            * Shared VPC Admin:
                * `roles/compute.xpnAdmin` and `roles/resourcemanager.projectIamAdmin`
            * Service Project Admin:
                * `roles/compute.networkUser` and `roles/compute.instanceAdmin`
        * [Provisioning a Shared VPC](https://cloud.google.com/vpc/docs/provisioning-shared-vpc)
        * [Deprovisioning a Shared VPC](https://cloud.google.com/vpc/docs/deprovisioning-shared-vpc)
        * Shared VPCs are useful when projects are in the same organization but are not used when traffic needs to flow between projects in different organizations. In that case, VPC network peering can be used.
* [VPC Network Peering](https://cloud.google.com/vpc/docs/vpc-peering)
    * enables different VPC networks to communicate using private IP address space, as defined in RFC 1918. VPC network peering is used as an alternative to using external IP addresses or using VPNs to link networks.
    * VPC sharing does not operate between organizations
    * typically used in SaaS platforms when the SaaS provider wants to make its servcies available to customers, which use different organizations within GCP
    * also organizations that have multiple network administrative domains can use VPC network peering to access resources across those domains using private IP addressing.
    * advantages:
        * lower latency as traffic stays on Google backbone
        * services in the VPC are inaccessible from public internet, reducing attack surface
        * no egress charges associate with traffic when using VPC peering
    * peered networks manage their own resources
    * max 25 peering connections from a single VPC
    * works with Compute Enginer, App Engine Flex Environment, and GKE clusters
    * reqiures both sides to setup a peering relationship
    * both sides must have matching configurations
    * [Create a VPC peering connection](https://cloud.google.com/vpc/docs/using-vpc-peering)
* Hybrid-Cloud Networking
    * practice of providing network services between an on-premises data center and a cloud
    * _mulicloud networking_ is when two or more public clouds are linked together, may also refer to linked private data centers
    * Design considerations
        * reliable networking and adequate capacity
        * single network interconnect can become a single point of failure
        * use multiple interconnects, preferably from different providers, can reduce risk of losing internetwork communication
        * use VPN as backup if the cost of maintaining two interconnects circuits is cost prohibitive
    * [Network Topologies](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies)
        * [Mirrored Topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#mirrored)
            * public cloud and private on-premises environments mirror each other
            * used for test or DR environments
        * [Meshed Topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#meshed)
            * all systems within all clouds and private networks can communication with each other
        * [Gated egress topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#gated-egress)
            * on-premises service APIs are made available to applications running in the cloud without exposing them to the public internet
        * [Gated ingress topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#gated-ingress)
            * cloud service APIs are made available to applications running on-premises without exposing them to the public internet
        * [Gated egress and ingress topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#gated-ingress-and-egress)
            * combination of Gated egress and Gated ingress
        * [Handover topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#handover)
            * applications running on premises upload data to a shared storage service (Cloud Storage) and then services running in GCP consumes and processes that data
            * commonly used for data warehousing and analytics services
    * [Best practices](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#best-practices-topologies)
    * Hybrid-Cloud options
        * [Cloud VPN](https://cloud.google.com/network-connectivity/docs/vpn/concepts/overview)
            * securely connects GCP VPC networks and peer networks (other clouds or on-premises network) using [IPSec](https://wikipedia.org/wiki/IPsec)
            * supports up to 30 Gbps
            * each tunnel supports up to 250,000 packets per second which is between 1 and 3 Gbps
            * data is transmitted over theh public internet but is encrypted at the origin gateway and decrypted at theh destination gateway to protect confidentiality of data in transit
            * uses Encryption based on Internet Key Exchange (IKE) protocol
            * operates in IPsec ESP Tunnel Mode
            * supported cipher tables
                * IKEv2 cipherss that use Authenticated Encryption with Associated Data (AEAD)
                    * https://cloud.google.com/network-connectivity/docs/vpn/concepts/supported-ike-ciphers#ikev2_ciphers_that_use_aead
                * IKEv2 ciphers that don't use AEAD
                    * https://cloud.google.com/network-connectivity/docs/vpn/concepts/supported-ike-ciphers#ikev2_ciphers_that_dont_use_aead
            * two types:
                * Classic VPN
                    * deprecated as of March 31, 2022
                    * one network interface and one external IP address and provides 99.9% SLA
                    * [Classic VPN Topologies](https://cloud.google.com/network-connectivity/docs/vpn/concepts/classic-topologies)
                * HA VPN
                    * provides IPSec VPN connection with 99.99% availability
                    * uses two connections to provide HA
                    * each connection has its own external IP address
                    * HA VPN gateways support mutiple tunnels
                    * can be configured with just one active gateway but that does not meet requirements for 99.99% SLA
                    * [HA VPN Topologies](https://cloud.google.com/network-connectivity/docs/vpn/concepts/topologies)
                    * [Terraform HA VPN Example](https://cloud.google.com/network-connectivity/docs/vpn/how-to/automate-vpn-setup-with-terraform)
            * [Migrate from Classic to HA VPN](https://cloud.google.com/network-connectivity/docs/vpn/how-to/moving-to-ha-vpn)
            * [Best Practices](https://cloud.google.com/network-connectivity/docs/vpn/concepts/best-practices)
        * [Cloud Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect/concepts/overview)
            * provides high throughput and ha networking between GCP and on-premise / other clouds
            * three types:
                * [Dedicated Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect/concepts/dedicated-overview)
                    * available in 10 Gbps or 100 Gbps 
                    * connects direct between Google Cloud access points and your data center
                    * colocation requirements
                        * provide own routing equipement and located near [Google colocation Facility](https://cloud.google.com/network-connectivity/docs/interconnect/concepts/choosing-colocation-facilities)
                        * network devices must support the following technical requirements:
                            * 10-Gbps circuits, single mode fiber, 10GBASE-LR (1310 nm), or 100-Gbps circuits, single mode fiber, 100GBASE-LR4
                            * IPv4 link local addressing
                            * LACP, even if you're using a single circuit
                            * EBGP-4 with multi-hop
                            * 802.1Q VLAN
                * [Partner Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect/concepts/partner-overview)
                    * third party provider configurable option from 50 Mbps to 50 Gbps Connections
                    * Layer 2 connections
                        * you must configure and establish a BGP session between your Cloud Routers and on-premises routers for each VLAN attachment that you create. The BGP configuration information is provided by the VLAN attachment after your service provider has configured it.
                        * Layer 3 connections
                            * your service provider establishes a BGP session between your Cloud Routers and their on-premises routers for each VLAN attachment. You don't need to configure BGP on your local router. Google and your service provider automatically set the correct BGP configurations.
                            * Because the BGP configuration for Layer 3 connections is fully automated, you can pre-activate your connections (VLAN attachments). When you enable pre-activation, the VLAN attachments are active as soon as the service provider configures them.
                * [Cross-Cloud Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect/concepts/cci-overview)
                    * establish high throughput dedicated connectivity between GCP and another cloud service provider
                    * Supports AWS, Azure, Oracle Cloud, and Alibaba Cloud
                    * available in 10 Gbps or 100 Gbps
                    * [Setup process - AWS](https://cloud.google.com/network-connectivity/docs/interconnect/how-to/cci/aws/connectivity-overview)
                    * [Setup process - Azure](https://cloud.google.com/network-connectivity/docs/interconnect/how-to/cci/azure/connectivity-overview)
                    * [Setup process - Oracle](https://cloud.google.com/network-connectivity/docs/interconnect/how-to/cci/oci/connectivity-overview)
                    * [Setup process - Alibaba Cloud](https://cloud.google.com/network-connectivity/docs/interconnect/how-to/cci/alibaba/connectivity-overview)
            * advantages:
                * transmit data on private connections. Data does not traverse the public internet.
                * Private IP addresses in Google Cloud VPCs are directly addressable from on-premises devices. There is no need for NAT or a VPN tunnel.
                * ability to scale up Dedicated Interconnects to 80 Gbps using eight 10 Gbps direct interconnects or 200 Gbps using two 100 Gbps interconnects.
                * ability to scale up Partner Interconnects to 80 Gbps using eight 10 Gbps partner interconnects.
            * disadvantage
                * additional costs and complexity of managing infra
                * if low latency and HA are not required, use Cloud VPN
            * You can use the following constraints when defining your policy:
                * `constraints/compute.restrictDedicatedInterconnectUsage`
                   * defines the set of VPC networks that you can use when creating a VLAN attachment using Dedicated Interconnect.
                * `constraints/compute.restrictPartnerInterconnectUsage`
                    * constraint defines the set of VPC networks that you can use when creating a VLAN attachment using Partner Interconnect.
        * [Direct Peering](https://cloud.google.com/network-connectivity/docs/direct-peering)
            * form of peering that allows customers to connect their networks to a Google network point of access. 
            * This kind of connection is not a GCP service—it is a lower level network connection that is outside of GCP. 
            * works by exchanging Border Gateway Protocol (BGP) routes, which define paths for transmitting data between networks. It does not make use of any GCP resources, like VPC firewall rules or GCP access controls.
            * should be used when you need access to Google Workspace services in addition to Google Cloud services. In other cases, Google recommends using Dedicated Interconnect or Partner Interconnect.
        * [Carrier Peering](https://cloud.google.com/network-connectivity/docs/carrier-peering)
            * similar to Direct Peering except instead of working directly with Google you work a service provider to obtain enterprise-grade network services that connect your infrastructure to Google.
            * When connecting to Google through a service provider, you can get connections with higher availability and lower latency, using one or more links. Work with your service provider to get the connection you need.
            * Considerations:
                * Carrier Peering exists outside of Google Cloud. Instead of Carrier Peering, the recommended methods of access to Google Cloud are Partner Interconnect, which uses a service provider, or Dedicated Interconnect, which provides a direct connection to Google.
                * If used with Google Cloud, Carrier Peering doesn't produce any custom routes in a VPC network. Traffic sent from resources in a VPC network leaves by way of a route whose next hop is either a default internet gateway (a default route, for example) or a Cloud VPN tunnel.
                * To send traffic through Carrier Peering by using a route whose next hop is a Cloud VPN tunnel, the IP address of your on-premises network's VPN gateway must be in your configured destination range.
* [Cloud Router](https://cloud.google.com/network-connectivity/docs/router/concepts/overview)
    * fully distributed and managed Google Cloud service that uses the [Border Gateway Protocol (BGP)](https://www.wikipedia.org/wiki/Border_Gateway_Protocol) to advertise IP address ranges to other networks
    * builds dynamic routes based on IP address information it receives from other BGP peers
    * provides routing services for the following:
        * Dedicated Interconnect
        * Partner Interconnect
        * Cross-Cloud Interconnect
        * HA VPN
        * Supported router appliance (part of Network Connectivity Center)
   * by default, only advertises subnet routes, custom route advertisements can be configured
   * can be configured with Bidirectional Forwarding Detection (BFD) to quickly detect path outages such as BGP/up/down events to allow for more resilient hybrid networks
        * current only supports BFD in single-hop mode
        * can be only enabled on provisioned VLAN attachements on [Dataplane v2](https://cloud.google.com/network-connectivity/docs/interconnect/concepts/terminology#dataplaneVersion)
* [Cloud Armor](https://cloud.google.com/armor/docs/cloud-armor-overview)
    * layer 7 web application firewall (WAF)
    * designed to mitigate distributed denial-of-service (DDoS) attacks and prevent other unwanted access to applications, such as cross-site scripting and SQL injection attacks
    * offers preconfigured rules for protection against OWASP Top 10 threats which is based on the [ModSecurity Core Rule Set (CRS)](https://github.com/coreruleset/coreruleset/releases/tag/v3.3.2)
        * each signature has a sensitivity level based on the CRS [paranoia level](https://coreruleset.org/20211028/working-with-paranoia-levels/) which is between 0 and 4, 0 means no rules are enabled
        * lower the sensity indicates higher confidence signatures which are less likely to generated a false positive
        * higher sensitivity level increases security, but also increases the risk of generating a false positive
        * example: `evaluatePreconfigureWaf('sql-v33-stable', {'sensitivity':1})`
        * use the `opt_out_rule_ids` to disable particulare signatures
            * example: `evaluatePreconfiguredWaf('xss-v33-stable', {'sensitivity': 4, 'opt_out_rule_ids': ['owasp-crs-v030301-id942350-sqli', 'owasp-crs-v030301-id942360-sqli']})`
        * use the `opt_in_rule_ids` to opt in rule signatures in otherwise disabled sensitivity levels, recommend that you opt in rule signatures when there are fewer signatures that you want to use in a given sensitivity level than there are rules that you want to opt out
            * example:  `evaluatePreconfiguredWaf('cve-canary', {'sensitivity': 0, 'opt_in_rule_ids': ['owasp-crs-v030001-id044228-cve', 'owasp-crs-v030001-id144228-cve']})`
    * configured using [security policies](https://cloud.google.com/armor/docs/security-policy-overview) which are designed to scrub incoming requests from common layer 7 attacks
        * some are available as preconfigured or custom policies
    * rules are defined using custom rules language which is a subset of the [Common Expression Language (CEL)](https://github.com/google/cel-spec)
        * and expression requires two components:
            * _Attributes_
                * inspected in rules expression
                * list of supported attributes : https://cloud.google.com/armor/docs/rules-language-reference#attributes
                * reCAPTCHA enterprise attributes: https://cloud.google.com/armor/docs/rules-language-reference#recaptcha-attributes
            * _Operations_
                * aciton to be performed on the attributes as part of the expression
                * supported operations: https://cloud.google.com/armor/docs/rules-language-reference#operations
        * example: `inIpRange(orgin.ip, '9.9.9.0/24')`
* Service-Centric Networking
    * [Private Service Connect for Google APIs](https://cloud.google.com/vpc/docs/configure-private-google-access)
        * allows users to connect to Google APIs and services through an endpoint within their VPC network without the need for an external IP address.
        * endpoint will forward traffic to the appropriate API or service. Clients can be GCP resources and on-premises systems. GCP resources may or may not have an external IP address.
        * two bundles of APIs
            * All APIs endpoints (all-apis)
                * provides access to the same APIs as `private.googleapis.com`
            * VPC-SC (vpc-sc)
                * provides access to the same APIs as `restricted.google.com`
    * [Private Service Connect for Google APIs with Consumer HTTP(s)](https://cloud.google.com/vpc/docs/private-google-access-hybrid)
        * used to connect Google APIs and services using internal HTTP(S) load balancers. Clients can be in GCP or on-premises.
    * Private Google Access
        * used to connect external IP addresses and Private Google Access domains to GCP APIs and services through the VPC’s default internet gateway. This private access option is used when GCP resources do not have external IP addresses.
        * enabled at the VPC subnet level
        * does not enable APIs
        * network will need to have routes for the destination IP range used by Google APIs and services. 
            * If you use the private.googleapis.com or restricted.googleapis.com domain name, you have to set up DNS records to direct traffic to the IP addresses of those domains.
    * Private Google Access for On-Premise Hosts
        * used to connect on-premises hosts to Google APIs and service through a VPC network. On-premises clients may have external IP addresses, but they are not required.
        * Cloud VPN and Cloud Interconnect can be used with Private Google Access for on-premises hosts. This allows on-premises hosts to use internal IP addresses to reach Google services.
    * [Private Service Connect for Published Services](https://cloud.google.com/vpc/docs/about-vpc-hosted-services)
        * used to connect to services in another VPC without using an external IP address. 
        * The service being accessed needs to be published using the Private Service Connect for Service Producers service.
            * two consumer types
                * [Private Service Connect endpoints](https://cloud.google.com/vpc/docs/about-accessing-vpc-hosted-services-endpoints)
                    * endpoint lets service consumers send traffic from the consumer's VPC network to services in the service producer's VPC network
                * [Private Service Connect backends](https://cloud.google.com/vpc/docs/private-service-connect-backends)
                    * backend that uses a global external Application Load Balancer lets service consumers with internet access send traffic to services in the service producer's VPC network
    * Private Service Access
        * used to connect from a serverless environment on GCP to resources within a VPC using IP addresses. This is implemented using a VPC Network Peering con- nection. The GCP VM instances connecting to services may have an external IP address, but they do not need one.
    * Serverless VPC Access
        * used to connect from a serverless environment in GCP to resources in a VPC using an internal address. This option supports Cloud Run, App Engine Standard, and Cloud Functions
* Cloud Load Balancing
    * practice of distributing work across a set of resources. GCP provides five different load balancers for different use cases. To determine which load balancer is an appropriate choice in a given scenario, you will have to consider three factors
    * Three categories
        * [Application Load Balancer (HTTP/HTTPS)](https://cloud.google.com/load-balancing/docs/application-load-balancer)
            * proxy-based layer 7 load balancer
            * distributes HTTP and HTTPS traffic to backends hosted on GKE, GCE, Cloud Run, Cloud Storage, as well as external backends connected over the internet or hybrid
            * Two Types:
                * [External](https://cloud.google.com/load-balancing/docs/https)
                    * Load balances traffic coming from clients on the internet
                    * use forwarding rules to direct traffic to a target HTTP proxy
                    * proxies then route the traffic to a URL map, which determines which target group to send the request to based on the URL
                    * the backend service then routes the requests to an instance within the target group based on capacity, health status, and zone
                    * For HTTPS the load balancer uses SSL certificates that must be installed on each of the backend instances. The backend resource for an HTTP(S) load balancer can also be a storage bucket.
                    * [Best Practices](https://cloud.google.com/load-balancing/docs/https/http-load-balancing-best-practices)
                    * Global
                        * Runs on Premium Networking Tier
                        * Load Balancing Scheme is `EXTERNAL_MANAGED`
                            * implemented as a managed service on [Google Front Ends (GFEs) ](https://cloud.google.com/docs/security/infrastructure/design#google-frontend-service) or [Envoy proxy](https://www.envoyproxy.io/)
                        * supports both IPv4 and IPv6 termination
                        * HTTP on 80 or 800 and HTTPS on 443
                    * Regional
                        * Runs on Standard Tier
                        * Load Balancing Scheme is `EXTERNAL_MANAGED`
                            * implemented as a managed service on [Google Front Ends (GFEs) ](https://cloud.google.com/docs/security/infrastructure/design#google-frontend-service) or [Envoy proxy](https://www.envoyproxy.io/)
                        * supports IPv4
                        * HTTP on 80 or 800 and HTTPS on 443
                        * requies Proxy-only Subnet
                            * provides a set of IP addresses that Google uses to run Envoy proxies on your behalf. You must create one proxy-only subnet in each region of a VPC network where you use load balancers. The `--purpose` flag for this proxy-only subnet is set to `REGIONAL_MANAGED_PROXY`.
                    * Classic
                        * Runs on Standard Tier or Premium
                        * Load Balancing Scheme is `EXTERNAL`
                            *  * implemented as a managed service on [Google Front Ends (GFEs) ](https://cloud.google.com/docs/security/infrastructure/design#google-frontend-service) or [Envoy proxy](https://www.envoyproxy.io/)
                        * supports IPv4 and (IPv6 Termination on Premium Tier Only)
                        * HTTP on 80 or 800 and HTTPS on 443
                * [Internal](https://cloud.google.com/load-balancing/docs/l7-internal)
                    * Load balance traffic with VPC or networks connected to VPC
                    * When to use   
                        * [Three Tier web service](https://cloud.google.com/load-balancing/docs/l7-internal#three-tier_web_services)
                        * Servicing HTTP/HTTPS requests from internal clients 
                        * Modernizing legacy services
                        * Cross-regional can improve your service availability by creating global backend services with backends in multiple regions. If backends in a particular region are down, traffic fails over to another region gracefully.
                    * Regional
                        * Runs on Premium Tier
                        * Load Balancing Scheme is `INTERNAL_MANAGED`
                            * implemented as a managed service based on [Envoy proxy](https://www.envoyproxy.io/)
                        * supports IPv4 and (IPv6 Termination on Premium Tier Only)
                        * HTTP on 80 or 800 and HTTPS on 443
                        * requies Proxy-only Subnet
                            * provides a set of IP addresses that Google uses to run Envoy proxies on your behalf. You must create one proxy-only subnet in each region of a VPC network where you use load balancers. The `--purpose` flag for this proxy-only subnet is set to `REGIONAL_MANAGED_PROXY`.
                    * Cross-Region Internal
                        * Runs on Premium Tier
                        * Load Balancing Scheme is `INTERNAL_MANAGED`
                            * implemented as a managed service based on [Envoy proxy](https://www.envoyproxy.io/)
                        * supports IPv4
                        * HTTP on 80 or 800 and HTTPS on 443
                        * requies Proxy-only Subnet
                            * provides a set of IP addresses that Google uses to run Envoy proxies on your behalf. In a given network and region, a single proxy-only subnet of purpose `GLOBAL_MANAGED_PROXY` is shared between all the cross-region internal Application Load Balancers in that region. At any point, only one subnet with purpose `GLOBAL_MANAGED_PROXY` can be active in each region of a VPC network.
        * [Proxy Network Load Balancer (TCP/SSL PROXY)](https://cloud.google.com/load-balancing/docs/proxy-network-load-balancer)
            * SSL Proxy 
                * terminates SSL/TLS traffic at the LB and distributes across the set of backend servers
                * After the SSL/TLS traffic has been decrypted, it can be transmitted to backend servers using either TCP or SSL. SSL is recommended
                * recommended for non-HTTPS
                * distribute traffic to the closest region that has capacity.
            * TCP Proxy
                * use a single IP address for all users regardless of where they are on the globe, and it will route traffic to the closest instance.
                * should be used for non-HTTPS and non-SSL traffic.
            * External (SSL Proxy)
                * Load Balances traffic from clients on the the internet
                * Global
                    * Global on Premium Tier or Regional on Standard Tier
                    * Load Balancing Scheme is `EXTERNAL`
                        * implemented as a managed service based on [Envoy proxy](https://www.envoyproxy.io/)
                        * supports both IPv4 and IPv6 termination
                        * exactly one port from 1 to 65535 
                * Regional
                    * Runs on Standard Tier
                    * Load Balancing Scheme is `EXTERNAL_MANAGED`
                        * implemented as a managed service on [Google Front Ends (GFEs) ](https://cloud.google.com/docs/security/infrastructure/design#google-frontend-service) 
                        * supports both IPv4
                        * exactly one port from 1 to 65535 
                        * requies Proxy-only Subnet
                            * provides a set of IP addresses that Google uses to run Envoy proxies on your behalf. You must create one proxy-only subnet in each region of a VPC network where you use load balancers. The `--purpose` flag for this proxy-only subnet is set to `REGIONAL_MANAGED_PROXY`.
            * Internal (TCP Proxy)
                * Load Balances traffic from within VPC or networks connected
                * Internal 
                    * Runs on Premium Tier
                    * Load Balancing Scheme is `INTERNAL_MANAGED`
                        * implemented as a managed service on [Google Front Ends (GFEs)](https://cloud.google.com/docs/security/infrastructure/design#google-frontend-service) 
                        * supports IPv4
                        * exactly one port from 1 to 65535 
        * [Passthrough Network Load Balancer (TCP/UDP)](https://cloud.google.com/load-balancing/docs/passthrough-network-load-balancer)
            * External
                * layer 4 load balancer
                * By default, to distribute traffic to instances, the [session affinity](https://cloud.google.com/load-balancing/docs/target-pools#sessionaffinity) value is set to NONE. Cloud Load Balancing picks an instance based on a hash of the source IP and port, destination IP and port, and protocol
                * based on [Maglev](https://research.google.com/pubs/pub44824.html) and [Andromeda](https://cloudplatform.googleblog.com/2014/04/enter-andromeda-zone-google-cloud-platforms-latest-networking-stack.html)
                * Use cases
                    * You need to load balance non-TCP traffic, or you need to load balance a TCP port that isn't supported by other load balancers.
                    * It is acceptable to have SSL traffic decrypted by your backends instead of by the load balancer. The external passthrough Network Load Balancer cannot perform this task. When the backends decrypt SSL traffic, there is a greater CPU burden on the VMs.
                    * Self-managing the backend VM's SSL certificates is acceptable to you. Google-managed SSL certificates are only available for external Application Load Balancers and external proxy Network Load Balancers.
                    * You need to forward the original packets unproxied. For example, if you need the client source IP to be preserved.
                    * You have an existing setup that uses a pass-through load balancer, and you want to migrate it without changes.
                    * You require advanced network DDoS protection for your external passthrough Network Load Balancer. For more information, see Configure advanced network DDoS protection using Google Cloud Armor.
                * Regional
                * runs on Premium Tier or standard
                * Load Balancing Scheme is `EXTERNAL`
                    * implemented as a managed service based on [Envoy proxy](https://www.envoyproxy.io/)
                * Traffic Type
                    * TCP, UDP, ICMP, ICMPv6, ESP, and GRE
                * A single port, range of ports, or all ports
                * Support IPv4 and IPv6
            * Internal
                * Regional
                * runs on Premium Tier
                * Load Balancing Scheme is `EXTERNAL`
                    * implemented as a managed service based on [Envoy proxy](https://www.envoyproxy.io/)
                * Traffic Type
                    * TCP, UDP, ICMP, ICMPv6, SCTP, ESP, AH, and GRE
                * A single port, range of ports, or all ports
                * Support IPv4 and IPv6
* [Traffic Director](https://cloud.google.com/traffic-director/docs/features)
    * is a managed, highly available control plane service that runs in Google Cloud which allows you to run microservices in a global service mesh.
* [Service Directory](https://cloud.google.com/service-directory/docs/overview)
    * managed service for centralizing information about your services. 
    * manages metadata about services by allowing you to publish, discover, and connect to services
    * essentially an endpoint registry.
    * supports workloads in Compute Engine, Kubernetes Engine, on-premises and third party clouds
    * Integrates with Cloud DNS via Service Directory zones which allow services to be made available on Virtual Private Cloud (VPC)
    * IAM Roles
        * `roles/servicedirectory.admin` to full management control of the Service Directory
        * `roles/servicedirectory.editor` to Edit the Service Directory resources
        * `roles/servicedirectory.networkAttacher` gives access to attach VPC networks to Service Directory endpoints
        * `roles/servicedirectory.pscAuthorizedService` Gives access to VPC Networks via Service Directory
        * `roles/servicedirectory.viewer` allows viewing Service Directory resources
    * [Configuring Service Directory](https://cloud.google.com/service-directory/docs/configuring-service-directory)
    * [Configure a DNS Zone for Service Directory](https://cloud.google.com/service-directory/docs/configuring-service-directory-zone)
* [Cloud CDN](https://cloud.google.com/cdn/docs/overview)
    * content delivery network managed by Google Cloud
    * provides the means to distribute content across the globe in ways to minimize latency when accessing that data.
    * works with external HTTP(S) Load Balancers which provides a public IP address while the CDN backend is responsible for providing content
    * content can come from several sources, including Compute Engine instance groups, zonal network endpoint groups, App Engine, Cloud Run, Cloud Functions, and Cloud Storage
    * FedRAMP certified
* [Media CDN](https://cloud.google.com/media-cdn/docs/overview)
    * compliments Cloud CDN but is optimized for high-throughput egress workloads, such as video streaming and large file downloads
    * Delivering video over Real-Time Message Protocol (RTMP)
        * configure a global external passthrough Network Load Balancer to deliver RTMP if you have any legacy RTMP-based services. 
        * or use Live Stream API to package RTMP source streams into HLS/DASH assets for delivery through Media CDN , see https://cloud.google.com/livestream/docs/overview
* [Cloud DNS](https://cloud.google.com/dns/docs/overview/)
    * managed global domain name service used to publish domain names
    * DNS is a hierarchical, distributed database that uses authoritative servers to hold DNS name records and uses nonauthoritative servers to cache DNS data for improved performance. 
    * DNS has several types of records, including :
        * A records, which are address records that map domain names to IP addresses. 
        * CNAME or canonical name records store aliases
        * MX is a mail exchange record
        * NS records are name server records that assign a DNS zone to an authoritative server
    * supports public and private zones
        * Public zones are visible to the internet
        * Private zones are visible only from specified VPCs
    * other zones
        * [Forwarding Zones](https://cloud.google.com/dns/docs/zones/zones-overview#forwarding_zones)
            * configured target name servers for specific private zones
            * a way to implement outbound DNS forwarding from your VPC network
            * special type of Cloud DNS private zone
            * Instead of creating records within the zone, you specify a set of forwarding targets
            * Each forwarding target is an IP address of a DNS server, located in your VPC network, or in an on-premises network connected to your VPC network by Cloud VPN or Cloud Interconnect
            * Supports three types of Targets
                * Type 1
                    * which is an internal ip of a VM or internal network lb in the same VPC
                    * source of requests 35.199.192.0/19
                * Type 2
                    * IP of an on-premises system connected to the VPC
                    * source of requests 35.199.192.0/19
                * Type 3
                    * External IP of a DNS name server accessible to the internet or external IP address of a GCP resource
                    * source of request [Google Public DNS source ranges](https://developers.google.com/speed/public-dns/faq#locations)
        * [Peering Zone](https://cloud.google.com/dns/docs/zones/peering-zones)
            * lets you send requests for records that come from one zone's namespace to another VPC network. For example, a SaaS provider can give a SaaS customer access to DNS records it manages
        * [Managed reverse lookup zones](https://cloud.google.com/dns/docs/zones/managed-reverse-lookup-zones)
            * private zone with a special attribute that instructs Cloud DNS to perform a PTR lookup against Compute Engine DNS data
            * Example zones include the following:
                * 10.in-addr.arpa.
                * 168.192.in-addr.arpa.
                * 16.172.in-addr.arpa., 17.172.in-addr.arpa., ... through 31.172.in-addr.arpa.
        * [Cross-project binding](https://cloud.google.com/dns/docs/zones/cross-project-binding)
            * keep the ownership of the DNS namespace of the service project independent of the ownership of the DNS namespace of the entire VPC network
            * useful with Shared VPC
                * ![Cross-project Shared VPC](https://cloud.google.com/static/dns/images/Diagram-2-with-cross-project-binding.svg)
        * [Zonal Cloud DNS zones](https://cloud.google.com/dns/docs/zones/zones-overview#zonal_zones)
            * private DNS zones that are scoped to a Google Cloud zone only. Zonal Cloud DNS zones are created for GKE when you choose a cluster scope.
    * Split horizone DNS
        * combination of public and private zones in a split horizon DNS configuration
        * Private zones enable you to define different responses to a query for the same record when the query originates from a VM within an authorized VPC network. Split horizon DNS is useful whenever you need to provide different records for the same DNS queries depending on the originating VPC network.
    * [Set up DNS Tutorial](https://cloud.google.com/dns/docs/tutorials/create-domain-tutorial)
    * [Set up DNS Records](https://cloud.google.com/dns/docs/set-up-dns-records-domain-name)
    * [Configuring cluster scope](https://cloud.google.com/dns/docs/zones/configure-scopes) 
    * [Configure a cluster-scoped zone](https://cloud.google.com/dns/docs/zones/configure-zonal-cluster-scopes) 

### Extending to on-premises environments (hybrid networking)
* [Hybrid Network Topologies](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies)
    * [Mirrored Topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#mirrored)
        * the cloud computing environment and private computing environment mirror each other
    * [Meshed Topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#meshed)
        * establishes a flat network that spans multiple computing environments in which all systems can communicate with one another. 
        * This topology applies primarily to tiered, partitioned, or bursting setups, and requires that you connect computing environments in a way that meets the following requirements:
            * Workloads can communicate with one another across environment boundaries over UDP or TCP by using private RFC 1918 IP addresses.
            * You can use firewall rules to restrict traffic flows in a fine-grained fashion, both between and within computing environments.
    * [Gated Egress Topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#gated-egress)
        * expose selected APIs from the private computing environment to workloads that are deployed in Google Cloud without exposing them to the public internet.
        * facilitated by using an API Gateway that serves a facade for existing workloads
    * [Gated Ingress Topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#gated-ingress)
        * expose selected APIs of workloads running in Google Cloud to the private computing environment without exposing them to the public internet.
        * well suited for [edge hybrid](https://cloud.google.com/architecture/hybrid-and-multi-cloud-architecture-patterns#edge-hybrid) scenarios
    * [Handover Topology](https://cloud.google.com/architecture/hybrid-and-multi-cloud-network-topologies#handover)
        * use Google Cloud-provided storage services to connect a private computing environment to projects in Google Cloud. 

### Extending to a multicloud environment that may include Google Cloud to Google Cloud communication
* [Mulit-cloud - Hybrid Design Patterns](https://cloud.google.com/architecture/hybrid-and-multi-cloud-architecture-patterns)
* 


### Security protection (e.g. intrusion protection, access control, firewalls)
**Access Control**
**Firewalls**
**Intrusion Detection**
[Cloud Intrusion Detection System (Cloud IDS)](https://cloud.google.com/intrusion-detection-system)


## 2.2 Configuring individual storage systems. 

### Storage Services
* [Cloud Storage](https://cloud.google.com/storage/docs/introduction)
    * Object storage system
    * designed for persisting unstructured data, such as data files, images, videos, backup files, and any other data
    * objects (files) stored in Cloud Storage are treated as atomic
    * when a file is access, the entire file is access
    * you cannot treat it as a file on a block storage device that allows for seeking and reading blocks in the file
    * no presume structure within that file
    * uses buckets to group objects
    * objects versioned and accessed as a single unit
    * a bucket is a group of objects that share access controls at the bucket and object level
        * a service account assigned to a vm may have permissions to write to the bucket, and another to read from the bucket
        * [Cloud Storage - Access Control List (ACL)](https://cloud.google.com/storage/docs/access-control/lists#acl-def)
        * [Predefined ACLs](https://cloud.google.com/storage/docs/access-control/lists#predefined-acl) or canned acls alias for a set of specific acl entries that you can quickly use to quickly apply ACL entries at once to a bucket or object
            * applying pre-defined acls completely replaces existing bucket or object ACls 
    * [Creating a bucket](https://cloud.google.com/storage/docs/creating-buckets#storage-create-bucket-cli)
    * Naming best practices
        * Do not use personally identifying information, such as names, email addresses, IP addresses, and so forth in bucket names. That kind of information could be useful to an attacker.
        * Follow DNS naming conventions because bucket names can appear in a CNAME record in DNS.
        * Use globally unique identifiers (GUIDs) if creating many buckets.
        * Do not use sequential names or timestamps if uploading files in parallel. Files with sequentially close names will likely be assigned to the same server. This can create a hotspot when writing files to Cloud Storage.
        * Bucket names can also be subdomain names, such as mybucket.example.com, you will have to verify that you own the domain
    * Does not provide a file system
    * Use Cloud Storage FUSE to use GCS like a filesystem
    * Provides high durability with 99.999999999% (eleven 9s) annaul durability
    * level of durability is achieved by keeping redundant copies of the object
    * Bucket Locations:
        * [region](https://cloud.google.com/storage/docs/locations#location-r)
            * stores mulitple copies of an object in multiple zones in one region
        * [dual-region](https://cloud.google.com/storage/docs/locations#location-dr)
            * stores replicas of objects in two regions
            * HA across regions
            * geo-redundant 
        * [multi-region](https://cloud.google.com/storage/docs/locations#location-mr)
            * stores replicas of objects in all regions in a region grouping (.ie ASIA, EU, US)
            * ha across regions
            * geo-redundant
            * This can also improve access time and latency by distributing copies of objects to locations that are closer to the users of those objects.
        * [Pricing](https://cloud.google.com/storage/pricing#storage-pricing)
        * Storage Class
            * [Standard](https://cloud.google.com/storage/docs/storage-classes#standard)
                * hot data, frequently accessed
                * SLA 99.95% , typicall monthly availability >99.99% in dual and multi-region
                * SLA 99.9%, typical monthly availability 99.99% in region
            * [Nearline](https://cloud.google.com/storage/docs/storage-classes#nearline)
                * data accessed less than once in 30 days
                * at-rest lower cost than standard, Nearline storage is a better choice than Standard storage in scenarios where slightly lower availability, a 30-day minimum storage duration, and costs for data access are acceptable trade-offs
                * SLA 99.9% , typical monthly availability 99.95% in muli and dual region
                * SLA 99.0%, typical monthly availability 99.9% in regions
            * [Coldline](https://cloud.google.com/storage/docs/storage-classes#coldline)
                * data access less than once in 90 days
                * at-rest lower cost than nearline and standard, higher cost for data access
                * 99.95% in muli and dual region
                * 99.9% in regions
            * [Archive](https://cloud.google.com/storage/docs/storage-classes#archive)
                * data access less than once per year
                * lowest at-rest cost than nearline, coldline, and standard, higher cost for data access
                * 99.95% in muli and dual region
                * 99.9% in regions
            * Additional Storage Classes
                * Multi-Regional Storage
                    * equivalent to Standard, except multi-regional storage can only used for objects
                * Regional Storage
                    * same as standard except Regional storage can only be used for objects
                * Durable Reduced Availability (DRA) Storage
                    * similar to standard except:
                        * has much higher operation pricing
                        * has lower performance, particularly in terms of availability (DRA has a 99% avaialability SLA)
                        * can move objects to Standard class using Storage Transfer Service
        * Features
            * [Autoclass](https://cloud.google.com/storage/docs/autoclass)
                * allows for automatic transitions of objects to appropriate storage classes base on each objects access patterns
                * useful feature to enable for the following general access patterns:
                    * Your data has a variety of access frequencies.
                    * The access patterns for your data are unknown or unpredictable.
                * not recommended if heavy reads from other google services or for Sensitive Data Protection scans from Cloud DLP
                * Enable: `gcloud storage buckets update gs://BUCKET_NAME --enable-autoclass | --no-enable-autoclass`
            * [Composite Objects](https://cloud.google.com/storage/docs/composite-objects)
                * create object from existing objects without transferring additional object data. 
                * Composite objects are useful for making appends to an existing object, as well as for recreating objects that you uploaded as multiple components in parallel.
                * must have the same storage class and stored in the same bucket
                * Compose an object : `gcloud storage objects compose gs://BUCKET_NAME/SOURCE_OBJECT_1 gs://BUCKET_NAME/SOURCE_OBJECT_2 gs://BUCKET_NAME/COMPOSITE_OBJECT_NAME`
            * Managing and controlling data lifecyles
                * [retention policy](https://cloud.google.com/storage/docs/bucket-lock)
                    * specify a retention period for objects in a bucket
                    * objects cannot be deleted or replaced until it reaches the specified age
                    * remove the retention policy to modify or delete objects
                * [object hold](https://cloud.google.com/storage/docs/object-holds)
                    * use to prevent anyone from deleting or replacing the object until the hold is removed
                * [object verioning](https://cloud.google.com/storage/docs/object-versioning)
                    * can be enabled on a bucket in order to retain older versions of objects. When the live version of an object is deleted or replaced, it becomes noncurrent if versioning is enabled on the bucket. If you accidentally delete a live object version, you can [restore the noncurrent version](https://cloud.google.com/storage/docs/using-versioned-objects#restore) of it back to the live version.
                    * increases storage costs
                * [object lifecycle management](https://cloud.google.com/storage/docs/lifecycle)
                    * allows for automated control of object deletion
                    * When you define a lifecycle configuration, Cloud Storage performs a specified action, such as deleting an object, only if the object meets your criteria.
                    * lifecyle rules specifies exactly one of the following actions
                        * `Delete`
                            * deletes an object that meets all conditions specified in the rule
                        * `SetStorageClass` 
                            * changes storage class of and object and updates the modification time when object meets all criteria
                            * follow supported transitions:
                                * DRA can be moved to:
                                    * Nearline, Coldline, Archive, Multi-Regional or Regional Storage
                                * Standard, Muli-Regional, or Regional can be moved to:
                                    * Nearline, Coldline, Archive
                                * Nearline can be moved to:
                                    * Coldline
                                * Coldline can be moved to :
                                    * Archive
                        * `AbortIncompleteMulitpartUpload`
                            * aborts an incomplete mulitpart upload and deletes the associated parts 
                    * use the `--lifecylce-file=FILE` flag to pass the lifecycle configuration file when using the `gcloud storage buckets update gs://BUCKET_NAME` command
                    * [Configuration examples](https://cloud.google.com/storage/docs/lifecycle-configurations)
        * [Create a bucket](https://cloud.google.com/storage/docs/creating-buckets)
* [Cloud Storage FUSE](https://cloud.google.com/storage/docs/gcs-fuse)
    * FUSE which stands for _Filesytem in Userpace_, is a framework for exposing a filesystem to the Linux kernel
    * stand-alone application that runs on Linux and provides a filesystem API along with an adapter for implementing filesystem functions in the underlying storage system
    * [open source adatper](http://fuse.sourceforge.net/) to allow users to mount Cloud Storage buckets as filesystems on Linux and macOS 
    * not like NFS and does not implmement a filesystem or a hierachial directory structure
    * does interpret / characters in filenames as directory delimeters
    * gsutil can be used with Cloud Storage FUSE
    * [Intall GCS Fuse](https://cloud.google.com/storage/docs/gcsfuse-install)
    * Use the following command to mount a bucket: `gcsfuse  my-bucket /path/to/mount/point`
    * can use commands like `ls` 
    * useful when you want to move files easily back and forth between cloud storage and a compute engine vm, local server, or local machine instead of using gsutil commands
    * Cloud Storage FUSE is a Google-developed and community-supported open source project under the Apache license and is avaialable at https://github.com/GoogleCloudPlatform/gcsfuse
* [Cloud Filestore](https://cloud.google.com/filestore/docs/overview)
    * network-attached storage service that provides a filesystem that is accessible from Compute Engine and Kubernetes Engine
    * designed to provide low latency and IOPS, so it can be used for databases and other performance sensitive services
    * supports multiple concurrent application instances accessing the same file system simultaneously.
    * Storage Types are HDD or SSD
    * [Create an instance](https://cloud.google.com/filestore/docs/creating-instances#gcloud)
    * [Services Tiers](https://cloud.google.com/filestore/docs/service-tiers)
        * [Basic](https://cloud.google.com/filestore/docs/service-tiers#basic_hdd_and_basic_ssd_tiers)
            * supports HDD or SSD
            * suitable for file sharing, software development, and use with GCE/GKE workloads
            * HDD instances have a performance increase when the provisioned capacity exceeds 10 TiB
            * SSD instances is fixed performance regardless of provisioned capactiy
            * zonal resource
        * [Zonal (Preview)](https://cloud.google.com/filestore/docs/service-tiers#zonal_with_capacity_bands)
            * Replaces High Scale tier
            * designed to meet the demands of high-performance computing workloads, such as genome analysis and financial services applications requiring low-latency file operations. 
            * a zonal resource.
        * [Enterprise](https://cloud.google.com/filestore/docs/service-tiers#enterprise_tier)
            * is for mission-critical applications and Google Kubernetes Engine workloads. 
            * provides 99.99 percent regional availability by provisioning multiple NFS shares across multiple zones within a region
    * provides for snapshots of the filesystem, which can be taken periodically. If you need to recover a filesystem from a snapshot, it would be available within 10 minutes.
    * can be used with Serverless VPC access to allow mounts in Cloud Run:
        * https://cloud.google.com/run/docs/tutorials/network-filesystems-filestore
    * Filestore Networking
        * connects to VPC networks using either VPC Network Peering or private services access
        * VPC Peering is used when creating a filesystem instance with a standalone VPC network, within the host project of a shared vpc or when accessing the filesystem from on-premises network via Cloud VPN or Cloud Interconnect
        * Private service access is used when creating an instance on a Shared VPC netowrk from a service project, not the host project, 
        * does not support transitive peering
    * Access Controls
        * access to Cloud Filestore and to files on the filesystem are managed with a combination of :
            * [IAM roles](https://cloud.google.com/filestore/docs/iam)
                * `roles/file.editor`
                    * includes viewer permissions and provides create and delete instances, backups, and snapshotes
                    * no file access
                * `roles/file.viewer` 
                    * allows users to see details about an instance, its location, backups, and snapshots as well as operational status of the instance
                    * no file access
            * POSIX file permissions 
                * unix-like read(r), write(w), and execute(x)
                * default permissions at instance creation is rwxr-xr-x
                * change permissions using `chmod` command

### Database Storage Services
* Concepts
    * Relational Databases
        * highly structured data stores
        * designed to store data in ways that mimnize risk of data anomolies and support comprehensive query language
        * supports ACID transactions, some NoSQL databases support ACID but not all
    * ACID
        * Atomicity
            * _Automic operations_ ensure that all steps in a transaction complete or no steps take effect
        * Consistency
            * guarantees that when a transaction executes, the database is left in a state that complies with contraints such as uniqueness reqirements and referential integrity, which ensures foreign keys reference a valid primary key
            * also refers to querying data from different servers in a cluster and recieving the same data 
        * Isolation
            * refers to ensuring that the effects of transactions that run at the same time leave the database in the same state as if they ran one after another
        * Durability
            * ensures that once a transaction is executed the state of the database will always reflect or account for that change
            * usually requires databases to write to persistent storage
* [Cloud SQL](https://cloud.google.com/sql/docs/introduction)
    * managed service that provides [MySQL](https://cloud.google.com/sql/docs/mysql/features), [SQL Server](https://cloud.google.com/sql/docs/sqlserver/features), and [PostgreSQL](https://cloud.google.com/sql/docs/postgres/features) databases
    * GCP manages patching database software, backups, and failovers
    * requires well-defined schemas
    * by default an instance is created in a single zone
    * provides support for high availability by optionally maintaining a failover replica of the primary instance.
    * changes to the primary are mirrored on the failover replica
    * if a failure is detected on the primary, Cloud SQL will promote the failover replica to the primary instance
    * key features
        * all data is encrypted at rest
        * data is replicated across multiple zones for ha
        * managed failover to replicas
        * supports standard database connectors and tools
        * provides integrated monitoring and logging
    * appropriate choice for regional databases up to 30 TB
    * supports read replicas
        * which is a copy of the primary instance data stored in the same region or different region from the primary instance
        * when a different region is used, this is known as _cross-region replica_, which support disaster reocvery and migration between regions
    * [Editions](https://cloud.google.com/sql/docs/editions-intro)
        * Enterprise
            * provides all core capabilities of Cloud SQL
            * suitable for applications requiring a balance of performance, availability, and cost
            * supports the following db verions
                * MySQL 5.6, 5.7, 8.0
                * PostgreSQL 9.6, 10, 11, 12, 13, 14, 15
            * 99.95% SLA
            * maintenance downtime is less than 60 seconds
        * Enterprise Plus
            * provides the best performance and availability to run applications requiring the highest level 
            of availability and performance in addition to the capabilities of the Cloud SQL Enterprise edition.
            * supports the following db versions
                * MySQL 8.0
                * PostgreSQL 14, 15
            * 99.99% SLA
            * maintenance down time is less than 10 seconds
    * [Creating a MySQL intance](https://cloud.google.com/sql/docs/mysql/create-instance)
    * [Creating a PostgreSQL instance](https://cloud.google.com/sql/docs/postgres/create-instance)
    * [Creating a SQL Server instance](https://cloud.google.com/sql/docs/sqlserver/create-instance)
    * limiting factor is that databases scale only vertically, that is, by moving the database to a larger machine
* [Cloud Spanner](https://cloud.google.com/spanner)
    * managed database service that supports horizontal scalability across regions
    * supports relational features such as schemas for structured data and SQL for querying
    * supports both Google Standards SQL (ANSI 2011 with extensions) and Postgres dialects
    * supports strong consistency
    * manages replication
    * used for applications that require strong consistency on a global scale
        * Financial trading systems require a globally consistent view of markets to ensure that traders have a consistent view of the market when making trades.
        * Logistics applications managing a global fleet of vehicles need accurate data on the state of vehicles.
        * Global inventory tracking requires global-scale transaction to preserve the integrity of inventory data.
        * Gloabl availability for gaming platform: https://cloud.google.com/spanner/docs/best-practices-gaming-database
    * provides 99.999% availability with a guarantee of less than 5 mins of downtime per year
    * patching, backing up and failovers management is performed by GCP
    * data is encrypted at rest and in transit
    * integrated with Cloud Identity to support the use of user accounts across applications and with [Cloud IAM](https://cloud.google.com/spanner/docs/iam) to control authorizations to perform operations on resources
    * recommended to use primary keys that do not lead to hotspotting, which is skews the database workloads distribution so that small number of nodes are doing a disproportionate amount of work
    * incremented values, time stamps and other values monotonically increase in the first part of the key should NOT be used as a primary key since it will lead to writes being directed to a single server instead of more evenly spread
        * choosing a primary key: https://cloud.google.com/spanner/docs/schema-and-data-model#choosing_a_primary_key
        * schema design best practices: https://cloud.google.com/spanner/docs/schema-design
    * upports secondary indexes in addition to primary key indexes
    * stores data encrypted at rest and by default uses Google-managed encryption. If you need to manage your encryption, you have the option to use Cloud Key Management Service (KMS) with a symmetric key, a Cloud HSM key, or a Cloud External Key Manager key
    * [Creating an instance](https://cloud.google.com/spanner/docs/create-manage-instances#gcloud)
        * Compute capacity defines amount of server and storage resources that are available to the databases in an instance. When you create an instance, you specify its compute capacity as a number of processing units or as a number of nodes, with 1000 processing units being equal to 1 node.
* [AlloyDB](https://cloud.google.com/alloydb/docs/overview)
    * fully managed, PostgreSQL-compatible database service
    * designed for your most demanding workloads, including hybrid transactional and analytical processing 
    * pairs a Google-built database engine with a cloud-based, multi-node architecture to deliver enterprise-grade performance, reliability, and availability
    * Architecture
        * ![AllyDB Arch](https://cloud.google.com/static/alloydb/images/cluster-diagram.svg)
    * [Creat an AlloyDB Instance](https://cloud.google.com/alloydb/docs/quickstart/create-and-connect)
* [Database Migration Service](https://cloud.google.com/database-migration/docs/overview) 
    * managed service for migrating MySQL and PostgreSQL databases to Cloud SQL and AlloyDb
    * Support Databases
        * MySQL
            * Source
                * Amazon RDS (5.6,5.7,8.0)
                * Self-managed (5.5,5.6,5.7,8.0)
                * Cloud SQL (5.6,5.7,8.0)
                * Amazone Aurora (5.6,5.7,8.0)
            * Destination
                * Cloud SQL for MySQL (5.6,5.7,8.0)
        * PostgreSQL
            * Source
                * Amazon RDS 9.6.10+, 10.5+, 11.1+, 12, 13, 14
                * Amazon Aurora 10.11+, 11.6+, 12.4+, 13.3+, 14.6+, 15.2
                * Self-managed PostgreSQL (on premises or on any cloud VM that you fully control) 
                    * 9.4, 9.5, 9.6, 10, 11, 12, 13, 14, 15
                * Cloud SQL for PostgreSQL 9.6, 10, 11, 12, 13, 14, 15
            * Destination 
                * Cloud SQL for PostgreSQL 9.6, 10, 11, 12, 13, 14, 15
        * Oracle to PostgreSQL
            * Source
                * Oracle 11g, Version 11.2.0.4
                * Oracle 12c, Version 12.1.0.2
                * Oracle 12c, Version 12.2.0.1
                * Oracle 18c
                * Oracle 19c
                * Oracle 21c
            * Destination
                * Cloud SQL for PostgreSQL 12, 13, 14
        * PostgreSQL to AlloyDB
            * Source
                * Amazon RDS 9.6.10+, 10.5+, 11.1+, 12, 13, 14
                * Amazon Aurora 10.11+, 11.6+, 12.4+, 13.3+, 14
                * Self-managed PostgreSQL (on premises or on any cloud VM that you fully control) 
                    * 9.4, 9.5, 9.6, 10, 11, 12, 13, 14
                * Cloud SQL 9.6, 10, 11, 12, 13, 14
    * Quickstarts
        * [MySQL](https://cloud.google.com/database-migration/docs/mysql/quickstart)
        * [PostgreSQL](https://cloud.google.com/database-migration/docs/postgres/quickstart)
        * [Oracle to PostgreSQL](https://cloud.google.com/database-migration/docs/oracle-to-postgresql/quickstart)
        * [PostgreSQL to AlloyDB](https://cloud.google.com/database-migration/docs/postgresql-to-alloydb/quickstart)
* [BigQuery]()
    * managed data warehouse and analystics database
    * designed to support queries that scan and return large volumes of data and performs aggregations on the data
    * uses SQL as a query language
    * serverless from the client perspective
    * [BigQuery's Architecture](https://cloud.google.com/blog/products/data-analytics/new-blog-series-bigquery-explained-overview)
        * ![BQ Arch](https://storage.googleapis.com/gweb-cloudblog-publish/images/BQ_Explained_3.max-500x500.jpg)
        * built on several Google technologies, as per [BigQuery Under the Hood](https://cloud.google.com/blog/products/bigquery/bigquery-under-the-hood)
            * [Dremel](https://research.google/pubs/pub36632/)
                * query execution engine that maps SQL statements into execution trees
                * The leaves of the tree are known as slots, which read data from storage and do some computation. Branches of the tree do aggregation
            * [Colossus](https://cloud.google.com/files/storage_architecture_and_challenges.pdf)
                * Google's distributed filesystem
                * provies peristent storage, including replication and encryption at rest
                * BigQuery leverages the ColumnIO columnar storage format and compression algorithm to store data in Colossus in the most optimal way for reading large amounts of structured data
                * Colossus allows BigQuery users to scale to dozens of Petabytes in storage seamlessly, without paying the penalty of attaching much more expensive compute resources — typical with most traditional databases.
            * [Borg](https://research.google/pubs/pub43438/)
                * cluster management system that routes jobs to nodes of the cluster and works around any node failures
                * Borg assigns server resources to jobs; the job in this case is the Dremel cluster.
            * [Jupiter](http://googlecloudplatform.blogspot.com/2015/06/A-Look-Inside-Googles-Data-Center-Networks.html)
                * Google's 1 petabit/second networking infrastructure provides quick and efficent distribution of large workloads.
                * fast enough to eliminate concerns such as rack-aware placement of data to reduce the need to copy data between racks
                * provides enough bandwidth to allow 100,000 machines to communicate with any other machine at 10 Gbs
                * full-duplex bandwidth means that locality within the cluster is not important. If every machine can talk to every other machine at 10 Gbps, racks don’t matter.
        * BigQuery Data Storage
            * columnar format, known as Capacitor, which means that values from a single column in a database are stored together rather than storing data from the same row together
            * because analytics and business intelligence queries often filter and group by values in a small number of columns and do not need to reference all columns in a row. Capacitor is designed to support nested and repeated fields as well.
    * bill based on the amount of data stored and the amount of data scanned when responding to queries 
        * offers flat-rate query billing
            * the allocation is used based on the size of the query. 
            * For this reason, it is best to craft queries that return only the data that is needed, and filter criteria should be as specific as possible.
    * [bq command utility](https://cloud.google.com/bigquery/docs/bq-command-line-tool)
        * `bq head`
            * viewing the structure of a table or view or you want to see sample data
        * `-dry-run` 
            * optional flag for queries to run an estimate of the number of bytes that would be returned if the the query were executed
    * IAM Roles
        * `roles/bigquery.dataViewer`: 
            * This role allows a user to list projects and tables and get table data and metadata.
        * `roles/bigquery.dataEditor`: 
            * This has the same permissions as dataViewer, plus permissions to create and modify tables and datasets
        * `roles/bigquery.dataOwner`: 
            * This role is similar to dataEditor, but it can also create, modify, and delete datasets.
        * `roles/bigquery.metadataViewer`: 
            * This role gives permissions to list tables, projects, and datasets.
        * `roles/bigquery.user`: 
            * The user role gives permissions to list projects and tables, view metadata, create datasets, and create jobs.
        * `roles/bigquery.jobUser`: 
            * A jobUser can list projects and create jobs and queries.
        * Additional Roles exist for controlling access for:
            * [BigQuery ML](https://cloud.google.com/bigquery/docs/bqml-introduction) 
                * https://cloud.google.com/bigquery/docs/access-control#bqml-permissions
            * BigQuery Transfer Service
            * BigQuer BI Engine
    * Concepts
        * [Jobs](https://cloud.google.com/bigquery/docs/jobs-overview)
            * used by BiqQuery for executing tasks such as loading and exporting data, running queries, and copying data
            * offers two options
                * Batch (Load)
                    * supports files in Avro, CSV, ORC, Parquet format, and Firestore exports stored in Cloud Storage
                    * Load ETL flows (Dataflow, Data Fusion, Composer)
                    * Console
                    * bq api
                    * [BigQuery Data Transfer Service](https://cloud.google.com/bigquery/docs/dts-introduction)
                        * specialized service for loading data from other cloud services, such as Google Ads, Google Ad Managers
                        * supports transferring data from Google SaaS applications or 3rd party apps
                    * [BQ Storage Write API](https://cloud.google.com/bigquery/docs/write-api)
                        * used to batch process and commit many records in one atomic operation
                        * https://cloud.google.com/bigquery/docs/write-api-batch
                * Streaming
                    * Storage Write API
                        * provides high throughput ingrest and exactly-once delivery semantics
                        * https://cloud.google.com/bigquery/docs/write-api-streaming
                    * Using [Datastream and Cloud Dataflow](https://cloud.google.com/datastream/docs/implementing-datastream-dataflow-analytics)
                        * [Datastream](https://cloud.google.com/datastream/docs/overview)
                            * serverless and easy-to-use change data capture (CDC) and repliaction service that lets you synchronize data reliably, and with minimal latency
            * [IAM Roles](https://cloud.google.com/bigquery/docs/control-access-to-resources-iam)
                * Each of the following predefined IAM roles includes the permissions that you need in order to run a job:
                    * roles/bigquery.dataEditor
                    * roles/bigquery.dataOwner
                    * roles/bigquery.user (includes bigquery.jobs.create)
                    * roles/bigquery.jobUser (includes bigquery.jobs.create)
                    * roles/bigquery.admin (includes bigquery.jobs.create)
                * Additionally, when you create a job, you are automatically granted the following permissions for that job:
                    * bigquery.jobs.get
                    * bigquery.jobs.update
        * [Dataset](https://cloud.google.com/bigquery/docs/datasets-intro)
            * used for organizing tables and views
            * dataset is contained in a project
            * may have regional or multiregional location
                * Regional datasets are stored in a single region such as us-west2 or europe-north1
                * Multiregional locations store data in multiple regions within either the United States or Europe
* NoSQL Databases
    * [Cloud Bigtable](https://cloud.google.com/bigtable/docs/overview)
        * wide-column, sparsely populated multidimensional database designed to support petabyte-scale databases for analytic operations, such as storing data for machine learning model building as well as IoT streaming data
        * used for time series data, marketing data, financial data, and [graph data](https://cloud.google.com/bigtable/docs/running-janusgraph-with-bigtable)
        * key features
            * Sub 10 ms latency
            * Stores petabyte-scale data
            * Uses regional replication
            * Queried using a Cloud Bigtable-specific command, [cbt](https://cloud.google.com/bigtable/docs/create-instance-write-data-cbt-cli)
            * Supports use of Hadoop HBase interface
            * Runs on a cluster of servers that store metadata while data is stored in the Colossus filesystem
                * [Bigtable Architecture](https://cloud.google.com/bigtable/docs/overview#architecture)
                * [Whitepaper on Bigtable](https://static.googleusercontent.com/media/research.google.com/en//archive/bigtable-osdi06.pdf)
        * [Storage model](https://cloud.google.com/bigtable/docs/overview#storage-model)
            * stores data in tables organized by key-value
            * each row contains data about a single entry and is indexed by a row key
            * multiple cells with different time stamps can exist at the intersection of a row and column
            * columns are grouped into column families, which are sets of related columns
            * a table may contain mulitple column families
            * Tables are partitioned into blocks of contiguous rows known as _tablets_, which are stored in the Colussus scalable filesystem
            * Data is not stored on nodes in the cluster, instead nodes store pointers to tablets stored in Colussus
            * distributed read/writes load across nodes yield better performance than having hotspots where a small number of nodes are responding to most read/write operations
        * Support HBase API, making it a good option for migrating from Hadoop HBase to a managed service
        * also a logical choice for replacing Cassandra databases to a managed database service
        * Supports creating more than one cluster in a BigTable instance and data is automatically replicated between clusters, useful when performing large number of read/write operations at the same time
        * with multiple clusters one can be dedicated to responding to read requests while the other recieves write requests, see [Bigtable replication](https://cloud.google.com/bigtable/docs/replication-overview)
        * Guarantees eventual consistency between replicas 
        * provides Change Data Capture (CDC) through _change streams_, which captures data changes to a Bigtable table as the changes happen, letting you stream them for processing or analysis.
            * to use this feature use the `--change-stream-retention-period=LENGTH_OF_TIME` on the `gcloud bigtable instances tables update` command
            * examples: 
                * [Read a change stream with Java](https://cloud.google.com/bigtable/docs/change-streams-read-java)
                * [Stream changes with a Dataflow Beam connector](https://cloud.google.com/bigtable/docs/change-streams-quickstart)
                * [Processing a change stream](https://cloud.google.com/bigtable/docs/change-streams-tutorial)
        * supports connection pools which is a cache of database connections that are shared and reused to improve connection latency and performance: https://cloud.google.com/bigtable/docs/connection-pools
    * [Cloud Datastore](https://cloud.google.com/datastore/docs/concepts/overview)
        * managed document database that uses a JSON-like data strucuture call a document
        * transactions are eventually consistent
        * transactions are limited up to 25 entity groups
        * Data structure
            * _Kind_ 
                * is similar to a Table in a relational database
            * _Entity_
                * is a row or an object
            * _Key_
                * equivalent to primary key in RDBs
            * _Property_
                * is a field or column
    * [Cloud Firestore](https://cloud.google.com/datastore/docs/concepts)
        * next generation document database, replacing Datastore
        * mix of Datastore and the [Firebase Realtime Database](https://firebase.google.com/docs/database/rtdb-vs-firestore)
        * Features:
            * is strongly consisten
            * Supports document and collection data models
            * Supports real-time updates
            * Provides mobile and web client libraries
        * [Two modes](https://cloud.google.com/datastore/docs/firestore-or-datastore):
            * Datastore Mode:
                * backward compatible with Cloud Datastore
                * provides strongly consistency of transactions (unlike traditional Datastore)
                * datastore query and writing limitations are removed
                * supports up to two million of writes per sec
            * Native (Firestore) Mode:
                * best for web and mobile applications
                * support for millions of concurrent connections
                
 * Caching
    * [Cloud Memorystore](https://cloud.google.com/memorystore/docs)
        * Managed cache service
        * Memorystore caches are used for storing data in nonpersistent memory, particularly when low-latency access is important. 
        * Stream processing and database caching are both common use cases for Memorystore.
        * Supported types:
            * [Redis](https://cloud.google.com/memorystore/docs/redis)
                * [Redis](https://redis.io/) is an open source, in-memory data store, which is designed to submillisecond data access that has a variety of data types including strings, lists, sets, sorted sets, bitmaps, and hyperloglogs
                * supports upto 300 Gb instances and 12 Gbps network throughput
                * replicated across two zones provide 99.9% availability
                * Two Service Tiers:
                    * Basic
                        * provides simple Redis cache on a single server without replication
                    * Standard
                        * HA instsance with cross-zone replication and support for automatic failover
            * [Memcached](https://cloud.google.com/memorystore/docs/memcached)
                *  [Memcached](https://memcached.org/) is an open source project and is used for caching a wide range of use cases including database query caching, reference data caching, and storing session state
                * does not have the range of data types as Redis, instead its stores string values indexed by key strings
                * deployed on clusters called _instances_ which is made up of nodes with the same amount of memory and virtual cpus
                * data is distributed across nodes in the cluster
                * instances can have between 1 and 20 nodes which can have 1 to 32 vCPUs and between 1 and 256 GB of memory
                * instance can have a max combined memory of 5 TB
                * requires Serverless VPC access to use with App Engine, Cloud Functions and CLoud Run  




Considerations include:

    ●  Data storage allocation

    ●  Data processing/compute provisioning

    ●  Security and access management


### Network configuration for data transfer and latency
* Network latency is a consideration when designing storage systems, particularly when data is transmitted between regions within GCP or outside GCP to globally distributed devices. 
* Three ways of addressing network latency concerns are as follows:
    * Replicating data in multiple regions and across continents 
    * Distributing data using Cloud CDN
    * Using Google Cloud Premium Network tier
* The reason to consider using these options is that the network latency without them would be too high to meet application or service requirements. For some points of reference, note the following:
    * Within Europe or Japan, expect 12–15 ms latency. 
    * Within North America, 30–32 ms latency is typical. 
    * Trans-Atlantic latency is about 70 ms. 
    * Trans-Pacific latency is about 100 ms.
    * Latency between the Europe, Middle East, and Africa (EMEA) region and Asia Pacific is closer to 120 ms.
* Data can be replicated in multiple regions under the control of a GCP service or under the control of a customer-managed service.
* Another way to reduce latency is to use GCP’s [Cloud CDN](https://cloud.google.com/cdn/docs/overview). 
    * This is particularly effective and efficient when distributing relatively static content globally. Cloud CDN maintains a set of globally distributed points of presence around the world. Points of presence are where the Google Cloud connects to the internet. Static content that is frequently accessed in an area can be cached at these edge nodes

    ●  Data retention and data life cycle management

    ●  Data growth planning

## 2.3 Configuring compute systems. 

### Compute resource provisioning
* Compute Engine
    * Google's Infrastructure-as-a-Service (IaaS)
    * Builing block for other services that run on top of this compute resource 
    * VMs are know as instances
    * Instances are provisioned by 
        * specifying machine types, which are differentiate by number of CPUs and the amount of memory allocated to the instance.
            * Machines are grouped into [machine families](https://cloud.google.com/compute/docs/machine-resource), includes general-purpose, compute-optimized, memory-optimized, and GPU.
        * specify a [boot image](https://cloud.google.com/compute/docs/images), choose from a set of predefined boot images, or create a your own.
            * When specifying a boot image your can also specify the disk type:
                * standard persistent disk, balanced persistent disk, SSD peristent disk, or extreme persistent disk
                * disk type should be base on workloads:
                    * Standard persistent disks are efficient and reliable block storage used for large data processing workloads that use sequential I/Os.
                    * Balanced disks are cost-effective and reliable block storage. SSD persistent disks are fast and reliable and balance cost and performance. These devices have the same maximum IOPS as SSD persistent disks but lower IOPS per GB. These are often used with general- purpose applications loads.
                    * SSD persistent disks provide low latency and high IOPS typically used in applications that require single-digit millisecond latencies, such as databases.
                    * Extreme persistent disks provide high performance for workloads that have both sequential and random access patterns. IOPS are user configurable. These devices are used for high-performance applications such as SAP HANA.
        * VMs also has a service account associated with it.
            * You use the default compute-engine service account or create a custom one for more fine grain access
        * [Create a GCE Instance using glcoud CLI](https://cloud.google.com/compute/docs/instances/create-start-instance#gcloud)
    * Sole-Tenant VMs
        * https://cloud.google.com/compute/docs/nodes/sole-tenant-nodes
        * use if you need your VMs to run only on phyiscal servers with other VMs from the same project, you can select sole tenancy when provisioning instances
        * The following types of workloads might benefit from using sole-tenant nodes:
            * Gaming workloads with performance requirements.
            * Finance or healthcare workloads with security and compliance requirements.
            * Windows workloads with licensing requirements.
            * Machine learning, data processing, or image rendering workloads. For these workloads, consider reserving GPUs.
            * Workloads requiring increased input/output operations per second (IOPS) and decreased latency, or workloads that use temporary storage in the form of caches, processing space, or low-value data. For these workloads, consider reserving local SSDs.
        * [Provisioning Sole Tenant VMs](https://cloud.google.com/compute/docs/nodes/provisioning-sole-tenant-vms)
    * [Shielded VMs](https://cloud.google.com/compute/shielded-vm/docs/shielded-vm)
        * instances with enhanced security controls, including the following
            * Secure boot
                * runs only software that is verified by digital signatures of all boot components using UEFI firmware features
                * the boot process fails if some software cannot be authenticated
                * software is authenticated by verifying the digital signatures of boot components are in a secure store of approved keys
            * Virtual Trusted Platform Module (vTPM)
                * is a virtual module for storing keys and other secrets
                * enables _Measured Boot_, which takes measurements to create a known good boot baseline, which is known as the integrity policy baseline.
                * The baseline is used for comparisons with subsequent boots to detect any differences
            * Integrity Monitoring
                * compares the boot measurements with a trusted baseline and returns true if the results match and false otherwise
                * logs are created for several types of events such as :
                    * clearing the secrets store
                    * early boot sequence integrity checks
                    * late boo sequence integrity checks
                    * updates to the baseline policy
                    * enabling/disabling Shielded VM options
                        * https://cloud.google.com/compute/shielded-vm/docs/quickstart
    * [Confidential VMs](https://cloud.google.com/confidential-computing/confidential-vm/docs/about-cvm)
        * Encrypts data in use
        * Runs on hosts based on AMD EPYC processors which provide [Secure Encrypted Virtualization](https://developer.amd.com/sev/) that encrypts all memory:
            * Isolation
                * encryption keys are generated by the AM Secure Processor during VM creation and resides solely within the AMD System-On-Chip(SOC)
                * keys are not even accessed by Google, offering improved isolation
            * Attestation
                * uses vTPM attestation
                * Every time an AMD SEV-based Confidential VM boots, a [lauch attestation report event](https://cloud.google.com/confidential-computing/confidential-vm/docs/monitoring#about_launch_attestation_report_events) is generated
                    * Contains the following info:
                        * `integrityEvaluationPassed`:
                            * result of an integrity check performed by the VM monitoring on the measurement computed by AMD SEV
                        * `sevPolicy`
                            * AMD SEV policy bits set for this VM
                            * policy bits are set at Confidential VM launch to enforce constraints such as whether debug mode is enableed
            * High Performance
                * AMD SEV offers high performance for demanding computational tasks
                * Enabling Confidential VM has little or no impact on most workloads, with only a 0-6% degradation in performance
        * Each has their own encryption key
        * Does not support Live Migration
        * Currently only supports the following CPU Platforms:
            * AMD EPYC Rome
                * default
            * AMD EPYC MILAN
            * `gcloud compute images list--filter="guestOsFeatures[].type:(SEV_CAPABLE)" --filter=FILTER`
        * Currently only the following Machine Types are supported:
            * [N2D](https://cloud.google.com/compute/docs/general-purpose-machines#n2d_machines)
                * Support both AMD EPYC Rome and Milan
                * use the `min-cpu-platorm="AMD Milan"` to use the Milan variant
            * [C2D](https://cloud.google.com/compute/docs/compute-optimized-machines#c2d_machine_types)
                * best for High Performance Compute
                * only supports AMD EPYC Milan platform
        * use the flags `--confidential-compute` and `--maintenance-policy=TERMINATE` on the `gcloud compute instances create` command to enable Confidential VMs
        * [Create a Confidential VM Instance](https://cloud.google.com/confidential-computing/confidential-vm/docs/creating-cvm-instance)
        * [Verifying The Identity Token](https://cloud.google.com/compute/docs/instances/verifying-instance-identity#verifying)

    * [Instance Groups](https://cloud.google.com/compute/docs/instance-groups)
        * clusters of VMs that are managed as a single unit
        * two kinds
            * Managed Instance Groups (MIGs)
                * contain identically configured instances
                * configuration is specified in an instance template
            * Unmanaged Instance Groups
                * groups of VMs that may not be identicial
                * not provisioned using an instance template
                * used to only support preexisting cluster configurations for load balancing tasks
                * not recommended for new configurations
        * intance templates
            * defines a machine type, disk image or container image, network settings, and other properties of a VM
            * can be used to create a single instance or a managed group of instances
            * global resource
            * if zone resources are specified in the template they will have to be changed before using the template in another zone
            * [Creating an Instance Template](https://cloud.google.com/compute/docs/instance-templates/create-instance-templates)
            * Its recommended to be explicit and deterministic when creating your templates to avoid unexpected behavior, see the documentation [here](https://cloud.google.com/compute/docs/instance-templates/deterministic-instance-templates)
            * Can be used for creating reservations: 
                * https://cloud.google.com/compute/docs/instances/reservations-overview
        * MIG advantages
            * Maintaining a minimal number of instances in the MIG. If an instance fails, it is auto- matically replaced.
            * Autohealing using application health checks. If the application is not responding as expected, the instance is restarted.
            * Distribution of instances across a zone. This provides resiliency in case of zonal failures. Load balancing across instances in the group.
            * Autoscaling to add or remove instances based on workload.
            * Auto-updates, including rolling updates and canary updates.
            * Rolling updates will update a minimal number of instances at a time until all instances are updated.
            * Canary updates allow you to run two versions of instance templates to test the newer version before deploying it across the group.
        * MIGs should be used when availability and scalability are required for VMs
        * MIGs may be zonal (single zone) or regional (multiple zones within a single region)
        * MIGs can be used for stateless or statefull workloads
            * Stateless workloads do not maintain state (i.e website front ends, bulk file processing applications)
            * Statefull workloads maintain state (such as databases and long-running batch computations)
        * [Stateful MIGs](https://cloud.google.com/compute/docs/instance-groups/stateful-migs) preserve each instance’s state, including instance name, persistent disks, and metadata when the instance is restarted, re-created, autohealed, or otherwise updated.
            * Use a combination of the instance template, optinal [all-instances configuration](https://cloud.google.com/compute/docs/instance-groups/set-mig-aic), optinal [stateful policy](https://cloud.google.com/compute/docs/instance-groups/stateful-migs#stateful_policy), and optional [per-instance configurations](https://cloud.google.com/compute/docs/instance-groups/stateful-migs#per_instance_configs)
* [App Engine](https://cloud.google.com/appengine/docs/the-appengine-environments)
    * Serverless PaaS offering
    * users do not have to configure servers, however they must provide the application code that is run in the environment
    * Regional resource, so GCP deploys redundant resources accross all zones in a region
    * Two types
        * [App Engine Standard](https://cloud.google.com/appengine/docs/standard)
            * allows developers to run their applications in a a serverless environment
            * based on container instances running on Google's infrastructure one of several available runtimes
            * cotnainers are preconfigured with one of several avaialable runtimes
                * currently standard supports the following runtime environments:
                    * Go
                    * Java
                    * PHP
                    * Node.js
                    * Python
                    * Ruby
            * provides 1 GiB of data storage and traffic for free
            * Each instance has an instance class that is determined by CPU speed and memory, memory varies by runtine generation (first or second)
                * First-generation
                    * supports Python 2.7, Java 8, and PHP 5.5
                    * these language versions are not longer supported by open source communities but is supported by Google for legacy runtimes because some App Engine customers use them
                * Second-generation
                    * Used with Python 3, Java 11, Node.js, PHP 7, Ruby, and Go 1.12+
                    * defaults instance class is F1 with 256 MB memory limit and 60 MHz CPU limit
                    * can the `intance_class` in the `app.yaml` to use a different instance class
                    * second largest second-generation instance class provides 2048 MB and 4.8GHz CPU
            * Good option for applications:
                * written in one of the supported languages and runtimes, 
                * needs to scale rapidly up/down, depending on traffic
                * instance startup time is on the order of seconds
        * App Engine Flexible 
            *  allows developers to customize their runtime environments by using Dockerfiles
            * allows applications to run within Docker Containers on Compute Engine VMs
            * Supported language runtimes
                * Go
                * Java 8
                * .NET
                * Node.js
                * PHP 5/7
                * Python 2.7 and Python 3.6
                * Ruby
            * Also supports custom runtimes that can be deployed via custom Docker containers
            * you can SSH into the backing GCE instance 
            * These instances provide additional features to what is provided by Compute Engine, including the following:
                * Health checks and autohealing
                * Automatic updates to the operating system
                * Automatically colocate a project’s VM instances for performance 
                * Weekly maintenance operations including restarts and updates 
                * Ability to use root access
            * Good option when applications :
                * run within a Docker container
                * scales but startup time is in the order of minutes and not seconds
                * when application uses microservices and depends on custom code or when libraries are not support by Standard
            * Key differences between running containers in App Engine Flexible vs Compute Engine:
                * App Engine Flexible containers are restarted once per week.
                * By default, SSH access is disabled in an App Engine Flexible container, but you can enable it. SSH access is enabled by default in Compute Engine.
                * Images in App Engine Flexible are built using the Cloud Build service. Images run in Compute Engine may use the Cloud Build service, but it is not necessary.
                * The geographic location of App Engine Flexible instances is determined by project settings, and all App Engine Flexible instances are colocated for performance.
    * Includes additional services
        * [App Engine Cron Service](https://cloud.google.com/appengine/docs/flexible/scheduling-jobs-with-cron-yaml)
            * which allows developers to schedule tasks to run at regular times or intervals
            * 
        * [Task Queues](https://cloud.google.com/appengine/docs/legacy/standard/python/taskqueue)
            * to support operations that need to run asynchronously or in the background
            * can use either push or pull model
            * well suited for distributed tasks
            * if a need for publish/subscribe type of messaging use Cloud Pub/Sub
* Cloud Functions
    * serverless compute service well suited for event processing
    * [Function framework](https://cloud.google.com/functions/docs/functions-framework) lets you write lightweight functions that can run in :
        * Cloud Functions
        * Local dev machine
        * Cloud Run
        * Knative-based environments
    * designed to respond to and execute code in response to events with GCP
    * Example, if am image file is uploaded to Cloud Storage, a cloud function can execute a piece of code to transform the image or record metadata in a databases
    * Can also be used to respond to messages from a Pub/Sub 
    topic
    * Also compliements App Engine Cron Service
    * Supports the following runtimes:
        * Node.js (20, 18 (Recommended), 16, 14, 12, 10)
        * Python 3 (3.11 (Recommended), 3.10, 3.9, 3.8, 3.7)
        * Go (1.21 (preview), 1.20 (Recommended), 1.19, 1.18, 1.16, 1.13)
        * Java (17 (Recommended), 11)
        * .NET Core (6.0 (Recommended), 3.1 (Using [Functions Framework V1](https://cloud.google.com/functions/docs/concepts/dotnet-runtime#selecting_the_net_functions_framework_version)))
        * Ruby (3.2 (Recommended), 3.0, 2.7, 2.6)
        * PHP (8.2 (Recommended), 8.1, 7.4)
    * Incoming requests are assigned to an instance of a cloud functiion       
    * Each instance operates on one request at a time
    * You can specific a max limit on the number of instance that exists at one time
        * `gcloud functions deploy FUNCTION_NAME --max-instances MAX_NUMBER`
        * `gcloud functions deploy FUNCTION_NAME --clear-max-instances`
    * Event driven functions
        * Gen 2 for all runtimes use [CloudEvent functions](https://cloud.google.com/functions/docs/writing/write-event-driven-functions#cloudevent-functions)
        * Gen 1 
            * for Node.js, Python, Go and Jave use [Background functions](https://cloud.google.com/functions/docs/writing/write-event-driven-functions#background-functions)
            * for .NET, Ruby, and PHP use [CloudEvent functions](https://cloud.google.com/functions/docs/writing/write-event-driven-functions#cloudevent-functions)
    * Local development
        * Gcloud CLI Functions emulator enables you to manage local instances of your cloud functions through alpha commands  
        * https://cloud.google.com/functions/docs/running/functions-emulator
    * an event is an action that occurs in GCP, however CF does not work will all possible events however it is designed to respond to the following kinds of events:
        * [Cloud Storage](https://cloud.google.com/functions/docs/calling/storage)
            * Supported events (Gen 2 events are via Eventarc)
                * Object Finalized
                    * Gen 2 : `google.cloud.storage.object.v1.finalized` 
                    * Gen 1: `google.cloud.storage.object.finalized`
                * Object deleted
                    * Gen 2 : `google.cloud.storage.object.v1.deleted`
                    * Gen 1: `google.cloud.storage.object.deleted`
                * Object archived
                    * Gen 2: `google.cloud.storage.object.v1.archived`
                    * Gen 1: `google.cloud.storage.object.archived`
                * Object metadata update
                    * Gen 2: `google.cloud.storage.v1.metadataUpdated`
                    * Gen 1: `google.cloud.storage.metadataUpdated`
        * [Cloud Pub/Sub](https://cloud.google.com/functions/docs/calling/pubsub)
            * Gen 1 
                * `--trigger-event=providers/cloud.pubsub/eventTypes/topic.publish --trigger-resource=TOPIC`
            * Gen 2
                * `--trigger-topic=TOPIC`
            * message publishing events
            * Example --> https://cloud.google.com/functions/docs/tutorials/pubsub
        * [HTTP](https://cloud.google.com/functions/docs/calling/http)
            * GET,POST,PUT,DELETE, and OPTIONS
            * `--trigger-http` flag on the `gcloud functions deploy` command
            * `--entry-point=ENDPOINT` is the endpoint for the function
            * `--allow-unauthenticated` lets you reach the function without authentication 
            * [HTTP Trigger Example](https://cloud.google.com/functions/docs/tutorials/http)
        * [Cloud Firestore](https://cloud.google.com/functions/docs/calling/cloud-firestore)
            * supports events of document create, update, delete, and write operations
            * Gen 2 Currently in preview
        * Firebase -- BETA
            * supports database triggers, remote configuration triggers, and authentication triggers
        * [Eventarc](https://cloud.google.com/functions/docs/calling/eventarc#gcloud)
            * Gen2 Cloud Functions
            * trigger by any of the [supported Eventarc events](https://cloud.google.com/eventarc/docs/reference/supported-events)

        * Cloud Logging
            * message is written to Cloud Logging it is forwarded to Cloud Pub/Sub and from there a cloud function can be triggered 
            * [Cloud Audit Logging Example](https://cloud.google.com/functions/docs/tutorials/cloud-audit-logs)
            * [Second-party triggers with Cloud Logging]()
* [Cloud Run](https://cloud.google.com/run/docs/overview/what-is-cloud-run)
    * serverless service for running stateless containers
    * available as a managed service or within Anthos
    * Managed Service is pay per use and can have up to 1000 container instances by default
    * allows unauthorized access or use Identity-Awre Proxy (IAP) to limit access to authorized clients
    * Unlike App Engine Standard, you are note restricted to using a fixed set of programming languages
    * regional service
    * easily integrated with Cloud Code for version control and Cloud Build for continous deployments
    * Service is the main abstraction of computing in Cloud Run
        * located in a region and replicated across mulitple zones
        * may have multiple revisions
    * Revision is a deployment of a service and consits of container image and a configuration 
    * Cloud Run will autoscale the number instances based on load
    * Each container instance can process up to 80 concurrent requests by default, but this can be increased up to 1,000
    * if an image is deployed that is not designed to handle multiple requests or a single request can consume most CPU and memory then you can reduce the concurrency to 1.
    * to avoid cold starts configure the min number of instances to 1 to ensure you service is always available to recieve requests without waiting to start up and instance
    * [Security](https://cloud.google.com/run/docs/securing/security)
        * use Google managed base images
        * enable container registry image vulnerability scanning to perform security scans on your images
        * Allow Authenticated Access
            * use the `--allow-unauthenticated` flag when deploying the service with `gcloud run deploy SERVICE` command
        * Create a IAM binding with the Role `role/run.invoker`
        * [End user authentication tutorial](https://cloud.google.com/run/docs/tutorials/identity-platform)
    * [Develop a Service Locally](https://cloud.google.com/code/docs/vscode/develop-service)
    * [Creating a Service](https://cloud.google.com/run/docs/deploying#command-line)
    * [Traffic rollout and splitting](https://cloud.google.com/run/docs/rollouts-rollbacks-traffic-migration#command-line)
    * [Best Practices](https://cloud.google.com/run/docs/tips/general)
* [Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine)
    * managed service providing Kubernetes cluster management and Kubernetes container orchestration
    * allocates cluster resources, determines where to run containers, performs health checks, and manages VM lifecycles using Compute Enginer instance groups
    * often abbreviated K8s
    * provides highly scalable and reliable execution of containers
    * has a growing ecosystem of related tools and services such as:
        * [helm](https://helm.sh/), for managing K8s applications
        * [Flux](https://fluxcd.io/), for supporting continuous deployment and delivery using source version control (GitOps)
        * [Istio](https://istio.io/) to secure individual clusters or enable services in mulitple clusters to securely work with each other (Service Mesh)
    * leverages a declarative configuration to define the desired of a cluster, service or other entity
    * uses automation to monitor the state of entities and return them to the desired state when they drift from that desired state
    * key services provided by K8s:
        * [Service Discovery](https://k21academy.com/docker-kubernetes/kubernetes-service-discovery/)
        * [Load Balancing](https://kubernetes.io/docs/concepts/services-networking/ingress/#load-balancing)
        * Storage Allocation
        * Automated rollouts and rollbacks
        * Placement of containers to optimize use of resources
        * Automated detection and correction with the self-healing
        * Configuration management
        * [Secrets management](https://kubernetes.io/docs/concepts/configuration/secret/)
    * Open source so it can be run in Google Cloud, on-premises, and in other clouds
    * Anthos is another Google Cloud Service designed for orchestrating applications and workload across multiple clusters
    * Kubernetes Versions
        * https://kubernetes.io/releases/
        * GKE Supported Versions
            * https://cloud.google.com/kubernetes-engine/docs/release-notes
    * [K8s Cluster Architecture](https://kubernetes.io/docs/concepts/overview/components/)
        * Cluster has two types of instances
            * Cluster Master
                * runs four core service that are part of the control plane:
                    * **Controller Manager**
                        * runs services that manage k8s abstract components, such as deployments and replica sets
                    * **API Server**
                        * handles intercluster interactions
                        * applications call the API server to interact with the cluster master
                    * **Scheduler**
                        * responsible for determining where to run pods, which are low-level compute abstractions that support containers
                    * **etcd**
                        * distributed key-value store used to store state information across a cluster
            * Cluster Node
                * instances that execute workloads
                * communicate to the cluster master through an agent called [_kublet_](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)
                * [_kube-proxy_](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) is a network proxy that runs on each node
                    * responsible for maintaining and implementing rules for network communication with network sessions inside and outside the cluster
        * Cluster container runtime
            * is the software that enables containers to run
            * supported runtimes
                * Docker, deprecated in new version of k8s in favor of runtimes that implement CRI
                * [containerd](https://containerd.io/)
                * [cri-o](https://cri-o.io/)
                * any other runtime that implements the [Kubernets Container Runtime Interface (CRI)](https://kubernetes.io/docs/concepts/architecture/cri/)
        * Workload and Abstraction Components
            * [Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
                * smallest computational unit managed by k8s
                * container one or more containers
                    * if functionality provided by two containers is tightly coupled, then they may be deployed in the same container, common example is the use of proxies, such as Envoy, which can provide support services such as authentication, monitoring and logging
                * multiple containers should be in the same pod only if they are functionaly related and have similar scaling and lifecycle characteristics
                * deployed to nodes by the scheduler
                * deployed usually in groups or replicas to provide high availability
                * ephemeral and may be terminated if they are not functioning properly
                * k8s monitors health of pods and replaces them if they are not functioning properly
                * using multiple replicas of pods allows pods to be destroyed without completely disrupting a service.
                * support scalability
            * [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
                * abstraction with a stable API endpoint and stable IP address that is used to expose an application running on a set of pods
                * keeps track of its associated pods so that it can always route calls
            * [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
                * a controller that manages the number of pods running for a deployment
            * [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
                * type of controller consisting of pods running the same version of an application
                * each pod in a deployment is created using the same template, which defines how to run a pod
                * the definition is call a pod specification
                * configured with a desired number of pods, if the actual number of pods varies from the desired state, example, if a pod is terminated for being unhealthy, then the replicaset will add or remove pods until the desired state is reached
            * [PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
                * represents storage allocated or provisioned for use by a pod
                * two ways to be provisioned
                    * Static
                        * created by cluster admins
                        * carry details of real storage which is available for use by cluster users
                        * exist in the k8s API and are available for consumption
                    * Dynamic
                        * When none of the static PVs the administrator created match a user's PersistentVolumeClaim, the cluster may try to dynamically provision a volume specially for the PVC
                        * provisioning is based on [StorageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/)
                            * the PVC must request a storage class and the administrator must have created and configured that class for dynamic provisioning to occur. Claims with the class "" effectively disable dynamic provisiong for themselves
                        * requires the cluster admin to enable the [DefaultStorageClass admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#defaultstorageclass) on the API Server
                * Pods acquire access to persistent volumes by creating [a _PersistentVolumeClaim_](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims), which is a logical way to link a pod to persistent storage
            * [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
                * pods are created from the same spec, but are not interchangeable: each has a persistent identifier that it maintains across any rescheduling.
                * used to designate pods as statefull and assigned a unique identifier to them
                * k8s uses these to track which clients are using which pods and keep them paired
                * StatefulSets are valuable for applications that require one or more of the following:
                    * Stable, unique network identifiers.
                    * Stable, persistent storage.
                    * Ordered, graceful deployment and scaling.
                    * Ordered, automated rolling updates.
            * [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
                * object that controls external access to services running in a k8s cluster
                * an [_Ingress Controller_](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) must be running in the cluster for an Ingress to function
            * [Node pools](https://cloud.google.com/kubernetes-engine/docs/concepts/node-pools)
                * sets of nodes in a cluster with the same configuration and a common node label
                * k8s creates a default node pool when a cluster is created, and you can add additional custom node pools
                * can be created with nodes configured for a particular worklods
                * configuration of a pod determines which node pool it runs in, this is done with the _nodeSelector_ in the pod configuration which specifices a node label
                * node with the same node label specified in a pod configuration will be selected to run that pod
                * When node labels are used, pods will only be run on nodes with a matching node label.
                * _node affinity_ is a concept in which it tries to schedule a pod on a node that meets the specified constraints but will run it on another node if needed
    * [GKE Cluster Types](https://cloud.google.com/kubernetes-engine/docs/concepts/kubernetes-engine-overview)
        * [Standard](https://cloud.google.com/kubernetes-engine/docs/concepts/choose-cluster-mode#why-standard)
            * offers more flexibility and control over configuration of the cluster and infrastructure
            * good option when
                * you want control over zonal vs regional clusters
                * use of routes-based networking
                selecting of which version of kubernetes to run
            * pay per node provisioned model
            * two cluster types
                * Zonal
                    * single control plane in a single zone
                    * has nodes running in the same zone as the control plane
                    * can be configured as multizonal cluster which has the control plane in a single zone but has nodes running in multiple zones
                        * has the advatange that workloads can run in a zone if there is an outage in the other zones
                    * [Creating a zonal cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-zonal-cluster)
                * Regional
                    * has multiple replicas of the control plane running in multiple zones of a single region
                    * node pools are replicated across three zones in regional clusters by default, but can can be changed during cluster setup
                    * [Creating a regional cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-regional-cluster)
        * [Autopilot](https://cloud.google.com/kubernetes-engine/docs/concepts/choose-cluster-mode#why-autopilot)
            * provides a preconfigured provisioned and managed cluster
            * cluster is always regional and uses VPC-native network routing
            * you will not have to manage compute capacity or managed the health of pods
            * nodes and node pools are managed by GKE
            * pay for only CPU, memory, and storage that pods use while running
        * [Private Clusters](https://cloud.google.com/kubernetes-engine/docs/concepts/private-cluster-concept)
            * nodes have only internal IP addresses. 
            * This isolates nodes in the cluster from the internet by default.
            * use VPC-native cluster networking
            * if outbound internet access is required your can use Cloud NAT
    * [Kubernetes Networking](https://kubernetes.io/docs/concepts/cluster-administration/networking/)
        * uses a declarative model to specify network rules in k8s
        * networking is associated with pods, services, and external clients as well as with nodes
        * GKE will provision a network load balancer for the service and configure firewall rules to allow connections to the service from outside the cluster
        * three kinds of IP addresses are supported by k8s
            * ClusterIP
                * an IP address assigned and fixed to a service
                * assigned by the VPC
            * Pod IP
                * an ephemeral IP address assigned to a Pod
                * assigned from a pool of addresses shared across the cluster
            * Node IP
                * an IP address assigned to a node in a cluster
                * assigned from the cluster's private VPC network and provides connectivity to kubelet and kube-proxy
        * Service Networking
            * pods to not expose external IP address instead they rely on kube-proxy to manage traffic on the node
            * pods and containers within a cluster can communicate using IP addresses and with services using ClusterIP addresses
            * when creating a service you must specify the [ServiceType](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types), which defines how the service is network accessible
            * types
                * [ClusterIP](https://kubernetes.io/docs/concepts/services-networking/service/#type-clusterip)
                    * default configuration
                    * which exposes a service on the internal IP network and makes the service reachable only from within the cluster
                    * You can expose the Service to the public internet using an [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) or a [Gateway](https://gateway-api.sigs.k8s.io/)
                * [NodePort](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport)
                    * exposes the service on a node’s IP address at a static port specified as NodePort in the configuration
                    * External clients can reach the service by specifying the node IP address and the NodePort
                * [LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer)
                    * exposes the Service externally using an external load balancer. 
                    * k8s does not directly offer a load balancing component; you must provide one, or you can integrate your Kubernetes cluster with a cloud provider.
                * [ExternalName](https://kubernetes.io/docs/concepts/services-networking/service/#externalname)
                    * maps the Service to the contents of the externalName field (for example, to the hostname api.foo.bar.example). 
                    * The mapping configures your cluster's DNS server to return a CNAME record with that external hostname value. 
                    * No proxying of any kind is set up.
            * [Headless Service](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)
                * When there is no need of load balancing or single-service IP addresses.We create a headless service which is used for creating a service grouping. That does not allocate an IP address or forward traffic.So you can do this by explicitly setting ClusterIP to “None” in the mainfest file, which means no cluster IP is allocated.
                * Kubernetes allows clients to discover pod IPs through DNS lookups. Usually, when you perform a DNS lookup for a service, the DNS server returns a single IP which is the service’s cluster IP. But if you don’t need the cluster IP for your service, you can set ClusterIP to None , then the DNS server will return the individual pod IPs instead of the service IP.Then client can connect to any of them.
* [Anthos](https://cloud.google.com/anthos/docs/concepts/overview)
    * an application management platform that builds on Kubernetes’ hybrid and multicloud implementations
    * designed to address many of the challenges of managing applications and services across infrastrcture on-premises and in mulitple clouds
    * provides mechanisms to managed fleets of clusters and their desired state
    * observes state of clusters, decides on changes needed to bring the system into the desired state, and then execute those changes
    * management model includes policy enforcement, service management, cluster management, and infrastructure management
    * extends GKE for hybrid and multicloud environments by providing services to create, scale, and upgrade conformant Kubernetes clusters along with a common orchestration layer
    * Multiple clusters can be managed as a group known as a [_fleet_](https://cloud.google.com/anthos/multicluster-management/fleet-overview)
    * Anthos Clusters can be connected using standard networking options including VPNs, Dedicated Intercon- nects, and Partner Interconnects
    * configuration of anthos clusters uses a declarative model for computing, networking, and other services
    * Configurations, which are stored in Git, build on k8s abstractions like namespaces, labels, and annotations
    * key benefits of using Anthos
        * Centralized management of configuration as code
        * Ability to roll back deployments with Git
        * Single pane of glass for cluster infrastructure and applications
        * centralized and auditable workflows
        * Instrumentation of code using Anthos Service Messh
        * Anthos Service Mesh authorization and routing
        * Migrate for Anthos for GKE, which allows orchestration of migrations using kubernetes and Anthos
    * [Anthos Service Mesh](https://cloud.google.com/service-mesh/docs/overview)
        * Service Mesh 
            * is architecture pattern which provides a common framework for services to communicate
            * allows for performing common operations such as monitoring, networking, and authentication of behalf of services so individual services do not have to implement those features/operations
            * also alleviates work on service developers by providing a consistent way of handling supporting operations like monitoring and networking
        * Anthos Service Mesh
            * managed service based on [Istio](https://istio.io/), which is a widely used open source service mesh
            * composed of
                * Control Plane
                    * can have one or more
                    * set of services that configure and manage communications between services
                    * provides configuration information to sidecar proxies for each service.
                * Data Plane
                    * manages the communication between services
                    * done through proxy sidecars which are auxillary services that support a main service
                    * sidecar is autility service that runs with a workload container in a pod
            * Functionality provided:
                * Controlling traffic flow between services, including at the application layer (layer 7) when using Istio-compatible custom resources
                    * [Traffic Management](https://cloud.google.com/service-mesh/docs/overview#traffic_management)
                * Collecting service metrics and logs for ingestion by Cloud Operations
                    * [Observability Insights](https://cloud.google.com/service-mesh/docs/overview#observability_insights)
                * Preconfigured service dashboards
                * Authenticating services with mutual TLS (mTLS) certificates
                * Encryption control plane communications
            * Deployment
                * [In-cluster control plane](https://cloud.google.com/service-mesh/docs/overview#in-cluster_control_plane)
                    * the Istiod service is run in the control plane to manage security, traffic, configuration, and service discovery
                    * use [`asmcli`](https://cloud.google.com/service-mesh/docs/unified-install/asmcli-overview)
                        * Google provided tool that allows you to install or upgrade Anthos Service Mesh
                        * If you let it, asmcli will configure your project and cluster as follows:
                            * Grant you the required Identity and Access Management (IAM) permissions on your Google Cloud project.
                            * Enable the required Google APIs on your Google Cloud project.
                            * Set a label on the cluster that identifies the mesh.
                            * Create a service account that lets data plane components, such as the sidecar proxy, securely access your project's data and resources.
                            * Register the cluster to the fleet if it isn't already registered.
                        * Just include the `--enable_all` flag when you run `asmcli` to let it configure your project and cluster
                        * [asmcli Reference](https://cloud.google.com/service-mesh/docs/unified-install/reference)
                * [Managed Anthos Service Mesh](https://cloud.google.com/service-mesh/docs/overview#managed_anthos_service_mesh)
                    * Google manages the control plane, including upgrades
                    * Google also manages scaling as needed and security
                    * [Provisioning Managed Anthos Service Mesh - gcloud](https://cloud.google.com/service-mesh/docs/managed/provision-managed-anthos-service-mesh)
                    * 
                * Anthos Service Mesh for Compute Engine VMs
                    * manage and secure managed instance groups and GKE clusters in the same mesh
    * [Anthos Multi Cluster Ingress](https://cloud.google.com/kubernetes-engine/docs/concepts/multi-cluster-ingress)
        *  a controller that is hosted on Google Cloud and enables load balancing of resources across clusters, including multiregional clusters
        * a single consistent virtual IP address for applications regardless of where they are deployed. By supporting multiple regions and multiple clusters, the Multi Cluster Ingress brings additional support for high availability. It also enables the cluster migration during upgrades and so reduces downtime.
        * globally distributed control plane that runs outside of your clusters. Within the Multi Cluster Ingress, the Config Cluster is the GKE Cluster running in GCP that is configured with the Multi Cluster Ingress resource. This ingress resource runs only on the Google Cloud Deployment.
        * Ingress controller that programs the external HTTP(S) load balancer using network endpoint groups (NEGs).
        * ![MultiCluster Ingress](https://cloud.google.com/static/kubernetes-engine/images/anthos-ingress-traffic-flow.svg)
    * Anthos Deployment Options
        * Anthos Service Mesh and Anthos Config Management are included in all deployments
        * Google Cloud Deployment
            * includes Anthos Config Management, Anthos Cloud Run, Multi Cluster Ingress, and binary authorization
        * On-Premise Deployment
            * designed to run Anthos in on-premises infrastructure
            * in addition to Anthos Config Management and the Anthos UI & Dashboard, this deployment includes services needed for an on-premises implementation including the following:
                * Network plugin
                * Container Storage Interface (CSI) and hybrid storage Authentication Plugin for Anthos
                * Prometheus and Grafana (on VMware)
                * Bundled layer 4 load balancers (on VMware)
        * Anthos can be run other clouds:
            * AWS using the [AWS Deployment](https://cloud.google.com/anthos/clusters/docs/multi-cloud/aws/concepts/architecture) which includes the following: 
                * Anthos Config Management
                * Anthos UI & Dashboard
                * Network Plugin
                * Container Storage Interface (CSI) and hybrid storage 
                * Authentication Plugin for Anthos
                * [AWS load balancers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/load-balancer-types.html)
                * [Pre-req for AWS](https://cloud.google.com/anthos/clusters/docs/multi-cloud/aws/how-to/create-aws-vpc)
                * [Deploy an application on Anthos Clusters on AWS](https://cloud.google.com/anthos/clusters/docs/multi-cloud/aws/quickstart)
             * Azure using the [Azure Deployment](https://cloud.google.com/anthos/clusters/docs/multi-cloud/azure/concepts/architecture) which includes the following: 
                * Anthos Config Management
                * Anthos UI & Dashboard
                * Network Plugin
                * Container Storage Interface (CSI) and hybrid storage 
                * Authentication Plugin for Anthos
                * [Azure Load Balancers](https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-overview)
                * [Deploy an applciation on Anthos Clusters in Azure](https://cloud.google.com/anthos/clusters/docs/multi-cloud/azure/deploy-app)
        * The minimal deployment option known as [Attached Clusters Deployment](https://cloud.google.com/anthos/clusters/docs/multi-cloud/attached): 
            * includes Anthos Config Management, Anthos UI & Dashboard, and Anthos Service Mesh.
    * [gkectl](https://cloud.google.com/anthos/clusters/docs/on-prem/latest/reference/gkectl)
        * command line interface for a for a variety tasks, including the following:
            Generate a template for a cluster configuration file.
            Validate a cluster configuration file.
            Prepare a vSphere environment.
            Create a cluster.
            Upgrade a cluster.
            Update a cluster.
            Resize a cluster.
            Diagnose cluster issues.
    * [gkeadm](https://cloud.google.com/anthos/clusters/docs/on-prem/latest/reference/gkeadm)
        * ommand-line interface for a variety of tasks, including the following:
            Create a template for an admin workstation configuration file.
            Create an admin workstation.
            Upgrade an admin workstation.
            Roll back an admin workstation to a previous version.
            Restore an admin workstation from a backup.
            Delete an admin workstation.
* [Recommender](https://cloud.google.com/recommender/docs/overview)
    * service that helps to optimize the use of cloud resources
    * Compute Enginer is one of the GCP Products with recommenders, 
    * Recommenders are machine learning models that provide insights into how you save on your cloud expenses, improve security, or otherwise optimzie your cloud resources
        * insights are findings that you can use to practively focus on important patterns in resource usage
            * https://cloud.google.com/recommender/docs/insights/using-insights
    * uses dats about your provisioned infrastructure to generate recommendations
    * Includes a committed use discount recommender, idle custom image recommender, idle IP address recommender, idle persistent disk recommender, and idle VM recommender, [VM resizing recommender](https://cloud.google.com/compute/docs/instances/apply-machine-type-recommendations-for-instances)
    * Full list of recommenders can be found [here](https://cloud.google.com/recommender/docs/recommenders)
    * [Using Recommenders with IaC](https://cloud.google.com/recommender/docs/tutorial-iac)
* AI and Machine Learning Services
    * [Vertex AI](https://cloud.google.com/vertex-ai/docs/start/introduction-unified-platform)
        * Unification of two prior Google Cloud Services, AutoML and AI Platform
        * provides a single API and UI
        * supports both custom training of ML models and automated training using AutoML
        * includes several components
            * Training using both AutoML automating training and AI custom training
            * Support for ML model deployment
            * Data labelling
                * allows for request human assitance in labelling training examples for supervised learning tasks
            * Feature storem which is a repository for managing and sharing ML features
            * Workbench, which is a Jupyter notebook-based development environment
        * also includes specially configured deep learning VM images and containers
    * [Cloud TPU](https://cloud.google.com/tpu/docs/intro-to-tpu)
        * service that provides access to Tensor Processing Units (TPUs), which are custom-designed, application specific integrated circuits (ASICs) designed by Google
        * can be more efficient at training deep learning models than GPUs or CPUs
        * v2 can provide up to 180 teraflops, while v3 can provide 420 teraflops
        * can also use clusters of TPUs known as pods
        * v2 pod provides 11.5 petaflops, v3 pod provides more than 100 petaflops
        * distinct service that is integrated and available from other GCP services, such as GCE we using a deep learning image, or GKE
        * preemptible TPUs are available at 70% off the standard price
* Data Flows and Pipelines
    * [Cloud Pub/Sub](https://cloud.google.com/pubsub/docs/overview) Pipelines
        * good option for buffering data between services
        * supports the following subscription models
            * Push
                * message data is sent via HTTP POST request to a push endpoint url
                * useful for when a single endpoint processes mesdsages from mutliple topics
                * also when data will be processed by an App Engine Standard application or Cloud Function as both will only be billed when in use
                * pushing avoids the need to check a queue continously for messages
            * Pull  
                * service reads messages from a topic
                * good approach when processing large volumes of data and efficiency is a top concern
        * works well when data needs to be transmitted from one service to another or buffered to control downstream services
        * to process data downstreams, example applying transformations from an IoT device, Cloud Dataflow is a good option
        * Pub/Sub Lite
            * is a partition-based solution that trades off operational workload, global availability, and some features for cost efficiency. 
            * requires you to manually reserve and manage resource capacity. 
            * choose zonal or regional Lite topics. 
                * Regional Lite topics offer the same availability SLA as Pub/Sub topics
            [Choose Lite or Standard](https://cloud.google.com/pubsub/docs/choosing-pubsub-or-lite)
        * [Choose Pub/Sub or Cloud Task](https://cloud.google.com/pubsub/docs/choosing-pubsub-or-cloud-tasks)
    * [Cloud Dataflow](https://cloud.google.com/dataflow/docs)
        * implementation of [Apache Beam](https://beam.apache.org/documentation/) stream processing framework
        * fully managed so you there is no need to provision and manage instances to process data in streams
        * operates in batch mode without changes to processing code
        * Devs can write stream and batch processors using Java, Python, and [SQL](https://cloud.google.com/dataflow/docs/guides/sql/dataflow-sql-intro)
        * can be used in conjunction with Cloud Pub/Sub
        * [Hands-on Stream Processing Lab](https://www.cloudskillsboost.google/focuses/18457?parent=catalog)
        * Dataflow Templates
            * allows you to package a Dataflow pipeline for deployment
            * Google provides [pre-built templates](https://cloud.google.com/dataflow/docs/templates/provided-templates) for common scenerios
            * Types
                * [Flex](https://cloud.google.com/dataflow/docs/guides/templates/using-flex-templates#cloud-shell)
                    * pipline is packaged as a Docker image in Artifact Registry along with the template specififaction file in Cloud Storage
                    * template spec contains a pointer to the Docker image
                    * when the Dataflow service starts a laucher VM, pulls the Docker image and runs the pipeline
                * [Classic](https://cloud.google.com/dataflow/docs/guides/templates/creating-templates)
                    * contains the JSON serialization of a Dataflow Job graph
                    * code for the pipeline must wrap any runtime parameters in the [`ValueProvider`](https://cloud.google.com/dataflow/docs/guides/templates/creating-templates#use-valueprovider-in-your-pipeline-options) interface which allows users to specify params values when deploying the template
        * Dataflow Prime
            * serverless data processing platform
            * uses a compute and state-separated architecture
            * supports both batch and streaming pipelines
            * by default uses [Dataflow Shuffle](https://cloud.google.com/dataflow/docs/shuffle-for-batch) and [Dataflow Runner V2](https://cloud.google.com/dataflow/docs/runner-v2) for batch pipelines
            * key features for different kinds of pipelines:
                * [Vertical Autoscaling (memory)](https://cloud.google.com/dataflow/docs/vertical-autoscaling) 
                    * Supports streaming pipelines in Python, Java, and Go.
                    * adjusts the memory available to the Dataflow worker vms to fit the pipeline needs
                    * helps prevent out-of-memory errors
                    * works alongside Horizontal Autoscaling to dynamically scale resources
                * [Right Fitting (Dataflow Prime resource hints)](https://cloud.google.com/dataflow/docs/guides/right-fitting) 
                    * Supports batch pipelines in Python and Java
                    * uses the Apache Beam feature known as [resource hints](https://beam.apache.org/documentation/runtime/resource-hints/)
                    * allows you to specify resource requirements either for the entire pipeline or a specific step
                    * allows you to create customized workers for different steps of a pipeline and maximize efficiency, lower operational costs and avoid out-of-memory and other resource errors
                    * supports memory and GPU resource hints
                * [Job Visualizer](https://cloud.google.com/dataflow/docs/concepts/execution-details)
                    * Supports batch pipelines in Python and Java
                    * allows for viewing performance of a Dataflow job and optimizing by finding inefficient code
                * [Smart Recommendations](https://cloud.google.com/dataflow/docs/guides/monitoring-overview#recommendations-and-diagnostics)
                    * Supports both streaming and batch pipelines in Python and Java
                    * allows for optimizing and troubleshooting pipelines based on recommendations via the Diagnostics Tab
                * [Data Pipelines](https://cloud.google.com/dataflow/docs/guides/data-pipelines)
                    * Supports both streaming and batch pipelines in Python and Java
                    * allows scheduling jobs, observing resource utlization, track data freshness objectives for streaming data, optimize pipelines
    * [Cloud Dataproc](https://cloud.google.com/dataproc/docs/concepts/overview)
        * Managed Spark and Hadoop service widely used for large-scale batch processing and machine learning
        * Spark supports stream processing
        * creates clusters quickly so they are often used ephemerally
        * clusters are Compute Engine virtual machines and can use preemptible instances as worker nodes
        * supports [Workflow Templates](https://cloud.google.com/dataproc/docs/concepts/workflows/using-workflows#running_a_workflow) which provides a flexible and easy to use mechanism for managing and executing worklfows as a [Directed Acyclic Graph (DAG)](https://en.wikipedia.org/wiki/Directed_acyclic_graph)
        * built-in integrations with BigQuery, BigTable, Cloud Storage, Cloud Logging, and Cloud Monitoring
        * recommended when migrating an on-premises Spark and Hadoop cluster and you want to minimize management overhead
        * [DataProc Versioning](https://cloud.google.com/dataproc/docs/concepts/versioning/overview)
            * Dataproc uses images to tie together useful Google Cloud Platform connectors and Apache Spark & Hadoop components into one package to deploy on a cluster
            * use the `--image-version=VERSION` when creating a cluster with the `gcloud dataproc clusters create` command
            * [2.1.x release verions](https://cloud.google.com/dataproc/docs/concepts/versioning/dataproc-release-2.1)
            * [2.0.x release versions](https://cloud.google.com/dataproc/docs/concepts/versioning/dataproc-release-2.1)
            * [Cluster image version lists](https://cloud.google.com/dataproc/docs/concepts/versioning/dataproc-version-clusters)
            * [Supported Dataproc images versions](https://cloud.google.com/dataproc/docs/concepts/versioning/dataproc-version-clusters)
    * [Cloud Worklfows](https://cloud.google.com/workflows/docs/overview)
        * service for orchestrating HTTP-based API services and serverless workflows
        * can be used with Cloud Functions, Cloud Run, and other Google Cloud APIs to string together a set of processing steps
        * define a series of steps in YAML or JSON formats
        * an authentication call is required to execute a workflow
        * if you need to process large amounts of data or coordinate complex sequence of jobs then use Cloud Dataflow, Cloud Dataproc, Cloud Data Fusion or Cloud Composer
            * [Choose Workflows or Cloud Composer](https://cloud.google.com/workflows/docs/choose-orchestration)
            * [Choose Workflows or Application Integration](https://cloud.google.com/workflows/docs/choose-app-integ-or-workflows)
        * similar to AWS Step Functions, plan a migration using the following [migration guide](https://cloud.google.com/workflows/docs/migrate-from-step-functions)
        * [Syntax overview](https://cloud.google.com/workflows/docs/reference/syntax)
        * [Cheat sheet](https://cloud.google.com/workflows/docs/reference/syntax/syntax-cheat-sheet)
        * [Creating a workflow with Terraform](https://cloud.google.com/workflows/docs/create-workflow-terraform)
        * [Creating a workflow with gcloud](https://cloud.google.com/workflows/docs/create-workflow-gcloud)
    * [Cloud Data Fusion](https://cloud.google.com/data-fusion/docs/concepts/architecture)
        * managed service based on the CDAP data analytics platform which allows for development of extraction, transformation, and load (ETL) and execution, load, and transform (ELT) pipelines without coding
        * [CDAP](https://cloud.google.com/data-fusion/docs/reference/cdap-reference) is a code-free, drap-and-drop dev tool that includes more than 160 prebuilt connectors and transformations
        * deploys as an instance which runs on the following
            *  on a GKE cluster inside a tenant project, and uses Cloud Storage, Cloud SQL, Persistent Disk, Elasticsearch, and Cloud KMS for storing business, technical, and operational metadata.
            * the instances is provisioned in a [tenancy](https://cloud.google.com/service-infrastructure/docs/glossary#tenancy) unit which provides per-service, per-service consumer isolated environments used for deploying managed services.
        * instance can be [public](https://cloud.google.com/data-fusion/docs/how-to/create-instance) or [private](https://cloud.google.com/data-fusion/docs/how-to/create-private-ip) which resides within a VPC
        * comes in three versions
            * Developer
                * lowest cost and limited features
            * Basic
                * includes a visual design, transformation and an SDK
            * Enterprise
                * includes everything in Dev and Basic editions plus streaming pipelines, integrations with a metadata repository, high availability, as well as support for triggers
        * supports [data lineage within Dataplex](https://cloud.google.com/data-fusion/docs/how-to/view-lineage-in-dataplex)
        * [Creating a data pipeline](https://cloud.google.com/data-fusion/docs/create-data-pipeline)
    * [Cloud Composer](https://cloud.google.com/composer/docs/concepts/overview)
        * managed service for [Apache Airflow](https://airflow.apache.org/), which is a workflow orchestration system that executes workflows represented as DAGs
        * a workflow is a collection of tasks with dependencies, DAGs are defined in Python and stored in Cloud Storage
        * Apached Airflow building blocks
            * [Tasks](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/tasks.html)
                * unit of work represented by a node in a graph
            * [Operators](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/operators.html)
                * define how tasks will be run and include
                    * Action Operators
                    * Transfer Operators
                    * Senor Operators
            * [Hooks](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/connections.html#hooks)
                * interfaces to third-party services
                * when its combined with an operator, it is referred to as a plugin
            * [Plugins](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/plugins.html)
        * logs are generated when a DAG is executed and are associated with a single DAG
        * logs can be viewed in the Airflow UI or by viewing logs in the associated Cloud Storage buckets
        * logs can be streamed to Logs Viewer for the scheduler, web server, and workers
        * Cloud Composer Codebase is open source : https://cloud.google.com/composer/docs/composer-airflow-codebase
        * Environments
            * [Environments Architecture](https://cloud.google.com/composer/docs/concepts/architecture)
            * are self-contained Apache Airflow installations deployed into a managed GKE cluster
            * can have one or more environments in a single environment
            * Versions
                * V1
                    * [Architecture](https://cloud.google.com/composer/docs/concepts/architecture)
                    * Runs in a Standard mode managed GKE Cluster
                    * VPC-native or Routes-based networking
                    * by default enables node auto-upgrades and node auto-repair to protect your environment's cluster from security
                    * Airflow web server, which runs teh Airflow UI is running in an App Engine Flex instance that runs in the tenant project of the environment
                    * Cloud SQL is used for the Airflow metadata database running in the tenant project
                    * Cloud Storage bucket is running in the tenant project
                    * [Creating a v1 Environment - glcoud](https://cloud.google.com/composer/docs/how-to/managing/creating)
                    * [Creating a v1 Environment - terraform](https://cloud.google.com/composer/docs/terraform-create-environments)
                * V2 
                    * [Architecture](https://cloud.google.com/composer/docs/composer-2/environment-architecture)
                    * Runs in a managed GKE Autopilot cluster
                    * VPC-native or Routes-based networking
                    * by default enables node auto-upgrades and node auto-repair to protect your environment's cluster from security
                    * Airflow UI runs as a k8s doploymnet in the environment cluster
                    * [Create a v2 Environment - gcloud](https://cloud.google.com/composer/docs/composer-2/create-environments)
                    * [Create a v2 Environment - terraform](https://cloud.google.com/composer/docs/composer-2/terraform-create-environments)
            * If using terraform to provision an environment certain caveats exists
                * can take up to one hour to create or update an environment resource
                * GCP may only detect some errors in the configuration when they are used (~40-50 mins into the creation process)
                * prone to limited error reporting
                * Environment creates GCS buckets that do not get cleaned up automatically on environment deletetion
                * known issues can be found here: https://cloud.google.com/composer/docs/known-issues

### Compute System Provisioning
* GCP provides
    * [Cloud shell](https://cloud.google.com/shell/docs) which is an interactive console that allow for managing your environment, run glcoud commands
    * [gcloud CLI](https://cloud.google.com/sdk/gcloud) which is a command line utility used     for creating and managing compute, storage, and networking resources
    * [Cloud Deployment Manager](https://cloud.google.com/deployment-manager/docs/concepts)
        * a service which is an infrastructure deployment service that automates the creation and management of Google Cloud resources. Write flexible template and configuration files and use them to create deployments that have a variety of Google Cloud services, such as Cloud Storage, Compute Engine, and Cloud SQL, configured to work together
        * It is a good practice to define infrastructure as code, since it allows teams to reproduce environments rapidly. It also lends itself to code reviews, version control, and other software engineering practices.
        * use declarative templates that describe what should be deployed
        * sets of resource templates can be grouped together into deployments
        * when a deployment is run or executed, all of the specified resources are created
    *  Alternatively you can use [Terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs), which is an open source infrastructure and code system
        * Use [HashiCorp Configuration Language (HCL)](https://developer.hashicorp.com/terraform/language/syntax/configuration) to describe resources and then generates execution plans to implement changes to bring an infratructure into the desired state described by the HCL specification.
        * Cloud agnostic tool

### Additional Design Issues
* Managing State in Distributed Systems
    * stateful systems present various kinds of challengs such as
        * Persistent assignement of Clients to Instances
            * stateful system keep data about client processes and connections for example IoT sensors on industrial machines
                * how to asssign sensors to servers to distribute workload even across a cluster
                * Often the best solution is to assign a device to an instance randomly which will distribute the work evenly across the cluster
                * In practice, it is common to use modulo division on a numeric identifier like sensor ID and the divisor being the number of instances
                    * Example assuming there are eight instances in the cluster, one set of assignements with IDs 80,83,89, and 93 follows:
                        * 80 mod 8 = 0
                        * 83 mod 8 = 3
                        * 89 mod 8 = 1
                        * 93 mod 8 = 5
                * Variation of this pattern is to use some form of aggregate-level identifier, such as an account number or group number instead of indvidual senors identifiers
                    * Example each IoT machine has between 10 and 200 sensor if we assigned sensors to instances based on machine ID, it is possible that some servers would have more load than others
                    * if 300 machines with 200 sensors were assigned to one machine, while 300 machines with 10 sensors were assigned to another, the workload would be skewed to the former
            * Horizontal scalable systems function well within GCP, ie. GCE instance groups and GKE clusters readily add and remove compute resources as needed.
                * if an instance has state information, their will need a means of distributing working at the application level so that clients can be assigned to a single server or move state information off the instances to a common data store
        * Persistent state and volatile instances
            * Move state information to common data store such as in-memory cache or databases
            * Options
                * In-Memory Cache 
                    * [Cloud Memorystore](https://cloud.google.com/memorystore/docs)
                        * [Managed Redis](https://cloud.google.com/memorystore/docs/redis) and [memcached](https://cloud.google.com/memorystore/docs/memcached) services
                        * work well for applications with low-latency data access needs
                        * data in the cache can be persisted using snapshots
                        * if the cache fails, the contents of memory can be recreated using the latest snapshot
                        * if any data changed between the time of the last snapshot and the cache failure is not restored using the snapshot
                        * if data is ingrested from a queue, the data could be kept in the queue until it is save in a snapshot
                        * if snapshots are made once per minute, the time to live (TTL) on messages in the queue could be set to two minutes
                    * Databases
                        * advantage of persisting data to durable storage
                        * disadvantage is possible latency may be high than cache latency
                        * if latency is a concern use a mix, cache to store query results so that data that is repeatedly queried can be read from the cache
                        * Cloud SQL, Spanner
        * Synchronous and Asychnronous Operations
            * _Synchronous calls_ are calls to another service or function that wait for the operation to complete before returning
                * Ex: Credit card authorization for a purchase 
            * _Asynchronous calls_ do not wait for an operation to complete before returning
                * using buffer data between applications in a message queue (Cloud Pub/Sub, RabbitMQ, Apache Kafka)


### Compute volatility configuration (preemptible vs. standard)
* Standard VMs continue to run until you shut them down or there is a failure. If there is a failure the VM will be migrated to another physical server by default
* [Preemptible VMs](https://cloud.google.com/compute/docs/instances/preemptible) 
    * are available at 60% to 91% discounts off the costs of standard VMs, and may not always be available depending on demand for compute resources
    * will run up to 24hrs before it is shut down by GCP
    * it can shut down at any time before the 24hrs also 
    * when shutting down the instance will have 30 seconds to shut down gracefully
    * cannot live migrate to a standard vm or automatically restart in the case of a maintenance event
    * not covered by the Compute Engine SLA
    * [Creating a preemptible VM](https://cloud.google.com/compute/docs/instances/create-use-preemptible)
    * Replaced with Spot VMs
* [Spot VMs](https://cloud.google.com/compute/docs/instances/spot)
    * newer version of preemptible vms
    * same pricing model as preemptible
    * not shut down automatically after 24hrs
    * [Creating a spot vm](https://cloud.google.com/compute/docs/instances/create-use-spot)

### Network configuration for compute resources (Google Compute Engine, Google Kubernetes Engine, serverless networking)
* [GKE Networking Best Practices](https://cloud.google.com/kubernetes-engine/docs/best-practices/networking)
* [GKE Networking Overview](https://cloud.google.com/kubernetes-engine/docs/concepts/network-overview)
    * [Fully Integrated network model](https://cloud.google.com/kubernetes-engine/docs/concepts/gke-compare-network-models#fully-integrated-model)
        * flat, ease of communication with applications outside of k8s and in other clusters
        * default [GKE networking model](https://cloud.google.com/kubernetes-engine/docs/concepts/gke-compare-network-models#gke-networking-model)
    * [Islan-mode network model](https://cloud.google.com/kubernetes-engine/docs/concepts/gke-compare-network-models#island-mode-model)
        * bridged, commonly used for on-premise kubernetes implementations where no deep integration with the underlying network is possible.
        * Pods in a Kubernetes cluster can communicate to resources outside of the cluster through some kind of gateway or proxy

### Infrastructure orchestration, resource configuration, and patch management

### Container orchestration


## Section 3: Designing for security and compliance

## 3.1 Designing for security. 

### Identity and access management (IAM)
* _Identity_ is an enty that represents a person or other agent that performs actions on GCP Resources
* Three Kinds of Identities:
    * Google Account
        * used by people and represent people who interact with GCP, such as developers and administrators
        * designated by an email address that is linked to a Google account (@gmail.com or some domain)
    * [Service Account](https://cloud.google.com/iam/docs/service-account-overview)
        * used by applications running in GCP
        * used to give applications their own set of access controls instead of relying on using a person’s account for permissions
        * also designated by email addresses
        * When you create a service account, you specify a name of the account, such as `gcp-arch-exam`. IAM will then create an associated email such as `gcp-arch-exam@gcp-certs-1.iam.gserviceaccount.com`, where    `gcp-certs-1` is the project ID of the project hosting the service account. Note that not all service accounts follow this pattern for instance App Engine creates a SA which uses the `appspot.gserviceaccount.com` domain
        * `gcloud iam service-accounts create` to create service account 
        * to allow users to imporsonat the service account uses the following:
        ```
        gcloud iam service-accounts add-iam-policy-binding \
    SA_NAME@PROJECT_ID.iam.gserviceaccount.com \
    --member="user:USER_EMAIL" \
    --role="roles/iam.serviceAccountUser"
        ```
    * [Cloud Identity](https://cloud.google.com/identity/docs/overview) 
        * is an Identity as a Service (IDaaS) offering
        * Users who do not have Google accounts or Workspace accounts can use the Cloud Identity service to create an identity. 
        * It will not be linked to a Google account, but it will create an identity that can be used when assigning roles and permissions
        * can be configured to delegate authentication to other identity providers that use OIDC or SAML.    
            * convenient when the primary source of truth about an application is an enterprise identity provider.
        * Two [Editions](https://cloud.google.com/identity/docs/editions#7431902)
            * Free
            * Premium   
* [Groups](https://cloud.google.com/iam/docs/groups-in-cloud-console)
    * Related to identities are Google Groups, which are sets of Google accounts and service accounts. Groups have an associated email address. Groups are useful for assigning permis- sions to sets of users. When a user is added to a group, that user acquires the permissions granted to the group. Similarly, when a user is removed from the group, they no longer receive permissions from the group. Google Groups do not have login credentials, and there- fore they cannot be used as an identity.
G Suite domains are another way to group identities. A G Suite domain is one that is linked to a G Suite account; that is, a G Suite account consists of users of a Google service account that bundles mail, Docs, Sheets, and so on for businesses and organizations. All users in the G Suite account are members of the associated group. Like Google Groups, G Suite domains can be used for specifying sets of users, but they are not identities.

* Roles 
    * are sets of permissions that can be granted to identities (single or groups)
    * granted for projects, folders, or organizations, and they apply to all resources under those
    * Three types
        * Predefined
            * are created and managed by GCP
            * organized around groups of tasks commonly performed when working with IT systems, such as administering a server, querying a database, or saving a file to a storage system. Roles have names such as the following:
                * `roles/bigquery.admin`
                * `roles/bigquery.dataEditor`
            * naming convention is to use prefix `roles/` followed by the name of the service and a name associated with a responsibility
        * Basic
            * before IAM GCP had three roles known as primitive roles, however favor predefined rules over basic
            * Viewer
                * grants users read-only permissions to a resource
                * can see but not change or modify
            * Editor
                * all viewer capabilities but can also modify resource state
            * Owner
                * includes all viewer and editor capabilities
                * can also managed roles and permissions for resources
                * can also be assigned to sepecifc resources, which case it applies only to that reosurce
                * can also setup billing
        * Custom
            * use when predefined roles do not fit a particular set of needs
            * follow seperation of duties and least priviledge
* [Policy](https://cloud.google.com/iam/docs/policies#structure)
    * set of statements that define a combination of users and the roles. This combination of users (or members as they are sometimes called) and a role is called a binding. Policies are specified using JSON
    * Pcan be managed using the Cloud IAM API, which provides three functions
        * setIamPolicy for setting policies on resources
        * getIamPolicy for reading policies on resources
        * testIamPermissions for testing whether an identity has a permission on a resource
    * can be set anywhere in the resource hierarchy (org level, folder, project) even a the individual resource
    * Policies set at the project level are inherited by all resources in the project including projects under it in the hierarchy, while policies set at the organization level are inherited by all resources in all folders and projects in the organization. If the resource hierarchy is changed, permissions granted by policies change accordingly.
    * Sample:
        ```
        {
            "bindings": [ {
                "role": "roles/storage.objectAdmin",
                "members": [
                    "user:alice@example.com", "serviceAccount:my-other-app@appspot.gserviceaccount.com", "group:admins@example.com",
                    "domain:google.com" 
                ]
                }, 
                {
                    "role": "roles/storage.objectViewer",
                    "members": ["user:bob@example.com"] 
                }
            ]
        }
        
        ```
* [Cloud IAM Conditions](https://cloud.google.com/iam/docs/conditions-overview)
    * feature of IAM that allows you to specify and enforce conditional access controls based on the attributes of a resource
    * allows you to grant access to an identity when specified conditions are met
    * Conditions are defined in resources role bindings
    * expressed using the Common Expression Language (CEL)
    * GCP services that have resource types that support conditional role bindings are 
        * Bigtable
        * Cloud KMS
        * Cloud SQL
        * Cloud Storage (only for buckets that use uniform bucket-level access)
        * Compute Engine
        * Identity-Aware Proxy
        * Resource Manager
        * Secret Manager
    * Examples:
        * [Grant temporary access](https://cloud.google.com/iam/docs/configuring-temporary-access)
* [IAM Best practices](https://cloud.google.com/iam/docs/using-iam-securely)
    * Favor predefined roles over basic roles. Predefined roles are designed to provide all of the permissions needed for a user or service account to carry out a particular set of tasks. Use basic roles only for small teams that do not need granular permissions or in development and test environments where having broad groups of permissions can facilitate the use of the environment without introducing too much risk
    * When using predefined roles, assign the most restricted set of roles needed to do a job. For example, if a user only needs to list Cloud Pub/Sub topics, then grant pubsub.topics.list only.
    * Think in terms of trust boundaries, which set the scope of where roles and permissions should apply. For example, if you have three services in an application, consider having three trust boundaries—one for each service. You could use a different service account for each service and assign it just the roles it needs. 
    * Review the Cloud Audit Logs messages for changes to IAM policies. Also, limit access to audit logs using logging roles, such as roles/logging.viewer and roles/logging. privateLogViewer. Restrict access to roles/logging.admin, which gives all permis- sions related to logging.

* [Identity-Aware Proxy](https://cloud.google.com/iap/docs/concepts-overview)
    * application layer (layer 7)–based access control for applications accessed using HTTPS. 
    * allows you to define access control policies for applications and resources
    * Applications that use IAP provide access to users who have proper IAM roles. When IAP is enabled, an IAP authentication server receives information about the protected resource, the request URL, and any IAP credentials in the request. IAP checks browser credentials, and if they do not exist, the user is redirected to sign in using OAuth 2.0 Google Account authen- tication. The IAP server verifies the user is authorized to access the resource.
    * It is important to note that when using IAP, you will need to implement network controls to prevent traffic that does not come from the IAP serving infrastructure.
    * [IAP for On-Premises Apps](https://cloud.google.com/iap/docs/cloud-iap-for-on-prem-apps-overview) allows you to use IAP to protect applications that run outside of GCP.
        * uses the [IAP On-Premises Connector](https://cloud.google.com/iap/docs/enabling-on-prem-howto) which leverages a Cloud Deployment Manager template to create the resources needed to host and deploy the IAP On-Prem Connector into an IAP-enabled Google Cloud project, forwarding authenticated and authorized requests to on-premises apps.
    * [Using IAP for TCP forwarding](https://cloud.google.com/iap/docs/using-tcp-forwarding)
        * IAM Roles
            * roles/iap.tunnelResourceAccessor (IAP-secured Tunnel User)
            * roles/compute.instanceAdmin.v1 (SSH Access)
            * [OS Login](https://cloud.google.com/compute/docs/instances/managing-instance-access#configure_users)
            * roles/iam.serviceAccountUser (Service Account User)
    * Commands
        * `gcloud compute start-iap-tunnel`
        * `gcloud compute ssh INSTANCE_NAME --tunnel-through-iap` : always use IAP TCP
        * `gcloud compute ssh --internal-ip` : never uses IAP TCP tunnel and instead directly connects to the internal IP of the VM
    
* [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation)
    * allows you to use IAM to grant external identities IAM roles
    * organized into workload identity pools
    * Google recommends creating separate workload pools for each external environment that needs access to your GCP resources
    * depends on workload identity providers that manage the external identities. 
    * A range of identity providers are supported, including :
        * AWS, Azure Active Directory, on-premises Active Directory, Okta, and Kubernetes clusters.
    * implemented using SAML or OAuth 2.0 token exchange. 
        * The credentials associated with an identity include attributes that are mapped to equivalent attri- butes in a Google Cloud token. 
        * Attribute conditions defined using CEL are supported as well.
    * [Configure AWS Or Azure](https://cloud.google.com/iam/docs/workload-identity-federation-with-other-clouds)
    * allows for service account impersonation. 
        * allow for this, you would grant roles/iam.workloadIdentityUser on the service account with the roles needed to execute the target workload.
* [Organization Contraints](https://cloud.google.com/resource-manager/docs/organization-policy/org-policy-constraints)
    *  used limit what GCP users and service accounts can do by using organization policy constraints. 
    * A constraint is a rule that is applied to prevent some action or configuration choice from being made. 
    * This is useful when you want to implement policies across an organization. 
        * For example, if you want to prevent serial port access to a VM in Compute Engine, you can specify the constraints/compute.disableSerialPortAccess constraint.
* Data security
    * Key Management
        * [Default Encryption](https://cloud.google.com/docs/security/encryption/default-encryption)
        * [Cloud KMS](https://cloud.google.com/docs/security/key-management-deep-dive)
            * hosted key management service
            * used to store and generate keys
            * used when customers want control over key management but do not need keys to reside on their own key management infrastructure.
            * supports a variety of cryptographic keys, including AES256, RSA 2048, RSA 3072, RSA 4096, EC P256, and EC P384
            * provides functionality for automatically rotating keys and encrypting DEKs with KEKs.
            * keys can be destroyed, but there is a 24-hour delay before the key is destroyed in case someone accidentally deletes a key or in the event of a malicious act
            * allows users to import keys that are managed outside of Google.
        * [Cloud HSM](https://cloud.google.com/docs/security/cloud-hsm-architecture)
            * cloud-hosted Hardware Security Module (HSM)
            * provides support for using keys only on FIPS 140-2 level 3 hardware security modules (HSMs). 
            * FIPS 140-2 is a U.S. government security standard for cryptographic mod- ules. 
            * Level 3 requires tamper-evident physical security as well as protections to respond to attempts to tamper.
            * use the `--protection-level "hsm"` to signify that the key is using HSM backed storeg
            * [Create a key ring](https://cloud.google.com/kms/docs/hsm#create_a_key_ring)
            * [Create a key](https://cloud.google.com/kms/docs/hsm#create_a_key)
        * [Cloud External Key Manager (EKM)](https://cloud.google.com/kms/docs/ekm)
            * using your external keys that are managed within a [supported EKM](https://cloud.google.com/kms/docs/ekm#supported_partners).
            * allows customers to manage keys outside of Google Cloud and set up Cloud KMS to use those externally managed keys.
        * [Customer-Managed Encryption Keys (CMEK)](https://cloud.google.com/kms/docs/cmek)
            * keys that are managed by customers of Google Cloud using Cloud KMS. 
            * When using CMEKs, customers have more control over the key lifecycle. 
            * Customers using CMEKs can limit Google Cloud’s ability to decrypt data by disabling keys. 
            * In addition, customers can automatically or manually rotate keys when using CMEKs.
    * Encryption
        * process of encoding data in a way that yields a coded version of data that cannot be practically converted back to the original form without additional information such as a key
        * At Rest
            * At the platform level, database and file data is protected using AES256 and AES128 encryption.
            * At the infrastructure level, data is grouped into data chunks in the storage system, and each chunk is encrypted using AES256 encryption.
            * At the hardware level, storage devices apply AES256 in almost all cases, but as of July 2020, a small number of older persistent disks use AES128 encryption.
            * [Default Encryption](https://cloud.google.com/docs/security/encryption/default-encryption)
                * stores data in storage system it stores it in subfile chunks that can be up to several gigabytes in size
                * each chunk is encrypted with its own key known as a data encryption key (DEK)
                * if the chunk is updated a new key is used, keys are not used for more than one chunk
                * each chunk has unique id and referenced with ACLs which are stored in different locations
                * the dek is also encrypted using a second key, envelop encryption, 
                    * key encryption key (KEK)
        * [In Transit](https://cloud.google.com/docs/security/encryption-in-transit)
            * All traffic to Google Cloud services is encrypted by default. 
            * Traffic incoming from users to the Google Cloud is routed to the Google Front End, a globally distributed proxy service. The Google Front End terminates HTTP and HTTPS traffic and routes it over the Google network to servers running the application. The Google Front End provides other security services, such as protecting against distributed denial-of-service (DDoS) attacks. Google Front End also implements global load balancers.
            * Encryption Implemented in the Google Front End for Google Cloud Services and Implemented in the [BoringSSL Cryptographic Library](https://cloud.google.com/docs/security/encryption-in-transit#boringssl)
            * Google Cloud and the client negotiate how to encrypt data using either Transport Layer Security (TLS) or the Google developed protocol [QUIC](https://en.wikipedia.org/wiki/QUIC) (in the past, this term stood for Quick UDP Internet Connections, but now the name of the protocol is simply QUIC).
            * Within the Google Cloud infrastructure, Google uses Application Layer Transport Security (ALTS) for authentication and encryption. This is done at layer 7 of the OSI network model.
    * [Secret Manager](https://cloud.google.com/secret-manager/docs/overview)
        * allows you to store, manage, and access secrets as binary blobs or text strings. With the appropriate permissions, you can view the contents of the secret.
        * works well for storing configuration information such as database passwords, API keys, or TLS certificates needed by an application at runtime.
        * by default secrets are encrypted with Googe default encryption
        * can be configured to use CMEK: https://cloud.google.com/secret-manager/docs/cmek
            * only available for Secret Manager v1 API and gcloud
            * use `--kms-key-name [KEY_LOCATION]` when using `gcloud secrets create`
        * [Schedule secret rotation](https://cloud.google.com/secret-manager/docs/secret-rotation)

* [Certificate Authority Service](https://cloud.google.com/certificate-authority-service/docs/best-practices)

* Cloud Storage Data Access
    * use uniform or fine-grained access
    * uniform bucket-level access you use only IAM to manage permissions while fine-grained access enables the use of ACLs along with IAM. Google recommends using uniform access. 
    * ith uniform access, you can grant permissions at the bucket or project level.
    * use signed URLs to provide access to objects for a short period of time. Signed URLs are useful when you want to grant access to a small number of objects in a bucket that has otherwise limited access.
    * good practice to validate uploads and downloads to Cloud Storage using either cyclic redudancy check (CRC) CRC32C (Castagnoli) or MD5 checksums. 
    * CRC32C is the Google-recommended way to validate data because it supports composite objects, such as those created when you upload an object as multiple components loaded in parallel.
        * use the `gsutil hash` command to calculate a CRC for any local file
        * gsutil use [crcmod](https://pypi.python.org/pypi/crcmod), a python module
        * Setting up crcmod -> https://cloud.google.com/storage/docs/gsutil/addlhelp/CRC32CandInstallingcrcmod
### Separation of duties (SoD)
* practice of limiting the responsibilities of a single individual in order to prevent the person from successfully acting alone in a way detrimental to the organization. A simple example comes from finance

### Least Privilege
* practice of granting only the minimal set of permissions needed to perform a duty. 
* IAM roles and permissions are fine-grained and enable the practice of least privilege. 
* Consider, for example, roles associated with App Engine:
    * **roles/appengine.appAdmin** 
        * can read, write, and modify access to all application con- figuration and settings.
    * **roles/appengine.appViewer** has read-only access to all application configuration and settings.
roles/appengine.codeViewer has read-only access to all application configuration, settings, and deployed source code.
roles/appengine.deployer has read-only access to all application configuration and settings and has write access to create a new version but cannot modify existing versions other than deleting versions that are not receiving traffic.
roles/appengine.serviceAdmin has read-only access to all application configuration and settings and has write access to module-level and version-level settings but cannot deploy a new version.

    ●  Security controls (e.g., auditing, VPC Service Controls, context aware access, organization policy)

    ●  Managing customer-managed encryption keys with Cloud Key Management Service

    ●  Remote access

## 3.2 Designing for compliance. 
Considerations include:

### Legislation (e.g., health record privacy, children’s privacy, data privacy, and ownership)
* HIPAA/HITECH
    * federal law in the United States that protects individuals’ healthcare information. It was enacted in 1996 and updated in 2003 and 2005. HIPAA is a broad piece of legisla- tion, but from a security perspective, the most important parts are the HIPAA Privacy Rule and the HIPAA Security Rule.
    * HIPAA Privacy Rule 
        * a set of rules established to protect a patient’s healthcare information. It sets limits on data that can be shared by healthcare providers, insurers, and others with access to protected information. This rule also grants patients the right to review information in their records and request information. For further details on this rule, see the following:
            * www.hhs.gov/hipaa/for-professionals/privacy/index.html
    * HIPAA Security Rule 
        * defines standards for protecting electronic records containing personal healthcare information. 
        * rule requires organizations that hold electronic health- care data to ensure the confidentiality, integrity, and availability of healthcare information, protect against expected threats, and prevent unauthorized disclosures.
            * www.hhs.gov/hipaa/for-professionals/security/index.html
    * Health Information Technology for Economic and Clinical Health (HITECH) Act
        * enacted in 2009, and it includes rules governing the transmission of health information. HITECH extended the application of HIPAA to business associates of healthcare providers and insurers. Business associates that provide services to healthcare and insurance providers must follow HIPAA regulations as well
        *  www.hhs.gov/hipaa/for-professionals/special-topics/hitech-act-enforcement-interim-final-rule/index.html
    *  When using Google Cloud for data and processes covered by HIPAA, you should know that all of Google Cloud infrastructure is covered under Google’s Business Associate Agreement (BAA), and many GCP services are as well, including Compute Engine, App Engine, Kubernetes Engine, BigQuery, Cloud SQL, and many other products. For a complete list, see the following: cloud.google.com/security/compliance/hipaa
* General Data Protection Regulation
    *   gdpr-info.eu
    * urpose of this regulation is to standardize privacy protections across the European Union, grant controls to individuals over their private information, and specify security practices required for organi- zations holding the private information of EU citizens.
    * GDPR distinguishes controllers and processors. A controller is a person or organization that determines the purpose and means of processing personal data. A processor is a person or organization that processes data on behalf of a controller.
* Sarbanes-Oxley Act (SOX)
    * U.S. federal law passed in 2002 to protect the public from fraudulent accounting practices in publicly traded companies. The legislation includes rules governing financial reporting and information technology controls. SOX has three rules covering destruction and falsification of records, the retention period of records, and the types of records that must be kept.
    * Under SOX, public companies are required to implement controls to prevent tampering with financial data. Annual audits are required as well. This typically means that companies will need to implement encryption and key management to protect the confidentiality of data and access controls to protect the integrity of data.
    * For more information on Sarbanes-Oxley, see www.soxlaw.com. 
* Children’s Online Privacy Protection Act (COPPA)
    * www.ftc.gov/tips-advice/business-center/guidance/complying-coppa-frequently-asked-questions
    * U.S. federal law passed in 1998 that requires the U.S. Federal Trade Commission to define and enforce regulations regarding children’s online privacy. This legislation is pri- marily focused on children under the age of 13, and it applies to websites and online services that collect information about children.
    * The rules require online service operators to do the following:
        * Post clear and comprehensive privacy policies.
        * Provide direct notice to parents before collecting a child’s personal information.
        * Give parents a choice about how a child’s data is used.
        * Give parents access to data collected about a child.
        * Give parents the opportunity to block collection of a child’s data.
        * Keep a child’s data only so long as needed to fulfill the purpose for which it was created. In general maintain the confidentiality, integrity, and availability of collected data.

    ●  Commercial (e.g., sensitive data such as credit card information handling, personally identifiable information [PII])

    ●  Industry certifications (e.g., SOC 2)

### Audits (including logs)
* basically reviewing what has happened on your system
* Cloud Logging agent will collect logs for widely used services, including syslog, Jenkins, Memcached, MySQL, PostgreSQL, Redis, and ZooKeeper. For a full list of logs collected, see https://cloud.google.com/logging/docs/agent/default-logs
* Managed services, like Compute Engine, Cloud SQL, and App Engine, log information to Cloud Logging logs.
* [Cloud Audit Logs](https://cloud.google.com/logging/docs/audit)
    * service that records administrative actions and data operations
    * Administrative actions that modify configurations or metadata of resources are always logged by Cloud Audit Logs
    * Data access logs record information when data is created, modified, or read
        * Data Access audit logs—except for BigQuery—are disabled by default.
        * store in the _Default_ bucket unless routed elsewhere
    * Data access logs can generate large volumes of data so that it can be configured to collect information for select GCP services
    * System Event audit logs are generated by Google Cloud systems and record details of actions that modify resource configurations
    * Policy Denied audit logs record information related to when Google Cloud denies access to a user or service account because of a security policy
    * The logs are saved for a limited period of time. Often, regulations require that audit logs be retained for longer periods of time. 
        * Plan to export audit logs from Cloud Audit Logs and save them to Cloud Storage or BigQuery. 
        * They can also be written to Cloud Pub/Sub.
    * Logs are exported from Cloud Logging, which supports the following three export methods:
        * JSON files to GCS
        * Logging tables in BigQuery Datasets
        * JSON Messages to Cloud Pub.Sub
    * You can use lifecycle management policies in Cloud Storage to move logs to different storage tiers, such as Nearline and Coldline storage, or delete them when they reach a specified age.
    * Penetration testing and logging are two recommended practices for keeping your systems secure

# Section 4: Analyzing and optimizing technical and business processes

## 4.1 Analyzing and defining technical processes. 

### Software development life cycle (SDLC)
* SDLC
    * a series of steps that software engineers follow to create, deploy, and maintain complicated software systems. 
    * consists of seven phases
        1. Analysis
            * begins with requirements and understanding the problem
            * purpose of the analysis phase is to do the following:
                * Identify the scope of the problem to address
                    * requires a combination of domain knowledge about the problem area and software and sys- tems knowledge to understand how to frame a solution.
                * Evaluate options for solving the problem
                    * build vs buy (i.e COTS)
                * Assess the cost benefit of various options
                    * do return on investment (ROI) assessment to measure the value, or retunr, of making an investment in a change
        2. Design
            * map out in detail how the software will be structured and how key functions will be implemented. 
            * Broken down into two subphases:
                * HL Design Phase
                    * major subcomponents of a system are identified
                    * identify interfaces between components
                        * REST , GraphQL
                        * messaging system
                        * ingestion sytem
                * Detailed Design
                    * focuses on how to implement each of the subcomponents
                    * choosing Cloud components (i.e Cloud Pub/Sub, Cloud SQL)
                    * detailed defined data structures, networking, algorithms
                    * ORM, OOP designs decisions
                    * UI/UX activities are performed
        3. Development
            * engs create the software artificats that implement a system
                * app code, config files
                * persist code to source repos (Github)
        4. Testing
        5. Deployment
        6. Documentation
            * Developer Documentation
                * designed for developers/engineers
                * comments, technical design doc
            * Operations Documentation
                * instructions to be used by sys admins
                * ie. runbooks
            * User Documentation
                * how the application works and used
        7. Maintenance
            * process of keeping software running and up-to-date with business requirements.
            * alerting, logging, sre

### Continuous integration / continuous deployment
* Continuous Delivery (CD)
    * practice of releasing code soon after it is completed and after it passes all tests. CD is an automated process—there is usually no human in the loop
* Continous Integration (CI)
    * practice of incorporating new code into an established code base as soon as it is complete.
    * [Jenkins](https://www.jenkins.io/) is a widely used CI tool that builds and tests code. Jenkins supports plugins to add functionality, such as integration with a particular version control system or support for different programming languages.
        * [Jenkins on GCP](https://cloud.google.com/architecture/using-jenkins-for-distributed-builds-on-compute-engine)
    * [Cloud Build](https://cloud.google.com/build/docs/overview)
        * service that provides software building services, and it is integrated with other GCP services, such as Cloud Source Repository


### Troubleshooting / root cause analysis best practices
* Incidents
    * events that have a significant adverse impact on a service’s ability to function. An incident may occur when customers cannot perform a task, retrieve information, or oth- erwise use a system that should be available.
    * may have a narrow impact, such as just affecting internal teams that depend on a service, or they can have broad impact, such as affecting all customers. Incidents are not minor problems that adversely affect only a small group, for example, a single team of devel- opers. Incidents are service-level disruptions that impact multiple internal teams or external customers.
* Incident Management
    *  set of practices that is used to identify the cause of a disruption, determine a response, implement the corrective action, and record details about the incident and decisions made in real time.
    * incident management is to correct problems and restore services to customers or other system users as soon as possible. There should be less focus on why the problem occurred or identifying who is responsible than on solving the immediate problem.
* Post-Mortem Analysis
    * performed after an incident has been resolved
    * During a post-mortem meeting, engineers share information about the chain of events that led to the incident.
    * goal of a post-mortem analysis is to identify the causes of an incident, understand why it happened, and determine what can be done to prevent it from happening again. Post- mortems do not assign blame; this is important for fostering an atmosphere of trust and honesty needed to ensure that all relevant details are understood. Post-mortems are opportu- nities to learn from failures. It is important to document conclusions and decisions for future reference.

### Testing and validation of software and infrastructure
* Tests
    * Unit tests 
        * a test that checks the smallest unit of testable code.
        * are designed to find bugs within the smallest unit. 
    * Integration tests 
        * test a combination of units.
        * can happen at multiple levels, depending on the complexity of the appli- cations being tested
        * can check an API endpoint that calls another API that runs some business logic on a server, which in turn has to query a database.
    * Acceptance tests 
        * tests help developers ensure that their code is functioning as they expect and want
        * designed to assure business owners of the system that the code meets the business requirements of the system
    * Load testing
        * used to understand how a system will perform under a particular set of con- ditions. A load test creates workloads for the system
        * may find bugs that were not uncovered during integration testing
        * example: Under heavy loads, the database may not be able to respond to all queries within a reasonable period of time. In that case, the connection will time out.
        * especially important when a system may be subject to spiking workloads. 

### Service catalog and provisioning
* [Service Catalog](https://cloud.google.com/service-catalog/docs/overview)
    * enables developers and cloud admins to make their solutions discoverable to their own organization's internal enterprise users.
    * While making solutions discoverable, cloud admins can also control the distribution of solutions and ensure compliance and governance.
    * [Create a Catalog](https://cloud.google.com/service-catalog/docs/create-catalog)
        * requires the `roles/cloudprivatecatalogproducer.admin`
    * [Assign a solution from a catalog](https://cloud.google.com/service-catalog/docs/assign-solutions)

### Business continuity and disaster recovery
* Business Continuity
    * planning for keeping business operations functioning in the event of a large-scale natural or human-made disaster. 
    * To enable business operations to continue in spite of such events requires considerable planning. 
        * This includes defining the following:
            * Disaster plan
                * documents a strategy for responding to a disaster. It includes information such as where operations will be established, which services are the highest priority, what personnel are considered vital to recovery operations, and plans for dealing with insurance carriers and maintaining relationships with suppliers and customers.
            * Business impact analysis 
                * describes the possible outcomes of different levels of disaster. Minor disruptions, such as localized flooding, may shut down offices in a small area
                * Business impact analysis includes cost estimates as well.
            * Recovery plan
                * describes how services will be restored to normal operations. 
                *  Once key services, such as power and access to physical infrastructure, are restored, business can start to move operations back to their usual location. This may be done incrementally to ensure that physical infrastructure is functioning as expected.
            * Recovery time objectives
                * RTOs
                * included in the recovery plan
                * prioritize which services should be restored first and the time expected to restore them.
* Disaster Recovery
    * part of business continuity planning is planning for operations of information systems throughout, or despite the presence of, disasters
* Recovery Time Objective (RTO)
* Recovery Point Object (RPO)

## 4.2 Analyzing and defining business processes. 
Considerations include:

* Stakeholder management
    * Stakeholder 
        * is someone or some group with an interest in a business initiative
        * has an interest when the outcome of an initiative, like a software development project, may affect the stakeholder. When a stakeholder has influence, that stakeholder can help direct the outcomes of an initiative.
        * have varying degrees of interest
        * Interests come in several forms, such as the following:
            * Financial interests around costs and benefits of an initiative
            * Organizational interests, such as the priority in which projects will be funded and completed
            * Personnel interests that include assignment of engineers to a project and opportunities for career advancement
            * Functional interests, such as another team of engineers who want the new service to include some specific API functions
        * Influences, describe the stakeholder's ability to get what he wants
            * have varying degrees of influence
        * Stakeholders can have interest and influence at any level.
* Projects
    * an initiative focused on completing some organizational task
    * have budgets specifying the funding available for the project
    * have schedules that describe the expected time frame for completing the project
    * have resources
* Programs
    * may contain one or more projects or may be a seperate initiative
    * initiatives designed to achieve some business goal
* Portfolios
    * groups of projects and programs that collectively implement a business or org strategy
* Stages of [Stakeholder Management](www.apm.org.uk/body-of-knowledge/delivery/integrative-
management/stakeholder-management)
    * Architects often have influence over projects and portfolios because of their knowledge.
    * The four basic stages of stakeholder management are as follows:
        * Identifying stakeholders
        * Determining their roles and scope of interests 
        * Developing a communications plan 
        * Communicating with and influencing stakeholders

### Change Management
* https://deming.org/change-management-post-change-evaluation-and-action/
* https://cloud.google.com/architecture/devops/devops-process-streamlining-change-approval
* Digital Transformation
    * describe the widespread adoption of digital tech- nology to transform the way that companies create products and deliver value to cus- tomers. Digital transformation initiatives often adopt the use of web technologies, cloud computing, mobile devices, big data technologies, IoT, and artificial intelligence (AI).
    * digital transformations are more difficult to manage and less likely to succeed than other kinds of changes
    * common traits of successful digital transformation efforts included knowledgeable leaders, ability to build workforce capabilities, enabling new ways of working, and good communications.
* Methodologies
    * **Plan-Do-Study-Act**
        * developed by Walter Shewhart and later popularized W. Edwards Deming
        * includes four stages:
            * Plan
                * When a change experiment is developed, predictions are made, and various possible results are outlined
            * Do
                * When the experiment is carried out, and the results are collected
            * Study
                * When results are compared to predictions, and other learning opportunities are identified
            * Act 
                * When a decision is made about using the results of the experiment, for example, by changing a workflow or implementing a new standard
* Team assessment / skills readiness
    * Defining skills needed to execute programs and projects defined by organization strategy Identifying skill gaps on a team or in an organization
    * Working with managers to develop plans to develop skills of individual contributors Helping recruit and retain people with the skills needed by the team
    * Mentoring engineers and other professionals
    
    ●  Decision-making processes

* Customer success management
    * goal is to advance the goals of the business by helping customers derive value from the products and services their company provides
    * Four basic stages:
        * Customer acquisition
            * practice of engaging new customers
            * starts with identifying potential customers
                * broad sweep tactics, such as mining social networks for individuals with certain roles in companies
                * more targeted such as collecting contact infor from people who download white paper from your company website
        * Marketing and sales
        * Professional services
            * consulting services
        * Training and support

* Cost optimization 
    * Four main areas:
        * Resource planning 
            * first step
            * identifying projects and programs that require funding and prioritizing their needs
            * consider the time required to complete projects and the relative benefit of the project when planning for resources.
        * Cost estimating
            * once programs / projects have been prioritized start doing cost estimates of top priority initiatives
            * consider serveral types of costs including the following:
                *  Human resources costs, 
                    * including salary and benefits 
                * Infrastructure, 
                    * such as cloud computing and storage costs 
                * Operational costs, 
                    * such as supplies
                * Capital costs, 
                    * such as investments in new equipment
        * Cost budgeting
            * stage of cost management where decisions are made about how to allocate funds
            * Stakeholders may exercise their influence during budget discussions to promote their projects and programs. 
            * Ideally, the budgeting process results in a spending plan that maximizes the overall benefits to the organization
        * Cost control
            * final stage
            * when funds are expended
            * often have approval processes in place for projects to follow
            * 
* Resource optimization (capex / opex)
    * 

## 4.3 Developing procedures to ensure reliability of solutions in production (e.g., chaos engineering, penetration testing)

Links:
* https://cloud.google.com/architecture/framework/reliability
* https://sre.google/sre-book/part-I-introduction/

### Cloud Operations Suite
* https://cloud.google.com/stackdriver/docs
* formerly known as Stackdriver, a comprehensive set of services for collecting data on the state of applications and infrastructure. 
* ssupports three ways of collecting and receiving reliability information.
    * Monitoring with [Cloud Monitor](https://cloud.google.com/monitoring/docs/monitoring-overview)
        * practice of collecting measurements of key aspects of infrastructure and application performance.
        * examples include average CPU utilization over the past minute, number of bytes written to a nic
        * [Metrics](https://cloud.google.com/monitoring/api/v3/metrics)
            * particular pattern that includes a property of an entity, a time range, and a numeric value. 
            * GCP has defined metrics for a wide range of entities, including the following:
                * GCP services, such as BigQuery, Cloud Storage, and Compute Engine
                * Operating system and application metrics that are collected by Cloud Monitoring agents that run on VMs
                * Anthos metrics, which include Kubernetes and Istio metrics
                * AWS metrics that measure performance of Amazon Web Services resources, such as EC2 instances
                * External metrics including metrics defined in Prometheus, a popular open source moni- toring tool 
            * metrics are collected at regular intervals
            * can have labels associated with them. This is useful when querying or filtering resources that you are interested in monitoring.
        * [Time Series](https://cloud.google.com/monitoring/api/v3/metrics-details)
            * set of metrics recorded with a time stamp. Often, metrics are collected at a specific interval, such as every second or every minute. 
            * associated with a monitored entity
            * [Sample TimeSeries object](https://cloud.google.com/monitoring/api/v3/metrics-details#real-ts-example)
        * provides an [API for working with time-series metrics](https://cloud.google.com/monitoring/api/ref_v3/rest/v3/TimeSeries)
            * The API supports the following:
                * Retrieving time series in a project, based on metric name, resource properties, and other attributes
                * Grouping resources based on properties Listing group members
                * Listing metric descriptors
                * Listing monitored entities descriptors
        * Common ways of working with metrics are using dashboards and alerting.
            * Dashboards
                * visual displays of time series
                * customized by users to show data that helps monitor and meet service- level objectives or diagnose problems with a particular service.
                * especially useful for determining correlated failures 
        * Synthetic Monitoring
            * https://cloud.google.com/monitoring/uptime-checks/introduction
            * let you test the availability, consistency, and performance of your services, applications, web pages, and APIs. Synthetic monitors periodically issue simulated requests and then record whether those requests were successful, and they record additional data about the request such as the latency. You can be notified when a test fails by creating an alerting policy to monitor the test results.
    * [Alerting with Cloud Monitoring](https://cloud.google.com/monitoring/alerts)
        * process of monitoring metrics and sending notifications when some custom- defined conditions are met.
        * goal of alerting is to notify someone when there is an incident or condition that cannot be automatically remediated and that puts service-level objectives at risk.
        * [Policies](https://cloud.google.com/monitoring/alerts#types-of-policies)
            * are sets of conditions, notification specifications, and selection criteria for determining resources to monitor
        * Conditions
            * rules that determine when a resource is in an unhealthy state. Alerting users can determine what constitutes an unhealthy state for their resources. Determining what is healthy and what is unhealthy is not always well defined.
            * Finding the optimal threshold may take some experimentation
        * Notifications
            * may receive notifications for incidents that do not warrant your intervention, these are known as false alerts
    * [Logging with Cloud Logging](https://cloud.google.com/logging/docs/overview)
        * entralized log management service. Logs are collections of messages that describe events in a system. 
        * log messages are written only when a particular type of event occurs
        * provides the ability to store, search, analyze, and monitor log messages from a variety of applications and cloud resources.
        * an store logs from virtually any application or resource, including GCP resources, other cloud resources, or applications running on premises. The Cloud Logging API accepts log messages from any source.
        * logs can be easily exported to BigQuery for more structured SQL-based analysis or leverate [Log Analytics](https://cloud.google.com/logging/docs/analyze/query-and-view) for using SQL directly in Log Explorer
            * When using Log Analytics, your log data is stored in a data set that is managed by BigQuery
            * Log Analytics Sample Queries: https://cloud.google.com/logging/docs/analyze/examples
        * Logs can also be streamed to Cloud Pub/Sub if you would like to use third-party tools to perform near real-time operations on the log data.
* Open Source Observability Tools
    * [Prometheus](https://prometheus.io/)
        * monitoring tool that collects metrics data from targets, such as applications, by scrapping HTTP endpoints of target services. 
        * The Prometheus project is hosted by the Cloud Native Computing Foundation, which also hosts Kubernetes.
        * uses a multidimensional data model based on key-value pairs.
        * PromQL is the query language used in Prometheus.
        * includes a server for collecting metrics, client libraries for instrumenting applications and services, and an alert manager.
        * [Managed Service for Prometheus](https://cloud.google.com/stackdriver/docs/managed-prometheus)
            * managed service providing a Prometheusco mpatible monitoring stack
            * uses Google’s in-memory time-series database called [Monarch](https://research.google/pubs/pub50652/), which Google uses to monitor its services.
            * Systems Architecture: https://cloud.google.com/stackdriver/docs/managed-prometheus#gmp-system-overview
    * [Grafana](https://grafana.com/)
        *  open source visualization tool often used with Prometheus. 
        * Grafana queries data from existing data sources rather than importing data into a Grafana managed data store. 
        * Grafana can pull data from monitoring services, relational databases, and time-series databases, as well as other sources.
        * Available on the GCP marketplace: https://console.cloud.google.com/marketplace/details/grafana-public/grafana-cloud



### Service Level Indicators (SLIs)
* Measurement/indicator that defines how reliable a service is and is performing
* SLI = (good events/valid events) x 100%
* Examples
    * Serving Systems (Request/Response)
        * _Availability_: 
            * tells you the fraction of the time that a service is usable. It's often defined in terms of the fraction of well-formed requests that succeed, such as 99%.
        * _Latency_ :
            * tells you how quickly a certain percentage of requests can be fulfilled. It's often defined in terms of a percentile other than 50th, such as "99th percentile at 300 ms".
        * _Quality_: 
            * tells you how good a certain response is. The definition of quality is often service-specific, and indicates the extent to which the content of the response to a request varies from the ideal response content. The response quality could be binary (good or bad) or expressed on a scale from 0% to 100%.
    * Data Processing systems
        * _Coverage_ :
            * tells you the fraction of data that has been processed, such as 99.9%.
        * _Correctness_:
            * tells you the fraction of output data deemed to be correct, such as 99.99%.
        * _Freshness_:
            * tells you how fresh the source data or the aggregated output data is. Typically the more recently updated, the better, such as 20 minutes.
        * _Throughput_: 
            * tells you how much data is being processed, such as 500 MiB/sec or even 1000 requests per second (RPS).
    * Storage systems
        * _Durability_: 
            * tells you how likely the data written to the system can be retrieved in the future, such as 99.9999%. Any permanent data loss incident reduces the durability metric.
        * _Throughput_ and _latency_ are also common SLIs for storage systems.
    

### Service Level Objectives (SLOs)
* Measure that describes when a service is reliable enough to meet user needs
* can also align development and operations teams around a single agreed-to objective, which can alleviate the natural tension that exists between their objectives—creating and iterating products (development) and maintaining system integrity (operations).
* Reliability Target
    * a target level of reliability for the service’s customers
    * Above this threshold, almost all users should be happy with your service (assuming they are otherwise happy with the utility of the service)
    * Below this threshold, users are likely to start complaining or to stop using the service
    * 100% reliability is the WRONG target
        * If your SLO is aligned with customer satisfaction, 100% is not a reasonable goal. Even with redundant components, automated health checking, and fast failover, there is a nonzero probability that one or more components will fail simultaneously, resulting in less than 100% availability.
        * Even if you could achieve 100% reliability within your system, your customers would not experience 100% reliability. The chain of systems between you and your customers is often long and complex, and any of these components can fail.3 This also means that as you go from 99% to 99.9% to 99.99% reliability, each extra nine comes at an increased cost, but the marginal utility to your customers steadily approaches zero.
        * If you do manage to create an experience that is 100% reliable for your customers, and want to maintain that level of reliability, you can never update or improve your service. The number one source of outages is change: pushing new features, applying security patches, deploying new hardware, and scaling up to meet customer demand will impact that 100% target. Sooner or later, your service will stagnate and your customers will go elsewhere, which is not great for anyone’s bottom line.
        * An SLO of 100% means you only have time to be reactive. You literally cannot do anything other than react to < 100% availability, which is guaranteed to happen. Reliability of 100% is not an engineering culture SLO—it’s an operations team SLO.
* Error Budget
    * The error budget for an SLO represents the total amount of time that a service can be noncompliant before it is in violation of its SLO. Thus, an error budget is 100% - SLO%
    * For example, if you have a rolling 30-day availability SLO with a 99.99% compliance target, your error budget is 0.01% of 30 days: just over 4 minutes of allowed downtime each 30 days. A service required to meet a 100% SLO has no error budget.



### Penetration Testing
* process of simulating an attack on an information system to gain insights into potential vulnerabilities
* Penetration tests are authorized by system owners.
    * In some cases, penetration testers know something about the structure of the network, servers, and applications being tested. In other cases, testers start without detailed knowledge of the system that they are probing.
* Penetration testing occurs in these five phases.
    * Reconnaissance
        * phase at which penetration testers gather information about the target system and the people who operate it or have access to it. This could include phishing attacks that lure a user into disclosing their login credentials or details of soft- ware running on their network equipment and servers.
    * Scanning
        * automated process of probing ports and checking for known and unpatched vulnerabilities.
    * Gaining access 
        * is the phase at which the attackers exploit the information gathered in the first two phases to access the target system.
    * Maintaining access 
        * phase where attackers will do things to hide their presence, such as manipulating logs or preventing attacking processes from appearing in a list of processes running on a server.
    * Removing footprints
        * the final phase, involves eliminating indications that the attackers have been in the system. This can entail manipulating audit logs and deleting data and code used in the attack.

* During a penetration test, testers will document how they gathered and exploited information, what if any vulnerabilities they exploited, and how they removed indications that they were in the system.
* You do not have to notify Google when conducting a penetration test, but you must still comply with the terms of service for GCP.
* You can find details on how to perform penetration testing at the Highly Adaptive Cybersecurity Services site at www.gsa.gov/technology/technology-products-services/it-security/highly-adaptive-cybersecurity-services-hacs, at the Penetration Testing Execution Standard organization at www.pentest-standard.org/index.php/Main_Page, and at the Open Web Application Security Project at owasp.org/www-project-penetration-testing-kit.


# Section 5: Managing implementation

## 5.1 Advising development/operation teams to ensure successful deployment of the solution. 
Considerations include:

### Application development
* Application Development Methodologies
    * principles for organizing and managing software development projects
    * Methodologies provide a set of practices that developers and stakeholders follow in order to produce operational software
    * follows one of three paradigms or models
        * Waterfall 
            * oldest
            * once you complete a phase, there is no going back, much like going over a waterfall
            * waterfall methodologies should reduce the risk of investing time in developing code that will not be used or having to redesign a component because a requirement was missed.
            * do not work well in situations where requirements cannot be completely known in the early stages or when requirements may change. Requirements may change for business reasons
                * One way to allow for changes in requirements and design phases is to revisit these stages multiple times over the course of a development project.
            * phases
               * Requirements 
               * Design
               * Implementation 
               * Testing and verification 
               * Maintenance 
        * Spiral
            * drop the strict requirement of not returning to an earlier stage in the process
            * use similar phases to waterfall methodologies, but instead of trying to complete each stage for the entire application, spiral approaches work on only a limited set of functionalities at a time
            * After all the stages have been completed for one set of functionalities, stakeholders determine what to work on next, and the process begins again.
            * Spiral models are designed to reduce risk in application development.
            * This is done by specifying what should be done in each cycle including:
                * Understanding stakeholders’ objectives
                * Reviewing product and process alternatives 
                * Identifying risks and how to mitigate them
                * Securing stakeholder commitment to the next iteration
            * advantage of spiral approaches is that you can learn things in each iteration that can be applied in later iterations.
            * adaptive
        * [Agile](https://agilemanifesto.org/)
            * most commonly being used for software development
            * distinguished by their focus on close collaboration between developers and stake- holders and on frequent code deployments
            * advocates for agile methods summarized the principles of agile as follows:
                * Individuals and interactions over processes and tools 
                * Working software over comprehensive documentation 
                * Customer collaboration over contract negotiation 
                * Responding to change over following a plan
            * iterative approach with shorter cycles called sprints
                * focus on smaller deliverables
                * each iteration includes
                    * Planning, design, development, testing, and deployment
            * focus on quality
                * includes meeting business requirements and producing functional, maintainable code
            * testing is part of the dev stage and not limited to post-development like in waterfall
            * transparant process, close collab between devs and stackholders
            * well suited to projects that must adapt to changing business and technical requirements
            * [Extreme Programming](https://en.wikipedia.org/wiki/Extreme_programming)
                * type of agile process that advocates frequent releases in short dev cycles
                * intended to improve productivity and introduce checkpoints at which new customer requirements can be adopted.
                * includes pair programming
* Technical Debt
    * describe the process of making expedient choices to meet an objective, like releasing code by a particular date
    * Application development involves trade-offs
    * developers may have to choose a design or coding method that can be implemented quickly but is not the option they would have chosen if they had more time
    * Ideally, technical debt is paid down by refactoring code and imple- menting a better solution
    * Projects incur technical debt for many reasons, including the following: 
        * Insufficient understanding of requirements
        * Need to deliver some functional code by a set time or within a fixed budget 
        * Poor collaboration between teams developing in parallel
        * Lack of coding standards
        * Insufficient testing
    * not necessarily a negative factor
    * can enable a project to move forward and realize more benefit than if the team had not incurred the technical debt
    * several forms
        * Architecture design debt
            * incurred when an architecture design choice is made for expedience but will require rework later
        * Environmental debt
            * occurs when expedient choices are made around tooling

* API best practices
    * [GCP API Design Guide](https://cloud.google.com/apis/design)
    * APIs provide programmatic access to services
    * often REST APIs or RPC APIs
    * REST APIs are resource oriented and use HTTP
    * RPC APIs tend to be oriented around functions implmented using sockets and designed for high efficiency
    * Google Recommned API design practices:
        * Resources and Standard Methods
            * APIs should be designed around resources and operations that can be performed on those resources.
            * four commonly used HTTP methods
                * GET, POST, PUT, DELETE
            * Standard methods for REST Google APIs (also known as REST methods) 
                * are List, Get, Create, Update, and Delete. 
            * Custom methods (also known as custom verbs or custom operations) are also available to API designers for functionality that doesn't easily map to one of the standard methods, such as database transactions.
            * Resources may be: 
                * Simple Resources 
                    * consists of a single entity
                * Collections
                    * list of resources of the same type
                    * often suppot pagination, sort ordering, and filtering
            * named using a hierachial model
                * example: api.com/contacts/{contactID}/profile
                * note that a resource name is not the SAME as the REST URL
            * REST URL should include and API version number:
                * xample: api.com/v2/contacts/{contactID}/profile
            * Standard HTTP error codes:
                * 400: 
                    * Bad request (for example, the call contained an invalid argument) 401: Request not authenticated
                * 403: Permission denied
                * 404: Resource not found
                * 500: Unknown server error
                * 501: Method not implemented by the API 503: Server unavailable
            * Additional detail about the error can be provided in the message payload
                * restricting the text of the message to the stan- dard text. Providing more information could be a security risk.
                * keep it brief
            * APIs should be versioned to improve the stability and reliability of APIs
        * [API Security](https://owasp.org/www-project-api-security/)
            * enforce controls to protect the confidentiality and integrity of data and the availability of services
            * favor HTTPS over HTTP to protect Confidentiality and integrety and protects data in transit
        * Authentication
            * API functions execute operations on behalf of an entity with an identity
            * require an API key
        * Authorization
            * [JSON Web Tokens (JWT)](https://en.wikipedia.org/wiki/JSON_Web_Token) are commonly used for authorizing when making API calls
            * When users log into services, they can receive a JWT, which they then pass to subsequent API calls
            * JWT contains claims about the subject of the token and what the subject of the token is allowed to do 
            * JWTs are digitally signed and can be encrypted
            * JWT JSON structure
                * Header
                    * contain a type attribute indicating that the token is a JWT type of token and the algorithm used to sign the token.
                * Payload
                    * set of claims
                    * Claims make statements about the issuer, subject, or token.
                    * may include commonly used claims such as an expiration time or the name of the subject. 
                    * may also include private claims that are known to the parties that agree to use them. 
                    * might include application-specific claims, such as a permission to query a specific type of data.
                * Signature
                    * the output of the signature algorithm generated using the header, the payload, and a secret.
                    * Before using the claims in the payload, a service should validate the signa- ture. If the signature is valid, it proves that the signer knows the secret and that the JWT has not been altered since it was signed.
            * JWT is encoded in three Base64-encoded strings seperated by periods.
        * Resource Limiting
            * set a maximum threshold for using a service for a given period of time
            * control resource usage is by rate limiting
            * Sometimes limits are set on the overall number of requests without regard to individual users.
                * These limits are higher than the limits that apply to individual users.
            * When one of these limits is exceeded, the response should have status code 429 (Too Many Requests).   
                * Responding to excessive requests in this way is called throttling
* Testing frameworks (load/unit/integration)
    * Data-driven testing 
        * uses structured data sets to drive testing
        * Tests are defined using a set of conditions or input values and expected output values
        * A test is executed by reading the test data source; then, for each condition or set of inputs, the tested function is executed, and the output is compared to the expected value
        * appropriate for testing APIs or functions executed from a command line
    * Modularity-driven testing 
        * uses small scripts designed to test a limited set of functionalities and combined to test higher-order abstractions
        * 
    * Keyword-driven testing 
        * separates test data from instructions for running a test.
        * Each test is identified using a keyword or key term. 
        * A test is defined as a sequence of steps to execute.
        * data for each test is stored in another document or data source.
        * well suited to manual testing, especially for testing graphical user interfaces. Keyword test frameworks can also be automated.
    * Model-based testing
        * instead of having a person generate test data, a simulation program is used to generate it
        * the simulator is built in parallel with the system under test
        * uses several methods to simulate the system being tested, including describing the expected system behavior in a finite state machine model or defining logical predicates that describe the system.
    * Test-driven development 
        * incorporates testing into the development process
        * equirements are mapped to tests
        * tests are usually specific and narrowly scoped
        * encourages developing small amounts of code and frequent testing
        * Once a piece of code passes its tests, it can be integrated into the baseline of code
    * Hybrid testing
        * testing framework that incorporates two or more distinct frameworks.
* Automated Testing Tools
    * Developing unit tests can be done with language-specific tools
        * [pytest](https://docs.pytest.org/en/latest/)
            * Python testing framework
        * [JUnit](https://junit.org/junit5/)
            * JAVA testing framework
        * [Selenium](https://www.seleniumhq.org/)
            * a widely used open source browser automation tool that can be used as part of testing. 
            * The Selenium WebDriver API enables tests to function as if a user were interacting with a browser. * Selenium scripts can be written in a programming language or by using the Selenium IDE.
        * [Katalong Studio](https://www.katalon.com/)
            * open source, interactive testing platform that builds on Selenium. It can be used to test web-based and mobile applications and APIs.
    * [Fuzzing](https://owasp.org/www-community/Fuzzing)
        * method of subjecting a program to semi-random inputs for an extended period of time, it can be used to find bugs and security vulnerabilities that would otherwise turn up only at runtime.
        * tools that do fuzzing are called fuzzers

## Data and system migration and management tooling
* Data and system migration tools support the transition from on-premises or other clouds to GCP cloud-based infrastructure
* Types of Migrations
    * Lift and Shift
        * (also known as re-hosting) projects, infrastructure and data are moved from an on-premises data center to the cloud with minimal changes
        * should perform an inventory of all applications, data sources, and infrastructure.
        * Identify dependencies between applications because that will influence the order in which you migrate applications to the cloud. You should also review software license agreements.
        * Variations on these migration strategies include 4 Rs
            * Replatforming
                * strategy to follow when you don’t want to make any changes to an application, but the platform it runs on is not available in the cloud
            * Repurchasing
                * an alternative to rebuild in the cloud
            * Retirement
                * technically not a migration strategy but should be considered when there are applications that do similar things. In such a case, retiring one and migrating the other can be a good strategy.
            * Retaining
                * usually required when there is an old application and no one knows exactly what it does and lift-and-shift is not an option.
    * Move and improve
        * nfrastructure and architecture are modified to take advantage of cloud infrastructure, for example, moving to containers managed by Kubernetes Engine.
    * Rebuild in the cloud
        * also known as rip and replace, a legacy application is replaced by a new, native cloud application.
* need a detailed plan identifying what systems will change, how those changes will impact other systems, and the order in which systems will be migrated and modified. If the migration will have any impact on the user experience, training should be included in the plan.
* Migrations typically require transfer of large volumes of data and how we do it is determined by a number of factors
    * Volume of data
    * Network Bandwidth
        * transferring 1 GB of data over a 100 Gbps network will take about 0.1 seconds
        * on a 1 Mbps network, that same data transfer will take about three hours
        * one petabyte of data will require 30 hours over a 100 Gbps network and more than 120 days over a 1 Gbps network
        * Network data transfer time: 
            * https://cloud.google.com/architecture/migration-to-google-cloud-transferring-your-large-datasets#time
    * Workflow time constraints on data transfer
    * Location of data
* Migration Services and Tools
    * [Storage Transfer Service](https://cloud.google.com/storage-transfer/docs/overview)
        * allows for the transfer of data from an HTTP/S location, an AWS S3 bucket, Azure Blob Storage or Data Lake Storage Gen2 or a Cloud Storage bucket
        * data is always transferred to a Cloud Storage bucket
        * Transfer operations are defined using [transfer jobs](https://cloud.google.com/storage-transfer/docs/create-transfers) that run in the Google Cloud
            * depending on the source/destination you may need to create and configure an agent pool and install agents on a machine with access to your source or destination.
                * Transfers from Amazon S3, Microsoft Azure, URL lists, or Cloud Storage to Cloud Storage do not require agents and agent pools.
                * Transfers whose source and/or destination is a file system, or from S3-compatible storage, do require agents and agent pools. See [Manage agent pools](https://cloud.google.com/storage-transfer/docs/on-prem-agent-pools) for instructions.
            * gcloud transfer jobs create|updated
        * recommended way for transfering data from AWS or other cloud providers to Google Cloud
    * [gsutil command-line utility](https://cloud.google.com/storage/docs/gsutil)
        * recommended way to transfer data from on-premises to Google Cloud
            * Considerations --> https://cloud.google.com/storage-transfer/docs/transfer-options#move_data_between_buckets
                * use when volumn of data is less than 1 TB from on-premise or another cloud
        * Consider compressing and de-duplicating data before transferring data to save time on the transfer operation. 
            * Compressing data is CPU intensive, so there is a trade-off between reducing transfer time and incurring additional CPU load.
        * multithreaded, which improves performance when transferring a large number of files
        * supports parallel loading of chunks or subsets of data in large files. The chunks are reassembled at the destination
        * supports restarts after failures
        * can tune gsutil transfers with command-line parameters specifying the number of processes, number of threads per process, and other options
        * Cloud SDK includes a new CLI, gcloud storage, that can be considerably faster than gsutil when performing uploads and downloads with less parameter tweaking.
            * has a syntax and command structure that is familiar to gsutil users but is fundamentally different in many important ways. To ease transition to this new CLI, gsutil provides a shim that translates your gsutil commands to gcloud storage commands if an equivalent exists, and falls back to gsutil's usual behavior if an equivalent does not exist.
            * To enable Set the `use_gcloud_storage=True` in the .boto config file under the `[GSUtil]`
            * you can also set the flag for invidual commands using the top level -o flag
                * `gsutil -o "GSUtil:use_gcloud_storage=True" -m cp -p file gs://bucket/obj`
            * [Available Commands](https://cloud.google.com/storage/docs/gsutil/addlhelp/ShimforRunninggcloudstorage#available-commands)
        * [Boto configuration file](https://cloud.google.com/storage/docs/boto-gsutil)
            * contains values that control how gsutil behaves
        * For small data sets you can use gsutil rsync. 
            * Use gsutil rsync to transfer data between Cloud Storage and other cloud storage providers, or between Cloud Storage and your file system data.
    * Third-party vendors
        * Zadara, Iron Mountain, and Prime Focus Technologies
    * [Database Migration Serivce](https://cloud.google.com/database-migration/docs/overview)
        * used to migrate MySQL and PostgreSQL databases from on-premises or in Compute Engine, or other clouds to Cloud SQL. Support for SQL Server migrations is expected soon. The service supports continuous change data capture, so it provides for minimal downtime.
        * Support Databases
            * MySQL
                * Source
                    * Amazon RDS (5.6,5.7,8.0)
                    * Self-managed (5.5,5.6,5.7,8.0)
                    * Cloud SQL (5.6,5.7,8.0)
                    * Amazone Aurora (5.6,5.7,8.0)
                * Destination
                    * Cloud SQL for MySQL (5.6,5.7,8.0)
            * PostgreSQL
                * Source
                    * Amazon RDS 9.6.10+, 10.5+, 11.1+, 12, 13, 14
                    * Amazon Aurora 10.11+, 11.6+, 12.4+, 13.3+, 14.6+, 15.2
                    * Self-managed PostgreSQL (on premises or on any cloud VM that you fully control) 
                        * 9.4, 9.5, 9.6, 10, 11, 12, 13, 14, 15
                    * Cloud SQL for PostgreSQL 9.6, 10, 11, 12, 13, 14, 15
                * Destination 
                    * Cloud SQL for PostgreSQL 9.6, 10, 11, 12, 13, 14, 15
            * Oracle to PostgreSQL
                * Source
                    * Oracle 11g, Version 11.2.0.4
                    * Oracle 12c, Version 12.1.0.2
                    * Oracle 12c, Version 12.2.0.1
                    * Oracle 18c
                    * Oracle 19c
                    * Oracle 21c
                * Destination
                    * Cloud SQL for PostgreSQL 12, 13, 14
            * PostgreSQL to AlloyDB
                * Source
                    * Amazon RDS 9.6.10+, 10.5+, 11.1+, 12, 13, 14
                    * Amazon Aurora 10.11+, 11.6+, 12.4+, 13.3+, 14
                    * Self-managed PostgreSQL (on premises or on any cloud VM that you fully control) 
                        * 9.4, 9.5, 9.6, 10, 11, 12, 13, 14
                    * Cloud SQL 9.6, 10, 11, 12, 13, 14
        * Quickstarts
            * [MySQL](https://cloud.google.com/database-migration/docs/mysql/quickstart)
            * [PostgreSQL](https://cloud.google.com/database-migration/docs/postgres/quickstart)
            * [Oracle to PostgreSQL](https://cloud.google.com/database-migration/docs/oracle-to-postgresql/quickstart)
            * [PostgreSQL to AlloyDB](https://cloud.google.com/database-migration/docs/postgresql-to-alloydb/quickstart)
    * [Google Transfer Appliance](https://cloud.google.com/transfer-appliance/docs/4.0/procedure-guide)
        * use if large volumes of data will be transferred and a transfer over the network would take too long 
        * a high-capacity storage device that is shipped to your site. 
            * Currently, 40 TB (TA40) and 300 TB (TA400) appliances are available
        * appliance is installed on your network, and data is transferred to the storage unit, which is then shipped back to Google. 
            * After Google receives the storage unit, it will make the unit accessible to you so that you can log in to the console and transfer the data to a Cloud Storage bucket.
        * Review that your data meets the following criteria:
            * Individual files are less than 5 terabytes (TB) in size.
            * File names follow object naming guidelines.
            * Files are regular files or Unix-style hidden files. 
                Unix-style hidden files start with a `.` character.
            * Folders contain files. 
                * Empty folders are not created in Cloud Storage, because objects don't reside within subdirectories within a Cloud Storage bucket.
            * The maximum path length is 1024 bytes, which includes the optional object prefix specified when you provide Transfer Appliance Team with bucket configuration details.

## 5.2 Interacting with Google Cloud programmatically. 

### REST API

### Terraform
* https://cloud.google.com/docs/terraform
* https://cloud.google.com/docs/terraform/best-practices-for-terraform
* https://cloud.google.com/docs/terraform/blueprints/terraform-blueprints

## Google Cloud Shell
* a managed service that provides an online development environment with the features of a Linux shell along with pre-installed tools such as the Google Cloud SDK and kubectl. 
* The service also includes a Cloud Shell Editor.
* Cloud Shell can be accessed from a web browser and provides 5 GB of persistent storage.

### Google Cloud SDK (gcloud, gsutil and bq)
**gcloud**
* Install 
    * https://cloud.google.com/sdk/docs/install
* Client libraries
    * https://cloud.google.com/apis/docs/cloud-client-libraries
* Initialization
    * `gcloud init`
    * use the `--no-launch-browser` flag to prevent the command from launching a browser-based authentication flow (if needed)
    * use the `--console-only` flag if you're running the command on a remote system using **ssh** and do not have access to a browser on that system. You must then manually open the provided URL in a browser on your local system to complete the authorization process.
* Authentication
    * `gcloud auth login` --> authorizes the user account only
        * use the `--no-browser` flag if your machine doesnt have a brower
        * `--cred-file=CONFIG_FILE | KEY_FILE` for service account authentication using either [workload identity credential configuration file](https://cloud.google.com/iam/docs/using-workload-identity-federation#generate-automatic) or a service account key file
* Configuring gcloud behind a proxy firewall
    * https://cloud.google.com/sdk/docs/proxy-settings
* Configuration
    * `gcloud config configurations create [NAME]`
    * `glcoud config configurations activate [NAME]`
    * `gcloud config set project PROJECT_ID`
    * `gcloud config set compute/zone us-east1-b`
    * `gcloud config configurations list`
* gcloud Cheat Sheet
    * https://cloud.google.com/sdk/docs/cheatsheet
* In addition to accessing the SDK from the command line, you can also use client libraries developed for several languages, including Java, Python, Ruby, PHP, C#, Node.js, and Go.

**bq**
* comes in Cloud SDK 
* A command-line tool for working with BigQuery
* https://cloud.google.com/bigquery/docs/bq-command-line-tool
* CLI Reference: https://cloud.google.com/bigquery/docs/reference/bq-cli-reference

**cbt**
* A command-line tool for Bigtable (Note: The current versions of gcloud include a gcloud bigtable component.)
* https://cloud.google.com/bigtable/docs/cbt-overview
* CLI reference: https://cloud.google.com/bigtable/docs/cbt-reference

**kubectl**
* a command line tool for interacting with and managing kubernets clusters
* cli reference: https://kubernetes.io/docs/reference/kubectl/
* kubectl cheatsheet: https://kubernetes.io/docs/reference/kubectl/cheatsheet/


### Cloud Emulators (e.g. Cloud Bigtable, Datastore, Spanner, Pub/Sub, Firestore)
Emulators are extremely useful for local or offline development because they allow you to test code without affecting data in your cloud environment. There are currently four emulators available in the Google Cloud SDK: BigTable, Datastore, Firestore, Cloud Pub/Sub, and Cloud Spanner

**GA Cloud SDK**

_**Firestore**
* https://cloud.google.com/firestore/docs/emulator
Starts the emulator:
* `glcoud emulators firestore start` 
Bind to specific host/port and run:
* `gcloud emulators firestore start --host-port=0.0.0.0:8080`
Run emulator with a Firebare Rule:
* `gcloud emulators firestore start --rules=firestore.rules`
* [Firestore Security Rules](https://firebase.google.com/docs/rules/rules-language)
    * Firebase Security Rules work by matching a pattern against database paths, and then applying custom conditions to allow access to data at those paths. All Rules across Firebase products have a path-matching component and a conditional statement allowing read or write access. You must define Rules for each Firebase product you use in your app.

**Spanner**
* https://cloud.google.com/spanner/docs/emulator
Starts local emulator
* `gcloud emulators spanner start`
Prints the env variables exports for a Spanner emulator
* `gcloud emulators spanner env-init`
Using docker to run the emulator
* `docker pull gcr.io/cloud-spanner-emulator/emulator`
* `docker run -p 9010:9010 -p 9020:9020 gcr.io/cloud-spanner-emulator/emulator`
Create a configuration to easily switch between live and emulation
```
gcloud config configurations create emulator
gcloud config set auth/disable_credentials true
gcloud config set project your-project-id
gcloud config set api_endpoint_overrides/spanner http://localhost:9020/
```
Once configured, your gcloud commands will be sent to the emulator instead of the production service. You can verify this by creating an instance with the emulator's instance config:

```
gcloud spanner instances create test-instance \
   --config=emulator-config --description="Test Instance" --nodes=1
```

To switch between the emulator and a default configuration:
* `gcloud config configurations activate [emulator | default]`

**Cloud BigTable**
* https://cloud.google.com/bigtable/docs/emulator
Start the emulator
* `gcloud beta emulators bigtable start`
Start and map to host / port
* `gcloud beta emulators bigtable start --host-port=[HOST]:[PORT]`
Docker option
`docker run -p 127.0.0.1:8086:8086 --rm -ti google/cloud-sdk gcloud beta emulators bigtable start --host-port=0.0.0.0:8086`

**Cloud Pub/Sub**
* https://cloud.google.com/pubsub/docs/emulator
Starting the emulator
* `gcloud beta emulators pubsub start --project=PUBSUB_PROJECT_ID [options]`
Manually editing the environment variables
* `gcloud beta emulators pubsub env-init`
* The emulator supports the following Pub/Sub features:
    * Publishing messages
    * Receiving messages from push and pull subscriptions
    * Ordering messages
    * Replaying messages
    * Forwarding messages to dead-letter topics
    * Retry policies on message delivery
    * Schema support for Avro
* Known limitations
    * UpdateTopic and UpdateSnapshot RPCs are not supported.
    * IAM operations are not supported.
    * Configurable message retention is not supported; all messages are retained indefinitely.
    * Subscription expiration is not supported. Subscriptions don't expire.
    * Filtering is not supported.
    * Schema support for protocol buffers.
    * BigQuery subscriptions can be created, but don't send messages to BigQuery.

# Section 6: Ensuring solution and operations reliability
* [System Reliability Engineering](https://sre.google/)
    * Overload
        * service designers cannot control is the load that users may want to place on a system at any time
        * good practice to assume that, at some point, your services will have more workload coming in than they can process.
        * responding to overload is the criticality of an operation.
        * Writing a message to an audit log, for example, may be more important from a business perspective than responding to a user query within a few seconds. For each of the following overload responses, be sure to take criticality into account when applying these methods.
    * Shedding Load
        * simplest ways to respond to overload is to shed or drop data that exceeds the system’s capacity to deal with it.
        * variation on this approach is to categorize each type of operation or request that can be placed on a service according to criticality.
            * service can then implement a shedding mechanism that drops lower criticality requests first for some period of time
        * consider service-level agreements with various users
    * Degrading Quality of Service
        * Depending on the nature of a service, it may be possible to provide partial or approximate results
        * For example, a service that runs a distributed query over multiple servers may return only the results from some of the servers instead of waiting for servers that are taking too long to respond. 
            * This is a common strategy for web search.
        * a service could use a sample of data rather than the entire population of data points to estimate the answer to a query.
        * advantage of responding to overload with a degraded service is that the service pro- vides results rather than errors. 
    * Upstream Throttling
        * having a service shed load or return approximate results, a calling service can slow down the rate at which it makes requests.
        * requires planning on the part of software engineers, who must have a mechanism to hold requests.
        * upstream throttling is to use the Circuit Breaker pattern
            * design pattern uses an object that monitors the results of a function or service call.
            * If the number of errors increases beyond a threshold, then the service stops making additional requests. This is known as tripping the circuit breaker. Since the calling service stops send- ing new requests, the downstream service may be able to clear any backlog of work without having to contend with additional incoming requests.
    * Cascading Failures
        * occur when a failure in one part of a distributed system causes a failure in another part of the system, which in turn causes another failure in some other service, and so on. For example, if a server in a cluster fails, additional load will be routed to other servers in the cluster. This could cause one of those servers to fail, which in turn will further increase the load on the remaining healthy servers.
        * often caused by resource exhaustion
        * use the Circuit Breaker design pattern or degrade the quality of service
        * there is a risk of a cascading failure, the best one can hope for may be to contain the number and range of errors returned while services under stress recover.
            * to reduce risk --> load test services and autoscale resources
    * Testing for Reliabiliy
        * Unit tests
        * Integration tests 
        * System tests 
            * include all integrated components and test whether an entire system functions as expected. 
            * These usually start with simple “sanity checks” that determine whether all of the components function under the simplest conditions.
        * Performance Tests
            * additional load is placed on the system 
            * should uncover any problems with meeting expected workloads when the system is released to production
        * Regression Tests
            * designed to ensure that bugs that have been corrected in the past are not reintroduced to the system at a later time. Developers should create tests that check for specific bugs and execute each of those during testing.
        * Reliability stress tests
            * place increasingly heavy load on a system until it breaks. The goal of these tests is to understand when a system will fail and how it will fail
            * are useful for understanding cascading failures through a system
            * Another form of stress testing uses chaos engineering tools such as Simian Army, which is a set of tools developed by Netflix to introduce failures randomly into functioning systems in order to study the impact of those failures. This is an example of the practice of chaos engineering. 
                * For more on Simian Army see https://medium.com/netflix-techblog/the-netflix-simian-army-16e57fbab116.


## 6.1 Monitoring/logging/profiling/alerting solution


## 6.2 Deployment and release management
* Release Management
    * practice of deploying code and configuration changes to environ- ments, such as production, test, staging, and development environments. It is an integral part of DevOps, which combines software engineering and system administration efforts
* Deployment Strategies
    * Complete deployment 
        * updates all instances of the modified code at once
        * a common practice with teams that used waterfall methodologies
        * still the only option in some cases, for example, in the case of a single server running a monolithic application.
        * may cause service disruption
    * Rolling deployment 
        * incrementally updates all servers over a period of time
        * For example, in a 10-server cluster, a deployment may be released to only one server at first. After a period of time, if there are no problems detected, a second server will be updated. This process con- tinues until all of the servers are updated.
        * advantage of rolling deployments is that you expose only a subset of users to the risk of disruptive code
        * generally possible to do a rolling deployment without any service disruptions.
    * Canary deployment 
        * engineers release new code, but no traffic is routed to it at first. Once it is deployed, engineers route a small amount of traffic to the deployment. As time passes, if no problems are found, more traffic can be routed to the servers with the newly deployed code.
        * you may want to choose users randomly to route to the new version of code, or you may have criteria for choosing users
    * Blue/Green deployment
        * uses two production environments, named Blue and Green which are configured similarly but run different code
        * At any point in time, one of them (for instance, Green) is the active production environment processing a live workload. The other (in other words, Blue) is available to deploy updated versions of software or new services where those changes can be tested. When testing is complete, workload is shifted from the current environment (Green) to the recently updated environment (Blue).
        * mitigate the risk of a bad deployment by allowing developers and DevOps engineers to switch between environments quickly.

* 
## 6.3 Assisting with the support of deployed solutions

## 6.4 Evaluating quality control measures