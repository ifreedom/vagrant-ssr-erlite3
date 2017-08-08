#!/bin/bash

mkdir -p /usr/src

# build pcre

cd /usr/src
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz
tar zxf pcre-8.40.tar.gz
cd pcre-8.40

./configure --host=mips-linux-gnu --prefix=/usr/local/pcre-mips --enable-utf8 --enable-unicode-properties

make && make install

# build zlib

cd /usr/src
wget http://www.zlib.net/zlib-1.2.11.tar.gz
tar zxf zlib-1.2.11.tar.gz
cd zlib-1.2.11/

export CC=mips-linux-gnu-gcc
export AR=mips-linux-gnu-ar
export RANLIB=mips-linux-gnu-ranlib
./configure --prefix=/usr/local/zlib-mips
unset CC AR RANLIB

make && make install

# build openssl
cd /usr/src
wget http://openssl.org/source/openssl-1.0.2e.tar.gz
tar zxvf openssl-1.0.2e.tar.gz
cd  openssl-1.0.2e

export CC=mips-linux-gnu-gcc
export CXX=mips-linux-gnu-cpp
export AR=mips-linux-gnu-ar
export RANLIB=mips-linux-gnu-ranlib
./Configure no-asm shared --prefix=/usr/local/openssl-mips linux-mips32
unset CC CXX AR RANLIB

make && make install

# build ssr
cd /usr/src
wget https://github.com/shadowsocksr-rm/shadowsocksr-libev/archive/master.tar.gz -O shadowsocksr-libev-master.tar.gz
tar zxvf shadowsocksr-libev-master.tar.gz
cd shadowsocksr-libev-master

./configure --host=mips-linux-gnu \
  --with-openssl=/usr/local/openssl-mips \
  --with-pcre=/usr/local/pcre-mips \
  --with-zlib=/usr/local/zlib-mips \
  --prefix=/usr/local/shadowsocks-libev-mips/ \
  --disable-ssp --disable-documentation

# 必须加上--disable-ssp关闭-fstack-protector。
make && make install

DEST=/vagrant/shadowsocks-libev-2.5.6

mkdir -p $DEST/bin $DEST/lib
cp /usr/local/pcre-mips/lib/libpcre.so* $DEST/lib/
cp /usr/local/shadowsocks-libev-mips/bin/ss-* $DEST/bin/

cd $DEST
dpkg-buildpackage -us -uc -amips
