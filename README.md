> Support HighSierra and Mojave

# OSX-KVM Dockerfile
[Docker Hub](https://hub.docker.com/r/syuchan1005/osx-kvm/)

## Container Environment

|ENV NAME|default|description|
|:--|--:|:--|
|CORE|2|number of cores to use|
|MEMORY|3G|amount of memory (M = Megabyte, g = Gigabyte)|
|KEYBOARD|en-us|Keyboard layout|
|CLOVER|1|Add Clover iso (0: false, *: true)|
|INSTALLER|1|Add Installer iso (0: false, *: true)|

### Keyboard layouts
||||||||||||
|---|---|---|---|---|---|---|---|---|---|---|
| ar | de-ch | es | fo    | fr-ca | hu | ja | mk    | no | pt-br | sv |
| da | en-gb | et | fr    | fr-ch | is | lt | nl    | pl | ru    | th |
| de | en-us | fi | fr-be | hr    | it | lv | nl-be | pt | sl    | tr |

## Usage
### Run Container
1. Do Installation Preparation => Preparation steps on your current macOS installation on
[This Repo](https://github.com/kholia/OSX-KVM/blob/master/HighSierra/README.md#preparation-steps-on-your-current-macos-installation)

1. Your generated ISO rename to `macOS.iso`

1. `docker pull syuchan1005/osx-kvm`

1.
```bash
docker run -d --name macOS --device /dev/kvm:/dev/kvm -p 5900:5900 \
-v /path/to/iso/folder:/data syuchan1005/osx-kvm
```

### Install macOS
1. Connect to VNC(port: 5900)
1. Do Installation => Installer Steps on
[This Repo](https://github.com/kholia/OSX-KVM/blob/master/HighSierra/README.md#installer-steps)

## Memo
### BootScript Changes

|DO|WHAT|DEFAULT|TO|
|:--|:--|:--|:--|
|CHANGE|machine|pc-q35-2.11| pc-q35-2.10|
|CHANGE|netdev|tap......  | user,id=net0 -device e1000-82545em,netdev=net0,id=net0,mac=52:54:00:c9:18:27|
|CHANGE|drive|./'Mojave/Clover.qcow2' | Clover.qcow2|
|CHANGE|drive|./mac_hdd.img | /data/mac_hdd.img|
|CHANGE|drive|./'Mojave.iso' | /data/macOS.iso|
|CHANGE|monitor|monitor stdin| vnc 0.0.0.0:0|
|ADD   |k|en-us||

### Mojave.iso
need 7.7GB
