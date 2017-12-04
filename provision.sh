#!/bin/bash
apt -y update &&
apt -y dist-upgrade &&
TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB" 'https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb' &&
dpkg -i "$TEMP_DEB" &&
rm -fr "$TEMP_DEB" &&
apt -y update && apt -y install elixir erlang-dev