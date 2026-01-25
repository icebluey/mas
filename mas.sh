#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
set -euo pipefail

rm -fr /tmp/_output
mkdir /tmp/_output
cd /tmp/_output

git clone --remote-submodules --recurse-submodules https://github.com/massgravel/Microsoft-Activation-Scripts.git mas-"$(date -u +"%Y-%m-%d")"
sleep 1
tar -Jcvf mas-"$(date -u +"%Y-%m-%d")".tar.xz mas-"$(date -u +"%Y-%m-%d")"
sleep 1
sha256sum -b mas-"$(date -u +"%Y-%m-%d")".tar.xz > mas-"$(date -u +"%Y-%m-%d")".tar.xz.sha256

rm -fr mas-"$(date -u +"%Y-%m-%d")"
exit

