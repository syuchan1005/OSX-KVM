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

RUN apt-get -qq update && apt-get -qq install -y \
    sudo git vim qemu libguestfs-tools uml-utilities linux-image-generic \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/kholia/OSX-KVM.git && cd OSX-KVM \
    && git checkout -b test ded4522d17692b7d8d596f8ae3bba8f1bfaae26a

WORKDIR /OSX-KVM
COPY start.sh /OSX-KVM/
RUN chmod 775 start.sh

ENTRYPOINT ["./start.sh"]
