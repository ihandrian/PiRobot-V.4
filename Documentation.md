# PiRobot V.4 Documentation

## Table of Contents
1. [System Overview](#system-overview)
2. [Hardware Requirements](#hardware-requirements)
3. [Software Dependencies](#software-dependencies)
4. [Hardware Configuration](#hardware-configuration)
5. [Core Components](#core-components)
6. [Safety Features](#safety-features)
7. [Performance Optimization](#performance-optimization)
8. [Troubleshooting](#troubleshooting)

## System Overview

PiRobot V.4 is a sophisticated robot control system optimized for Raspberry Pi 3B. It implements real-time control, safety monitoring, and autonomous navigation capabilities while maintaining efficient resource usage.

### Key Features
- Real-time person detection and tracking
- Autonomous navigation with obstacle avoidance
- Temperature monitoring and protection
- Resource-aware performance optimization
- Web-based control interface
- Comprehensive safety monitoring

## Hardware Requirements

### Essential Components
- Raspberry Pi 3B
- L298N H-Bridge Motor Driver
- HC-SR04 Ultrasonic Sensor
- Air530Z GPS Module
- Logitech C270 Webcam
- Raspberry Pi Camera Module
- Google Coral TPU
- Power supply (12V, 2.5A minimum)

### Recommended Setup
- Heatsink for Raspberry Pi
- Cooling fan (optional)
- Battery backup system
- Emergency stop button
- Status LEDs

## Software Dependencies

### System Requirements
- Raspberry Pi OS (64-bit recommended)
- Python 3.7 or higher
- OpenCV 4.5 or higher
- TensorFlow Lite 2.5 or higher
- PyCoral API for Coral TPU
- RPi.GPIO library
- pigpio library for PWM
- gpsd for GPS support
- v4l2-ctl for USB camera control

### Python Packages
```bash
pip install:
- opencv-python>=4.5.0
- numpy>=1.19.0
- tensorflow-lite>=2.5.0
- pycoral>=2.0.0
- RPi.GPIO>=0.7.0
- pigpio>=1.78
- gpsd-py3>=0.3.0
- v4l2-python3>=0.1.0
```

## Hardware Configuration

### Power System
```
Main Power Supply (12V, 2.5A)
        |
        +---> L298N Motor Driver (12V)
        |
        +---> 5V Regulator
                |
                +---> Raspberry Pi 3B
                |
                +---> Sensors (5V)
                |
                +---> USB Devices
```

### GPIO Configuration
| Pin | Function | Component | Notes |
|-----|----------|-----------|-------|
| GPIO2 | PWM | Motor A Speed | Hardware PWM |
| GPIO3 | PWM | Motor B Speed | Hardware PWM |
| GPIO4 | Direction | Motor A Direction | High/Low |
| GPIO17 | Direction | Motor B Direction | High/Low |
| GPIO23 | Trigger | HC-SR04 | Output |
| GPIO24 | Echo | HC-SR04 | Input (5V to 3.3V) |
| GPIO14 | TXD | Air530Z GPS | UART |
| GPIO15 | RXD | Air530Z GPS | UART |
| GPIO5 | Status LED | System Status | PWM |
| GPIO6 | Warning LED | Error Status | PWM |
| GPIO27 | Emergency Stop | Safety | Pull-up |

### USB Devices
| Port | Device | Notes |
|------|--------|-------|
| USB 2.0 | Logitech C270 | Video input |
| USB 2.0 | Coral TPU | AI acceleration |
| CSI | Raspberry Pi Camera | Video input |

### Interface Configuration
| Interface | Pins | Component | Notes |
|-----------|------|-----------|-------|
| UART | GPIO14, GPIO15 | Air530Z GPS | 9600 baud |
| PWM | GPIO2, GPIO3 | Motor Control | 50Hz |
| PWM | GPIO5, GPIO6 | LED Control | 50Hz |

## Component Dependencies

### Motor Control
- L298N H-Bridge
  - Requires 12V power supply
  - Needs heat sinking for high current
  - Requires current limiting resistors
  - Depends on pigpio for PWM

### Sensors
- HC-SR04
  - Requires voltage level shifting
  - Needs noise filtering
  - Depends on RPi.GPIO
- Air530Z GPS
  - Requires clear sky view
  - Needs gpsd service
  - Depends on UART configuration

### Cameras
- Logitech C270
  - Requires v4l2-ctl
  - Needs USB power management
  - Depends on OpenCV
- Raspberry Pi Camera
  - Requires CSI interface
  - Needs camera interface enabled
  - Depends on picamera library

### Coral TPU
- Requires USB power management
- Needs PyCoral API
- Depends on TensorFlow Lite
- Requires specific driver installation

## Error Codes
| Code | Component | Description | Solution |
|------|-----------|-------------|----------|
| E101 | Motor A | PWM failure | Check GPIO2, pigpio |
| E102 | Motor B | PWM failure | Check GPIO3, pigpio |
| E103 | HC-SR04 | Sensor error | Check GPIO23/24, voltage levels |
| E104 | GPS | No signal | Check UART, antenna |
| E105 | Camera | Init error | Check USB/CSI, permissions |
| E106 | TPU | Comm error | Check USB, drivers |

## Core Components

### Motor Controller
The motor controller implements precise speed control using PID algorithms and encoder feedback. It includes:
- Speed regulation
- Direction control
- Emergency stop
- Temperature protection
- Error handling

### Safety Monitor
The safety monitor ensures safe operation through:
- Real-time obstacle detection
- Battery voltage monitoring
- Temperature monitoring
- Emergency stop system
- Warning system

### Temperature Monitor
The temperature monitor protects the system by:
- Monitoring motor temperatures
- Monitoring CPU temperature
- Implementing cooling strategies
- Triggering safety measures

### Error Handler
The error handler manages system errors through:
- Error logging
- Error recovery
- System state management
- User notifications

## Safety Features

### Hardware Safety
- Emergency stop circuit
- Temperature sensors
- Voltage monitoring
- Current limiting

### Software Safety
- Real-time monitoring
- Automatic shutdown
- Error recovery
- State management

## Performance Optimization

### Resource Management
- CPU usage optimization
- Memory management
- Temperature control
- Power saving modes

### Real-time Performance
- Priority-based task scheduling
- Resource-aware processing
- Efficient data structures
- Minimal garbage collection

## Troubleshooting

### Common Issues
1. **High CPU Usage**
   - Check running processes
   - Verify resource manager settings
   - Monitor temperature

2. **Motor Control Issues**
   - Check power supply
   - Verify connections
   - Monitor temperature
   - Check encoder feedback

3. **Camera Issues**
   - Verify camera connection
   - Check permissions
   - Monitor resource usage

4. **Navigation Issues**
   - Verify sensor connections
   - Check calibration
   - Monitor GPS signal

### Error Codes
- E001: Motor controller error
- E002: Safety monitor error
- E003: Temperature monitor error
- E004: Navigation system error
- E005: Resource manager error

## License
This documentation is part of the PiRobot V.4 project and is subject to the same license terms as the main project. 