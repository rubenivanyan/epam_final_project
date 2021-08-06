#Create Image form ServiceOne installed host
resource "aws_ami_from_instance" "example1" {
  name               = "serviceone"
  source_instance_id = aws_instance.ServiceOne.id
  depends_on         = [null_resource.ansibleservices]
}
#Create Image form ServiceTwo installed host
resource "aws_ami_from_instance" "example2" {
  name               = "servicetwo"
  source_instance_id = aws_instance.ServiceTwo.id
  depends_on         = [null_resource.ansibleservices]
}
#Create Image form Consul installed host
resource "aws_ami_from_instance" "example3" {
  name               = "consul"
  source_instance_id = aws_instance.Consul.id
  depends_on         = [null_resource.ansibleconsul]
}
#Create Image form ApiGateway installed host
resource "aws_ami_from_instance" "example4" {
  name               = "apigateway"
  source_instance_id = aws_instance.ApiGateway.id
  depends_on         = [null_resource.ansibleservices]
}
/*
#Create Image form Mongo_db installed host
resource "aws_ami_from_instance" "exampledb" {
  name               = "mongo"
  source_instance_id = aws_instance.db_instance_1.id
  #depends_on         = [null_resource.ansibledb]
}*/
#Create Image form WebAPP installed host
resource "aws_ami_from_instance" "example6" {
  name               = "webapp"
  source_instance_id = aws_instance.WebApp.id
  depends_on         = [null_resource.ansibleservices]
}
#Create Image form RabbitMQ installed host
resource "aws_ami_from_instance" "example7" {
  name               = "rabbitmq"
  source_instance_id = aws_instance.RabbitMQ.id
  depends_on         = [null_resource.ansiblemq]
}
