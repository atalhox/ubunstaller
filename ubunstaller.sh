#!/bin/bash

# Add the necessary repositories
sudo add-apt-repository -y ppa:videolan/stable-daily
sudo add-apt-repository -y ppa:inkscape.dev/stable
sudo add-apt-repository -y ppa:transmissionbt/ppa
sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
sudo add-apt-repository -y ppa:otto-kesselgulasch/spotify
sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
sudo add-apt-repository -y ppa:ubuntu-mozilla-security/ppa
sudo add-apt-repository -y ppa:webupd8team/y-ppa-manager
sudo add-apt-repository -y ppa:thomas-schiex/blender
sudo add-apt-repository -y ppa:flameshot-dev/stable
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
sudo install -o root -g root -m 644 microsoft.asc.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Update the repositories
sudo apt-get update

# Install the applications
sudo apt-get install -y vlc firefox google-chrome-stable gimp steam transmission audacity inkscape spotify-client thunderbird dropbox python3-psutil python3-xlib python3-tk python3-gi python3-gi-cairo python3-dbus python3-dev python3-pil python3-pil.imagetk wine flameshot code git

# Install Docker and Docker Compose
sudo apt-get install -y docker.io docker-compose

# Add the current user to the docker group
sudo usermod -aG docker $USER

# Restart the Docker service
sudo systemctl restart docker

echo "Installation complete! Please logout and login again so that the Docker group configuration can be applied."
