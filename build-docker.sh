#!/usr/bin/env bash
#
# build-docker.sh - build the 5K Linux ISO inside an Arch Linux container.
#
# Works on any host with Docker (or Podman). The container needs --privileged so
# mkarchiso can use loop devices.
#
set -euo pipefail

PROFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${OUT_DIR:-${PROFILE_DIR}/out}"

ENGINE="docker"
command -v docker >/dev/null 2>&1 || ENGINE="podman"
command -v "$ENGINE" >/dev/null 2>&1 || { echo "error: need docker or podman" >&2; exit 1; }

mkdir -p "$OUT_DIR"

echo ">> Building 5K Linux ISO in an archlinux container ($ENGINE)"

"$ENGINE" run --rm --privileged \
    -v "$PROFILE_DIR":/profile:Z \
    -v "$OUT_DIR":/out:Z \
    archlinux:latest \
    bash -euo pipefail -c '
        pacman -Sy --noconfirm archiso
        mkarchiso -v -w /tmp/work -o /out /profile
    '

echo ">> Done. ISO written to: $OUT_DIR"
ls -lh "$OUT_DIR"/*.iso 2>/dev/null || true
