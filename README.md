# Submission Reminder App
A bash-based application that helps track student assignment submissions and sends reminders for pending submissions.
## Overview
The Submission Reminder App is a command-line tool designed to help educators and administrators track student assignment submissions. It reads from a CSV file containing student data and identifies students who haven't submitted their assignments, providing automated reminders.

## Features

- **Automated Setup**: Creates organized directory structure with all necessary files
- **Assignment Tracking**: Monitors submission status for specific assignments
- **Dynamic Assignment Updates**: Change which assignment to check without manual file editing
- **Color-coded Output**: Visual feedback with colored terminal output
- **Validation**: Input validation for user entries
- **Modular Design**: Organized code structure with separate modules for different functions

## Project Structure

```
submission_reminder_Ayo/
├── app/
│   └── reminder.sh              # Main application script
├── assets/
│   └── submissions.txt          # Student submission data (CSV format)
├── config/
│   └── config.env              # Configuration variables
├── modules/
│   └── functions.sh            # Helper functions
└── startup.sh                  # Application entry point
```
## Installation & Setup
### Step 1: Initial Setup

1. **Download/clone**:
   ```bash
   git https://github.com/Airman-web/submission_reminder_app_Airman-web.git
   cd submission_reminder_app_Airman-web
   chmod +x create_environment.sh
   ```
2. **Run the setup script**:
   ```bash
   ./create_environment.sh
   ```
3. **Follow the prompts**:
   - Enter your name when prompted
   - The script will create a directory named `submission_reminder_[your_name]`
   - All necessary files and directories will be created automatically

## Usage
### Running the Main Application
1. **Navigate to the app directory**:
   ```bash
   cd submission_reminder_[your_name]
   ```

2. **Run the application**:
   ```bash
   ./startup.sh
   ```

3. **Expected Output**:
   ```
   Assignment: Shell Navigation
   Days remaining to submit: 2 days
   --------------------------------------------
   Checking submissions in ./assets/submissions.txt
   Reminder: Chinemerem has not submitted the Shell Navigation assignment!
   Reminder: Divine has not submitted the Shell Navigation assignment!
   ```

### Updating Assignment Settings

1. **Run the assignment update tool**:
   ```bash
   # From the main directory (where create_environment.sh is located)
   ./copilot_shell_script.sh
   ```

2. **Follow the interactive prompts**:
   - View current assignment configuration
   - Enter new assignment name
   - Choose whether to run immediate check
   - Option to update additional assignments

3. **Example Session**:
   ```
   === Assignment Update Tool ===
   Current assignment: Shell Navigation
   Enter the new assignment name: Git
   Assignment updated successfully!
   Would you like to run the reminder check for the new assignment? (y/n): y
   ```
## Configuration
### Environment Variables (`config/config.env`)

```bash
# This is the config file
ASSIGNMENT="Shell Navigation"    # Current assignment to check
DAYS_REMAINING=2                # Days left for submission
```
### Student Data Format (`assets/submissions.txt`)

The submissions file uses CSV format with the following structure:
```csv
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Helen, Git, not submitted
```

**Column Descriptions**:
- **student**: Student's full name
- **assignment**: Assignment name (must match ASSIGNMENT in config.env)
- **submission status**: Either "submitted" or "not submitted"

## Customization

### Adding New Students

Edit `assets/submissions.txt`:
```bash
cd submission_reminder_[your_name]
vi assets/submissions.txt
```

Add new entries following the CSV format:
```csv
New Student Name, Assignment Name, not submitted
```

### Error Messages
- **"Error: Name cannot be empty!"**: Enter a valid name during setup
- **"Error: No submission reminder app directory found!"**: Run create_environment.sh first
- **"Error: Configuration file not found"**: Check if config/config.env exists

## File Descriptions
### Core Scripts
- **`create_environment.sh`**: Initial setup script that creates directory structure and files
- **`copilot_shell_script.sh`**: Interactive tool for updating assignment configurations
- **`startup.sh`**: Entry point that launches the main reminder application
- **`app/reminder.sh`**: Main application logic that processes submissions and displays reminders

### Supporting Files

- **`modules/functions.sh`**: Contains the `check_submissions` function
- **`config/config.env`**: Environment variables for assignment and deadline configuration
- **`assets/submissions.txt`**: CSV database of student submissions

## Advanced Usage
### Batch Processing Multiple Assignments
You can run the copilot script multiple times to check different assignments:
```bash
./copilot_shell_script.sh
# Update to "Math Homework"
# Run check
# Continue and update to "Science Project"
# Run check
```
