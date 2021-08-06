#!/bin/bash

list1="project_build/templates/script.txt"
list2="project_build/templates/template.txt"
user=$(whoami)

i=0
while read script && [ $i -le 0 ];
do
	 i=$((i+1))
echo "variable "cred" {
  type    = string
  default = \"/home/$user/credentials\"
}" >> temp/var.tf

done < $list1

i=0
while read script || [ $i -le 6 ];
do
        i=$((i+1))
echo "variable "scriptpath$i" {
  type    = string
  default = \"/home/$user/epam_final_project/project_build/scripts/$script\"
}" >> temp/var.tf

done < $list1
i=0
while read template || [ $i -le 3 ];
do
	i=$((i+1))
echo "variable "tmplpath$i" {
  type    = string
  default = \"/home/$user/epam_final_project/project_build/templates/$template\"
} " >> temp/var.tf

done < $list2

cp temp/var.tf temp/var_temp.tf
mv temp/var.tf /home/$user/epam_final_project/project_build/variable.tf
