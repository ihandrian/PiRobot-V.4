#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status messages
print_status() {
    echo -e "${GREEN}[*] $1${NC}"
}

# Function to print error messages
print_error() {
    echo -e "${RED}[!] $1${NC}"
}

# Function to print warning messages
print_warning() {
    echo -e "${YELLOW}[!] $1${NC}"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_error "Please run as root"
    exit 1
fi

# Check if virtual environment exists
if [ ! -d "PiRobot" ]; then
    print_error "Virtual environment not found. Please run setup_pi.sh first."
    exit 1
fi

# Activate virtual environment
source PiRobot/bin/activate

# Check Python version
python_version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
if [[ $python_version < "3.8" ]]; then
    print_error "Python 3.8 or higher is required. Current version: $python_version"
    exit 1
fi

# Check required packages
required_packages=("torch" "cv2" "numpy" "flask" "RPi.GPIO")
for package in "${required_packages[@]}"; do
    if ! python3 -c "import $package" 2>/dev/null; then
        print_error "Required package $package is not installed."
        exit 1
    fi
done

# Start the robot
print_status "Starting PiRobot V.4..."
python main.py

# Handle exit
if [ $? -ne 0 ]; then
    print_error "PiRobot failed to start. Check logs for details."
    exit 1
fi 