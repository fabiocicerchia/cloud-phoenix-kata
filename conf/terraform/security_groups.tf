# Docs: https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/3.1.0

module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.1.0"

  name   = "cloud-phoenix-kata-sg"
  vpc_id = aws_vpc.cpk-vpc.id

  ingress_cidr_blocks = ["10.0.0.0/16"]
  ingress_rules       = ["http-80-tcp"]
  ingress_with_cidr_blocks = [
    {
      cidr_blocks = var.whitelisted_ip
      description = "Your IP Address"
      from_port   = 22
      protocol    = "tcp"
      to_port     = 22
    },
  ]

  egress_with_cidr_blocks = [
    {
      cidr_blocks = "0.0.0.0/0"
      from_port   = 0
      protocol    = "-1"
      to_port     = 0
    },
  ]

  tags = {
    Terraform   = "true"
    Author      = "fabiocicerchia"
    Environment = "base"
    Service     = "cloud-phoenix-kata"
  }
}

resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = aws_vpc.cpk-vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

resource "aws_security_group" "worker_group_mgmt_two" {
  name_prefix = "worker_group_mgmt_two"
  vpc_id      = aws_vpc.cpk-vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
    ]
  }
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = aws_vpc.cpk-vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}
