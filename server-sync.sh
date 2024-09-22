#!/bin/bash

retry_command() {
    local command=$1
    local retries=$2
    local retry_count=0

    until [ $retry_count -ge $retries ]; do
        echo "Attempt $(($retry_count+1))/$retries: $command"
        $command
        if [ $? -eq 0 ]; then
            echo "$command succeeded."
            return 0
        else
            echo "$command failed. Retrying..."
            ((retry_count++))
            sleep 5  # Wait 5 seconds before retrying
        fi
    done

    echo "$command failed after $retries retries."
    return 1
}

echo "Starting snapraid sync..."
retry_command "snapraid sync" 5

echo "Running Python script..."
retry_command "python3 upload-sync.py" 5

echo "All tasks completed."
