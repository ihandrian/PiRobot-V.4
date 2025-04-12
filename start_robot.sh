#!/bin/bash

# Check if virtual environment exists
if [ ! -d "PiRobot" ]; then
    echo "Creating virtual environment..."
    python -m venv PiRobot
    source PiRobot/bin/activate
    pip install -r requirements.txt
else
    source PiRobot/bin/activate
fi

# Start the robot
python main.py 