#!/usr/bin/env bash

if [ $# -ne a]; then
  echo Specify Ruby version
  exit
fi

major=$(echo $1 | cut -d. -f1)
minor=$(echo $1 | cut -d. -f2)
patch=$(echo $1 | cut -d. -f3)

PATH="/home/linuxbrew/.linuxbrew/opt/openssl@3/bin:$PATH" \
  LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/openssl@3/lib" \
  CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/openssl@3/include" \
  PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/openssl@3/lib/pkgconfig" \
  rbenv install $1
