FROM ubuntu:bionic AS create-clover

MAINTAINER syuchan1005 <syuchan.dev@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && apt-get -qq install -y \
    sudo git libguestfs-tools linux-image-generic \
    && git clone https://github.com/kholia/OSX-KVM.git && cd OSX-KVM \
    && git checkout -b test ded4522d17692b7d8d596f8ae3bba8f1bfaae26a \
    && cd HighSierra && ./clover-image.sh --iso Clover-v2.4k-4380-X64.iso --cfg clover/config.plist.stripped.qemu --img 'Clover.qcow2'

FROM alpine:3.7

COPY --from=create-clover ["/OSX-KVM/HighSierra/Clover.qcow2", "/OSX-KVM/OVMF_CODE-pure-efi.fd", "/OSX-KVM/OVMF_VARS-pure-efi-1024x768.fd", "/OSX-KVM/"]

ENV QEMU_AUDIO_DRV=none \
    CORE=2 \
    MEMORY=3G \
    CLOVER=1 \
    INSTALLER=1

WORKDIR /OSX-KVM

RUN apk add --no-cache qemu-system-x86_64 

EXPOSE 5900
VOLUME /data

COPY start.sh /OSX-KVM/
RUN chmod 775 start.sh

ENTRYPOINT ["./start.sh"]
