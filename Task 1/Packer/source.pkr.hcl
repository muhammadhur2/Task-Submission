source "amazon-ebs" "my_aws_build" {

  region = var.aws_region


  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"] 
    most_recent = true
  }

  instance_type = "t2.micro"
  ssh_username  = "ubuntu"

  ami_name = "my-nginx-ami-${local.timestamp}"
}
