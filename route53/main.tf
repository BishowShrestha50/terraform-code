resource "aws_route53_zone" "example_zone" {
  name = "dev.skyxplug.dev"
}
resource "aws_route53_record" "example_record" {
  zone_id = aws_route53_zone.example_zone.zone_id
  name    = "bish.dev.skyxplug.dev"
  type    = "CNAME"
  ttl     = "300"
  records = ["k8s-default-wordvali-0f116b29eb-1528910660.ap-south-1.elb.amazonaws.com"] # Replace with your EKS cluster IP or load balancer DNS
}
provider "aws" {
  region  = "ap-south-1"

}
 provider "kubernetes" {
  config_path = "~/.kube/config"
}