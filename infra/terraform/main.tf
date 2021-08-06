terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
#   backend "s3" {
#     bucket = "rbasto-infra-prd"
#     key    = "setor/case/terraform.tfstate"
#     region = var.aws_region
#   }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

# data "terraform_remote_state" "case-tf" {
#   backend = "s3"
#   config = {
#     bucket = "rbasto-infra-prd"
#     key    = "setor/case/terraform.tfstate"
#     region = var.aws_region
#   }
# }

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Canonical
}


#############################
# EBS Volumes
#############################
resource "aws_ebs_volume" "server_ebs" {
  availability_zone = aws_instance.server.availability_zone
  size              = 10
  tags = {
    Name = "CASE"
  }

}

#############################
# EC2 Instance
#############################
resource "aws_instance" "server" {
  ami                    = data.aws_ami.ubuntu.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.CASE-SG.id ]
  key_name               = aws_key_pair.user.key_name

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "CASE"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.server_ebs.id
  instance_id = aws_instance.server.id
}


###########################
# Input variables
###########################

variable "aws_region" {
  type    = string
}

variable "aws_vpc" {
  type    = string
}

variable "user_public_key" {
  type    = string
}
