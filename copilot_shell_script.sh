#!/bin/bash
# Copilot Shell Script
# This script allows users to update the assignment name and rerun the checker

# Function to prompt user for exit
prompt_exit() {
    echo ""
    read -p "Do you want to exit the application? (y/n): " exit_choice

    if [[ "$exit_choice" =~ ^[Yy]$ ]]; then
        echo ""
        echo -e "\e[0;32mThank you for using the Assignment Update Tool!\e[0m"
	echo""
	sleep 1
        echo "Goodbye! Mr Herve"
	echo "Successfully Exited..."
        exit 0
    elif [[ "$exit_choice" =~ ^[Nn]$ ]]; then
        echo ""
        echo "Continuing with the application..."
        return 0
    else
        echo -e "\e[0;33mInvalid input. Please enter 'y' for yes or 'n' for no.\e[0m"
        prompt_exit  # Recursively call until valid input
    fi
}

# Function to find the submission reminder directory
find_app_directory() {
    local main_dir=""
    # Look for directories that start with "submission_reminder_"
    for dir in submission_reminder_*; do
        if [[ -d "$dir" ]]; then
            main_dir="$dir"
            break
        fi
    done

    echo "$main_dir"
}

echo "=== Assignment Update Tool ==="
echo ""
echo "This tool helps you to change the current assignment being checked."
echo ""

# Find the app directory
main_dir=$(find_app_directory)

if [[ -z "$main_dir" ]]; then
    echo -e "\e[0;31mError: No submission reminder app directory found!\e[0m"
    echo ""
    echo "Opps! please make sure you have run create_environment.sh first."
    prompt_exit
fi

echo "Found app directory: $main_dir"

SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Check if config file exists
CONFIG_FILE="$SCRIPT_DIR/$main_dir/config/config.env"
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo -e "\e[0;31mError: Configuration file not found at $CONFIG_FILE\e[0m"
    prompt_exit
fi

# Application loop
while true; do
    # Display current assignment
    echo ""
    echo "Current configuration:"
    cat "$CONFIG_FILE"
    echo ""

    # Get current assignment name
    CURRENT_ASSIGNMENT=$(grep "^ASSIGNMENT=" "$CONFIG_FILE" | cut -d'=' -f2 | tr -d '"')
    echo "Current assignment: $CURRENT_ASSIGNMENT"
    echo ""

    # Prompt for new assignment name
    while true; do
        read -p "Enter the new assignment name: " new_assignment

        # Validate input
        if [[ -z "$new_assignment" ]]; then
            echo -e "\e[0;31mError: Assignment name cannot be empty!\e[0m"
            prompt_exit
            continue  # Go back to the beginning of this inner loop
        fi

        break  # Exit the inner loop if input is valid
    done

    # Update the config file using sed
    echo "Updating assignment name..."
    sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$CONFIG_FILE"

    # Verify the change was made
    if grep -q "ASSIGNMENT=\"$new_assignment\"" "$CONFIG_FILE"; then
        echo -e "\e[0;32mAssignment updated successfully!\e[0m"
        echo "New assignment: $new_assignment"
    else
        echo -e "\e[0;31mError: Failed to update assignment name\e[0m"
        prompt_exit
        continue  # Go back to the beginning of the loop
    fi

    echo ""
    echo "Updated configuration:"
    cat "$CONFIG_FILE"
    echo ""

    # Ask if user wants to run the reminder check

    while true; do
        read -p "Would you like to run the reminder check for the new assignment? (y/n): " run_check

        if [[ "$run_check" =~ ^[Yy]$ ]]; then

            # Run the startup script
            cd $SCRIPT_DIR/$main_dir

            ./startup.sh
            break

        else
            echo "Reminder check skipped. You can run it manually later by:"
            echo "  cd $main_dir"
            echo "  ./startup.sh"
        fi

    done

    echo ""
    echo -e "\e[0;32mAssignment update process completed!\e[0m"
    echo ""
    echo "Tips:"
    echo ""
    echo "- To change assignment again, stay in this application"
    echo ""
    echo "- To check reminders anytime, run: $main_dir/app/startup.sh"
    echo ""
    echo "- To add more students, edit: $main_dir/assets/submissions.txt"

    # Ask if user wants to update another assignment or exit
    echo ""
    read -p "Would you like to update another assignment? (y/n): " continue_choice

    if [[ "$continue_choice" =~ ^[Yy]$ ]]; then
        echo ""
        echo "Starting new assignment update..."
        echo "=================================="
        continue  # Go back to the beginning of the main loop
    elif [[ "$continue_choice" =~ ^[Nn]$ ]]; then
        echo ""
        echo -e "\e[0;32mThank you for using the Assignment Update Tool!\e[0m"
        echo "Goodbye! Mr Herve it was a pleasure having you"
	echo ""
	echo "Successfully Exited..."
        exit 0
    else
        echo -e "\e[0;33mInvalid input. Asking again...\e[0m"
        prompt_exit
    fi
done
