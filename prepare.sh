#!/bin/bash
set -e
source /tmp/buildconfig
source /etc/os-release
set -x

## Temporarily disable dpkg fsync to make building faster.
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
   echo force-unsafe-io >/etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

echo "deb http://security.ubuntu.com/ubuntu xenial-security main" >>/etc/apt/sources.list

## Update pkg repos
apt update -qq

## Install things we need
$minimal_apt_get_install php php-cli dumb-init wget unzip ca-certificates libfontconfig1 libfreetype6 libfluidsynth2 libicu-dev libpng16-16 liblzma-dev liblzo2-2 libsdl1.2debian libsdl2-2.0-0 libharfbuzz0b >/dev/null 2>&1

## Download and install openttd
wget -q https://github.com/JGRennison/OpenTTD-patches/releases/download/jgrpp-${OPENTTD_JGR_VERSION}/openttd-jgrpp-${OPENTTD_JGR_VERSION}-linux-ubuntu-jammy-amd64.deb
dpkg -i openttd-jgrpp-${OPENTTD_JGR_VERSION}-linux-ubuntu-jammy-amd64.deb

## Download GFX and install
mkdir -p /usr/share/games/openttd/baseset/
cd /usr/share/games/openttd/baseset/
wget -q -O opengfx-${OPENGFX_VERSION}.zip https://cdn.openttd.org/opengfx-releases/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}-all.zip

unzip opengfx-${OPENGFX_VERSION}.zip
tar -xf opengfx-${OPENGFX_VERSION}.tar
rm -rf opengfx-*.tar opengfx-*.zip

## Create user
adduser --disabled-password --uid 1000 --shell /bin/bash --gecos "" openttd
addgroup openttd users

## Set entrypoint script to right user
chmod +x /openttd.sh
