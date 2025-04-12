# PiRobot V.4

An advanced autonomous robot system with enhanced safety features, collision detection, and room mapping capabilities.

## Features

- **Enhanced Safety Monitoring**
  - Priority-based safety checks
  - Hardware-accelerated safety monitoring
  - Predictive safety measures
  - Emergency stop functionality

- **Improved Collision Detection**
  - Hierarchical collision detection system
  - Predictive collision avoidance
  - Hardware-accelerated image processing
  - State tracking for better prediction

- **Room Mapping & Navigation**
  - Real-time room mapping
  - Path planning and optimization
  - Obstacle avoidance
  - Autonomous navigation

- **Data Collection & Training**
  - Manual data collection interface
  - Google Colab training support
  - Synthetic data generation
  - Model deployment tools

## Project Structure

```
PiRobot-V.4/
├── config/                  # Configuration files
│   ├── data_collector.yaml  # Data collection settings
│   └── ...
├── src/                     # Source code
│   ├── core/               # Core functionality
│   │   ├── safety_monitor.py
│   │   ├── collision_detector.py
│   │   ├── motor_controller.py
│   │   └── data_collector.py
│   └── ...
├── training/               # Training related code
│   ├── mapping/           # Room mapping system
│   ├── collected_data/    # Collected training data
│   └── requirements.txt   # Training dependencies
└── docs/                  # Documentation
```

## Installation

1. Clone the repository:
```bash
git clone https://github.com/ihandrian/PiRobot-V.4.git
cd PiRobot-V.4
```

2. Install dependencies:
```bash
pip install -r training/requirements.txt
```

3. Configure the system:
- Copy `config/data_collector.yaml.example` to `config/data_collector.yaml`
- Adjust settings according to your hardware

## Usage

### Data Collection

1. Start the data collector:
```bash
python src/core/data_collector.py
```

2. Use the interface to:
- Start/stop recording
- Save frames manually
- Monitor robot status
- View statistics

### Training

1. Collect training data using the data collector
2. Upload data to Google Colab
3. Run the training scripts
4. Deploy the trained model

### Room Mapping

1. Start the room mapping system:
```bash
python src/core/room_mapper.py
```

2. The robot will:
- Map the environment
- Plan optimal paths
- Avoid obstacles
- Navigate autonomously

## Safety Features

- Emergency stop button
- Collision detection and avoidance
- Battery monitoring
- Temperature monitoring
- Motor safety controls

## Requirements

- Python 3.8+
- OpenCV
- PyTorch
- NumPy
- Other dependencies listed in `training/requirements.txt`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Google Coral TPU support
- OpenCV for computer vision
- PyTorch for deep learning
- Raspberry Pi hardware support
