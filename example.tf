terraform {
  backend "s3" {
    bucket = "ritesh-aws-infrastructure-tfstate"
    key    = "devops/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "instance01" {
  ami           = "ami-09ba48996007c8b50"
  instance_type = "t2.micro"
  key_name      = "ritesh-aws-key"
  tags = {
    Name = "terraform-devops"
  }
  security_groups = ["${aws_security_group.AWSaccess.name}"]
}
resource "aws_security_group" "AWSaccess" {
  name        = "AWSaccess"
  description = "SSH access"
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}