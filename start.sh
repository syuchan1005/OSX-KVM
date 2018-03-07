#!/bin/bash

if [ ! -e '/data/mac_hdd.img' ]
then
  qemu-img create -f qcow2 '/data/mac_hdd.img' 128G
fi

if [ $CLOVER -ne 0 ]
then
  clover=(-device ide-drive,bus=ide.2,drive=Clover \
          -drive id=Clover,if=none,snapshot=on,format=qcow2,file='./Clover.qcow2')
fi

if [ $INSTALLER -ne 0 ]
then
  installer=(-device ide-drive,bus=ide.0,drive=MacDVD \
              -drive id=MacDVD,if=none,snapshot=on,media=cdrom,file='/data/HighSierra.iso')
fi

qemu-system-x86_64 -enable-kvm \
  -cpu Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on \
  -machine pc-q35-2.9 \
  -usb -device usb-kbd -device usb-tablet \
  -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
  -drive if=pflash,format=raw,readonly,file=OVMF_CODE-pure-efi.fd \
  -drive if=pflash,format=raw,file=OVMF_VARS-pure-efi-1024x768.fd \
  -smbios type=2 \
  -device ich9-intel-hda -device hda-duplex \
  -device ide-drive,bus=ide.1,drive=MacHDD \
  -drive id=MacHDD,if=none,file='/data/mac_hdd.img',format=qcow2 \
  -netdev user,id=net0 -device e1000-82545em,netdev=net0,id=net0,mac=52:54:00:c9:18:27 \
  -vnc 0.0.0.0:0 \
  -smp $(($CORE * 2)),cores=$CORE \
  -m $MEMORY \
  "${clover[@]}" \
  "${installer[@]}" \
  "$@"