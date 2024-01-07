resource "kubernetes_horizontal_pod_autoscaler" "deploy-hpa" {
  metadata {
    name = "deploy-hpa"
    namespace = var.namespace
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = var.name
    }

    min_replicas = 2
    max_replicas = 10

    target_cpu_utilization_percentage = 50
  }
}