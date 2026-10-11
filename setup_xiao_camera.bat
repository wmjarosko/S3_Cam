@echo off
chcp 65001 >nul
echo Xiao S3 Sense Motion Camera - Windows Setup Script
echo ==================================================

:: Check if Arduino IDE is installed
echo Checking Arduino IDE installation...
if exist "C:\Program Files\Arduino IDE\Arduino IDE.exe" (
    set ARDUINO_EXE="C:\Program Files\Arduino IDE\Arduino IDE.exe"
    echo Arduino IDE found at: %ARDUINO_EXE%
) else if exist "C:\Program Files (x86)\Arduino\arduino.exe" (
    set ARDUINO_EXE="C:\Program Files (x86)\Arduino\arduino.exe"
    echo Arduino IDE found at: %ARDUINO_EXE%
) else (
    echo Arduino IDE not found. Please install Arduino IDE first.
    echo Download from: https://www.arduino.cc/en/software
    pause
    exit /b 1
)

:: Check if Python is installed
echo Checking Python installation...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Python found
) else (
    echo Python not found. Please install Python first.
    pause
    exit /b 1
)

:: Check if pip is available
echo Checking pip availability...
python -m pip --version >nul 2>&1
if %errorlevel% equ 0 (
    echo pip is available
) else (
    echo pip not found. Please install pip first.
    pause
    exit /b 1
)

:: Install esptool if not available
echo Checking esptool installation...
python -c "import esptool" >nul 2>&1
if %errorlevel% equ 0 (
    echo esptool is already installed
) else (
    echo Installing esptool...
    python -m pip install esptool
    if %errorlevel% neq 0 (
        echo Failed to install esptool
        pause
        exit /b 1
    )
    echo esptool installed successfully
)

:: Create Arduino preferences directory
echo Creating Arduino IDE preferences...
set ARDUINO_PREFS_DIR=%APPDATA%\Arduino15
set ARDUINO_PREFS_FILE=%ARDUINO_PREFS_DIR%\preferences.txt

if not exist "%ARDUINO_PREFS_DIR%" (
    mkdir "%ARDUINO_PREFS_DIR%"
)

:: Check if ESP32 board manager URL is already added
findstr /C:"http://arduino.esp8266.com/stable/package_esp32_index.json" "%ARDUINO_PREFS_FILE%" >nul
if %errorlevel% neq 0 (
    echo Adding ESP32 board manager URL...
    echo additional.urls=http://arduino.esp8266.com/stable/package_esp32_index.json >> "%ARDUINO_PREFS_FILE%"
)

:: Create project directory
echo Creating project directory...
set PROJECT_DIR=%USERPROFILE%\xiao_s3_motion_camera
if not exist "%PROJECT_DIR%" (
    mkdir "%PROJECT_DIR%"
)

:: Copy files to project directory
echo Copying project files...
if exist "xiao_s3_motion_camera.ino" (
    copy "xiao_s3_motion_camera.ino" "%PROJECT_DIR%\"
) else (
    echo Warning: xiao_s3_motion_camera.ino not found in current directory
)

if exist "stream.html" (
    copy "stream.html" "%PROJECT_DIR%\"
) else (
    echo Warning: stream.html not found in current directory
)

if exist "xiao_s3_motion_camera_installation.md" (
    copy "xiao_s3_motion_camera_installation.md" "%PROJECT_DIR%\"
) else (
    echo Warning: xiao_s3_motion_camera_installation.md not found in current directory
)

if exist "xiao_s3_motion_camera_config.md" (
    copy "xiao_s3_motion_camera_config.md" "%PROJECT_DIR%\"
) else (
    echo Warning: xiao_s3_motion_camera_config.md not found in current directory
)

:: Create WiFi configuration template
echo Creating WiFi configuration template...
echo // WiFi Configuration Template > "%PROJECT_DIR%\wifi_config_template.txt"
echo // Update these values with your WiFi credentials >> "%PROJECT_DIR%\wifi_config_template.txt"
echo. >> "%PROJECT_DIR%\wifi_config_template.txt"
echo const char* ssid = "YOUR_WIFI_SSID"; >> "%PROJECT_DIR%\wifi_config_template.txt"
echo const char* password = "YOUR_WIFI_PASSWORD"; >> "%PROJECT_DIR%\wifi_config_template.txt"
echo. >> "%PROJECT_DIR%\wifi_config_template.txt"
echo // Motion Detection Settings >> "%PROJECT_DIR%\wifi_config_template.txt"
echo const int MOTION_THRESHOLD = 30;  // 0-100, lower = more sensitive >> "%PROJECT_DIR%\wifi_config_template.txt"
echo const int MOTION_COOLDOWN = 5000; // milliseconds between captures >> "%PROJECT_DIR%\wifi_config_template.txt"
echo const int FRAME_INTERVAL = 100;   // milliseconds between frames >> "%PROJECT_DIR%\wifi_config_template.txt"

:: Create Windows batch file
echo Creating setup batch file...
echo @echo off > "%PROJECT_DIR%\setup.bat"
echo echo Opening Arduino IDE... >> "%PROJECT_DIR%\setup.bat"
echo start "" %ARDUINO_EXE% "%%~dp0xiao_s3_motion_camera.ino" >> "%PROJECT_DIR%\setup.bat"
echo echo Please configure WiFi credentials in the Arduino code before uploading. >> "%PROJECT_DIR%\setup.bat"
echo pause >> "%PROJECT_DIR%\setup.bat"

:: Create PowerShell script for Arduino library installation
echo Creating library installation script...
echo # Arduino Library Installation Script > "%PROJECT_DIR%\install_libraries.ps1"
echo Write-Host "Installing Arduino libraries..." >> "%PROJECT_DIR%\install_libraries.ps1"
echo $libraries = @("ESP32", "ESP32 Camera", "ArduinoJson") >> "%PROJECT_DIR%\install_libraries.ps1"
echo foreach ($lib in $libraries) { >> "%PROJECT_DIR%\install_libraries.ps1"
echo     Write-Host "Installing $lib..." >> "%PROJECT_DIR%\install_libraries.ps1"
echo     & "%ARDUINO_EXE%" --install-library $lib >> "%PROJECT_DIR%\install_libraries.ps1"
echo } >> "%PROJECT_DIR%\install_libraries.ps1"
echo Write-Host "Libraries installed successfully" >> "%PROJECT_DIR%\install_libraries.ps1"

:: Create flash script
echo Creating flash script...
echo @echo off > "%PROJECT_DIR%\flash_device.bat"
echo echo Xiao S3 Sense Flash Script >> "%PROJECT_DIR%\flash_device.bat"
echo echo. >> "%PROJECT_DIR%\flash_device.bat"
echo echo Requirements: >> "%PROJECT_DIR%\flash_device.bat"
echo echo 1. Xiao S3 Sense connected to computer >> "%PROJECT_DIR%\flash_device.bat"
echo echo 2. Arduino IDE installed >> "%PROJECT_DIR%\flash_device.bat"
echo echo 3. WiFi credentials configured in Arduino code >> "%PROJECT_DIR%\flash_device.bat"
echo echo. >> "%PROJECT_DIR%\flash_device.bat"
echo echo Press any key to open Arduino IDE... >> "%PROJECT_DIR%\flash_device.bat"
echo pause >nul >> "%PROJECT_DIR%\flash_device.bat"
echo start "" %ARDUINO_EXE% "%%~dp0xiao_s3_motion_camera.ino" >> "%PROJECT_DIR%\flash_device.bat"
echo echo Please upload the sketch to your Xiao S3 Sense... >> "%PROJECT_DIR%\flash_device.bat"
echo pause >> "%PROJECT_DIR%\flash_device.bat"

echo.
echo Setup completed successfully!
echo.
echo Next steps:
echo 1. Open Arduino IDE: %PROJECT_DIR%\setup.bat
echo 2. Update WiFi credentials in xiao_s3_motion_camera.ino
echo 3. Connect your Xiao S3 Sense to your computer
echo 4. Select the correct board and port in Arduino IDE
echo 5. Upload the firmware
echo 6. Access the web interface using the IP address shown in serial monitor
echo.
echo Project location: %PROJECT_DIR%
echo.
echo For detailed instructions, see:
echo   - %PROJECT_DIR%\xiao_s3_motion_camera_installation.md
echo   - %PROJECT_DIR%\xiao_s3_motion_camera_config.md
echo.
echo Additional scripts:
echo   - %PROJECT_DIR%\install_libraries.ps1 (Install Arduino libraries)
echo   - %PROJECT_DIR%\flash_device.bat (Flash device helper)
echo.
pause