# Docs: https://registry.terraform.io/modules/terraform-aws-modules/eks/aws

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "7.0.0"

  cluster_name = var.cluster-name
  subnets      = [aws_subnet.cpk-zones[0].id, aws_subnet.cpk-zones[1].id, aws_subnet.cpk-zones[2].id]
  vpc_id       = aws_vpc.cpk-vpc.id

  cluster_enabled_log_types     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_log_retention_in_days = var.retention_days

  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]

  worker_groups = [
    {
      instance_type                 = "t2.small"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]

      tags = [
        {
          key                 = "Terraform"
          value               = "true"
          propagate_at_launch = true
        },
        {
          key                 = "Author"
          value               = "fabiocicerchia"
          propagate_at_launch = true
        },
        {
          key                 = "Environment"
          value               = "base"
          propagate_at_launch = true
        },
        {
          key                 = "Service"
          value               = "cloud-phoenix-kata"
          propagate_at_launch = true
        }
      ]
    },
    {
      instance_type                 = "t2.medium"
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]

      tags = [
        {
          key                 = "Terraform"
          value               = "true"
          propagate_at_launch = true
        },
        {
          key                 = "Author"
          value               = "fabiocicerchia"
          propagate_at_launch = true
        },
        {
          key                 = "Environment"
          value               = "base"
          propagate_at_launch = true
        },
        {
          key                 = "Service"
          value               = "cloud-phoenix-kata"
          propagate_at_launch = true
        }
      ]
    }
  ]

  tags = {
    Terraform   = "true"
    Author      = "fabiocicerchia"
    Environment = "base"
    Service     = "cloud-phoenix-kata"
  }
}

