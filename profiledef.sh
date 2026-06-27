#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="5k"
iso_label="5K_$(date +%Y%m)"
iso_publisher="5K Linux <https://github.com/Gasterboi2012/5K-arch>"
iso_application="5K Linux Live/Installer ISO"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.systemd-boot.esp' 'uefi-x64.systemd-boot.esp'
           'uefi-ia32.systemd-boot.eltorito' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.gnupg"]="0:0:700"
  ["/root/customize_airootfs.sh"]="0:0:755"
  ["/usr/local/bin/5k-install"]="0:0:755"
  ["/usr/local/bin/5k-welcome"]="0:0:755"
  ["/usr/local/bin/5k-fastfetch"]="0:0:755"
)
