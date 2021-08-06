resource "local_file" "application1" {
  content = templatefile(var.tmplpath1,
    {
      public_dns = aws_lb.app1lb.dns_name
      consulhost = aws_instance.consul.private_ip
      rabbithost = aws_instance.rabbitmq.private_ip
    }
  )
  filename        = "../temp/serviceone.yaml"
  file_permission = "664"
}
resource "local_file" "application2" {
  content = templatefile(var.tmplpath2,
    {
      public_dns = aws_lb.app2lb.dns_name
      rds_sql    = aws_db_instance.default.endpoint
      consulhost = aws_instance.consul.private_ip
      rabbithost = aws_instance.rabbitmq.private_ip
    }
  )
  filename        = "../temp/servicetwo.yaml"
  file_permission = "0664"
}
resource "local_file" "api_file" {
  content = templatefile(var.tmplpath3,
    {
      consulhost = aws_instance.consul.private_ip
      public_dns = aws_lb.app3lb.dns_name
    }
  )
  filename        = "../temp/api.yaml"
  file_permission = "0664"
}
resource "local_file" "web_file" {
  content = templatefile(var.tmplpath4,
    {
      api_host = aws_lb.app3lb.dns_name
    }
  )
  filename        = "../temp/constants.ts"
  file_permission = "0664"
} /*
resource "local_file" "java" {
  content = templatefile(var.tmplpath5,
    {
      mongohost = aws_instance.Mongo.private_ip
    }
  )
  filename        = "../project_samples/service-one/src/main/java/com/mudigal/one/config/ReactiveMongoConfiguration.java"
  file_permission = "0664"
}*/