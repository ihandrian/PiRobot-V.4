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

# Check if running on Raspberry Pi
if ! grep -q "Raspberry Pi" /proc/device-tree/model; then
    print_error "This script is intended to run on a Raspberry Pi!"
    exit 1
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_error "Please run as root"
    exit 1
fi

print_status "Starting Raspberry Pi 3B setup for PiRobot V.4..."

# Update system
print_status "Updating system packages..."
apt-get update
apt-get upgrade -y

# Install system dependencies for OpenCV
print_status "Installing OpenCV dependencies..."
apt-get install -y \
    python3-pip \
    python3-dev \
    libatlas-base-dev \
    libjasper-dev \
    libqtgui4 \
    python3-pyqt5 \
    libqt4-test \
    libhdf5-dev \
    libhdf5-serial-dev \
    libhdf5-103 \
    libqtgui4 \
    libqtwebkit4 \
    libqt4-test \
    python3-pyqt5 \
    libatlas-base-dev \
    libjasper-dev \
    libwebp-dev \
    libtiff-dev \
    libopenexr-dev \
    libgstreamer1.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libgtk-3-dev \
    libgtk2.0-dev \
    libgtk-3-dev \
    libblas-dev \
    liblapack-dev \
    gfortran \
    python3-h5py

# Install other system dependencies
print_status "Installing other system dependencies..."
apt-get install -y \
    git \
    build-essential \
    cmake \
    pkg-config \
    python3-opencv

# Configure swap space
print_status "Configuring swap space..."
if [ ! -f /etc/dphys-swapfile ]; then
    apt-get install -y dphys-swapfile
fi

# Set swap size to 2GB
sed -i 's/CONF_SWAPSIZE=.*/CONF_SWAPSIZE=2048/' /etc/dphys-swapfile

# Restart swap service
systemctl restart dphys-swapfile

# Install Python dependencies
print_status "Installing Python dependencies..."

# Create and activate virtual environment
python3 -m venv PiRobot
source PiRobot/bin/activate

# Upgrade pip
pip install --upgrade pip setuptools wheel

# Install numpy first (required for OpenCV)
pip install numpy==1.21.6

# Install OpenCV
print_status "Installing OpenCV..."
pip install opencv-python==4.5.3.56

# Install PyTorch
print_status "Installing PyTorch..."
pip install torch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

# Install other requirements
print_status "Installing other requirements..."
pip install -r requirements.txt

# Install Coral TPU dependencies if requested
read -p "Do you want to install Coral TPU support? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Installing Coral TPU dependencies..."
    echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    apt-get update
    apt-get install -y libedgetpu1-std
    pip install pycoral tflite-runtime
fi

# Optimize system settings
print_status "Optimizing system settings..."

# Increase GPU memory
sed -i 's/gpu_mem=.*/gpu_mem=256/' /boot/config.txt

# Enable camera if not already enabled
if ! grep -q "start_x=1" /boot/config.txt; then
    echo "start_x=1" >> /boot/config.txt
fi

# Enable I2C and SPI
raspi-config nonint do_i2c 0
raspi-config nonint do_spi 0

# Set CPU governor to performance
echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Verify OpenCV installation
print_status "Verifying OpenCV installation..."
python3 -c "import cv2; print(f'OpenCV version: {cv2.__version__}')"

print_status "Setup completed successfully!"
print_warning "Please reboot your Raspberry Pi for all changes to take effect."
print_warning "After reboot, activate the virtual environment with: source PiRobot/bin/activate"

# Create a test script
cat > test_installation.py << 'EOF'
import sys
import platform
import torch
import cv2
import numpy as np
import RPi.GPIO as GPIO

def test_installation():
    print("Testing PiRobot V.4 installation...")
    
    # Test Python version
    print(f"Python version: {sys.version}")
    
    # Test system info
    print(f"System: {platform.system()} {platform.release()}")
    print(f"Machine: {platform.machine()}")
    
    # Test OpenCV
    print("\nTesting OpenCV...")
    print(f"OpenCV version: {cv2.__version__}")
    print(f"OpenCV build info: {cv2.getBuildInformation()}")
    
    # Test PyTorch
    print("\nTesting PyTorch...")
    print(f"PyTorch version: {torch.__version__}")
    print(f"CUDA available: {torch.cuda.is_available()}")
    
    # Test NumPy
    print("\nTesting NumPy...")
    print(f"NumPy version: {np.__version__}")
    
    # Test GPIO
    print("\nTesting GPIO...")
    try:
        GPIO.setmode(GPIO.BCM)
        print("GPIO test successful")
    except Exception as e:
        print(f"GPIO test failed: {e}")
    
    print("\nInstallation test completed!")

if __name__ == "__main__":
    test_installation()
EOF

print_status "Created test script: test_installation.py"
print_status "Run 'python test_installation.py' to verify the installation" 