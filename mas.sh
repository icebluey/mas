#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ
set -euo pipefail

_install_7z() {
    set -euo pipefail
    local _tmp_dir="$(mktemp -d)"
    cd "${_tmp_dir}"
    #_7zip_loc="$(wget -qO- 'https://www.7-zip.org/download.html' | grep -i '\-linux-x64.tar' | grep -i 'href="' | sed 's|"|\n|g' | grep -i '\-linux-x64.tar' | sort -V | tail -n 1)"
    #wget -q -c -t 9 -T 9 "https://www.7-zip.org/${_7zip_loc}"
    #tar -xof *.tar*
    #sleep 1
    #rm -f *.tar*
    #file 7zzs | sed -n -E 's/^(.*):[[:space:]]*ELF.*, not stripped.*/\1/p' | xargs --no-run-if-empty -I '{}' strip '{}'
    #rm -f 7z && mv 7zzs 7z
    wget -q -c -t 9 -T 9 'https://github.com/icebluey/7zip-zstd/releases/latest/download/7z'
    rm -f /usr/bin/7z
    rm -f /usr/local/bin/7z
    install -v -c -m 0755 7z /usr/bin/7z
    cp -f /usr/bin/7z /usr/local/bin/7z
    /usr/bin/7z --version 2>/dev/null || true
    cd /tmp
    rm -fr "${_tmp_dir}"
}
_install_7z

rm -fr /tmp/_output
mkdir /tmp/_output
cd /tmp/_output

git clone --remote-submodules --recurse-submodules https://github.com/massgravel/Microsoft-Activation-Scripts.git mas-"$(date -u +"%Y-%m-%d")"
sleep 1
cd mas-"$(date -u +"%Y-%m-%d")"
_tag="$(git describe --tags --always)"
cd ..
mv mas-"$(date -u +"%Y-%m-%d")" mas-v${_tag}-"$(date -u +"%Y-%m-%d")"

/usr/bin/7z a -r -tzip mas-v"${_tag}-$(date -u +"%Y-%m-%d")".zip mas-v"${_tag}-$(date -u +"%Y-%m-%d")"
sleep 1
sha256sum -b mas-v"${_tag}-$(date -u +"%Y-%m-%d")".zip > mas-v"${_tag}-$(date -u +"%Y-%m-%d")".zip.sha256

echo "$(date -u +"%Y-%m-%d")" > .ver.txt
rm -fr mas-v"${_tag}-$(date -u +"%Y-%m-%d")"
exit
