# Ubuntu 22.04 for better glibc compatibility with DayZ
FROM ubuntu:22.04

ARG VERSION=1.1.20

ENV DEBIAN_FRONTEND=noninteractive

# Add 32-bit architecture (required for DayZ server runtime)
RUN dpkg --add-architecture i386

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    # CFTools Architect requirements
    curl wget gnome-keyring libsecret-1-0 lsb-release \
    python3 python3-pip \
    # DayZ server 32-bit runtime libraries
    lib32gcc-s1 lib32stdc++6 \
    libsdl2-2.0-0:i386 \
    # Utilities
    ca-certificates tmux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/cftools/architect/agent

RUN wget -q "https://architect.cftools.com/releases/${VERSION}/ArchitectAgent" \
    -O /opt/cftools/architect/agent/ArchitectAgent && \
    chmod +x /opt/cftools/architect/agent/ArchitectAgent

COPY config.toml /opt/cftools/architect/agent/config.toml

RUN mkdir -p /root/.local/share/keyrings

EXPOSE 8090

WORKDIR /opt/cftools/architect/agent

ENTRYPOINT ["/opt/cftools/architect/agent/ArchitectAgent", "--config", "/opt/cftools/architect/agent/config.toml"]