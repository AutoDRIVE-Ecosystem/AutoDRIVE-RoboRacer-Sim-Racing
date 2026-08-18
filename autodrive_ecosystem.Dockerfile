####################################################
#
#   AutoDRIVE Ecosystem Dockerfile
#
####################################################

# Set base image and environment variables
FROM ros:humble

ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute,display
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# Install Debian packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        sudo \
        wget \
        gpg \
        software-properties-common \
        gedit \
        nano \
        vim \
        curl \
        unzip \
        net-tools \
        libvulkan1 \
        mesa-vulkan-drivers \
        vulkan-tools \
        libgl1 \
        libgl1-mesa-dri \
        libegl1 \
        libgbm1 \
        libdrm2 \
        libglvnd0 \
        mesa-utils \
        libglu1-mesa \
        libgtk-3-0 \
        libnss3 \
        libx11-6 \
        libxcursor1 \
        libxi6 \
        libxinerama1 \
        libxrandr2 \
        libxss1 \
        libxxf86vm1 \
        libasound2 \
        libpulse0 \
        libc++1 \
        libc++abi1 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p "${XDG_RUNTIME_DIR}" \
    && chmod 700 "${XDG_RUNTIME_DIR}"

# Install tools for display
RUN apt update --fix-missing \
    && apt install -y xvfb ffmpeg libgdal-dev libsm6 libxext6

# Copy AutoDRIVE Simulator executable
COPY autodrive_simulator /home/autodrive_simulator

# Set work directory and register executable
WORKDIR /home/autodrive_simulator
RUN chmod +x /home/autodrive_simulator/AutoDRIVE\ Simulator.x86_64

# Install Python dependencies
RUN pip3 install attrdict
RUN pip3 install numpy==1.22.2
RUN pip3 install pillow
RUN pip3 install opencv-contrib-python==4.10.0.84
RUN pip3 install eventlet==0.33.3
RUN pip3 install Flask==1.1.1
RUN pip3 install Flask-SocketIO==4.1.0
RUN pip3 install python-socketio==4.2.0
RUN pip3 install python-engineio==3.13.0
RUN pip3 install greenlet==1.1.0
RUN pip3 install gevent==21.12.0
RUN pip3 install gevent-websocket==0.10.1
RUN pip3 install Jinja2==3.0.3
RUN pip3 install itsdangerous==2.0.1
RUN pip3 install werkzeug==2.0.3
RUN pip3 install transforms3d

# Install ROS 2 dependencies
RUN apt update && apt install -y --no-install-recommends \
    ros-$ROS_DISTRO-tf-transformations \
    ros-$ROS_DISTRO-imu-tools \
    ros-$ROS_DISTRO-rviz2 \
    ros-$ROS_DISTRO-rqt-graph \
    ros-$ROS_DISTRO-cv-bridge \
    ros-$ROS_DISTRO-foxglove-bridge

# Set up AutoDRIVE Devkit (ROS 2 API)
COPY autodrive_devkit/. /home/autodrive_devkit/src/autodrive_devkit
RUN cd /home/autodrive_devkit && colcon build
RUN /bin/bash -c 'echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc' \
    && /bin/bash -c 'echo "source /home/autodrive_devkit/install/setup.bash" >> ~/.bashrc' \
    && /bin/bash -c 'echo "export XDG_RUNTIME_DIR='/tmp/runtime-root'" >> ~/.bashrc' \
    && /bin/bash -c 'source ~/.bashrc'

# Set work directory and expose ports
WORKDIR /home
EXPOSE 4567
EXPOSE 8765

# Set entrypoint
COPY autodrive_ecosystem.sh /home
ENTRYPOINT ["/home/autodrive_ecosystem.sh"]
