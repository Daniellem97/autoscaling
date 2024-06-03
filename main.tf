terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.57.0"
    }
  }
}

module "my_workerpool" {
  source = "github.com/spacelift-io/terraform-aws-spacelift-workerpool-on-ec2?ref=v2.5.0"

  configuration = <<-EOT
    export SPACELIFT_TOKEN="${var.worker_pool_config}"
    export SPACELIFT_POOL_PRIVATE_KEY="${var.worker_pool_private_key}"
  EOT

  min_size          = 1
  max_size          = 5
  worker_pool_id    = var.worker_pool_id
  security_groups   = var.security_groups
  vpc_subnets       = var.vpc_subnets
  api_key_secret    = var.api_key_secret
  api_key_id        = var.api_key_id
  api_key_endpoint  = var.api_key_endpoint
}

variable "spacelift_api_key_id" {
  type        = string
  description = "ID of the Spacelift API key to use"
  default     = null
}

variable "spacelift_api_key_secret" {
  type        = string
  sensitive   = true
  description = "Secret corresponding to the Spacelift API key to use"
}

variable "spacelift_api_key_endpoint" {
  type        = string
  description = "Full URL of the Spacelift API endpoint to use, eg. https://demo.app.spacelift.io"
  default     = null
}


variable "worker_pool_config" {
  type = string
}

variable "worker_pool_private_key" {
  type = string
}

variable "worker_pool_id" {
  type    = string
  default = "01HK8GXR4C5PT465ZWBQHWXEA1"
}

variable "security_groups" {
  type    = list(string)
}

variable "vpc_subnets" {
  type    = list(string)
}


 variable "autoscaling_max_create" {
  description = "The maximum number of instances the utility is allowed to create in a single run"
  type        = number
  default     = 2
}

variable "autoscaling_max_terminate" {
  description = "The maximum number of instances the utility is allowed to terminate in a single run"
  type        = number
  default     = 1
}
