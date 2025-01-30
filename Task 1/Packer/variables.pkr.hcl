variable "aws_region" {
  type    = string
  default = "us-east-1"
}

locals {
  # Strips out dashes, colons, spaces, etc. from the timestamp
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}
