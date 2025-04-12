# PiRobot V.4

An advanced autonomous robot system with enhanced safety features, collision detection, and room mapping capabilities.

## Features

- Enhanced safety monitoring with real-time sensor feedback
- Improved collision detection using ultrasonic sensors
- Room mapping and autonomous navigation
- Data collection and training system for machine learning
- Real-time camera feed and sensor data visualization
- Emergency stop functionality
- Configurable settings via YAML configuration
- Optimized for Raspberry Pi 3B performance

## Project Structure

```
PiRobot-V.4/
├── config/
│   └── data_collector.yaml    # Configuration settings
├── src/
│   └── core/
│       ├── data_collector.py  # Data collection interface
│       ├── motor_controller.py # Motor control and safety
│       └── safety_monitor.py  # Safety monitoring system
├── training/
│   ├── mapping/
│   │   ├── room_mapper.py     # Room mapping implementation
│   │   ├── dataset.py         # Training dataset handling
│   │   └── train.py           # Training script
│   └── requirements.txt       # Training dependencies
├── docs/
│   ├── data_collector.md      # Data collector documentation
│   └── training.md            # Training system documentation
├── setup_pi.sh                # Raspberry Pi setup script
├── LICENSE                    # GPL-3.0 License
└── README.md                  # This file
```

## Installation

### Quick Setup (Recommended)

1. Clone the repository:
   ```bash
   git clone https://github.com/ihandrian/PiRobot-V.4.git
   cd PiRobot-V.4
   ```

2. Run the setup script (as root):
   ```bash
   chmod +x setup_pi.sh
   sudo ./setup_pi.sh
   ```

3. Reboot your Raspberry Pi:
   ```bash
   sudo reboot
   ```

4. After reboot, activate the virtual environment:
   ```bash
   source venv/bin/activate
   ```

5. Verify the installation:
   ```bash
   python test_installation.py
   ```

### Manual Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/ihandrian/PiRobot-V.4.git
   cd PiRobot-V.4
   ```

2. Create and activate virtual environment:
   ```bash
   python3 -m venv PiRobot
   source PiRobot/bin/activate
   ```

3. Install dependencies:
   ```bash
   pip install -r training/requirements.txt
   ```

4. Configure the system:
   ```bash
   mkdir -p config
   # Edit config/data_collector.yaml as needed
   ```

## Usage

### Data Collection
1. Start the data collector:
   ```bash
   python src/core/data_collector.py
   ```

2. Use the interface to:
   - Start/stop recording
   - Save frames manually
   - View real-time sensor data
   - Monitor system status

### Training
1. Collect training data using the data collector
2. Upload data to Google Colab
3. Run the training script:
   ```bash
   python training/mapping/train.py
   ```

### Room Mapping
1. Deploy the trained model
2. Start the room mapper:
   ```bash
   python training/mapping/room_mapper.py
   ```

## Safety Features

- Real-time monitoring of:
  - Battery voltage
  - Motor temperature
  - Obstacle distances
  - Emergency stop button
- Automatic shutdown on critical conditions
- Hardware watchdog timer
- Thread-safe operations
- Optimized resource management for Raspberry Pi 3B

## Requirements

- Raspberry Pi 3B (optimized for)
- Python 3.8+
- Camera module
- Ultrasonic sensors
- Motor drivers
- Emergency stop button
- Battery monitoring circuit
- Minimum 2GB swap space (configured by setup script)
- 256MB GPU memory (configured by setup script)

## System Optimizations

The setup script (`setup_pi.sh`) includes several optimizations for Raspberry Pi 3B:
- Configured 2GB swap space for better memory management
- Optimized GPU memory allocation (256MB)
- Performance-oriented CPU governor
- Hardware-accelerated OpenCV
- ARM-compatible PyTorch version
- Optional Coral TPU support

## Contributing

1. Fork the repository at https://github.com/ihandrian/PiRobot-V.4
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Free Software Foundation for the GPL-3.0 License
- Raspberry Pi Foundation for hardware support
- OpenCV and PyTorch communities for software libraries
- Google Coral team for TPU support

## Support

- Paypal: https://paypal.me/IrfanHandrian
- Buy me Coffee: https://buymeacoffee.com/handrianirv
