FROM debian:latest

LABEL \
	maintainer="shiuan.dsc@gmail.com" \
	description="SteamCMD base image"

ARG DEBIAN_FRONTEND=noninteractive
ARG STEAMCMD_URL=https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz

# Install, update, clean required packages
RUN apt-get update \
	&& apt-get install -y --no-install-recommends ca-certificates lib32gcc1 curl \
	&& apt-get -y upgrade \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y

# Download, install SteamCMD
# Create steam user
RUN useradd -m steam \
	&& mkdir -p /home/steam/steamcmd \
	&& cd /home/steam/steamcmd \
	&& curl -sqL "${STEAMCMD_URL}" | tar zxvf - \
	&& chown -R steam:steam /home/steam

USER steam

CMD ["/bin/bash"]