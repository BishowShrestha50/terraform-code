module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"] 

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"  
    Environment = "dev"
    
  }

}

  # locals {
  #   public_subnet_tags = {
  #     for idx, subnet in module.vpc.public_subnets : "subnet-${idx}" => merge(
  #       module.vpc.tags,
  #       {
  #         Name        = "PublicSubnet-${idx + 1}"
  #         kubernetes.io/role/elb = "1"
  #         kubernetes.io/cluster/eks-cluster = "shared"
  #         Type        = "public"
  #         # Add any other tags specific to public subnets
  #       }
  #     )
  #   }
  # }

#   resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "main"
#   }
# }



