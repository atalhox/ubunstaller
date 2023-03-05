#!/bin/bash

function install_chrome() {
  if [ ! -f "google-chrome-stable_current_amd64.deb" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  fi
  dpkg -i google-chrome-stable_current_amd64.deb
  apt --fix-broken install
  rm google-chrome-stable_current_amd64.deb
}

function install_vscode() {
  if ! grep -q "packages.microsoft.com/repos/vscode" /etc/apt/sources.list.d/*; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    rm packages.microsoft.gpg
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscode.list
  fi
}

function update_repositories() {
  apt update
}

function install_apps() {
  apt install -y \
    code \
    firefox \
    flameshot \
    git \
    gimp \
    npm \
    steam \
    thunderbird \
    transmission \
    vim \
    vlc \
    wget
}

function install_docker() {
  if ! command -v docker &> /dev/null; then
    apt install -y docker.io docker-compose
  fi
}

function add_user_to_docker_group() {
  if groups $USER | grep -q "\bdocker\b"; then
    echo "User is already in docker group."
  else
    usermod -aG docker $USER
    echo "User added to docker group."
  fi
}

function restart_docker() {
  systemctl restart docker
}
    
install_chrome
install_vscode

update_repositories
install_apps

install_docker
add_user_to_docker_group

restart_docker