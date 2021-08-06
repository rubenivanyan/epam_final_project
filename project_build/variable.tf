variable "health_check_path1" {
  type    = string
  default = "/swagger-ui/index.html"
}
variable "health_check_path2" {
  type    = string
  default = "/swagger-ui.html"
}
variable "health_check_path3" {
  type    = string
  default = "/"
}
variable "cred" {
  type    = string
  default = "/home/ruben/credentials"
}
variable "mykey" {
  type    = string
  default = "Consuldemo"
}
variable scriptpath1 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/scripts/S1.sh"
}
variable scriptpath2 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/scripts/S2.sh"
}
variable scriptpath3 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/scripts/S3.sh"
}
variable scriptpath4 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/scripts/webapp.sh"
}
variable scriptpath5 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/scripts/consul.sh"
}
variable scriptpath6 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/scripts/rabbit.sh"
}
variable scriptpath7 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/scripts/mongo.sh"
}
variable tmplpath1 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/templates/serviceone.template"
} 
variable tmplpath2 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/templates/servicetwo.template"
} 
variable tmplpath3 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/templates/api.template"
} 
variable tmplpath4 {
  type    = string
  default = "/home/ruben/epam_final_project/project_build/templates/constants.template"
} 
