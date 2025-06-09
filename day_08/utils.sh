#!/bin/bash

# Function to greet the user
greet_user() {
    echo "Hello, $1! Welcome!"
}

# Function to backup a folder
backup_folder() {
    src="$1"
    dest="$2"
    
    if [ ! -d "$src" ]; then
        echo "Source folder '$src' does not exist."
        exit 1
    fi

    timestamp=$(date +%Y%m%d_%H%M%S)
    dest_folder="$dest/backup_$timestamp"
    mkdir -p "$dest_folder"

    echo "Backing up files from '$src' to '$dest_folder'..."
    for file in "$src"/*; do
        cp "$file" "$dest_folder/"
    done

    echo "Backup completed."
}

# Function to show help
username_1="kunle"
pwd
source_folder=$pwd
show_help() {
    echo "Usage:"
    echo "./util.sh greet $username_1"
    echo "./util.sh backup  $source_folder ./backups"
    echo "./util.sh help"
}

# Main script log   
if [ $# -lt 1 ]; then
    show_help
    exit 1
fi

command=$1

if [ "$command" == "greet" ]; then
    if [ $# -ne 2 ]; then
        echo "Error: Missing username."
        show_help
        exit 1
    fi
    greet_user "$2"
elif [ "$command" == "backup" ]; then
    if [ $# -ne 3 ]; then
        echo "Error: Missing source or destination folder."
        show_help
        exit 1
    fi
    backup_folder "$2" "$3"
elif [ "$command" == "help" ]; then
    show_help
else
    echo "Unknown command: $command"
    show_help
    exit 1
fi

