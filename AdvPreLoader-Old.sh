#!/usr/bin/env bash

# BLING PreLoader Utility
#
# TODO: Add to BLING
# 	Enable Cecho

####################################################################################################################################
# Define Files and Folders.													   #
####################################################################################################################################


CONFIG_DIR="$(pwd)/config"

# CONFIG_FILE="test.ini"
#  CONFIG_FILE="config.ini"
  CONFIG_FILE="FLIPTool-2026.conf"

FUNC_DIR="$(pwd)/functions"
FUNC_FILE="lib_ini.bfunc"

# Colors for Cecho-like output
COLORS_FILE="Colors.conf"

# Source our Color Config
if [ -f "$CONFIG_DIR"/"$COLORS_FILE" ]; then
        source "$CONFIG_DIR"/"$COLORS_FILE"
fi

####################################################################################################################################
# Display Stuff															   #
####################################################################################################################################

echo " "
echo "BLING PreLoader Utility"
echo "-----------------------"
echo " "

function DisplayLine() {
	echo " ${brightblue}__________________________________________________${reset}"
}

function NewLine() {
	echo " "
}


####################################################################################################################################
# Source If Exists Function 													   #
####################################################################################################################################
# Function to source files in a given directory with a specific extension

source_files_if_exist() {
    local dir="$1"
    local pattern="$2"
    if [[ -d "$dir" ]]; then
        echo "${brightwhite} Sourcing files from: ${brightyellow} $dir ${reset}"
	echo "-------------------------------------------------------------------------------------------"
	# Use a glob to find matching files and loop through them
        for file in "$dir"/$pattern; do
            # Check if the glob found actual files (and not just the literal pattern if no files match)
            if [[ -f "$file" ]]; then
                echo "  ${brightyellow} Sourcing: ${brightblue} $file"
                source "$file"
            fi
        done
    else
        echo "Directory not found: $dir"
    fi
}

# DisplayLine

####################################################################################################################################
# Source configuration files													   #
####################################################################################################################################

## source_files_if_exist "config" "*.conf"
source_files_if_exist "$(pwd)/config" "*.conf"
# DisplayLine
NewLine

# Source function files
## source_files_if_exist "functions" "*.bfunc"
source_files_if_exist "$(pwd)/functions" "*.bfunc"
# DisplayLine
NewLine

# Source profile files
## source_files_if_exist "profiles" "*.bprofile"
source_files_if_exist "$(pwd)/profiles" "*.bprofile"
# DisplayLine
NewLine


####################################################################################################################################
# Finish PreLoad														   #
####################################################################################################################################
# Continue with the rest of your script...

DisplayLine
echo "Advanced Preload Completed."
NewLine
