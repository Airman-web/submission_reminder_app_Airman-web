#!/bin/bash

#Task 1, set up script for script for submission reminder app
#This script will create the directory structure and organize the exisitng files

echo "==Submission Reminder App Setup=="
echo "This Script will create the directory structure and organize your existing files"
echo 

#Check if all required files exists in the directory
required_files=("subimissions.txt" "config.env" "startup.sh" "reminder.sh" "functions.sh")
missing_files=()

echo "Checking for required files in current directory..."
for file in "${required_files[@]}"; do 
	if [[ -f "$file" ]]; then 
		echo " found $file"
	else " Error Missing: $file"
		missing_files+=("$file")
	fi
done
#Exist if files are missing
if [[ ${missing_files[@]}"; do
	echo " - $file"
done
echo
echo "Required files for the app:"
echo " - submissions.txt (student submission records)"
echo " - config.env (application configuration)"
echo " - startup.sh (main startup script)"
echo " - reminder.sh (reminder logic script)"
echo " - functions.sh (helper functions script)"
echo
echo "Please make sure all these files are in the same directory as create_environment.sh"



