resource "aws_security_group" "main" {
  name        = "${var.cluster_name}-cluster"
  description = "Pretty loose security group to allow inbound SSH and all ports/protocols within group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.remote_ssh_cidr_blocks
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  ingress {
    from_port   = 8200
    to_port     = 8201
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }
  
  ### FOR THE GRINCH APP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "main" {
  name_prefix   = var.cluster_name
  image_id      = var.vault_node_ami_id
  instance_type = var.vault_instance_type
  key_name      = var.vault_node_key_pair

  user_data = base64encode(
    templatefile(
      "${path.module}/templates/vault-cloudinit.tpl",
      {
        cluster_name       = var.cluster_name
        aws_region         = var.aws_region
        hosted_zone_id     = var.route53_zone_id
        vault_kms_key_id   = aws_kms_key.main.id
        vault_api_port     = 8200
        vault_cluster_port = 8201
        vault_domain       = var.vault_domain

        ssm_parameter_tls_certificate = var.ssm_parameter_tls_certificate
        ssm_parameter_tls_key         = var.ssm_parameter_tls_key
        ssm_parameter_tls_ca          = var.ssm_parameter_tls_ca
        vault_tls_path                = "/etc/vault.d/tls"
        vault_tls_cert_filename       = "vault.crt"
        vault_tls_key_filename        = "vault.key"
        vault_tls_ca_filename         = "ca.pem"
      }
    )
  )

  tags = {}

  iam_instance_profile {
    name = aws_iam_instance_profile.main.name
  }

  lifecycle {
    create_before_destroy = true
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_type           = var.vault_node_ebs_root.volume_type
      volume_size           = var.vault_node_ebs_root.volume_size
      delete_on_termination = var.vault_node_ebs_root.delete_on_termination
      encrypted             = var.vault_node_ebs_root.encrypted
    }
  }

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_type           = var.vault_node_ebs_data.volume_type
      volume_size           = var.vault_node_ebs_data.volume_size
      delete_on_termination = var.vault_node_ebs_data.delete_on_termination
      encrypted             = var.vault_node_ebs_data.encrypted
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name           = format("%s-%s", var.cluster_name, "asg-node")
      VaultRetryJoin = "${var.cluster_name}"
      Owner          = var.owner
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name  = format("%s-%s", var.cluster_name, "asg-volume")
      Owner = var.owner
    }
  }

  vpc_security_group_ids = [
    aws_security_group.main.id,
  ]
}

resource "aws_lb" "vault" {
  name               = "${var.cluster_name}-nlb"
  internal           = var.elb_internal
  load_balancer_type = "network"
  subnets            = var.private_subnet_ids
}

resource "aws_lb_listener" "vault" {
  load_balancer_arn = aws_lb.vault.id
  port              = 8200
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vault.arn
  }
}

resource "aws_lb_target_group" "vault" {
  name                 = "${var.cluster_name}-tg"
  target_type          = "instance"
  port                 = 8200
  protocol             = "TCP"
  vpc_id               = var.vpc_id
  deregistration_delay = 15

  health_check {
    protocol = "HTTPS"
    port     = "traffic-port"
    path     = "/v1/sys/health?perfstandbyok=true"
    interval = 30
    timeout  = 10
  }
}

#### GRINCH APP UPDATES ####
resource "aws_lb_listener" "grinchapp" {
  load_balancer_arn = aws_lb.vault.id
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.grinchapp.arn
  }
}

resource "aws_lb_target_group" "grinchapp" {
  name                 = "grinch-app-tg"
  target_type          = "instance"
  port                 = 80
  protocol             = "TCP"
  vpc_id               = var.vpc_id
  deregistration_delay = 15

  # health_check {
  #   protocol = "HTTPS"
  #   port     = "traffic-port"
  #   path     = "/v1/sys/health?perfstandbyok=true"
  #   interval = 30
  #   timeout  = 10
  # }
}

resource "aws_route53_record" "vault_lb" {
  zone_id = var.route53_zone_id
  name    = var.cluster_name
  type    = "A"

  alias {
    name                   = aws_lb.vault.dns_name
    zone_id                = aws_lb.vault.zone_id
    evaluate_target_health = true
  }
}

resource "aws_placement_group" "main" {
  name     = var.cluster_name
  strategy = "spread"
}

resource "aws_autoscaling_group" "main" {
  name_prefix               = var.cluster_name
  min_size                  = var.vault_asg_capacity
  max_size                  = var.vault_asg_capacity
  desired_capacity          = var.vault_asg_capacity
  wait_for_capacity_timeout = "480s"
  health_check_grace_period = 15
  health_check_type         = "EC2"
  vpc_zone_identifier       = var.private_subnet_ids
  default_cooldown          = 30
  placement_group           = aws_placement_group.main.id
  target_group_arns         = [aws_lb_target_group.vault.arn]

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  termination_policies = [
    "OldestInstance",
    "OldestLaunchTemplate",
  ]
}

resource "aws_kms_key" "main" {
  description             = "KMS key for ${var.cluster_name} Vault Auto Unseal"
  enable_key_rotation     = var.vault_kms_key_rotate
  deletion_window_in_days = var.vault_kms_deletion_days

  tags = {
    Name = "vault-kms-${var.cluster_name}"
    Owner = var.owner
  }
}

resource "aws_iam_instance_profile" "main" {
  name_prefix = "${var.cluster_name}-vault-"
  role        = aws_iam_role.main.name
  path        = var.iam_role_path
}

resource "aws_iam_role" "main" {
  name_prefix          = "${var.cluster_name}-vault-"
  path                 = var.iam_role_path
  assume_role_policy   = file("${path.module}/templates/vault-server-role.json")
  permissions_boundary = var.iam_role_permissions_boundary_arn
}

data "template_file" "aws_iam_role_policy" {
  template = file("${path.module}/templates/vault-server-role-policy.json")

  vars = {
    route53_hosted_zone_arn = var.route53_hosted_zone_arn
  }
}

resource "aws_iam_role_policy" "main" {
  name   = "${var.cluster_name}-vault-server"
  role   = aws_iam_role.main.id
  policy = data.template_file.aws_iam_role_policy.rendered
}
