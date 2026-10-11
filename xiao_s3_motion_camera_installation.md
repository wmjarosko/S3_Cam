# Xiao S3 Sense Motion Camera - Installation Guide

## Quick Start Instructions

### 1. Hardware Setup
1. Insert formatted microSD card (FAT32) into Xiao S3 Sense
2. Connect power via USB-C cable
3. Ensure camera module is properly connected

### 2. Software Installation
1. Install Arduino IDE from https://www.arduino.cc/en/software
2. Open Arduino IDE
3. Go to File > Preferences
4. Add this URL to "Additional Boards Manager URLs":
   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
5. Go to Tools > Board > Boards Manager
6. Search for "esp32" and install "esp32" by Espressif Systems

### 3. Library Installation
In Arduino IDE, go to Tools > Manage Libraries and install:
- ESP32 (by Espressif Systems)
- ESP32 Camera (by Espressif Systems)

### 4. Board Configuration
1. Go to Tools > Board > ESP32 Arduino > ESP32-S3 Dev Module
2. Go to Tools > Partition Scheme > Huge App (no OTA)

### 5. WiFi Configuration
Edit the `xiao_s3_motion_camera.ino` file and update:
```cpp
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";
```

### 6. Upload Firmware
1. Connect Xiao S3 Sense to your computer
2. Select the correct port in Tools > Port
3. Click Upload button in Arduino IDE

### 7. Access Web Interface
After successful upload:
1. Open serial monitor to find the IP address
2. Visit `http://<IP_ADDRESS>` in your browser

## Web Interface Features

### Main Page (`/`)
- Current motion detection status
- Quick links to other pages
- Real-time status updates

### Live Stream (`/stream`)
- Live MJPEG video stream
- No plugin required
- Works in all modern browsers

### Image Gallery (`/gallery`)
- View all captured motion images
- Download individual images
- Grid layout for easy browsing

### Configuration (`/config`)
- Update WiFi credentials
- Adjust motion detection sensitivity
- Set motion cooldown period

### System Status (`/status`)
- WiFi connection status
- IP address information
- Motion detection status
- Image capture count
- SD card usage
- System uptime

## Motion Detection Settings

### Threshold (0-100)
- Lower values = more sensitive
- Higher values = less sensitive
- Recommended starting point: 30

### Cooldown (ms)
- Time between motion captures
- Prevents multiple images from same motion event
- Recommended: 5000 (5 seconds)

## Troubleshooting

### Common Issues
1. **Camera initialization failed**
   - Check camera module connection
   - Verify PSRAM setting in Tools menu
   - Try different partition scheme

2. **SD card mount failed**
   - Ensure card is formatted FAT32
   - Check card is properly inserted
   - Try different SD card

3. **WiFi connection failed**
   - Verify SSID and password
   - Check router settings
   - Move closer to router

4. **No motion detection**
   - Adjust motion threshold
   - Check camera field of view
   - Ensure adequate lighting

### Serial Monitor Commands
Open serial monitor (115200 baud) for debugging:
- Camera initialization status
- Motion detection events
- Image capture notifications
- WiFi connection status

## Advanced Configuration

### Customizing Motion Detection
You can modify the motion detection algorithm by changing:
- `MOTION_THRESHOLD`: Sensitivity (0-255)
- `FRAME_INTERVAL`: Time between frames (ms)
- `MOTION_COOLDOWN`: Time between captures (ms)

### File Management
- Images are saved with timestamp: `motion_YYYYMMDD_HHMMSS.jpg`
- Automatic cleanup when SD card space is low
- Files stored in root directory of SD card

### Network Configuration
The device will automatically:
- Connect to WiFi on startup
- Display IP address in serial monitor
- Start web server on port 80
- Handle network reconnection automatically

## Security Notes
- Default web interface has no authentication
- For production use, consider adding password protection
- Place device on secure network
- Regularly check SD card storage usage