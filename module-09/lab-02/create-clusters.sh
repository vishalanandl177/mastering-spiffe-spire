#!/bin/bash
set -e
kind create cluster --name cluster-a
kind create cluster --name cluster-b
echo "✓ Two clusters created"
