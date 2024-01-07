
 variable "vpc_id" {
  description = "The deployment name to scale"
  default     = "word-validation"  
}

variable "private_subnets" {
  description = "The namespace of deployment"
  default     = {
    private1="my-vpc-private-ap-south-1a"
    private2="my-vpc-private-ap-south-1b"
    private3="my-vpc-private-ap-south-1c"
  }  
}