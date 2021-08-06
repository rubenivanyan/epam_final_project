#!/bin/bash

home="/home/"
user=$(whoami)
projectpath="/epam_final_project/project_build/"
path="$home$user$projectpath"
echo "${path}" > nm.txt
cd ${path}
	terraform init 
        terraform apply --auto-approve
