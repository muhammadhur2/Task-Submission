source "amazon-ebs" "my_aws_build" {
  # Use your preferred AWS region
  region = var.aws_region

  # Rely on environment variables or IAM roles for credentials:
  #   AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN, etc.
  #   e.g. export AWS_ACCESS_KEY_ID="..."

  # Example: An Ubuntu 20.04 official AMI
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"] # Canonical
    most_recent = true
  }

  instance_type = "t2.micro"
  ssh_username  = "ubuntu"

  ami_name = "my-nginx-ami-${local.timestamp}"
}
