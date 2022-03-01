# get (externally configured) DNS Zone
data "aws_route53_zone" "base_domain" {
  name         = var.dns_base_domain
  private_zone = false
}

# data "aws_subnet_ids" "stage_public" {
#   # vpc_id = data.aws_vpc.default.id
#   # public_subnet_ids = module.vpc.public_subnets[*]
#   vpc_id     = module.vpc.vpc_id
#     tags = {
#     Tier = "Private"
#   }

#   depends_on = [module.vpc]
# }

# data "aws_subnet_ids" "stage_private" {
#   # vpc_id = data.aws_vpc.default.id
#   # public_subnet_ids = module.vpc.public_subnets[*]
#   vpc_id     = module.vpc.vpc_id
#   depends_on = [module.vpc]
# }

# create AWS-issued SSL certificate
resource "aws_acm_certificate" "eks_domain_cert" {
  domain_name               = var.dns_base_domain
  subject_alternative_names = ["*.${var.dns_base_domain}"]
  validation_method         = "DNS"

  tags = {
    Name = var.dns_base_domain
    # iac_environment = var.iac_environment_tag
  }
}

resource "aws_route53_record" "eks_domain_cert_validation_dns" {
  for_each = {
    for dom_valid_opts in aws_acm_certificate.eks_domain_cert.domain_validation_options : dom_valid_opts.domain_name => {
      name   = dom_valid_opts.resource_record_name
      type   = dom_valid_opts.resource_record_type
      record = dom_valid_opts.resource_record_value
    }
  }
  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  # zone_id         = each.value.zone_id
  zone_id = data.aws_route53_zone.base_domain.zone_id
  ttl     = 60
}
resource "aws_acm_certificate_validation" "eks_domain_cert_validation" {
  certificate_arn         = aws_acm_certificate.eks_domain_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.eks_domain_cert_validation_dns : record.fqdn]
}

# deploy Ingress Controller
resource "helm_release" "dublz_ingress_gateway" {
  # name       = "${var.environment}-${var.cluster_name}"
  name       = var.ingress_gateway_chart_name
  chart      = var.ingress_gateway_chart_name
  repository = var.ingress_gateway_chart_repo
  version    = var.ingress_gateway_chart_version
  depends_on = [module.stage-eks-cluster]

  dynamic "set" {
    for_each = var.ingress_gateway_annotations

    content {
      name  = set.key
      value = set.value
      type  = "string"
    }
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = aws_acm_certificate.eks_domain_cert.id
  }
}

# create base domain for EKS Cluster
data "kubernetes_service" "dublz_ingress_gateway" {
  metadata {
    # name = "nginx-ingress-nginx-ingress"
    name = join("-", [helm_release.dublz_ingress_gateway.chart, helm_release.dublz_ingress_gateway.name])
    # name = "${helm_release.dublz_ingress_gateway.name}-controller"
  }
  depends_on = [module.stage-eks-cluster.aws_autoscaling_group]
}

data "aws_elb_hosted_zone_id" "elb_zone_id" {}

resource "aws_route53_record" "eks_domain" {
  zone_id         = data.aws_route53_zone.base_domain.zone_id
  name            = var.dns_base_domain
  type            = "A"
  allow_overwrite = true

  alias {
    zone_id = data.aws_elb_hosted_zone_id.elb_zone_id.id
    name    = data.kubernetes_service.dublz_ingress_gateway.status.0.load_balancer.0.ingress.0.hostname
    # name                   = "nginx-ingress-70092103.ap-southeast-1.elb.amazonaws.com"
    evaluate_target_health = true
  }
}
