# vscode-arm
Automated builds of Visual Studio Code for ARM Linux

## Installation Instructions

1. Download the [latest release](https://github.com/stevedesmond-ca/vscode-arm/releases/latest)
1. Double-click the downloaded `.deb` file, or run `sudo dpkg -i {downloaded .deb}`

## Building from source

*Note: These instructions currently only work for versions 1.21.1 and older. New builds, and new scripts, are coming soon!*

1. Clone this repo
1. Run `./setup` to configure your system
1. Run `./build` to compile vscode and build a `.deb` file
