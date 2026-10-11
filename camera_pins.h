// Camera pin definitions for Xiao ESP32-S3 Sense
// This file defines the GPIO pins used by the camera module

#ifndef CAMERA_PINS_H
#define CAMERA_PINS_H

// XIAO ESP32-S3 Sense pin definitions
#define PWDN_GPIO_NUM     -1  // Power down pin (not used)
#define RESET_GPIO_NUM    -1  // Reset pin (not used)
#define XCLK_GPIO_NUM     10  // XCLK clock pin
#define SIOD_GPIO_NUM     40  // I2C data pin
#define SIOC_GPIO_NUM     39  // I2C clock pin

// Camera data pins
#define Y9_GPIO_NUM       15
#define Y8_GPIO_NUM       17
#define Y7_GPIO_NUM       18
#define Y6_GPIO_NUM       16
#define Y5_GPIO_NUM       14
#define Y4_GPIO_NUM       12
#define Y3_GPIO_NUM       11
#define Y2_GPIO_NUM       48

// Camera control pins
#define VSYNC_GPIO_NUM    38  // Vertical sync
#define HREF_GPIO_NUM     47  // Horizontal reference
#define PCLK_GPIO_NUM     13  // Pixel clock

#endif // CAMERA_PINS_H