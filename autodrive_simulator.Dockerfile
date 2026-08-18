####################################################
#
#   AutoDRIVE Simulator Dockerfile
#
####################################################

# Set base image and environment variables
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute,display
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# Install Debian packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        sudo \
        wget \
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

# Set entrypoint
COPY autodrive_simulator.sh /home
ENTRYPOINT ["/home/autodrive_simulator.sh"]