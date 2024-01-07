# Implementation Document: Auto-Scaling and Load-Balancing Strategies
Introduction

The following document reviews the design decisions and strategies implemented in the Terraform configuration for AWS EKS, emphasizing auto-scaling and load-balancing approaches. The objective was to create a scalable, resilient, and efficient infrastructure for managing Kubernetes workloads.
Auto-Scaling Strategy

The auto-scaling strategy revolves around the Kubernetes Horizontal Pod Autoscaler (HPA) and EKS managed node groups.

**HPA Configuration**:
- The Horizontal Pod Autoscaler is set to scale pods based on CPU utilization.
- kubernetes_horizontal_pod_autoscaler resource in main.tf defines the target CPU utilization percentage and minimum/maximum replicas for pods.

**EKS Managed Node Groups**:
- Configured managed node groups for automatic scaling based on varying demand.
- Utilized instance types (t3.medium) with adjustable scaling parameters (desired_capacity, max_capacity, min_capacity) in variables.tf to accommodate workload fluctuations.

Load-Balancing Strategy

The Load Balancing strategy involves using AWS Load Balancer Controller for efficient ingress traffic management.

**Load Balancer Setup**:
- Leveraged the helm_release resource to deploy the AWS Load Balancer Controller in the kube-system namespace.
- Specified the Load Balancer's image repository and associated configurations (serviceAccount.name, clusterName) in main.tf.

**Controller Policies**:
- Defined policies and permissions for the Load Balancer Controller via the lb_role module to manage AWS resources for load balancing.
- Mapped necessary IAM roles (aws-load-balancer-controller) to the aws-load-balancer-controller service account in kubernetes_service_account resource.

Design Rationale

**Auto-Scaling Choice**:
- The decision to scale based on CPU utilization ensures resource optimization during varying workload conditions. CPU-based scaling allows the cluster to adapt to changing demands efficiently.

**Load Balancer Controller**:
- Deploying the AWS Load Balancer Controller streamlines ingress traffic management, providing a standardized way to route external traffic into the EKS cluster.
- Leveraging IAM roles and policies helps in secure access and resource management for the Load Balancer Controller.

## Conclusion

The implemented auto-scaling strategy ensures dynamic resource allocation based on workload demands, optimizing resource utilization. Simultaneously, the Load Balancer Controller facilitates efficient ingress traffic routing into the EKS cluster, enhancing reliability and scalability.