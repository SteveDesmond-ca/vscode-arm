# vscode-arm
Automated builds of Visual Studio Code for Linux on ARM

No longer maintained -- for more recent builds, check out https://code.headmelted.com/

## Installation Instructions

1. Download the [latest release](https://github.com/stevedesmond-ca/vscode-arm/releases/latest)
1. Double-click the downloaded `.deb` file, or run `sudo dpkg -i {downloaded .deb}`

## Building from source

1. Clone this repo
1. Run `docker-compose up --build`
1. Once complete, the `.deb` file will be in the `bin` directory
