# NixOS
My configuration

## Installation Commands
sudo -i
lsblk
cfdisk /dev/nvme0n1

gpt labels

1G type: EFI
4G type: swap
remaining space, type: Linux Filesystem

mkfs.ext4 -L nixos /dev/vda3
mkswap -L swap /dev/vda2
mkfs.fat -F 32 -n boot /dev/vda1

mount /dev/vda3 /mnt
mount --mkdir /dev/vda1 /mnt/boot
swapon /dev/vda2

nixos-generate-config --root /mnt
cd /mnt/etc && mv nixos nix.bak
git clone https://github.com/seko2000-ksa/nixos && rm -rf nixos/.git
mv nix.bak/hardware-configuration.nix nixos/devices/laptop/prometheus/