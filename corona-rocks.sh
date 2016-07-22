#!/bin/bash

# Luarocks for CoronaSDK
# (c)2016 C. Byerley
# @develephant

## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## RUN THIS FILE IN YOUR CORONA SDK PROJECT ROOT DIRECTORY ONLY
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

WD=$(pwd)
LUAROCKS='luarocks-2.3.0'
CONF='config-5.1.lua'
BASE='vendor'
PREFIX=$WD

mkdir -p "${PREFIX}/${BASE}"
mkdir -p "${PREFIX}/${BASE}/bin"
mkdir -p "${PREFIX}/${BASE}/lib"

cd /tmp

wget -q "http://keplerproject.github.io/luarocks/releases/${LUAROCKS}.tar.gz"
tar xzf "${LUAROCKS}.tar.gz"
cd $LUAROCKS

./configure --prefix="${PREFIX}/${BASE}" --rocks-tree="${PREFIX}/" --sysconfdir="${PREFIX}/${BASE}" --force-config

make -s build
make -s install

cat $1 > "${PREFIX}/${BASE}/${CONF}" <<BLOB
rocks_trees =
{
  {
    name    = [[coronasdk]],
    root    = [[${PREFIX}/${BASE}]],
    bin_dir = [[${PREFIX}/${BASE}/bin]],
    lib_dir = [[${PREFIX}/${BASE}/lib]],
    lua_dir = [[${PREFIX}]]
  }
}
BLOB

#linky
cd $PREFIX
ln -sf "${PREFIX}/${BASE}/bin/luarocks-5.1" luarocks

clear
echo
echo '###############################################################################'
echo ' !! Ready To Rock !! | https://luarocks.org'
echo '-------------------------------------------------------------------------------'
echo
echo '  ./luarocks install <rock_name>'
echo '  ./luarocks search <rock_name>'
echo '  ./luarocks --help'
echo
echo '###############################################################################'
echo
