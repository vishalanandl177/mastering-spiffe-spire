#!/bin/bash
set -e
mkdir -p data/server
./spire/bin/spire-server run -config server.conf
