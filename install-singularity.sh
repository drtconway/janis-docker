#!/bin/bash
set -e

apt install -y  build-essential cryptsetup-bin libssl-dev uuid-dev libgpgme11-dev squashfs-tools

cd /tmp
curl -o go1.14.3.linux-amd64.tar.gz https://dl.google.com/go/go1.14.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.3.linux-amd64.tar.gz

echo 'export GOPATH=/go' >> ~/.bashrc
echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc
source ~/.bashrc

export GOPATH=/go
export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin

mkdir -p $GOPATH/src/github.com/sylabs
cd $GOPATH/src/github.com/sylabs
git clone https://github.com/sylabs/singularity.git
cd singularity

go get -u -v github.com/golang/dep/cmd/dep || true

cd $GOPATH/src/github.com/sylabs/singularity
./mconfig || true
make -C builddir
make -C builddir install

