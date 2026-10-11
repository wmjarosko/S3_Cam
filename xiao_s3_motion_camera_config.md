# Xiao S3 Sense Motion Camera - Configuration Guide

## WiFi Configuration

### Basic WiFi Setup
Update these values in the Arduino code before uploading:

```cpp
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";
```

### Advanced WiFi Options
The system includes automatic WiFi management with these features:
- Automatic reconnection on disconnect
- WiFi sleep mode disabled for better streaming
- Network status monitoring

## Motion Detection Configuration

### Sensitivity Settings
```cpp
const int MOTION_THRESHOLD = 30;  // 0-100, lower = more sensitive
const int MOTION_COOLDOWN = 5000; // milliseconds between captures
const int FRAME_INTERVAL = 100;   // milliseconds between frames
```

### Motion Detection Algorithm
The system uses frame difference comparison:
1. Captures current frame and converts to grayscale
2. Compares with previous frame
3. Calculates percentage of pixels that changed
4. Triggers capture if change exceeds threshold

### Tuning Motion Detection
- **Low threshold (10-20)**: Very sensitive, triggers on small movements
- **Medium threshold (20-40)**: Good for general use
- **High threshold (40-60)**: Less sensitive, only large movements
- **Very high threshold (60+)**: Only detects significant motion

## Camera Configuration

### Resolution Settings
```cpp
config.frame_size = FRAMESIZE_QVGA;  // 320x240
// Other options:
// FRAMESIZE_96X96    // 96x96
// FRAMESIZE_QQVGA    // 160x120
// FRAMESIZE_QCIF     // 176x144
// FRAMESIZE_HQVGA    // 240x240
// FRAMESIZE_240X240   // 240x240
// FRAMESIZE_CIF      // 400x296
// FRAMESIZE_HVGA     // 480x320
// FRAMESIZE_VGA      // 640x480
// FRAMESIZE_SVGA     // 800x600
// FRAMESIZE_XGA      // 1024x768
// FRAMESIZE_HD       // 1280x720
// FRAMESIZE_SXGA     // 1280x1024
// FRAMESIZE_UXGA     // 1600x1200
```

### Quality Settings
```cpp
config.jpeg_quality = 12;  // 0-63, lower = better quality, larger files
// Recommended values:
// 10-15: Good balance of quality and file size
// 20+: Lower quality, smaller files
// 5-9: High quality, large files
```

### Camera Adjustments
```cpp
// Camera sensor adjustments
sensor_t * s = esp_camera_sensor_get();
s->set_brightness(s, 1);      // -2 to 2
s->set_contrast(s, 0);        // -2 to 2
s->set_saturation(s, -2);     // -2 to 2
s->set_special_effect(s, 0);  // 0-6
s->set_quality(s, 12);       // 0-63
s->set_brightness(s, 1);      // -2 to 2
s->set_sharpness(s, 2);       // -2 to 2
s->set_denoise(s, 0);         // 0-1
```

## SD Card Configuration

### File System Requirements
- Format: FAT32
- Maximum size: 32GB
- Recommended: Class 10 or higher

### File Management
- Images saved as: `motion_YYYYMMDD_HHMMSS.jpg`
- Automatic cleanup when space is low
- No manual file management required

### Storage Optimization
- Adjust JPEG quality to balance quality vs. storage
- Use motion cooldown to prevent duplicate images
- Consider automatic cleanup for long-term use

## Web Interface Configuration

### Server Settings
```cpp
AsyncWebServer server(80);  // Default port 80
// Can be changed to other ports if needed
```

### WebSocket Configuration
- Real-time motion notifications
- Automatic reconnection
- Binary data support

### Web Interface Features
- Responsive design for mobile and desktop
- Real-time status updates
- Image gallery with download capability
- Live MJPEG streaming

## Power Management

### Power Requirements
- Input: 5V/2A USB-C
- Recommended: USB-C power adapter
- Avoid USB ports that may not provide sufficient power

### Power Saving Options
- WiFi sleep mode disabled for better performance
- Camera can be put to sleep when not in use
- Consider external power for continuous operation

## Network Configuration

### Static IP Option
To use a static IP address, add this before WiFi.begin():
```cpp
// Static IP configuration
IPAddress localIP(192, 168, 1, 100);
IPAddress gateway(192, 168, 1, 1);
IPAddress subnet(255, 255, 255, 0);
IPAddress dns(8, 8, 8, 8);

WiFi.config(localIP, gateway, subnet, dns);
```

### Access Point Mode
For setup without WiFi router:
```cpp
// Start access point
WiFi.softAP("XiaoCamera", "password123");
Serial.println("AP IP Address: ");
Serial.println(WiFi.softAPIP());
```

## Security Considerations

### Network Security
- Use WPA2/WPA3 encryption on WiFi
- Consider network isolation for security cameras
- Regular firmware updates

### Web Interface Security
- No authentication by default
- Consider adding password protection for production use
- Use HTTPS if available

## Performance Optimization

### Memory Management
- PSRAM usage for frame buffers
- Automatic memory cleanup
- Frame buffer optimization

### Streaming Performance
- MJPEG format for compatibility
- Adjustable frame rate
- Buffer management for smooth streaming

### Power Efficiency
- Dynamic frame rate adjustment
- Sleep modes when inactive
- Power monitoring and optimization

## Troubleshooting Configuration

### Debug Mode
Enable serial debug output:
```cpp
Serial.setDebugOutput(true);
```

### Camera Debug Information
Monitor camera initialization:
```cpp
esp_err_t err = esp_camera_init(&config);
if (err != ESP_OK) {
    Serial.printf("Camera init failed with error 0x%x\n", err);
}
```

### WiFi Debug Information
Monitor connection status:
```cpp
Serial.print("WiFi status: ");
Serial.println(WiFi.status());
```