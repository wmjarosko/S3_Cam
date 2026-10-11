#!/bin/bash

# Xiao S3 Sense Motion Camera - Setup Script
# This script helps set up the development environment for Xiao S3 Sense motion camera

echo "Xiao S3 Sense Motion Camera Setup Script"
echo "========================================"

# Check if we're on the right platform
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    PLATFORM="Windows"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    PLATFORM="Linux"
elif [[ "$OSTYPE" == "darwin" ]]; then
    PLATFORM="macOS"
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

echo "Detected platform: $PLATFORM"

# Check if Arduino IDE is installed
check_arduino() {
    echo "Checking Arduino IDE installation..."
    
    if [[ "$PLATFORM" == "Windows" ]]; then
        ARDUINO_PATH="C:\\Program Files\\Arduino"
        if [[ -d "$ARDUINO_PATH" ]]; then
            ARDUINO_EXE="$ARDUINO_PATH\\arduino.exe"
            if [[ -f "$ARDUINO_EXE" ]]; then
                echo "Arduino IDE found at: $ARDUINO_EXE"
                return 0
            fi
        fi
        # Check common installation paths
        if command -v arduino.exe &> /dev/null; then
            ARDUINO_EXE=$(which arduino.exe)
            echo "Arduino IDE found at: $ARDUINO_EXE"
            return 0
        fi
    else
        if command -v arduino &> /dev/null; then
            ARDUINO_EXE=$(which arduino)
            echo "Arduino IDE found at: $ARDUINO_EXE"
            return 0
        fi
    fi
    
    echo "Arduino IDE not found. Please install Arduino IDE first."
    echo "Download from: https://www.arduino.cc/en/software"
    return 1
}

# Check if Python is installed
check_python() {
    echo "Checking Python installation..."
    
    if command -v python3 &> /dev/null; then
        PYTHON_EXE=$(which python3)
        echo "Python 3 found at: $PYTHON_EXE"
        return 0
    elif command -v python &> /dev/null; then
        PYTHON_EXE=$(which python)
        echo "Python found at: $PYTHON_EXE"
        return 0
    fi
    
    echo "Python not found. Please install Python first."
    return 1
}

# Check if esptool is installed
check_esptool() {
    echo "Checking esptool installation..."
    
    if python3 -c "import esptool" 2>/dev/null; then
        echo "esptool is already installed"
        return 0
    elif python -c "import esptool" 2>/dev/null; then
        echo "esptool is already installed"
        return 0
    fi
    
    echo "Installing esptool..."
    if python3 -m pip install esptool; then
        echo "esptool installed successfully"
        return 0
    elif python -m pip install esptool; then
        echo "esptool installed successfully"
        return 0
    else
        echo "Failed to install esptool"
        return 1
    fi
}

# Create Arduino IDE preferences file
create_arduino_prefs() {
    echo "Creating Arduino IDE preferences..."
    
    if [[ "$PLATFORM" == "Windows" ]]; then
        ARDUINO_PREFS_DIR="$APPDATA\\Arduino15"
        ARDUINO_PREFS_FILE="$ARDUINO_PREFS_DIR\\preferences.txt"
    else
        ARDUINO_PREFS_DIR="$HOME/.arduino15"
        ARDUINO_PREFS_FILE="$ARDUINO_PREFS_DIR/preferences.txt"
    fi
    
    mkdir -p "$ARDUINO_PREFS_DIR"
    
    # Add ESP32 board manager URL
    if ! grep -q "http://arduino.esp8266.com/stable/package_esp32_index.json" "$ARDUINO_PREFS_FILE" 2>/dev/null; then
        echo "Adding ESP32 board manager URL..."
        echo "additional.urls=http://arduino.esp8266.com/stable/package_esp32_index.json" >> "$ARDUINO_PREFS_FILE"
    fi
    
    echo "Arduino IDE preferences updated"
}

# Install required Arduino libraries
install_libraries() {
    echo "Installing required Arduino libraries..."
    
    LIBRARIES=(
        "ESP32"
        "ESP32 Camera"
        "ArduinoJson"
    )
    
    for lib in "${LIBRARIES[@]}"; do
        echo "Installing $lib..."
        if [[ "$PLATFORM" == "Windows" ]]; then
            "$ARDUINO_EXE" --install-library "$lib"
        else
            arduino --install-library "$lib"
        fi
    done
    
    echo "Libraries installed successfully"
}

# Create project directory
create_project() {
    echo "Creating project directory..."
    
    PROJECT_DIR="$HOME/xiao_s3_motion_camera"
    mkdir -p "$PROJECT_DIR"
    
    # Copy files to project directory
    cp "xiao_s3_motion_camera.ino" "$PROJECT_DIR/"
    cp "stream.html" "$PROJECT_DIR/"
    cp "xiao_s3_motion_camera_installation.md" "$PROJECT_DIR/"
    cp "xiao_s3_motion_camera_config.md" "$PROJECT_DIR/"
    
    echo "Project created at: $PROJECT_DIR"
}

# Generate WiFi configuration template
generate_wifi_config() {
    echo "Generating WiFi configuration template..."
    
    WIFI_CONFIG_TEMPLATE='// WiFi Configuration Template
// Update these values with your WiFi credentials
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

// Motion Detection Settings
const int MOTION_THRESHOLD = 30;  // 0-100, lower = more sensitive
const int MOTION_COOLDOWN = 5000; // milliseconds between captures
const int FRAME_INTERVAL = 100;   // milliseconds between frames'
    
    echo "$WIFI_CONFIG_TEMPLATE" > "$PROJECT_DIR/wifi_config_template.txt"
    echo "WiFi configuration template created"
}

# Create batch file for Windows users
create_windows_batch() {
    if [[ "$PLATFORM" == "Windows" ]]; then
        BATCH_FILE='@echo off
echo Opening Arduino IDE...
start "" "C:\Program Files\Arduino\arduino.exe" "%~dp0xiao_s3_motion_camera.ino"
echo Please configure WiFi credentials in the Arduino code before uploading.
pause'
        
        echo "$BATCH_FILE" > "$PROJECT_DIR/setup.bat"
        echo "Windows batch file created: setup.bat"
    fi
}

# Create shell script for Linux/macOS users
create_shell_script() {
    if [[ "$PLATFORM" == "Linux" || "$PLATFORM" == "macOS" ]]; then
        SHELL_SCRIPT='#!/bin/bash
echo "Opening Arduino IDE..."
if command -v arduino &> /dev/null; then
    arduino "$PWD/xiao_s3_motion_camera.ino"
else
    echo "Arduino IDE not found. Please install it first."
fi
echo "Please configure WiFi credentials in the Arduino code before uploading."'
        
        echo "$SHELL_SCRIPT" > "$PROJECT_DIR/setup.sh"
        chmod +x "$PROJECT_DIR/setup.sh"
        echo "Shell script created: setup.sh"
    fi
}

# Main setup process
main() {
    echo "Starting setup process..."
    
    # Check prerequisites
    if ! check_arduino; then
        exit 1
    fi
    
    if ! check_python; then
        exit 1
    fi
    
    if ! check_esptool; then
        exit 1
    fi
    
    # Setup Arduino IDE
    create_arduino_prefs
    install_libraries
    
    # Create project
    create_project
    generate_wifi_config
    create_windows_batch
    create_shell_script
    
    echo ""
    echo "Setup completed successfully!"
    echo ""
    echo "Next steps:"
    echo "1. Open Arduino IDE and load the project"
    echo "2. Update WiFi credentials in the Arduino code"
    echo "3. Connect your Xiao S3 Sense to your computer"
    echo "4. Select the correct board and port"
    echo "5. Upload the firmware"
    echo "6. Access the web interface using the IP address shown in serial monitor"
    echo ""
    echo "Project location: $PROJECT_DIR"
    echo ""
    echo "For detailed instructions, see:"
    echo "  - $PROJECT_DIR/xiao_s3_motion_camera_installation.md"
    echo "  - $PROJECT_DIR/xiao_s3_motion_camera_config.md"
}

# Run main function
main