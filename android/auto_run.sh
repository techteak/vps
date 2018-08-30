#!/bin/bash

set -x

if [ $# -eq 0 ] ; then
    echo $0 rom_url
    exit
fi

url=$1
file=${url##*/}

rm *.zip
[[ ${url} =~ "bigota.d.miui.com" ]] && wget ${url}
[[ ${url} =~ "bigota.d.miui.com" ]] || aria2c -s 4 -x 2 ${url}

rm -rf rom
mkdir -p rom

unzip ${file} -d rom > /dev/null

cd rom

if [ -f payload.bin ]; then
    ln -s ../payload_dumper.py .
    ln -s ../update_metadata_pb2.py .
    python payload_dumper.py payload.bin > /dev/null
fi

if [ -f system.new.dat.br ]; then
    ln -s ../brotli .
    ./brotli -d system.new.dat.br -o system.new.dat
fi

if [ -f system.new.dat ]; then
    ln -s ../sdat2img.py .
    python sdat2img.py system.transfer.list system.new.dat > /dev/null
fi

cd -

mkdir -p img
sudo umount img
sudo mount -t ext4 rom/system.img img

