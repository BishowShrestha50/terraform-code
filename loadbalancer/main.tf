module "lb_role" {
 source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

 role_name                              = "terraform_eks_lb"
 attach_load_balancer_controller_policy = true

 oidc_providers = {
     main = {
     provider_arn               = "arn:aws:iam::847579972211:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/F36840E0572457CCD74C050EA19DD0FD"
     namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
     }
 }
 }

 resource "kubernetes_service_account" "service-account" {
 metadata {
     name      = "aws-load-balancer-controller"
     namespace = "kube-system"
     labels = {
     "app.kubernetes.io/name"      = "aws-load-balancer-controller"
     "app.kubernetes.io/component" = "controller"
     }
     annotations = {
     "eks.amazonaws.com/role-arn"               = module.lb_role.iam_role_arn
     "eks.amazonaws.com/sts-regional-endpoints" = "true"
     }
 }
 }

 resource "helm_release" "alb-controller" {
 name       = "aws-load-balancer-controller"
 repository = "https://aws.github.io/eks-charts"
 chart      = "aws-load-balancer-controller"
 namespace  = "kube-system"
 depends_on = [
     kubernetes_service_account.service-account
 ]

 set {
     name  = "region"
     value = var.region
 }

 set {
     name  = "vpcId"
     value = var.vpcId
 }

 set {
     name  = "image.repository"
     value = "602401143452.dkr.ecr.ap-south-1.amazonaws.com/amazon/aws-load-balancer-controller"
 }

 set {
     name  = "serviceAccount.create"
     value = "false"
 }

 set {
     name  = "serviceAccount.name"
     value = "aws-load-balancer-controller"
 }

 set {
     name  = "clusterName"
     value = var.cluster
 }
 }

 provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
 }

 provider "kubernetes" {
  config_path = "~/.kube/config"
}

data "aws_iam_role" "example" {
  name = "green-eks-node-group-20240107132711769900000004"
}


resource "aws_iam_policy_attachment" "example_attachment" {
  name       = "example-attachment"
    for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess",
    "arn:aws:iam::aws:policy/AWSWAFFullAccess"
  ])
  roles      = [data.aws_iam_role.example.name]
   policy_arn = each.value
}
