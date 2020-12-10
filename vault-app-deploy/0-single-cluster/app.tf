# Stolen from https://github.com/sshastri/hashicat-aws/blob/master/main.tf
# We're using a little trick here so we can run the provisioner without
# destroying the VM. Do not do this in production.

# If you need ongoing management (Day N) of your virtual machines a tool such
# as Chef or Puppet is a better choice. These tools track the state of
# individual files and can keep them in the correct configuration.

# Here we do the following steps:
# Sync everything in files/ to the remote VM.
# Set up some environment variables for our script.
# Add execute permissions to our scripts.
# Run the deploy_app.sh script.
resource "null_resource" "configure-grinch-app" {
  #depends_on = [aws_eip_association.hashicat]

  triggers = {
    build_number = timestamp()
  }

  provisioner "file" {
    source      = "files/"
    destination = "/home/ec2-user"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.cluster.private_key_pem
      #todo - can this be derived?
      host        = var.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2",
      "sudo yum install -y httpd mariadb-server",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo chown -R ec2-user:ec2-user /var/www/html",
      "chmod +x *.sh",
      "PLACEHOLDER=placeholder WIDTH=500 HEIGHT=500 PREFIX=grinch ./deploy_app.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.cluster.private_key_pem
      host        = var.public_ip
    }
  }
}
