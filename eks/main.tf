provider "aws" {
  region  = "ap-south-1"

}

data "aws_vpc" "vpc"{
  tags = {
    Name = "my-vpc"  # Replace with your desired tag key-value pair
  }
}



data "aws_subnet" "private1"{
    tags = {
    Name = "my-vpc-private-ap-south-1a"  # Replace with your desired tag key-value pair
  }
}
data "aws_subnet" "private2"{
    tags = {
    Name = "my-vpc-private-ap-south-1b"  # Replace with your desired tag key-value pair
  }
}

data "aws_subnet" "private3"{
    tags = {
    Name = "my-vpc-private-ap-south-1c"  # Replace with your desired tag key-value pair
  }
}


module "eks" {
 source  = "terraform-aws-modules/eks/aws"
 version = "~> 19.0"

 cluster_name    = "eks-cluster"
 cluster_version = "1.27"
 cluster_endpoint_public_access = true

 create_kms_key              = false
 create_cloudwatch_log_group = false
 cluster_encryption_config   = {}

 cluster_addons = {
     coredns = {
     most_recent = true
     }
     kube-proxy = {
     most_recent = true
     }
     vpc-cni = {
     most_recent = true
     }
 }

 vpc_id                   = data.aws_vpc.vpc.id
 subnet_ids               = [data.aws_subnet.private1.id,data.aws_subnet.private2.id,data.aws_subnet.private3.id]
 # EKS Managed Node Group(s)
 eks_managed_node_group_defaults = {
     instance_types = ["t3.medium"]
 }

 eks_managed_node_groups = {
    #  blue = {}
     green = {
    #  min_size     = 1
    #  max_size     = 10
    #  desired_size = 1

     instance_types = ["t3.medium"]
      scaling_config = {
        desired_size = 1
        max_size     = 10
        min_size     = 1

        # Specify scaling policies
        scaling_policies = [
          {
            name             = "CPUAutoScaler"
            adjustment_type  = "ChangeInCapacity"
            cooldown         = 300
            scaling_adjustment = 1
          },
          # You can define more scaling policies as needed
        ]
      }
     }
 }

 tags = {
     env       = "dev"
     terraform = "true"
 }
 }