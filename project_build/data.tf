#Get aws_account username id
data "aws_caller_identity" "current" {}
#Dataset from ServiceOne image
data "aws_ami" "ubuntu1" {
  most_recent = true

  filter {
    name   = "name"
    values = ["serviceone"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [data.aws_caller_identity.current.account_id] # MySelf
  depends_on = [
    aws_ami_from_instance.example1
  ]
}
#Dataset from ServiceTwo image
data "aws_ami" "ubuntu2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["servicetwo"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [data.aws_caller_identity.current.account_id] # MySelf
  depends_on = [
    aws_ami_from_instance.example2
  ]
}
#Dataset from Consul image
data "aws_ami" "ubuntu3" {
  most_recent = true

  filter {
    name   = "name"
    values = ["consul"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [data.aws_caller_identity.current.account_id] # MySelf
  depends_on = [
    aws_ami_from_instance.example3
  ]
}
#Dataset from ApiGateway image
data "aws_ami" "ubuntu4" {
  most_recent = true

  filter {
    name   = "name"
    values = ["apigateway"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [data.aws_caller_identity.current.account_id] # MySelf
  depends_on = [
    aws_ami_from_instance.example4
  ]
} /*
#Dataset from Mongo_db image
data "aws_ami" "ubuntu5" {
  most_recent = true

  filter {
    name   = "name"
    values = ["mongo"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [data.aws_caller_identity.current.account_id] # MySelf
}*/
#Dataset from ApiGateway image
data "aws_ami" "ubuntu6" {
  most_recent = true

  filter {
    name   = "name"
    values = ["webapp"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [data.aws_caller_identity.current.account_id] # MySelf
  depends_on = [
    aws_ami_from_instance.example6
  ]
}
#Dataset from ApiGateway image
data "aws_ami" "ubuntu7" {
  most_recent = true

  filter {
    name   = "name"
    values = ["rabbitmq"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [data.aws_caller_identity.current.account_id] # MySelf
  depends_on = [
    aws_ami_from_instance.example7
  ]
}
