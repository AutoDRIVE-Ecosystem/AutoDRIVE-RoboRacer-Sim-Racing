#!/bin/bash
set -e

cd /home

####################################################
#
#   AutoDRIVE Simulator Setup
#
####################################################

# AutoDRIVE Simulator Executable
# cd /home/autodrive_simulator

# Launch AutoDRIVE Simulator with GUI
# ./AutoDRIVE\ Simulator.x86_64

# Launch AutoDRIVE Simulator Headless
# xvfb-run ./AutoDRIVE\ Simulator.x86_64 -ip 127.0.0.1 -port 4567

# Launch AutoDRIVE Simulator without Graphics
# ./AutoDRIVE\ Simulator.x86_64 -batchmode -nographics -ip 127.0.0.1 -port 4567

####################################################
#
#   AutoDRIVE Devkit Setup
#
####################################################

# Setup Development Environment
source /opt/ros/humble/setup.bash
source /home/autodrive_devkit/install/setup.bash

# AutoDRIVE Devkit Workspace
# cd /home/autodrive_devkit

# Launch AutoDRIVE Devkit with GUI
# ros2 launch autodrive_roboracer bringup_graphics.launch.py

# Launch AutoDRIVE Devkit Headless
# ros2 launch autodrive_roboracer bringup_headless.launch.py

# Launch Foxglove Bridge
# ros2 launch foxglove_bridge foxglove_bridge_launch.xml