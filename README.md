# OSX-KVM Dockerfile
[Docker Hub](https://hub.docker.com/r/syuchan1005/osx-kvm/)

## Usage
### Run Container
1. Do Installation Preparation => Preparation steps on your current macOS installation on [This Repo](https://github.com/kholia/OSX-KVM/blob/master/HighSierra/README.md#preparation-steps-on-your-current-macos-installation)

1. Your generated ISO rename to `HighSierra.iso`

1. `docker pull syuchan1005/osx-kvm`

1. 
```bash
docker run -d --name macOS --device /dev/kvm:/dev/kvm -p 5900:5900 \
-v /path/to/iso/folder:/data syuchan1005/osx-kvm
```

### Install macOS
1. Connect to VNC(port: 5900)
1. Do Installation => Installer Steps on [This Repo](https://github.com/kholia/OSX-KVM/blob/master/HighSierra/README.md#installer-steps)
