#! /bin/bash

cd buildroot/
make qemu_arm_versatile_defconfig
make menuconfig
make
qemu-system-arm -M versatilepb -kernel output/images/zImage -dtb output/images/versatile-pb.dtb -drive file=output/images/rootfs.ext2,if=scsi -append "root=/dev/sda console=ttyAMA0,115200" -nographic

#Modules (already integrated in zImage)
cd output/build/linux-4.11.3
mkinitramfs -o initrd.img-4.11.3
cd -
qemu-system-arm -M versatilepb -kernel output/images/zImage -initrd output/build/linux-4.11.3/initrd.img-4.11.3 -dtb output/images/versatile-pb.dtb -drive file=output/images/rootfs.ext2,if=scsi -append "root=/dev/sda console=ttyAMA0,115200" -nographic
ls /lib/modules/4.11.3/kernel/fs/fat/

#Network
qemu-system-arm -M versatilepb -kernel output/images/zImage -dtb output/images/versatile-pb.dtb -drive file=output/images/rootfs.ext2,if=scsi -append "root=/dev/sda console=ttyAMA0,115200" -netdev user,id=eth0 -device e1000,netdev=eth0,mac=64:00:6a:88:1e:2a -nographic