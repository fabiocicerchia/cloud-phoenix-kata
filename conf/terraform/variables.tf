variable "region" {
  default = "eu-west-1"
  type    = "string"
}

variable "owner_id" {
  default = ""
  type    = "string"
}

variable "s3_bucket" {
  default = "fabiocicerchia-base-cloud-phoenix-kata"
  type    = "string"
}

variable "ecr_name" {
  default = "fabiocicerchia-cloud-phoenix-kata"
  type    = "string"
}

variable "whitelisted_ip" {
  default = "1.2.3.4/32"
  type    = "string"
}

variable "cluster-name" {
  default = "cloud-phoenix-kata"
  type    = "string"
}
