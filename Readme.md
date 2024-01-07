
# Terraform AWS EKS Cluster, VPC, Load Balancer, and Horizontal Pod Autoscaler

This Terraform project provisions an AWS EKS cluster, VPC, Load Balancer,route53 and sets up a Horizontal Pod Autoscaler (HPA) for autoscaling Kubernetes pods.

## Prerequisites

Before using this Terraform configuration, ensure the following:

**AWS CLI**: Configure AWS CLI with the necessary permissions.

**Terraform**: Install Terraform on your machine. Download Terraform.

**Kubernetes Configuration**: Ensure kubectl is configured correctly to interact with your Kubernetes cluster.

**Domain/Subdomain**: Have a registered domain/subdomain in Route 53 if needed.

## Project Structure

The configuration comprises the following files:

**main.tf**: Defines the primary infrastructure resources like EKS cluster, VPC, Load Balancer, and HPA.

**variables.tf**: Contains variable declarations used within the configuration.

**providers.tf**: Contains provider declarations used within the configuration.


## Usage

1. **Initialize Terraform**: Run `terraform init` in the directory containing the Terraform configuration files.

2. **Review and Modify Variables and validate terraform code**: Check `variables.tf` for configurable variables. Adjust these according to your specific requirements for the EKS cluster, VPC, and Load Balancer settings.

3. **VPC Configuration**:
- This Terraform configuration sets up an AWS Virtual Private Cloud (VPC) with specified CIDR blocks for private and public subnets.
- Modify `eks_vpc_cidr`, `private_subnet_cidrs`, `public_subnet_cidrs`, `enable_nat_gateway`, `enable_igw` and `enable_vpn_gateway` variables in `variables.tf` to customize VPC settings.

4. **EKS Cluster Configuration**:
 - The configuration provisions an EKS cluster with managed node groups using specified instance types and scaling configurations.
- Update `cluster_name`, `eks_cluster_version`, `instance_types`, `desired_capacity`, `max_capacity`, and `min_capacity` variables in `variables.tf` to tailor EKS cluster specifications.

5. **Load Balancer Configuration**:
- A Load Balancer is set up using the AWS Load Balancer Controller (ALB/NLB) for managing ingress traffic to your EKS cluster.
- Modify `eks_cluster_image_repository`, `namespace_service_accounts`, and other related variables in `variables.tf` to adjust Load Balancer settings as needed.

6. **Horizontal Pod Autoscaler (HPA)**:
- The configuration includes an HPA for autoscaling Kubernetes pods based on CPU and Memory utilization.
- Adjust `target_cpu_utilization_percentage`, `min_replicas`, and `max_replicas` in `main.tf` to fine-tune the HPA settings according to your application's requirements.

6. **Route53**:
- AWS Route 53 is a scalable and highly available Domain Name System (DNS) web service provided by Amazon Web Services (AWS). It allows you to manage your domain names, route traffic to resources, such as EC2 instances or load balancers, and perform various DNS-related tasks.

7. **Apply Configuration**: Execute `terraform apply` and review the proposed changes. Enter `yes` when prompted to apply the changes.

8. **Apply word-validation**: Apply deployment, service and ingress inside kubernetes folder into eks cluster. Replace the annotation `alb.ingress.kubernetes.io/subnets` with your subnets inside ingress yaml.

9. **Clean Up Resources (Optional)**: Run `terraform destroy` to remove the provisioned resources when they are no longer needed. Be cautious as this action is irreversible.







