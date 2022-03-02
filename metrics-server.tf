# deploy Metrics Server
resource "helm_release" "metrics-server" {
  # name       = "${var.environment}-${var.cluster_name}"
  name       = var.metrics_server_chart_name
  chart      = var.metrics_server_chart_name
  repository = var.metrics_server_chart_repo
  version    = var.metrics_server_chart_version
  namespace  = "kube-system"
  depends_on = [module.eks-cluster.aws_autoscaling_group]
  set {
    name  = "apiService.create"
    value = "true"
  }
}
