# Xiao S3 Sense Motion Camera - Complete Package

## Project Overview
This is a complete motion detection camera system for the Xiao ESP32-S3 Sense that provides:
- Live video streaming via web interface
- Motion detection with automatic image capture
- SD card storage for captured images
- Web-based image gallery and download functionality

## Files Included

### Core Files
1. **xiao_s3_motion_camera.ino** - Main Arduino sketch with all functionality
2. **stream.html** - Enhanced web interface for live streaming
3. **setup_xiao_camera.sh** - Linux/macOS setup script
4. **setup_xiao_camera.bat** - Windows setup script

### Documentation
5. **xiao_s3_motion_camera_setup.md** - Project overview and requirements
6. **xiao_s3_motion_camera_installation.md** - Detailed installation guide
7. **xiao_s3_motion_camera_config.md** - Configuration and customization guide

## Quick Start

### 1. Hardware Setup
- Insert formatted microSD card (FAT32) into Xiao S3 Sense
- Connect camera module
- Power via USB-C 5V/2A adapter

### 2. Software Installation
Choose your platform and run the appropriate setup script:

**Windows:**
```bash
setup_xiao_camera.bat
```

**Linux/macOS:**
```bash
chmod +x setup_xiao_camera.sh
./setup_xiao_camera.sh
```

### 3. Configure WiFi
Edit the Arduino sketch and update:
```cpp
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";
```

### 4. Upload Firmware
1. Open Arduino IDE
2. Connect Xiao S3 Sense to computer
3. Select correct board and port
4. Upload the sketch

### 5. Access Web Interface
- Find IP address in serial monitor
- Visit `http://<IP_ADDRESS>` in browser

## Key Features

### Motion Detection
- Frame difference comparison algorithm
- Adjustable sensitivity (0-100)
- Configurable cooldown period
- Real-time motion notifications

### Web Interface
- **Main Dashboard**: Current status and quick links
- **Live Stream**: MJPEG streaming with fullscreen mode
- **Image Gallery**: Browse and download captured images
- **Configuration**: WiFi and motion settings
- **System Status**: Real-time system information

### Storage Management
- Automatic image saving with timestamps
- SD card space monitoring
- File cleanup when space is low
- Organized file naming

## Technical Specifications

### Hardware Requirements
- Xiao ESP32-S3 Sense board
- OV2640/OV3660 camera module
- MicroSD card (FAT32, up to 32GB)
- USB-C power supply (5V/2A)

### Software Requirements
- Arduino IDE with ESP32 support
- Required libraries:
  - ESP32
  - ESP32 Camera
  - ArduinoJson
  - AsyncTCP
  - ESPAsyncWebServer

### Network Requirements
- WiFi network (2.4GHz recommended)
- HTTP access to device IP
- No internet connection required for local operation

## Configuration Options

### WiFi Settings
```cpp
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";
```

### Motion Detection
```cpp
const int MOTION_THRESHOLD = 30;  // Sensitivity (0-100)
const int MOTION_COOLDOWN = 5000; // Time between captures (ms)
const int FRAME_INTERVAL = 100;   // Frame interval (ms)
```

### Camera Settings
```cpp
config.frame_size = FRAMESIZE_QVGA;  // Resolution
config.jpeg_quality = 12;           // Image quality (0-63)
config.fb_count = 2;                // Frame buffers
```

## Troubleshooting

### Common Issues
1. **Camera initialization failed**
   - Check camera module connection
   - Verify PSRAM settings
   - Try different partition scheme

2. **SD card mount failed**
   - Format card as FAT32
   - Check card capacity (max 32GB)
   - Try different SD card

3. **WiFi connection failed**
   - Verify SSID and password
   - Check router settings
   - Move closer to router

4. **No motion detection**
   - Adjust motion threshold
   - Check camera field of view
   - Ensure adequate lighting

### Debug Mode
Enable debug output in Arduino IDE:
```cpp
Serial.setDebugOutput(true);
```

## Advanced Features

### WebSocket Integration
- Real-time motion notifications
- Live status updates
- Remote control capabilities

### File Management
- Automatic timestamp-based naming
- Space monitoring and cleanup
- Batch download support

### Performance Optimization
- PSRAM usage for better performance
- Frame buffer management
- Memory optimization

## Security Considerations

### Network Security
- Use WPA2/WPA3 encryption
- Consider network isolation
- Regular firmware updates

### Web Interface
- No authentication by default
- Add password protection for production
- Consider HTTPS for secure access

## Support and Resources

### Documentation
- Installation guide: `xiao_s3_motion_camera_installation.md`
- Configuration guide: `xiao_s3_motion_camera_config.md`
- Project overview: `xiao_s3_motion_camera_setup.md`

### Online Resources
- Arduino IDE: https://www.arduino.cc/en/software
- ESP32 Board Manager: https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
- Xiao ESP32-S3 Sense Documentation: https://wiki.seeedstudio.com/XIAO_ESP32S3_Micropython/

### Community Support
- Arduino Forum: https://forum.arduino.cc/
- ESP32 Forum: https://esp32.com/
- Seeed Studio Forum: https://forum.seeedstudio.com/

## License
This project is open source and available under the MIT License. Feel free to modify and use for your own projects.

## Contributing
If you find bugs or have suggestions for improvements, please create an issue or submit a pull request.

## Changelog
- v1.0: Initial release with basic motion detection and web interface
- v1.1: Enhanced streaming and gallery features
- v1.2: Improved motion detection algorithm and WebSocket support
- v1.3: Added comprehensive documentation and setup scripts

## Contact
For questions or support, please refer to the documentation or create an issue in the project repository.# S3_Cam
