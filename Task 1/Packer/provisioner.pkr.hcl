build {
  name    = "my_aws_build"
  sources = ["source.amazon-ebs.my_aws_build"]

  provisioner "shell" {
    inline = [
      "export DEBIAN_FRONTEND=noninteractive",

      "sleep 200",
      
      "apt-get update -y",
      "apt-get upgrade -y",

      # Install Nginx
      "apt-get install -y nginx",

      # Create a simple HTML file
      "echo 'Hello, World!' > /var/www/html/index.html",

      # Enable and start Nginx
      "systemctl enable nginx",
      "systemctl start nginx",

      # Reset environment
      "export DEBIAN_FRONTEND=dialog"
    ]
  }
}
