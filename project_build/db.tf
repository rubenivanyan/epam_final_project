resource "aws_db_instance" "default" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.25"
  instance_class         = "db.t3.micro"
  name                   = "S2_db"
  username               = "user"
  password               = "password"
  skip_final_snapshot    = true
  vpc_security_group_ids = ["${aws_security_group.SQLdb_sg.id}"]
  db_subnet_group_name   = aws_db_subnet_group.def.name
}
#Create subnet group for RDS
resource "aws_db_subnet_group" "def" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[2], module.vpc.private_subnets[3]]

  tags = {
    Name = "My DB subnet group"
  }
}
/*
#make aws_Mongo_db_instance_from_image
resource "aws_instance" "Mongo" {
  ami                    = data.aws_ami.ubuntu5.id
  instance_type          = "t2.micro"
  key_name               = var.mykey
  vpc_security_group_ids = ["${aws_security_group.Mongodb_sg.id}"]
  subnet_id              = module.vpc.private_subnets[2]
  tags = {
    Name = "Mongo_db"
  }
  user_data = file(var.scriptpath6)
}*/