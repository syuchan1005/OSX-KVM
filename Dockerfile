FROM alpine:3.8

MAINTAINER syuchan1005 <syuchan.dev@gmail.com>

ENV QEMU_AUDIO_DRV=none \
    CORE=2 \
    MEMORY=3G \
    KEYBOARD=en-us \
    CLOVER=1 \
    INSTALLER=1

EXPOSE 5900
EXPOSE 22
VOLUME /data

COPY start.sh /OSX/

RUN chmod 775 /OSX/start.sh \
	&& apk add --no-cache git qemu-system-x86_64 qemu-img \
	&& cd / && git clone https://github.com/kholia/OSX-KVM.git && cd /OSX-KVM \
    && git checkout -b test cfd120dd3092fb38a89544785b2a97bc93668b44 \
    && cp /OSX-KVM/OVMF_CODE.fd /OSX-KVM/OVMF_VARS-1024x768.fd /OSX-KVM/Mojave/Clover.qcow2 /OSX-KVM/boot-macOS-Mojave.sh /OSX \
    && cd /OSX && rm -rf /OSX-KVM && apk del --purge git

WORKDIR /OSX

ENTRYPOINT ["./start.sh"]
