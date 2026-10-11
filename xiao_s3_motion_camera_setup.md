# Xiao S3 Sense Motion Detection Camera Setup

## Project Overview
Create a motion-activated camera system for Xiao S3 Sense that:
- Streams live video feed
- Detects motion and captures snapshots to SD card
- Provides web interface to view stored images

## Hardware Requirements
- Xiao ESP32-S3 Sense board
- MicroSD card (FAT32 format, up to 32GB)
- Power supply (USB-C 5V/2A)

## Software Requirements
- Arduino IDE with ESP32 board support
- ESP32 library
- Camera library
- WiFi library

## Configuration Setup
1. Install Arduino IDE
2. Install ESP32 board manager: https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
3. Install required libraries through Arduino Library Manager:
   - ESP32
   - ESP32 Camera
   - ArduinoJson

## Pin Configuration (Xiao S3 Sense)
- XCLK: GPIO 10
- SDA: GPIO 40
- SCL: GPIO 39
- D0-D7: GPIO 15,17,18,16,14,12,11,48
- VSYNC: GPIO 38
- HREF: GPIO 47
- PCLK: GPIO 13
- PWDN: GPIO -1 (not used)
- RESET: GPIO -1 (not used)

## Motion Detection Algorithm
- Frame difference comparison between consecutive frames
- Motion threshold sensitivity (0-255)
- Debounce to prevent false triggers
- Cooldown period between captures

## File Storage
- Images saved as JPEG with timestamp
- Automatic cleanup when SD card space is low
- File naming: motion_YYYYMMDD_HHMMSS.jpg

## Web Interface Features
- Live MJPEG stream at /stream
- Image gallery at /gallery
- Download individual images
- Configuration page for WiFi and motion settings
- System status page

## Installation Steps
1. Flash firmware to Xiao S3 Sense
2. Insert formatted SD card
3. Configure WiFi credentials
4. Test motion detection
5. Access web interface