FROM ubuntu:24.04

ARG VERSION=1.1.20

RUN apt-get update && \
    apt-get install -y curl wget gnome-keyring libsecret-1-0 lsb-release && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directory structure
RUN mkdir -p /opt/cftools/architect/agent

# Download Architect Agent
RUN wget -q "https://architect.cftools.com/releases/${VERSION}/ArchitectAgent" \
    -O /opt/cftools/architect/agent/ArchitectAgent && \
    chmod +x /opt/cftools/architect/agent/ArchitectAgent

# Copy default config
COPY config.toml /opt/cftools/architect/agent/config.toml

# Create keyrings directory
RUN mkdir -p /root/.local/share/keyrings

# Expose the default Architect Agent port
EXPOSE 8090

WORKDIR /opt/cftools/architect/agent

# Run the agent directly (no systemd in Docker)
ENTRYPOINT ["/opt/cftools/architect/agent/ArchitectAgent", "--config", "/opt/cftools/architect/agent/config.toml"]

