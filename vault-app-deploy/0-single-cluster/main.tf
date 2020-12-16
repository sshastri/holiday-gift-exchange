#resource "random_pet" "cluster" {}

resource "tls_private_key" "cluster" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "tls_private_key" {
  content         = tls_private_key.cluster.private_key_pem
  filename        = ".cluster_id_rsa"
  file_permission = "0600"
}

resource "aws_key_pair" "cluster" {
  key_name   = "grinch-key"
  public_key = tls_private_key.cluster.public_key_openssh
}

module "vault" {
  source = "../../is-immutable-aws-vault-raft"

  cluster_name   = "grinch"
  vault_domain   = var.vault_domain
  aws_region     = var.aws_region
  vpc_id         = var.vpc_id
  vpc_cidr_block = "0.0.0.0/0"

  route53_hosted_zone_arn = var.route53_hosted_zone_arn

  availability_zones = [
    "us-west-2a"
  ]

  private_subnet_ids = [
   "subnet-0226b02c05388f0a5"
  ]

  vault_asg_capacity  = 1
  vault_instance_type = "t3a.medium"

  vault_node_ebs_root = {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
    encrypted             = true
  }

  vault_node_ebs_data = {
    volume_type           = "gp2"
    volume_size           = 25
    delete_on_termination = true
    encrypted             = true
  }

  ssm_parameter_tls_certificate = "shobs-vault-tls-cert"
  ssm_parameter_tls_key         = "shobs-vault-tls-key"
  ssm_parameter_tls_ca          = "shobs-vault-tls-ca"

  vault_node_key_pair    = aws_key_pair.cluster.key_name
  vault_node_ami_id      = var.immutable_vault_raft_ami_id
  remote_ssh_cidr_blocks = ["0.0.0.0/0"]
  route53_zone_id        = data.aws_route53_zone.main.zone_id

  iam_role_permissions_boundary_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  
  elb_internal = false
  
  owner = "shobs"
}
