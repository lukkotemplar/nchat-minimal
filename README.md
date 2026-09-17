# nchat-minimal

Minimal WhatsApp-only build of nchat for Arch Linux.

Based on nchat v5.18.20.

## Features

Enabled:

- WhatsApp

Disabled:

- Telegram
- TDLib
- Dummy backend
- Multiprotocol mode

## Build dependencies

- base-devel
- cmake
- git
- go

Go and the other build tools are only required to compile nchat.
They are not required at runtime.

## Runtime dependencies

The WhatsApp-only build uses the normal Arch system libraries required by
nchat, including:

- glibc
- gcc-libs
- ncurses
- file / libmagic
- openssl
- sqlite
- zlib

Python is NOT required by this build.

## Build

Clone nchat v5.18.20:

    git clone --depth 1 --branch v5.18.20 \
      https://github.com/d99kris/nchat.git

Then build it with:

    NCHAT_CMAKEARGS="-DHAS_DUMMY=OFF -DHAS_MULTIPROTOCOL=OFF" \
      ./make.sh --no-telegram build

The resulting runtime files are:

    nchat
    libncutil.so
    libwmchat.so

Strip them before installation:

    strip --strip-unneeded nchat
    strip --strip-unneeded libncutil.so
    strip --strip-unneeded libwmchat.so

## Result

Official nchat package:

    ~50.3 MiB

Minimal WhatsApp-only build:

    ~24 MiB

This build does not contain Telegram, TDLib or the Dummy backend.

## Configuration

nchat stores its configuration and WhatsApp session under:

    ~/.config/nchat

Do NOT commit this directory.

It may contain WhatsApp session data and other private information.
