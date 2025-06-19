#!/bin/bash

#Task 1, set up script for script for submission reminder app
#This script will create the directory structure and organize the exisitng files

echo "==Submission Reminder App Setup=="
echo "This Script will create the directory structure and organize your existing files"
echo

#prompt the user for their name
read -p "Please enter your name: " user_name

#validate name input
while [[ -z "$user_name" ]]; do
	echo -e "\e[0;31mError: Name cannot be empty!\e[0m "
	read -p "Please enter your name: " user_name
done

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
echo ""
mkdir -p "$main_dir/app"
mkdir -p "$main_dir/modules"
mkdir -p "$main_dir/assets"
mkdir -p "$main_dir/config"

echo -e "\e[0;32mSuccessfully Created:\e[0m $main_dir/app"
echo ""
echo -e "\e[0;32mSuccessfully Created:\e[0m $main_dir/modules"
echo ""
echo -e "\e[0;32mSuccessfully Created:\e[0m $main_dir/assets"
echo ""
echo -e "\e[0;32mSuccessfully Created:\e[0m $main_dir/config"
echo""

#Copy files to their respective directories
echo ""
echo "Organizing files into directory structure..."

#Copy config.env to config directory
cat <<"EOF" >> "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

#Copy functions.sh into modules directory
cat <<"EOF" >> "$main_dir/modules/functions.sh"
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
cat <<"EOF" >> "$main_dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Helen, Git, not submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
John Smith, Math Homework, submitted
Jane Doe, Math Homework, not submitted
Mike Johnson, Math Homework, submitted
Sarah Wilson, Math Homework, not submitted
Tom Brown, Math Homework, submitted
Alice Cooper, Math Homework, not submitted
Bob Davis, Math Homework, submitted
Emma Thompson, Math Homework, not submitted
Ryan Garcia, Math Homework, submitted
Lisa Martinez, Math Homework, not submitted
David Lee, Science Project, submitted
Mary Jones, Science Project, not submitted
Chris Taylor, Science Project, submitted
Jennifer White, Science Project, not submitted
Kevin Anderson, Science Project, submitted
EOF

#Copy reminder.sh into app
cat <<"EOF" >> "$main_dir/app/reminder.sh"
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

# FIXED: Create startup.sh BEFORE making files executable
cat > "${main_dir}/startup.sh" << 'EOF'
#!/bin/bash
./app/reminder.sh
EOF

#Make scripts with .sh executable
echo
echo "Making all .sh files executable..."
sleep 1
find "$main_dir" -name "*.sh" -type f -exec chmod +x {} \;



#Verify if all files are in place
echo ""
echo "Verification - checking if all files are in correct locations:"
files_to_check=(
	"$main_dir/config/config.env"
	"$main_dir/modules/functions.sh"
	"$main_dir/assets/submissions.txt"
	"$main_dir/startup.sh"
	"$main_dir/app/reminder.sh"
)

all_files_ok=true
for file in "{$files_to_check[@]}"; do
	if [[ -f "$file" ]]; then
		echo "file"
	else echo "file (MISSING!)"
		all_files_ok=false
	fi

done

chmod 777 $main_dir/startup.sh
chmod 777 $main_dir/modules/functions.sh
chmod 777 $main_dir/app/reminder.sh

chmod 777 $main_dir/config/config.env
chmod 777 $main_dir/assets/submissions.txt

if [[ "$all_files_ok" == true ]]; then
	echo "Ready to test the application!"
	echo""
	echo "To run your app:"
	echo "1. cd $main_dir/app"
	echo "2. ./startup.sh"
	echo ""
	echo "To change assignments later."
	echo  "1. Run the copilot_shell_script.sh from the main directory"
	echo ""
	echo "All the files have been organized and made executable!"
else
	echo "Some files may not haqve been copied correctly. Please check manually."
fi
echo ""
echo "Original files remain in the current directory (not deleted)"
echo "Your organized app is ready in: $main_dir"











