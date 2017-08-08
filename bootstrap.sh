#!/bin/bash

apt-get install emdebian-archive-keyring -y

echo deb http://www.emdebian.org/debian/ squeeze main >> /etc/apt/sources.list.d/emdebian.list
apt-get update

wget http://archive.debian.org/debian/pool/main/g/gmp/libgmp3c2_4.3.2+dfsg-1_amd64.deb
dpkg -i libgmp3c2_4.3.2+dfsg-1_amd64.deb

apt-get install linux-libc-dev-mips-cross libc6-mips-cross libc6-dev-mips-cross binutils-mips-linux-gnu gcc-4.4-mips-linux-gnu g++-4.4-mips-linux-gnu -y

apt-get install debhelper -y
