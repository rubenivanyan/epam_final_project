#Run ansible
resource "null_resource" "ansibleservices" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/aws_ec2.yaml ../ansible/playbook.yaml --vault-password-file ../../n.txt --tags webap"

  }
  depends_on = [/*aws_ami_from_instance.exampledb, */ aws_ami_from_instance.example3, aws_ami_from_instance.example7]
}
resource "null_resource" "ansibleservices1" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/aws_ec2.yaml ../ansible/playbook.yaml --vault-password-file ../../n.txt --tags s1"

  }
  depends_on = [/*aws_ami_from_instance.exampledb, */ aws_ami_from_instance.example3, aws_ami_from_instance.example7]
}
resource "null_resource" "ansibleservices2" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/aws_ec2.yaml ../ansible/playbook.yaml --vault-password-file ../../n.txt --tags api"

  }
  depends_on = [/*aws_ami_from_instance.exampledb, */ aws_ami_from_instance.example3, aws_ami_from_instance.example7]
}
resource "null_resource" "ansibleservices3" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/aws_ec2.yaml ../ansible/playbook.yaml --vault-password-file ../../n.txt  --tags s2"

  }
  depends_on = [/*aws_ami_from_instance.exampledb, */ aws_ami_from_instance.example3, aws_ami_from_instance.example7]
}
resource "time_sleep" "sleep" {

  create_duration = "120s"
  depends_on      = [aws_instance.Consul, aws_instance.RabbitMQ, aws_instance.db_instance_1]
} /*
#runansible, make DB images
resource "null_resource" "ansibledb" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/aws_ec2.yaml ../ansible/dbplaybook.yaml --vault-password-file ../../n.txt"
  }
  depends_on = [time_sleep.sleep ]
}*/
resource "null_resource" "ansibleconsul" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/aws_ec2.yaml ../ansible/playbook.yaml --vault-password-file ../../n.txt --tags consul"
  }
  depends_on = [time_sleep.sleep]
}
resource "null_resource" "ansiblemq" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/aws_ec2.yaml ../ansible/playbook.yaml --vault-password-file ../../n.txt --tags mq"
  }
  depends_on = [time_sleep.sleep]
}