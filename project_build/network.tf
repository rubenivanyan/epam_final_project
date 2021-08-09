locals {
  vpc_id                     = module.vpc.vpc_id
  sec_group_lb_to_ec2_s1     = [aws_security_group.s1_lb_sg.id]
  sec_group_lb_to_ec2_s2     = [aws_security_group.s2_lb_sg.id]
  sec_group_lb_to_ec2_api    = [aws_security_group.api_lb_sg.id]
  sec_group_lb_to_ec2_webapp = [aws_security_group.webapp_lb_sg.id]
  sec_group_ec2_to_db        = [aws_security_group.main_sg.id]
}
#Create VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                   = "epamproject"
  cidr                   = "10.10.0.0/16"
  azs                    = ["us-east-1a", "us-east-1b"]
  public_subnets         = ["10.10.10.0/24", "10.10.20.0/24"]
  private_subnets        = ["10.10.30.0/24", "10.10.40.0/24", "10.10.50.0/24", "10.10.60.0/24", "10.10.70.0/24"]
  enable_dns_hostnames   = true
  enable_dns_support     = true
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  tags = {
    Name = "epamproject"
  }
}
#Subnet tags
resource "aws_ec2_tag" "mytagS0" {
  resource_id = module.vpc.public_subnets[0]
  key         = "Name"
  value       = "instances_samples"
}
resource "aws_ec2_tag" "mytagS1" {
  resource_id = module.vpc.public_subnets[1]
  key         = "Name"
  value       = "test"
}
resource "aws_ec2_tag" "mytagS2" {
  resource_id = module.vpc.private_subnets[0]
  key         = "Name"
  value       = "server_subnet"
}
resource "aws_ec2_tag" "mytagS3" {
  resource_id = module.vpc.private_subnets[1]
  key         = "Name"
  value       = "db_subnet_1"
}
resource "aws_ec2_tag" "mytagS4" {
  resource_id = module.vpc.private_subnets[2]
  key         = "Name"
  value       = "db_subnet_2"
}
resource "aws_ec2_tag" "mytagS5" {
  resource_id = module.vpc.private_subnets[3]
  key         = "Name"
  value       = "backend"
}
resource "aws_ec2_tag" "mytagS6" {
  resource_id = module.vpc.private_subnets[4]
  key         = "Name"
  value       = "frontend"
}
#Main security group
resource "aws_security_group" "main_sg" {
  name        = "main_sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = local.vpc_id

  dynamic "ingress" {
    for_each = ["8600", "8500", "8300", "8301"]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_security_group" "sample_sg" {
  name        = "sample_sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = local.vpc_id

  ingress {
    description      = "HTTP from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_security_group" "mq_sg" {
  name        = "mq_sg"
  description = "Allow mq inbound traffic"
  vpc_id      = local.vpc_id
  dynamic "ingress" {
    for_each = ["15672", "5672", "25672"]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
#Load balancer security groups
resource "aws_security_group" "s1_lb_sg" {
  name        = "s1_lb_sg"
  description = "Allow http inbound traffic"
  vpc_id      = local.vpc_id
  ingress {
    description      = "HTTP from anywhere"
    from_port        = 8082
    to_port          = 8082
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_security_group" "s2_lb_sg" {
  name        = "s2_lb_sg"
  description = "Allow http inbound traffic"
  vpc_id      = local.vpc_id
  ingress {
    description      = "HTTP from anywhere"
    from_port        = 8084
    to_port          = 8084
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_security_group" "api_lb_sg" {
  name        = "api_lb_sg"
  description = "Allow http inbound traffic"
  vpc_id      = local.vpc_id
  ingress {
    description      = "HTTP from anywhere"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_security_group" "webapp_lb_sg" {
  name        = "webapp_lb_sg"
  description = "Allow http inbound traffic"
  vpc_id      = local.vpc_id
  ingress {
    description      = "HTTP from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
#SQL security group
resource "aws_security_group" "SQLdb_sg" {
  name        = "SQLdb_sg"
  description = "Allow connection to database"
  vpc_id      = local.vpc_id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = local.sec_group_ec2_to_db
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}/*
#Mongo security group
resource "aws_security_group" "Mongodb_sg" {
  name        = "Mongodb_sg"
  description = "Allow connection to database"
  vpc_id      = local.vpc_id
  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = local.sec_group_ec2_to_db
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = local.sec_group_ec2_to_db
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}*/