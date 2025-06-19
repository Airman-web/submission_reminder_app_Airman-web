#!/bin/bash
#Copilot Shell Script
# This script allows users to update the assignment name and rerun the checker

echo "=== Assignment Update Tool ==="
echo "This tool helps you to change the current assignment being checked."
echo ""

#Function to find the submission reminder directory
find_app_directory() {
	local main_dir=""
#look for directories that start with "submission_reminder_"
	for dir in submission_reminder_*; do
		if [[ -d "$dir" ]]; then
		   main_dir="$dir"
		   break
		fi
	done

	echo "$main_dir"
}
# Find the app directory

if [[ -z "$main_dir" ]]; then
    echo -e "\e[0;31mError: No submission reminder app directory found!\e[0m"
    echo ""
    echo "Please make sure you have run create_environment.sh first."
    exit 1
fi

echo "Found app directory: $main_dir"

# Check if config file exists
CONFIG_FILE="$main_dir/config/config.env"
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo -e "\e[0;31mError: Configuration file not found at $CONFIG_FILE\e[0m"
    exit 1
fi

# Display current assignment
echo ""
echo " Current configuration:"
cat "$CONFIG_FILE"
echo ""

# Get current assignment name
CURRENT_ASSIGNMENT=$(grep "^ASSIGNMENT=" "$CONFIG_FILE" | cut -d'=' -f2 | tr -d '"')
echo "Current assignment: $CURRENT_ASSIGNMENT"
echo ""

# Prompt for new assignment name
read -p "Enter the new assignment name: " new_assignment

# Validate input
if [[ -z "$new_assignment" ]]; then
    echo -e "\e[0;31mError: Assignment name cannot be empty!\e[0m"
    exit 1
fi

# Update the config file using sed
echo " Updating assignment name..."
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$CONFIG_FILE"

# Verify the change was made
if grep -q "ASSIGNMENT=\"$new_assignment\"" "$CONFIG_FILE"; then
    echo -e "\e[0;32mAssignment updated successfully!\e[0m"
    echo "New assignment: $new_assignment"
else
    echo -e"\e[0;31mError: Failed to update assignment name\e[0m"
    exit 1
fi

echo""
echo "Updated configuration:"
cat "$CONFIG_FILE"
echo ""

# Ask if user wants to run the reminder check
read -p "Would you like to run the reminder check for the new assignment? (y/n): " run_check

if [[ "$run_check" =~ ^[Yy]$ ]]; then
    echo ""
    echo "Running reminder check for '$new_assignment'..."
    echo "=================================="

    # Change to app directory and run startup script
    cd "$APP_DIR/app" || {
        echo -e "\e[0;31mError: Cannot navigate to app directory\e[0m"
        exit 1
    }

    # Run the startup script
    ./startup.sh

    echo
    echo " Reminder check completed!"
else
    echo " Reminder check skipped. You can run it manually later by:"
    echo " cd $APP_DIR/app"
    echo "   ./startup.sh"
fi

echo
echo -e "\e[0;32mAssignment update process completed!\e[0m"
echo ""
echo " Tips:"
echo ""
echo " - To change assignment again, run this script again"
echo ""
echo " - To check reminders anytime, run: $APP_DIR/app/startup.sh"
echo ""
echo " - To add more students, edit: $APP_DIR/assets/submissions.txt"
