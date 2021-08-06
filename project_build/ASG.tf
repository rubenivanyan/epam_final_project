#Create Launch config for ServiceOne
resource "aws_launch_configuration" "serviceone" {
  name_prefix                 = "lc2"
  image_id                    = data.aws_ami.ubuntu1.id
  instance_type               = "t2.large"
  key_name                    = var.mykey
  security_groups             = [aws_security_group.main_sg.id, aws_security_group.mq_sg.id, aws_security_group.s1_lb_sg.id]
  associate_public_ip_address = false
  lifecycle {
    create_before_destroy = true
  }
  user_data = file(var.scriptpath1)
}

#Create Launch config for ServiceTwo
resource "aws_launch_configuration" "servicetwo" {
  name_prefix                 = "lc2"
  image_id                    = data.aws_ami.ubuntu2.id
  instance_type               = "t2.large"
  key_name                    = var.mykey
  security_groups             = [aws_security_group.main_sg.id, aws_security_group.mq_sg.id, aws_security_group.s2_lb_sg.id]
  associate_public_ip_address = false
  lifecycle {
    create_before_destroy = true
  }
  user_data = file(var.scriptpath2)
}
#Create Launch config for Api-gateway
resource "aws_launch_configuration" "api" {
  name_prefix                 = "lc2"
  image_id                    = data.aws_ami.ubuntu4.id
  instance_type               = "t2.micro"
  key_name                    = var.mykey
  security_groups             = [aws_security_group.main_sg.id, aws_security_group.api_lb_sg.id]
  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }
  user_data = file(var.scriptpath3)
}
#Create Launch config for WebAPP
resource "aws_launch_configuration" "webapp" {
  name_prefix                 = "lc2"
  image_id                    = data.aws_ami.ubuntu6.id
  instance_type               = "t2.large"
  key_name                    = var.mykey
  security_groups             = [aws_security_group.main_sg.id, aws_security_group.webapp_lb_sg.id]
  associate_public_ip_address = false
  lifecycle {
    create_before_destroy = true
  }
  user_data = file(var.scriptpath4)
}
#Create ASG for ServiceOne
resource "aws_autoscaling_group" "serviceone_asg" {
  name                      = "serviceone_asg"
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.serviceone.name
  vpc_zone_identifier       = [module.vpc.private_subnets[0]]
  tags = (
    [
      {
        "key"                 = "Name"
        "value"               = "ServiceOne"
        "propagate_at_launch" = true
      }
    ]
  )
}
#Create ASG for ServiceTwo
resource "aws_autoscaling_group" "servicetwo_asg" {
  name                      = "servicetwo_asg"
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.servicetwo.name
  vpc_zone_identifier       = [module.vpc.private_subnets[1]]
  tags = (
    [
      {
        "key"                 = "Name"
        "value"               = "ServiceTwo"
        "propagate_at_launch" = true
      }
    ]
  )

  lifecycle {
    create_before_destroy = true
  }
}

#Create ASG for apigateway
resource "aws_autoscaling_group" "api_asg" {
  name                      = "api_asg"
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.api.name
  vpc_zone_identifier       = [module.vpc.private_subnets[3]]
  tags = (
    [
      {
        "key"                 = "Name"
        "value"               = "apigateway"
        "propagate_at_launch" = true
      }
    ]
  )

  lifecycle {
    create_before_destroy = true
  }
}
#Create ASG for web application
resource "aws_autoscaling_group" "webapp_asg" {
  name                      = "webapp_asg"
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.webapp.name
  vpc_zone_identifier       = [module.vpc.private_subnets[3]]
  tags = (
    [
      {
        "key"                 = "Name"
        "value"               = "webapp"
        "propagate_at_launch" = true
      }
    ]
  )
  lifecycle {
    create_before_destroy = true
  }
}
#ASG attachments
resource "aws_autoscaling_attachment" "asg_attachment_1" {
  autoscaling_group_name = aws_autoscaling_group.serviceone_asg.id
  alb_target_group_arn   = aws_lb_target_group.serviceone.arn
}
resource "aws_autoscaling_attachment" "asg_attachment_2" {
  autoscaling_group_name = aws_autoscaling_group.servicetwo_asg.id
  alb_target_group_arn   = aws_lb_target_group.servicetwo.arn
}
resource "aws_autoscaling_attachment" "asg_attachment_3" {
  autoscaling_group_name = aws_autoscaling_group.api_asg.id
  alb_target_group_arn   = aws_lb_target_group.apigateway.arn
}
resource "aws_autoscaling_attachment" "asg_attachment_4" {
  autoscaling_group_name = aws_autoscaling_group.webapp_asg.id
  alb_target_group_arn   = aws_lb_target_group.webapp.arn
}