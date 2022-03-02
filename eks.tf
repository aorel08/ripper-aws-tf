# render Admin & Developer users list with the structure required by EKS module
locals {
  admin_user_map_users = [
    for admin_user in var.admin_users :
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${admin_user}"
      username = admin_user
      groups   = ["system:masters"]
    }
  ]

  worker_groups_launch_template = [
    {
      name                   = "workernode"
      instance_type          = var.asg_instance_type
      asg_desired_capacity   = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available_azs.zone_ids)
      asg_min_size           = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available_azs.zone_ids)
      asg_max_size           = var.autoscaling_maximum_size_by_az * length(data.aws_availability_zones.available_azs.zone_ids)
      asg_recreate_on_change = true
      kubelet_extra_args     = "--node-labels=node.kubernetes.io/lifecycle=normal"
      # override_instance_types = var.asg_instance_types
      # kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot" # use Spot EC2 instances to save some money and scale more
      # additional_security_group_ids = [aws_security_group.worker_group.id]
    },
  ]
}

# create EKS cluster
module "eks-cluster" {
  source           = "terraform-aws-modules/eks/aws"
  version          = "17.18.0"
  cluster_name     = var.cluster_name
  cluster_version  = "1.21"
  write_kubeconfig = true

  subnets = module.vpc.private_subnets
  vpc_id  = module.vpc.vpc_id

  worker_groups_launch_template = local.worker_groups_launch_template

  # map developer & admin ARNs as kubernetes Users
  #map_users = concat(local.admin_user_map_users, local.developer_user_map_users)
}

# get EKS cluster info to configure Kubernetes and Helm providers
data "aws_eks_cluster" "cluster" {
  name = module.eks-cluster.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks-cluster.cluster_id
}

# deploy spot termination handler
# resource "helm_release" "spot_termination_handler" {
#   name       = var.spot_termination_handler_chart_name
#   chart      = var.spot_termination_handler_chart_name
#   repository = var.spot_termination_handler_chart_repo
#   version    = var.spot_termination_handler_chart_version
#   namespace  = var.spot_termination_handler_chart_namespace
# }

# add spot fleet Autoscaling policy
resource "aws_autoscaling_policy" "eks_autoscaling_policy" {
  count = length(local.worker_groups_launch_template)

  name                   = "${module.eks-cluster.workers_asg_names[count.index]}-autoscaling-policy"
  autoscaling_group_name = module.eks-cluster.workers_asg_names[count.index]
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.autoscaling_average_cpu
  }
}
