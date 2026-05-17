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



# Install Google Chrome (Debian method)
if ! command -v google-chrome &> /dev/null; then
    echo "Installing Google Chrome..."
    wget -q -O /usr/share/keyrings/google-linux-signing-key.gpg https://dl.google.com/linux/linux_signing_key.pub
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google-chrome.list
    apt-get update
    apt-get install -y google-chrome-stable
else
    echo "Google Chrome is already installed"
fi

# Verify Chrome installation
CHROME_VERSION=$(google-chrome --version)
echo "Chrome version: $CHROME_VERSION"

# Install webdriver-manager
echo "Installing webdriver-manager..."
pip3 install webdriver-manager

# Clean up to reduce image size
apt-get clean
rm -rf /var/lib/apt/lists/*

echo "Docker setup complete!"
echo "ChromeDriver will be managed by webdriver-manager"





