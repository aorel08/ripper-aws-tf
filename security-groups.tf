resource "aws_security_group" "worker_group" {
  name_prefix = "worker_group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

resource "aws_security_group" "bastion_sg" {
  name   = "bastion-security-group"
  vpc_id = module.vpc.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22555
    to_port     = 22555
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "eks_ingress_controller" {
  name        = "eks-ingress-controller"
  description = "Security group allowing incoming traffic to the EKS Ingress Controller."
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group_rule" "monstabet-alb-public-https" {
#   description       = "Allow eks load balancer to communicate with public traffic securely."
#   cidr_blocks       = ["0.0.0.0/0"]
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   security_group_id = aws_security_group.monstabet-rds.id
#   type              = "ingress"
# }
#
# resource "aws_security_group_rule" "eks-alb-public-http" {
#   description       = "Allow eks load balancer to communicate with public traffic."
#   cidr_blocks       = ["0.0.0.0/0"]
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   security_group_id = aws_security_group.monstabet-rds.id
#   type              = "ingress"
# }
