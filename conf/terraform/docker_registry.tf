# Docs: https://registry.terraform.io/modules/cloudposse/ecr/aws/0.10.0

module "ecr" {
  source  = "cloudposse/ecr/aws"
  version = "0.10.0"

  namespace = "fabiocicerchia"
  stage     = "base"
  name      = "cloud-phoenix-kata"

  tags = {
    Terraform   = "true"
    Author      = "fabiocicerchia"
    Environment = "base"
    Service     = "cloud-phoenix-kata"
  }
}
