#!/bin/bash

# Get the directory where the script is located
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Set test folder path inside the project folder
TEST_DIR="$PROJECT_DIR/test_env"

# Create the test folder
mkdir -p "$TEST_DIR"

echo "Test folder created at: $TEST_DIR"

