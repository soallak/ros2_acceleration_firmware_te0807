#! /bin/bash

set -e # Exist on first error

function import_platform {
  local vitis_workspace=$1
  local vitis_pfm_name=$2
  local firmware_dir=$3
  local platform_dir=$firmware_dir/platform
  mkdir -p $platform_dir
  if [[ -d $platform_dir/$vitis_pfm_name ]]; then 
    echo "deleting old files pfm files"
    rm -rf $platform_dir/$vitis_pfm_name
  fi

  cp -r $vitis_workspace/$vitis_pfm_name/export/$vitis_pfm_name $platform_dir/
}

function import_petalinux {
  local plnx=$1
  local firmware_dir=$2

  # These should normally be the same things used to create the vitis platform
  # I also import BOOT.BIN, although this is not necessary
  local import_files=(zynqmp_fsbl.elf pmufw.elf bl31.elf u-boot.elf system.dtb system.bit Image boot.scr BOOT.BIN)
  for x in ${import_files[@]}
  do 
    y=$plnx/images/linux/$x
    if [[ -f $firmware_dir/$x ]]; then 
      mv $firmware_dir/$x $firmware_dir/$x.old; 
    fi
    cp $y $firmware_dir/
  done
}

function create_artifacts {
  # I used platforminfo to get these for my te0807
  # I should automatize this
  local firmware_dir=$1

  if [[ -f $firmware_dir/BOARD ]]; then 
    rm -fi $firmware_dir/BOARD
  fi
  if [[ -f $firmware_dir/SOC ]]; then 
    rm -fi $firmware_dir/SOC
  fi
  echo "te0807_02_07ev_1ek" > $firmware_dir/BOARD
  echo "xczu7ev-fbvb900-1-e" > $firmware_dir/SOC
}

function import_rootfs {
  local rootfs_tar=$1
  local firmware_dir=$2

  local sysroot_dir=$firmware_dir/sysroot
  # I back up the tar
  if [[ -f $firmware_dir/rootfs.tar ]]; then 
    mv $firmware_dir/rootfs.tar $firmware_dir/rootfs.tar.old
  fi
  cp $rootfs_tar $firmware_dir/rootfs.tar
  rootfs_tar=$(readlink -f $firmware_dir/rootfs.tar)
  # and remove extracted files
  if [[ -d $sysroot_dir ]]; then 
    rm -rf $sysroot_dir
  fi
  mkdir -p $sysroot_dir
  echo "Extracting rootfs $rootfs_tar"
  tar -C $sysroot_dir -x -f $rootfs_tar
}


FIRMWARE_DIR=$(dirname $0)/firmware

VITIS_WORKSPACE_PATH=$1 
VITIS_PFM_NAME=$2
PETALINUX_PRJ=$3
ROOTFS_TAR=$4


if [[ -d $VITIS_WORKSPACE_PATH ]]; then 
  echo "Importing Vitis platform..."
  import_platform $VITIS_WORKSPACE_PATH $VITIS_PFM_NAME $FIRMWARE_DIR
  create_artifacts $FIRMWARE_DIR
fi

if [[ -d $PETALINUX_PRJ ]]; then 
  echo "Importing Petalinux artificats..."
  import_petalinux  $PETALINUX_PRJ $FIRMWARE_DIR
fi

if [[ -f $ROOTFS_TAR ]]; then 
  echo "Importing Rootfs... "
  import_rootfs $ROOTFS_TAR $FIRMWARE_DIR
fi 
