variable "aws_region" {
  type        = string
  description = "Name of AWS region to place resources"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to place resources"
}

variable "immutable_vault_raft_ami_id" {
  type = string
  description = "Machine image ID generated by Packer build of is-vault-amzn2.json"
}

variable "vault_domain" {
  type = string
}

variable "route53_hosted_zone_arn" {
  type        = string
  description = "The ARN of the Route 53 Hosted Zone to create A records for Vault servers"
}

variable "public_ip" {
  type = string
  description = "Public IP of the host instance"
}