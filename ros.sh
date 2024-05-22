#!/bin/bash

SUDO_PASSWORD='YourPW'

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

function continue_wizard {
    while true; do
        read -p "Do you want to continue? [Y/n]" yn
        case $yn in
            [Yy]* ) echo -e "${GREEN}Script starting${NC}"; break;;
            [Nn]* ) exit;;
            * ) echo "Do you want to continue? [Y/n]";;
        esac
    done
}

function install_ros {
    echo $SUDO_PASSWORD | sudo -S sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    echo $SUDO_PASSWORD | sudo -S apt install curl
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
    echo $SUDO_PASSWORD | sudo -S apt update
    echo $SUDO_PASSWORD | sudo -S apt install ros-noetic-desktop-full
    source /opt/ros/noetic/setup.bash
    echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
    source ~/.bashrc
    echo $SUDO_PASSWORD | sudo -S apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
    echo $SUDO_PASSWORD | sudo -S apt install python3-rosdep
    echo $SUDO_PASSWORD | sudo -S rosdep init
    rosdep update
}

echo -e "${YELLOW}This program installs ROS1 (noetic) and all associated dependencies.${NC}"
continue_wizard

install_ros

echo -e "${GREEN}ROS is completly installed!${NC}"

echo -e "${YELLOW}Do you want to setup catkin_ws & sandbox_ws, the missing libraries & dependencies and all other used ROS tools?${NC}"
continue_wizard

echo -e "${RED}Missing skript${NC}
