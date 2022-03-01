############### variables for EKS cluster ###############
variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
  default     = "rip"
}
variable "admin_users" {
  type        = list(string)
  description = "List of Kubernetes admins."
  default     = ["andrey.o"]
}
variable "developer_users" {
  type        = list(string)
  description = "List of Kubernetes developers."
  default     = []
}
# variable "asg_instance_types" {
#   type        = list(string)
#   description = "List of EC2 instance machine types to be used in EKS."
#   default     = ["t2.xlarge", "t3.xlarge"]
# }
variable "asg_instance_type" {
  type        = string
  description = "List of EC2 instance machine types to be used in EKS."
  default     = "t3.xlarge"
}
variable "autoscaling_minimum_size_by_az" {
  type        = number
  description = "Minimum number of EC2 instances to autoscale our EKS cluster on each AZ."
  default     = 1
}
variable "autoscaling_maximum_size_by_az" {
  type        = number
  description = "Maximum number of EC2 instances to autoscale our EKS cluster on each AZ."
  default     = 10
}
variable "autoscaling_average_cpu" {
  type        = number
  description = "Average CPU threshold to autoscale EKS EC2 instances."
  default     = 30
}
# variable "namespaces" {
#   type        = list(string)
#   description = "List of namespaces to be created in our EKS Cluster."
#   default     = ["development", "staging", "production"]
# }
# variable "spot_termination_handler_chart_name" {
#   type        = string
#   description = "EKS Spot termination handler Helm chart name."
#   default     = "aws-node-termination-handler"
# }
# variable "spot_termination_handler_chart_repo" {
#   type        = string
#   description = "EKS Spot termination handler Helm repository name."
#   default     = "https://aws.github.io/eks-charts"
# }
# variable "spot_termination_handler_chart_version" {
#   type        = string
#   description = "EKS Spot termination handler Helm chart version."
#   default     = "0.9.1"
# }
# variable "spot_termination_handler_chart_namespace" {
#   type        = string
#   description = "Kubernetes namespace to deploy EKS Spot termination handler Helm chart."
#   default     = "kube-system"
# }

############### variables for Route53 records ###############
# variable "dns_base_domain" {
#   type        = string
#   description = "DNS Zone name to be used from EKS Ingress."
#   default     = "dublz.com"
# }
# variable "deployments_subdomains" {
#   type        = list(string)
#   description = "List of subdomains to be routed to Kubernetes Services."
#   default = [
#     "k8s",
#     "health",
#     # "admin",
#     # "api",
#     # "admin-api",
#     # "stage-admin",
#     # "stage-api",
#     # "stage-admin-api",
#     # "stage",
#     "dev-admin",
#     "dev-api",
#     "dev-admin-api",
#     "dev",
#   ]
# }

############### variables for Ingress controller ###############
# variable "ingress_gateway_chart_name" {
#   type        = string
#   description = "Ingress Gateway Helm chart name."
#   default     = "ingress-nginx"
# }
# variable "ingress_gateway_chart_repo" {
#   type        = string
#   description = "Ingress Gateway Helm repository name."
#   default     = "https://kubernetes.github.io/ingress-nginx"
# }
# variable "ingress_gateway_chart_version" {
#   type        = string
#   description = "Ingress Gateway Helm chart version."
#   default     = "4.0.1"
# }
# variable "ingress_gateway_annotations" {
#   type        = map(string)
#   description = "Ingress Gateway Annotations required for EKS."
#   default = {
#     "kubernetes.io/ingress.class"                                                                               = "nginx",
#     "controller.service.httpPort.targetPort"                                                                    = "http",
#     "controller.service.httpsPort.targetPort"                                                                   = "http",
#     "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"        = "http",
#     "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"               = "https",
#     "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-connection-idle-timeout" = "60",
#     "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"                    = "elb",
#     "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-subnets"                 = "dublz-public-ap-southeast-1a"
#     # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled" = "true"
#     # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-access-log-enabled"                = "true"
#     # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-access-log-emit-interval"          = "60"
#     # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-access-log-s3-bucket-name"         = "nginx-ingress-loadbalancer-logs"
#     # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-access-log-s3-bucket-prefix"       = "nginx-ingress-loadbalancer-logs/stage"
#   }
# }

variable "ingress_gateway_chart_name" {
  type        = string
  description = "Ingress Gateway Helm chart name."
  default     = "nginx-ingress"
}
variable "ingress_gateway_chart_repo" {
  type        = string
  description = "Ingress Gateway Helm repository name."
  default     = "https://helm.nginx.com/stable"
}
variable "ingress_gateway_chart_version" {
  type        = string
  description = "Ingress Gateway Helm chart version."
  default     = "0.10.1"
}
variable "ingress_gateway_annotations" {
  type        = map(string)
  description = "Ingress Gateway Annotations required for EKS."
  default = {
    "controller.service.httpPort.targetPort"                                                                    = "http",
    "controller.service.httpsPort.targetPort"                                                                   = "http",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal"                = "false",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"        = "http",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"               = "https",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-connection-idle-timeout" = "60",
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"                    = "elb",
    # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-subnets"                 = "dublz-public-ap-southeast-1a, dublz-public-ap-southeast-1b, dublz-public-ap-southeast-1c"
    # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled" = "true",
    # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-access-log-enabled"                = "true",
    # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-access-log-emit-interval"          = "60",
    # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-access-log-s3-bucket-name"         = "nginx-ingress-loadbalancer-logs",
    # "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-access-log-s3-bucket-prefix"       = "nginx-ingress-loadbalancer-logs/stage"
  }
}

############### variables for Metrics Server ###############
variable "metrics_server_chart_name" {
  type        = string
  description = "Metrics Server Helm chart name."
  default     = "metrics-server"
}
variable "metrics_server_chart_repo" {
  type        = string
  description = "Metrics Server Helm repository name."
  default     = "https://charts.bitnami.com/bitnami"
}
variable "metrics_server_chart_version" {
  type        = string
  description = "Metrics Server Helm chart version."
  default     = "5.5.1"
}

############### variables for VPC creation ###############
variable "aws_region" {
  type        = string
  description = "AWS Region ID."
  default     = "ap-southeast-1"
}
variable "main_network_block" {
  type        = string
  description = "Base CIDR block to be used in our VPC."
  default     = "10.0.0.0/16"
}
variable "subnet_prefix_extension" {
  type        = number
  description = "CIDR block bits extension to calculate CIDR blocks of each subnetwork."
  default     = 4
}
variable "zone_offset" {
  type        = number
  description = "CIDR block bits extension offset to calculate Public subnets, avoiding collisions with Private subnets."
  default     = 8
}
# variable "iac_environment_tag" {
#   type        = string
#   description = "AWS tag to indicate environment name of each infrastructure object."
#   default     = "staging"
# }

############### variables for RDS instance ###############
# variable "db_identifier" {
#   type        = string
#   description = "AWS RDS Instance identifier."
# }
# data "aws_security_group" "default" {
#   vpc_id = module.vpc.vpc_id
#   #name   = "default"
# }
# resource "random_string" "password" {
#   length  = 32
#   special = true
# }
# variable "environment" {
#   type        = string
#   description = "Environment type (dev, stage, prod)."
#   default     = "stage"
# }
# variable "keeper_name" {
#   type        = string
#   description = "The trigger for RDS master password rotation"
#   default     = "no"
# }

# variable "environment" {
#   type        = string
#   description = "The trigger for RDS master password rotation"
#   default     = ""
# }
