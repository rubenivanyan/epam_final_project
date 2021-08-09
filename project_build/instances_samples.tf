#Create Consul sample instance
resource "aws_instance" "Consul" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = var.mykey
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.sample_sg.id, aws_security_group.main_sg.id]
  tags = {
    Name  = "Consul"
    Group = "Server"
  }
}
#Create Consul sample instance
resource "aws_instance" "RabbitMQ" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = var.mykey
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.sample_sg.id, aws_security_group.mq_sg.id]
  tags = {
    Name  = "RabbitMQ"
    Group = "Server"
  }
}
#Create aws_instance for db_example
resource "aws_instance" "db_instance_1" {
  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = var.mykey
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
  subnet_id              = module.vpc.public_subnets[0]
  tags = {
    Name  = "Mongo_db/Bastion"
    Group = "Database"
  }
}
#Create ServiceOne sample instance
resource "aws_instance" "ServiceOne" {
  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = var.mykey
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
  tags = {
    Name  = "ServiceOne"
    Group = "Services"
  }
}
#Create ServiceTwo sample instance
resource "aws_instance" "ServiceTwo" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = var.mykey
  subnet_id     = module.vpc.public_subnets[0]
  tags = {
    Name  = "ServiceTwo"
    Group = "Services"
  }
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
}
#Create ApiGateway sample instance
resource "aws_instance" "ApiGateway" {
  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = var.mykey
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
  tags = {
    Name  = "ApiGateway"
    Group = "Frontend"
  }
}
#Create Web applications sample instance
resource "aws_instance" "WebApp" {
  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.large"
  key_name               = var.mykey
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
  tags = {
    Name  = "WebApp"
    Group = "Frontend"
  }
}