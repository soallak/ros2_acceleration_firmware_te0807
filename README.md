
A ROS2 package contaning accleration firmware artifcats to be used with Xilinx Kria Stack.

Generting `sd_card.img` using. `colcon acceleration linux vanilla --install-dir install-te0807` is not supported

## Artificats
TODO
## Import Artificats
Use the `make_firmware.sh` to import artifcats before using this package. The scripts needs to be
invoked from the root path of this repository:

```
./make_firmware.sh <vitis-workspace-path> <pfm-name> <petalinux-prj-path> <rootfs-tar-path>
```

The repository already contains initial artifacts. Only rootfs is missing, the above command can be
invoked with dummy arguments to only import rootfs 

```
./make_firmware.sh  x y z <rootfs-tar-path>
```

where x and z do not correspond to any existing file.

