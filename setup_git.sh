#!/bin/bash

ROOT_DIR="$(pwd)"

source scripts/env.sh

git submodule update --init --recursive --progress --jobs 16

# switch QEMU to proper branch
cd ${QEMU_SRC_DIR}
git checkout riscv_pm_qemu_5.1_dev
git submodule init
git submodule update --progress
cd ${ROOT_DIR}

# switch Linux to proper branch
cd ${LINUX_SRC_DIR}
git checkout riscv_pm_5.8_dev
cd ${ROOT_DIR}

# switch LLVM to proper branch
cd ${LLVM_SRC_DIR}
git checkout riscv_hwasan
cd ${ROOT_DIR}

# switch LLVM to proper branch
cd ${BUILDROOT_SRC_DIR}
git checkout da6cca38da1584fed17ffb40316cd7c2fdd5e754
cd ${ROOT_DIR}

# apply my patches
cd ${LINUX_SRC_DIR}
git am ${ROOT_DIR}/0001-change-csr-address.patch
cd ${QEMU_SRC_DIR}
git am ${ROOT_DIR}/0001-change-csr-address-qemu.patch
cd ${ROOT_DIR}
echo "done"
