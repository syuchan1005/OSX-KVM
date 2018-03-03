#!/bin/bash

if [ ! -e '/data/mac_hdd.img' ]
then
    qemu-img create -f qcow2 '/data/mac_hdd.img' 128G
fi


qemu-system-x86_64 -enable-kvm \
  -m 3072 \
  -cpu Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on \
  -machine pc-q35-2.9 \
  -smp 4,cores=2 \
  -usb -device usb-kbd -device usb-tablet \
  -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
  -drive if=pflash,format=raw,readonly,file=OVMF_CODE-pure-efi.fd \
  -drive if=pflash,format=raw,file=OVMF_VARS-pure-efi-1024x768.fd \
  -smbios type=2 \
  -device ich9-intel-hda -device hda-duplex \
  -device ide-drive,bus=ide.2,drive=Clover \
  -drive id=Clover,if=none,snapshot=on,format=qcow2,file='./Clover.qcow2' \
  -device ide-drive,bus=ide.1,drive=MacHDD \
  -drive id=MacHDD,if=none,file='/data/mac_hdd.img',format=qcow2 \
  -device ide-drive,bus=ide.0,drive=MacDVD \
  -drive id=MacDVD,if=none,snapshot=on,media=cdrom,file='/data/HighSierra.iso' \
  -netdev user,id=net0 -device e1000-82545em,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
  -vnc 0.0.0.0:0 