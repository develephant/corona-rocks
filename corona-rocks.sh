#!/bin/bash
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# The MIT License (MIT)

# LuaRocks for CoronaSDK
# Copyright (c) 2016 C. Byerley @develephant
# https://github.com/develephant/corona-rocks

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## RUN THIS FILE IN YOUR CORONA SDK PROJECT ROOT DIRECTORY ONLY
## ./corona-rocks.sh
## ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

###############################################################################
## Preflight
###############################################################################

# Working directory
WD=$(pwd)
# Current LuaRocks version
LUAROCKS='luarocks-2.3.0'
# LuaRocks config file name
CONF='config-5.1.lua'
# Base for LuaRocks related files
BASE='vendor'
# Path prefix, using working directory
PREFIX=$WD

###############################################################################
## Scaffold directories
###############################################################################
mkdir -p "${PREFIX}/${BASE}/bin"
mkdir -p "${PREFIX}/${BASE}/lib"

###############################################################################
## Download LuaRocks archive
###############################################################################
cd /tmp

wget -q "http://keplerproject.github.io/luarocks/releases/${LUAROCKS}.tar.gz"
tar xzf "${LUAROCKS}.tar.gz"
cd $LUAROCKS

###############################################################################
## Set up build configuration
###############################################################################
./configure --prefix="${PREFIX}/${BASE}" --rocks-tree="${PREFIX}/" \
--sysconfdir="${PREFIX}/${BASE}" --force-config

###############################################################################
## Build & Install LuaRocks
###############################################################################
make -s build
make -s install

###############################################################################
## Generate LuaRocks config for the project
###############################################################################
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

###############################################################################
## Soft link to luarocks-5.1
###############################################################################
cd $PREFIX
ln -sf "${PREFIX}/${BASE}/bin/luarocks-5.1" luarocks

###############################################################################
## Fanfare
###############################################################################
clear
echo
echo '###############################################################################'
echo ' !! Ready To Rock !! | https://luarocks.org'
echo '-------------------------------------------------------------------------------'
echo
echo '> RUN THESE COMMANDS FROM YOUR PROJECT DIRECTORY'
echo
echo '  ./luarocks install <rock_name>'
echo '  ./luarocks remove <rock_name>'
echo
echo '  ./luarocks search <query>'
echo
echo '  ./luarocks list'
echo '  ./luarocks --help'
echo
echo '###############################################################################'
echo

###############################################################################
## Fin
###############################################################################
exit 0
