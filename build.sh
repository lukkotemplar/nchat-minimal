#!/bin/bash

set -euo pipefail

DEPS=(
    base-devel
    cmake
    ccache
    file
    go
    gperf
    help2man
    ncurses
    openssl
    readline
    sqlite
    zlib
)

MISSING=()

for pkg in "${DEPS[@]}"; do
    pacman -Q "$pkg" &>/dev/null || MISSING+=("$pkg")
done

if ((${#MISSING[@]})); then
    echo "Installing missing dependencies:"
    printf '  %s\n' "${MISSING[@]}"
    sudo pacman -S --needed "${MISSING[@]}"
fi

VERSION="v5.18.20"

rm -rf build-src dist

git clone --depth 1 --branch "$VERSION" \
    https://github.com/d99kris/nchat.git build-src

cd build-src

NCHAT_CMAKEARGS="-DHAS_DUMMY=OFF -DHAS_MULTIPROTOCOL=OFF" \
    ./make.sh --no-telegram build

cd ..

mkdir -p dist/bin dist/lib

cp build-src/build/bin/nchat dist/bin/
cp build-src/build/lib/libncutil.so dist/lib/
cp build-src/build/lib/libwmchat.so dist/lib/

strip --strip-unneeded dist/bin/nchat
strip --strip-unneeded dist/lib/*.so

echo
echo "Build complete:"
du -h dist/bin/nchat dist/lib/*
du -sh dist
