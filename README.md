# CFTools Architect Agent - Docker

> ⚠️ **Unofficial Docker Image** - This is a community-maintained Docker setup for [CFTools Architect Agent](https://architect.cftools.com/). It will be available until CFTools publishes their own official Docker image when they are out of beta.

## Docker hub

You can find the Docker image on Docker Hub:
- [arkmind/architect-agent](https://hub.docker.com/r/arkmind/architect-agent)

## About

This repository provides a Dockerized version of the CFTools Architect Agent for managing DayZ servers on Linux.

## Quick Start

### 1. Clone & Setup

```bash
git clone <repository-url>
cd architect-docker
```

### 2. Configure

Copy the example compose file and create your config directory:

```bash
cp docker-compose.example.yml docker-compose.yml
mkdir -p config
cp config.toml config/config.toml
```

Edit `config/config.toml` and set your license key:

```toml
[authorization]
  license_key = "<YOUR_LICENSE_KEY>"
```

### 3. Create root.txt

Create a `config/root.txt` file with your root password for the Architect Agent web interface.

### 4. Run

```bash
docker compose up -d
```

## Configuration

### Volumes

| Host Path | Container Path | Description |
|-----------|----------------|-------------|
| `./config/config.toml` | `/opt/cftools/architect/agent/config.toml` | Agent configuration |
| `./config/root.txt` | `/opt/cftools/architect/agent/root.txt` | Root password file |
| `./deployments/` | `/opt/cftools/architect/agent/deployments/` | Server deployments |
| `./config/database/` | `/opt/cftools/architect/agent/db` | Agent database |

You will find more volumes and configuration options in the [CFTools Documentation](https://docs.cftools.cloud/).

### Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 8090 | TCP | Architect Agent Web UI |
| 2302-2305 | TCP/UDP | DayZ server ports (adjust as needed) |

## Updating

To update to a newer version, modify the `VERSION` build arg in the Dockerfile or rebuild:

```bash
docker compose build --no-cache
docker compose up -d --force-recreate
```

## Links

- [CFTools Architect](https://architect.cftools.com/)
- [CFTools Documentation](https://docs.cftools.cloud/)
- [CFTools Discord](https://discord.gg/cftools)

## Disclaimer

This is an **unofficial** community project. For official support, please refer to CFTools directly. This Docker setup is provided as-is and will be deprecated once CFTools releases their official Docker solution.
