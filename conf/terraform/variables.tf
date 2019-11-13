variable "region" {
  default = "eu-west-1"
  type    = string
}

variable "owner_id" {
  default = ""
  type    = string
}

variable "whitelisted_ip" {
  default = "1.2.3.4/32"
  type    = string
}

variable "cluster-name" {
  default = "cloud-phoenix-kata"
  type    = string
}

variable "s3_bucket" {
  default = "fabiocicerchia-${var.cluster-name}"
  type    = string
}

variable "ecr_name" {
  default = "fabiocicerchia-${var.cluster-name}"
  type    = string
}

variable "retention_days" {
  default = 7
  type    = number
}
