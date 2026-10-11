
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "app_sg" {
  name        = "devops-app-sg"
  description = "Security group for the Node.js application"


  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  ingress {
    description = "Node.js application"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-app-sg"
  }
}


resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type           = var.instance_type
  vpc_security_group_ids = [aws_security_group.app_sg.id]


  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    dnf install -y docker
    systemctl enable --now docker

    docker pull subodhdhamala/nodejs-cicd-pipeline:latest

    docker run -d \
      --restart unless-stopped \
      --name nodejs-app \
      -p 3000:3000 \
      subodhdhamala/nodejs-cicd-pipeline:latest
  EOF


  user_data_replace_on_change = true

  tags = {
    Name = "devops-app-server"
  }
}
