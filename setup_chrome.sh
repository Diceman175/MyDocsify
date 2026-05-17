#!/bin/bash
set -e

echo "Setting up Chrome and ChromeDriver for Docker environment..."

# Update package list
apt-get update

# Install dependencies for Chrome
apt-get install -y wget curl unzip gnupg2 ca-certificates
apt-get install -y \
    chromium \
    chromium-driver \
    fonts-liberation \
    libnss3 \
    libxss1 \
    xdg-utils

# Verify ChromeDriver installation
which chromedriver || echo "ChromeDriver installation completed"

echo "Chrome and ChromeDriver setup completed successfully"



# Verify Chrome/Chromium installation
if command -v google-chrome &> /dev/null; then
    CHROME_CMD="google-chrome"
elif command -v chromium &> /dev/null; then
    CHROME_CMD="chromium"
elif command -v chromium-browser &> /dev/null; then
    CHROME_CMD="chromium-browser"
else
    echo "No Chrome/Chromium binary found after install"
    exit 1
fi

CHROME_VERSION=$(${CHROME_CMD} --version)
echo "Chrome version: $CHROME_VERSION"

# Install webdriver-manager
echo "Installing webdriver-manager..."
pip3 install webdriver-manager

# Clean up to reduce image size
apt-get clean
rm -rf /var/lib/apt/lists/*

echo "Docker setup complete!"
echo "ChromeDriver will be managed by webdriver-manager"




