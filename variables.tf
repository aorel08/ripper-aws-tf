############### variables for EKS cluster ###############
variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
  default     = "rip"
}
variable "admin_users" {
  type        = list(string)
  description = "List of Kubernetes admins."
  default     = ["andrey.o"] # set here your IAM username (make sure this user has all required privileges to create aws resources)
}

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
  default     = "5.11.3"
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

