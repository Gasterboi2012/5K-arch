#!/usr/bin/env bash
#
# build.sh - build the 5K Linux ISO with archiso's mkarchiso.
#
# Requirements: must run on Arch Linux (or an Arch container) as root with the
# `archiso` package installed. For a containerised build that works anywhere,
# use ./build-docker.sh instead.
#
set -euo pipefail

PROFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="${WORK_DIR:-/tmp/5k-archiso/work}"
OUT_DIR="${OUT_DIR:-${PROFILE_DIR}/out}"

if [[ $EUID -ne 0 ]]; then
    echo "error: mkarchiso must run as root (try: sudo ./build.sh)" >&2
    exit 1
fi

if ! command -v mkarchiso >/dev/null 2>&1; then
    echo "error: mkarchiso not found. Install it with: pacman -S archiso" >&2
    echo "       (or build inside a container with ./build-docker.sh)" >&2
    exit 1
fi

echo ">> Building 5K Linux ISO"
echo "   profile : $PROFILE_DIR"
echo "   work    : $WORK_DIR"
echo "   output  : $OUT_DIR"

mkdir -p "$WORK_DIR" "$OUT_DIR"

mkarchiso -v -w "$WORK_DIR" -o "$OUT_DIR" "$PROFILE_DIR"

echo ">> Done. ISO written to: $OUT_DIR"
ls -lh "$OUT_DIR"/*.iso 2>/dev/null || true
