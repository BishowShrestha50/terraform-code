variable "region" {
  description = "The region name of eks cluster"
  default     = "ap-south-1"  
}

variable "vpcId" {
  description = "The vpc id used by cluster"
  default     = "vpc-0d3aa5943fbc2acf5"
}

variable "cluster" {
  description = "The namespace of deployment"
  default     = "eks-cluster"
}

variable "oidc_provider_arn" {
  description = "The provider arn of the eks cluster"
  default     = "arn:aws:iam::847579972211:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/2BC2EA1D836C387C3D8F18973492FA38"
}

