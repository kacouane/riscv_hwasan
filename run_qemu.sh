#!/bin/bash

ROOT_DIR="$(pwd)"
# MAC=$(whoami | md5sum | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')

source scripts/env.sh
#-append "root=/dev/vda ro console=ttyS0" \
QEMU_BIN=${INSTALL_DIR}/bin/qemu-system-riscv64
# sudo ovs-vsctl add-br vmbr20
${QEMU_BIN} \
    -machine virt -cpu rv64,x-j=on \
    -kernel ${LINUX_BUILD_DIR}/arch/riscv/boot/Image \
    -append "root=/dev/vda ro console=ttyS0" \
    -device virtio-blk-device,drive=hd0 \
    -drive file=${BUILDROOT_BUILD_DIR}/output/images/rootfs.ext2,format=raw,id=hd0 \
    -m 2G \
    -netdev user,id=n1,hostfwd=tcp::3333-:22 \
    -device e1000,netdev=n1
# #     -device virtio-net-device,netdev=net0,mac=${MAC} \
# #     -netdev tap,id=net0,script=./scripts/add_to_bridge.sh,downscript=./scripts/del_from_bridge.sh \
# #     -nographic
#     -drive file=${BUILDROOT_BUILD_DIR}/output/images/rootfs.ext2,format=raw,id=hd0 \${ROOT_DIR}/busybear.bin
