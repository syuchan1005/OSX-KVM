FROM ubuntu:bionic

MAINTAINER syuchan1005 <syuchan.dev@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive \
    QEMU_AUDIO_DRV=none \
    CORE=2 \
    MEMORY=3G \
    CLOVER=1 \
    INSTALLER=1

EXPOSE 5900
VOLUME /data

COPY start.sh /macOS-KVM/

RUN apt-get -qq update && apt-get -qq install -y \
    sudo git vim \
    qemu qemu-kvm qemu-utils \
    libguestfs-tools linux-image-generic uml-utilities \
    virt-manager libvirt-bin bridge-utils > /dev/null \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/kholia/OSX-KVM.git \
    && cd OSX-KVM \
    && git checkout -b test ded4522d17692b7d8d596f8ae3bba8f1bfaae26a \
    && mv OVMF_CODE-pure-efi.fd /macOS-KVM/ \
    && mv OVMF_VARS-pure-efi-1024x768.fd /macOS-KVM/ \
    && cd HighSierra && ./clover-image.sh \
        --iso Clover-v2.4k-4380-X64.iso \
        --cfg clover/config.plist.stripped.qemu \
        --img '/macOS-KVM/Clover.qcow2' > /dev/null \
    && rm -rf /OSX-KVM \
    && chmod 775 /macOS-KVM/start.sh

WORKDIR /macOS-KVM

ENTRYPOINT ["./start.sh"]
