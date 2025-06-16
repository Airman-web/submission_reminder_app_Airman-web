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

#Create subdirectories
echo "creating subdirectories..."
mkdir -p "$main_dir/app"
mkdir -p "$main_dir/modules"
mkdir -p "$main_dir/assets"
mkdir -p "$main_dir/config"

echo "Created: $main_dir/app"
echo "Created: $main_dir/modules"
echo "Created: $main_dir/assets"
echo "Created: $main_dir/config"

#Copy files to their respective directories
echo 
echo "Organizing files into directory structure..."

#Copy config.env to config directory
cat <<EOF >> "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

#Copy functions.sh into modules directory
cat <<EOF >> "$main_dir/modules/fucntions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

#Copy submissions.txt into assets directory
cat <<EOF >> "$main_dir/submissions.txt/assets"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
John Smith,Math Homework,submitted
Jane Doe,Math Homework,not_submitted
Mike Johnson,Math Homework,submitted
Sarah Wilson,Math Homework,not_submitted
Tom Brown,Math Homework,submitted
Alice Cooper,Math Homework,not_submitted
Bob Davis,Math Homework,submitted
Emma Thompson,Math Homework,not_submitted
Ryan Garcia,Math Homework,submitted
Lisa Martinez,Math Homework,not_submitted
David Lee,Science Project,submitted
Mary Jones,Science Project,not_submitted
Chris Taylor,Science Project,submitted
Jennifer White,Science Project,not_submitted
Kevin Anderson,Science Project,submitted
EOF

#Copy reminder.sh into app
cat <<EOF >> "$main_dir/reminder.sh/app"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF












