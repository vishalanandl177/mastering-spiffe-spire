# Lab Environment Setup

This guide walks you through setting up the tools needed for all course labs.

## Required Tools

### 1. Docker

We use Docker for containerization and Kind for local Kubernetes.

**macOS / Windows:**
Download [Docker Desktop](https://www.docker.com/products/docker-desktop/)

**Linux:**
```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
# Log out and back in
```

Verify:
```bash
docker run hello-world
```

### 2. kubectl

```bash
# macOS
brew install kubectl

# Linux
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

# Verify
kubectl version --client
```

### 3. Kind (Kubernetes in Docker)

```bash
# macOS
brew install kind

# Linux
curl -Lo kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x kind && sudo mv kind /usr/local/bin/

# Verify
kind version
```

### 4. SPIRE Binaries

```bash
# Download SPIRE 1.9.x
SPIRE_VERSION=1.9.6
curl -L -o spire-${SPIRE_VERSION}.tar.gz \
  https://github.com/spiffe/spire/releases/download/v${SPIRE_VERSION}/spire-${SPIRE_VERSION}-linux-amd64-musl.tar.gz
tar -xzvf spire-${SPIRE_VERSION}.tar.gz
sudo mv spire-${SPIRE_VERSION}/bin/* /usr/local/bin/

# Verify
spire-server --version
spire-agent --version
```

### 5. Additional Tools

```bash
# OpenSSL (usually pre-installed)
openssl version

# jq for JSON processing
brew install jq      # macOS
sudo apt install jq  # Linux

# helm (used in later modules)
brew install helm    # macOS
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash  # Linux
```

## Recommended IDE Setup

- **VS Code** with extensions:
  - Kubernetes
  - YAML
  - Docker
  - Go (if doing Go labs)

## Verification Script

Run this to check all tools are installed:

```bash
./scripts/verify-setup.sh
```

If any tool is missing, the script will tell you what to install.

## System Requirements

- **CPU:** 4+ cores recommended
- **RAM:** 8GB minimum, 16GB recommended (Kubernetes is memory-hungry)
- **Disk:** 20GB free space
- **OS:** macOS, Linux, or Windows with WSL2

## Troubleshooting

### "Cannot connect to Docker daemon"
```bash
# Linux: ensure Docker service is running
sudo systemctl start docker

# Add user to docker group
sudo usermod -aG docker $USER
# Log out and back in
```

### Kind cluster fails to start
```bash
# Increase Docker resources in Docker Desktop settings
# CPU: 4+, Memory: 8GB+

# Or for Linux, ensure inotify limits are high enough:
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512
```

### SPIRE binary not found
```bash
# Verify it's in your PATH
which spire-server
echo $PATH

# If not in /usr/local/bin/, move it there:
sudo cp spire-server /usr/local/bin/
```

## Next Steps

Once your environment is set up, proceed to [Module 1: Understanding Zero Trust Security](../module-01/README.md).
