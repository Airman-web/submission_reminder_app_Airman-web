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
sleep 1
for file in "${required_files[@]}"; do 
	if [[ -f "$file" ]]; then 
		echo " found $file"
	else 
		echo " Error Missing: $file"
		missing_files+=("$file")
	fi
done

#Exist if files are missing
if [[ ${#missing_files[@]} -gt 0 ]]; then
	echo "Error: The following files are missing from the current directorie:"
	for file in "${missing_files[@]}"; do 
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
exit 1

fi
echo 
sleep 1
echo "All required files found!"
echo

#prompt the user for their name
read -p "Please enter your name: " user_name

#validate name input
if [[ -z "$user_name" ]]; then
	echo "Error: Name cannot be empty! "
	exit 1
fi

#Create the main directory
main_dir="submission_reminder_${user_name}"
echo "Creating main directory...: $main_dir"
sleep 1

#Remove directory if it already exsits
if [[ -d "$main_dir" ]]; then
       echo "Directory $main_dir already exists. Removing it..."
        rm -rf "$main_dir"  
fi
mkdir -p "$main_dir"








