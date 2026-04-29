#!/bin/bash
set -e
SPIRE_VERSION="1.9.0"
ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] && ARCH=amd64
[ "$ARCH" = "aarch64" ] && ARCH=arm64
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

URL="https://github.com/spiffe/spire/releases/download/v$SPIRE_VERSION/spire-$SPIRE_VERSION-$OS-$ARCH-glibc.tar.gz"
echo "Downloading SPIRE $SPIRE_VERSION..."
curl -sL "$URL" -o spire.tar.gz
tar -xzf spire.tar.gz
mv "spire-$SPIRE_VERSION" spire
echo "✓ SPIRE installed in ./spire"
./spire/bin/spire-server --version
./spire/bin/spire-agent --version
