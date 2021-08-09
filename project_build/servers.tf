#make Consulhost
resource "aws_instance" "consul" {
  ami                    = data.aws_ami.ubuntu3.id
  instance_type          = "t2.micro"
  key_name               = var.mykey
  vpc_security_group_ids = ["${aws_security_group.main_sg.id}"]
  #subnet_id              = module.vpc.public_subnets[1]
  subnet_id = module.vpc.private_subnets[0]
  tags = {
    Name = "Consul"
  }
  user_data = file(var.scriptpath5)
}
#make RabbitMQhost
resource "aws_instance" "rabbitmq" {
  ami                    = data.aws_ami.ubuntu7.id
  instance_type          = "t2.micro"
  key_name               = var.mykey
  vpc_security_group_ids = ["${aws_security_group.mq_sg.id}"]
  #subnet_id              = module.vpc.public_subnets[1]
  subnet_id = module.vpc.private_subnets[0]
  tags = {
    Name = "RabbitMQ"
  }
  user_data = file(var.scriptpath6)
}