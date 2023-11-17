# nixos-pi5

Try to get the Raspberry Pi 5 working with NixOS.
Therefor, I'm building bootable images with different kernels and bootloaders.

Trying to fix the following error:
```log
Device-tree file "bcm2712-rpi-5-b.dtb" not found.
The installed operating system (OS) does not indicate support for the Raspberry Pi 5
Update the OS or set os_check=0 in config.txt to skip this check.
```

| Kernel version | Image link                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Status      |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| 6.1.21         | [Download](https://s3.eu-central-003.backblazeb2.com/crab-share/01HG09F2SD2W5RMX9YJS7G0D2Z/pi5-image-23.11.20231114.bf744fe-aarch64-linux.img.zst?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=003d560892a1b3a0000000002%2F20231117%2Feu-central-003%2Fs3%2Faws4_request&X-Amz-Date=20231117T090955Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&response-cache-control=no-cache%2C+no-store&X-Amz-Signature=ea2a27a1c3d393a083cc853e09670e61a2648298d96e1c313add0508530edf33) | not booting |
