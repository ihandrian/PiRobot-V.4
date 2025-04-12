#!/usr/bin/env python3
"""
PiRobot V.4 Installation Test Script
This script verifies the installation and basic functionality of PiRobot V.4.
"""

import os
import sys
import importlib
import subprocess
from pathlib import Path

def check_imports():
    """Check if all required packages can be imported."""
    required_packages = [
        "numpy",
        "scipy",
        "RPi.GPIO",
        "cv2",
        "flask",
        "flask_socketio",
        "flask_cors",
        "gpsd",
        "pynmea2",
        "dotenv",
        "yaml",
        "requests"
    ]

    print("Checking required packages...")
    for package in required_packages:
        try:
            importlib.import_module(package)
            print(f"✓ {package}")
        except ImportError as e:
            print(f"✗ {package}: {e}")
            return False
    return True

def check_directories():
    """Check if all required directories exist."""
    required_dirs = [
        "src",
        "src/core",
        "src/navigation",
        "src/utils",
        "src/web",
        "src/tests",
        "docs",
        "config",
        "scripts",
        "logs"
    ]

    print("\nChecking required directories...")
    for dir_path in required_dirs:
        if Path(dir_path).exists():
            print(f"✓ {dir_path}")
        else:
            print(f"✗ {dir_path}")
            return False
    return True

def check_configuration():
    """Check if configuration file exists and is valid JSON."""
    config_path = Path("config/config.txt")
    if not config_path.exists():
        print("✗ Configuration file not found")
        return False

    try:
        import json
        with open(config_path) as f:
            json.load(f)
        print("✓ Configuration file is valid JSON")
        return True
    except json.JSONDecodeError as e:
        print(f"✗ Invalid configuration file: {e}")
        return False

def check_gpio_access():
    """Check if GPIO access is available."""
    try:
        import RPi.GPIO as GPIO
        GPIO.setmode(GPIO.BCM)
        GPIO.cleanup()
        print("✓ GPIO access available")
        return True
    except Exception as e:
        print(f"✗ GPIO access error: {e}")
        return False

def main():
    """Run all installation tests."""
    print("Starting PiRobot V.4 installation tests...\n")

    tests = [
        ("Package Imports", check_imports),
        ("Directory Structure", check_directories),
        ("Configuration File", check_configuration),
        ("GPIO Access", check_gpio_access)
    ]

    results = []
    for name, test in tests:
        print(f"\nTesting: {name}")
        try:
            result = test()
            results.append(result)
            print(f"{'✓ Passed' if result else '✗ Failed'}")
        except Exception as e:
            print(f"✗ Error: {e}")
            results.append(False)

    # Print summary
    print("\nTest Summary:")
    for (name, _), result in zip(tests, results):
        print(f"{'✓' if result else '✗'} {name}")

    if all(results):
        print("\n✓ All tests passed successfully!")
        sys.exit(0)
    else:
        print("\n✗ Some tests failed. Please check the errors above.")
        sys.exit(1)

if __name__ == "__main__":
    main() 