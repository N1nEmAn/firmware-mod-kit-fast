# Firmware Mod Kit FAST Usage Guide

The motivation for creating this tool stemmed from encountering issues with the original Firmware Mod Kit (FMK) when it failed to work for me. I found a reliable Docker image from the repository bnzm5270/firmware-mod-kit, which I initially used as a reference. To ensure stability and better control, I adapted and copied the Docker setup to my own Docker account. I appreciate the original work done by bnzm5270, which served as the foundation for this project.

## Dependencies

This project relies on Docker for firmware extraction. Install Docker based on your operating system:

### Ubuntu

```bash
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
```

### macOS

Download and install Docker Desktop from the [Docker website](https://www.docker.com/products/docker-desktop).

### Arch Linux

```bash
sudo pacman -S docker
sudo systemctl start docker
sudo systemctl enable docker
```

## Installation

1. **Clone the repository**

    ```bash
    git clone https://github.com/N1nEmAn/firmware-mod-kit-fast.git
    cd firmware-mod-kit-fast
    ```

2. **Run the installation script**

    To install the `fmk` tool to `/usr/bin`, run:

    ```bash
    ./install.sh
    ```

    This will create a `fmk` command for easy use.

## Usage

**Extract firmware**

The first time Docker is used, it may take some time to download the required Docker image. Once downloaded, firmware extraction will be faster. Use the following command to extract firmware:

```bash
fmk example_DIR_815
```

Here, `example_DIR_815` should be replaced with the actual firmware path.

**Note**: If the `fmk` command fails, try running it with `sudo`:

```bash
sudo fmk example_DIR_815
```

## Example

```bash
# Clone the repository
git clone https://github.com/N1nEmAn/firmware-mod-kit-fast.git
cd firmware-mod-kit-fast

# Run the installation script
./install.sh

# Extract firmware
fmk example_DIR_815
```
