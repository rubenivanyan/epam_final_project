#define local variables
locals {
  vpc_id2 = module.vpc.vpc_id
}
#Create application load balancer service1
resource "aws_lb" "app1lb" {
  name               = "app1lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.s1_lb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
#Create application load balancer service2
resource "aws_lb" "app2lb" {
  name               = "app2lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.s2_lb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
#Create application load balancer api-gateway
resource "aws_lb" "app3lb" {
  name               = "app3lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.api_lb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
#Create application load balancer web-application
resource "aws_lb" "app4lb" {
  name               = "app4lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webapp_lb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
#Create target_group for service1
resource "aws_lb_target_group" "serviceone" {
  name     = "serviceone"
  port     = 8082
  protocol = "HTTP"
  vpc_id   = local.vpc_id2
  health_check {
    path = var.health_check_path1
  }

}
#Create target_group for service2
resource "aws_lb_target_group" "servicetwo" {
  name     = "servicetwo"
  port     = 8084
  protocol = "HTTP"
  vpc_id   = local.vpc_id2
  health_check {
    path = var.health_check_path2
  }
}
#Create target_group for apigateway
resource "aws_lb_target_group" "apigateway" {
  name     = "apigateway"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id2
  health_check {
    path = var.health_check_path3
  }
}
#Create target_group for web-application
resource "aws_lb_target_group" "webapp" {
  name     = "webapp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc_id2
  health_check {
    path = var.health_check_path3
  }
}
#Create listener (service1)
resource "aws_lb_listener" "listen80_1" {
  load_balancer_arn = aws_lb.app1lb.arn
  port              = "8082"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.serviceone.id
    type             = "forward"
  }
}
#Create listener (service2)
resource "aws_lb_listener" "listen80_2" {
  load_balancer_arn = aws_lb.app2lb.arn
  port              = "8084"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.servicetwo.id
    type             = "forward"
  }
}
#Create listener (api-gateway)
resource "aws_lb_listener" "listen80_3" {
  load_balancer_arn = aws_lb.app3lb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.apigateway.id
    type             = "forward"
  }
}
#Create listener (web application)
resource "aws_lb_listener" "listen80_4" {
  load_balancer_arn = aws_lb.app4lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.webapp.id
    type             = "forward"
  }
}