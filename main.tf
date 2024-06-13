terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "jenkins_server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.jenkins_subnet.id
  security_groups = [aws_security_group.jenkins_sg.id]

  root_block_device {
    volume_size = 100 // specify the size here in GB
  }

  tags = {
    Name = var.instance_name
  }
}

data "aws_eip" "jenkins_eip" {
  id = var.allocation_id
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.jenkins_server.id
  allocation_id = data.aws_eip.jenkins_eip.id
}
