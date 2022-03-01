output "public_subnets" {
  description = "List of the public subnets"
  value       = module.vpc.public_subnets
}

# output "private_subnets" {
#   description = "List of the private subnets"
#   value       = module.dev_db.db_instance_address
# }

output "dev-database_instance_address" {
  description = "The address of the RDS instance"
  value       = module.dev_db.db_instance_address
}
# output "stage-database_instance_address" {
#   description = "The address of the RDS instance"
#   value       = module.stage_db.db_instance_address
# }
output "prod-database_instance_address" {
  description = "The address of the RDS instance"
  value       = module.prod_db.db_instance_address
}

output "dev-database_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.dev_db.db_instance_availability_zone
}
# output "stage-database_instance_availability_zone" {
#   description = "The availability zone of the RDS instance"
#   value       = module.stage_db.db_instance_availability_zone
# }
output "prod-database_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.prod_db.db_instance_availability_zone
}

output "dev-database_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.dev_db.db_instance_endpoint
}
# output "stage-database_instance_endpoint" {
#   description = "The connection endpoint"
#   value       = module.stage_db.db_instance_endpoint
# }
output "prod-database_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.prod_db.db_instance_endpoint
}

output "dev-database_instance_id" {
  description = "The RDS instance ID"
  value       = module.dev_db.db_instance_id
}
# output "stage-database_instance_id" {
#   description = "The RDS instance ID"
#   value       = module.stage_db.db_instance_id
# }
output "prod-database_instance_id" {
  description = "The RDS instance ID"
  value       = module.prod_db.db_instance_id
}

output "dev-database_instance_status" {
  description = "The RDS instance status"
  value       = module.dev_db.db_instance_status
}
# output "stage-database_instance_status" {
#   description = "The RDS instance status"
#   value       = module.stage_db.db_instance_status
# }
output "prod-database_instance_status" {
  description = "The RDS instance status"
  value       = module.prod_db.db_instance_status
}
output "dev-database_name" {
  description = "The database name"
  value       = module.dev_db.db_instance_name
}
# output "stage-database_name" {
#   description = "The database name"
#   value       = module.stage_db.db_instance_name
# }
output "prod-database_name" {
  description = "The database name"
  value       = module.prod_db.db_instance_name
}

output "dev-database_username" {
  description = "The master username for the database"
  value       = module.dev_db.db_instance_username
  sensitive   = true
}
# output "stage-database_username" {
#   description = "The master username for the database"
#   value       = module.stage_db.db_instance_username
#   sensitive   = true
# }
output "prod-database_username" {
  description = "The master username for the database"
  value       = module.prod_db.db_instance_username
  sensitive   = true
}

output "dev-rds_password" {
  value     = data.aws_ssm_parameter.dev_rds_password.value
  sensitive = true
}
# output "stage-rds_password" {
#   value     = data.aws_ssm_parameter.stage_rds_password.value
#   sensitive = true
# }
output "prod-rds_password" {
  value     = data.aws_ssm_parameter.prod_rds_password.value
  sensitive = true
}
output "dev-database_port" {
  description = "The database port"
  value       = module.dev_db.db_instance_port
}
# output "stage-database_port" {
#   description = "The database port"
#   value       = module.stage_db.db_instance_port
# }
output "prod-database_port" {
  description = "The database port"
  value       = module.prod_db.db_instance_port
}

output "cluster_name" {
  description = "The Name of the EKS cluster"
  value       = var.cluster_name
}
output "aws_region" {
  description = "The AWS region ID"
  value       = var.aws_region
}

output "nat_gateways" {
  description = ""
  value       = aws_eip.nat_gw_elastic_ip.*.public_ip
  # value       = module.vpc.nat_public_ips
}

# output "this_db_instance_arn" {
#   description = "The ARN of the RDS instance"
#   value       = module.db.this_db_instance_arn
# }

# output "this_db_instance_hosted_zone_id" {
#   description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
#   value       = module.db.this_db_instance_hosted_zone_id
# }

# output "this_db_instance_resource_id" {
#   description = "The RDS Resource ID of this instance"
#   value       = module.db.this_db_instance_resource_id
# }

# output "this_db_subnet_group_id" {
#   description = "The db subnet group name"
#   value       = module.db.this_db_subnet_group_id
# }

# output "this_db_subnet_group_arn" {
#   description = "The ARN of the db subnet group"
#   value       = module.db.this_db_subnet_group_arn
# }

# output "this_db_parameter_group_id" {
#   description = "The db parameter group id"
#   value       = module.db.this_db_parameter_group_id
# }
#
# output "this_db_parameter_group_arn" {
#   description = "The ARN of the db parameter group"
#   value       = module.db.this_db_parameter_group_arn
# }
