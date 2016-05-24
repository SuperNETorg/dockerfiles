#!/bin/bash
 cd /home/autobuild/
 wget https://storage.googleapis.com/nativeclient-mirror/nacl/nacl_sdk/nacl_sdk.zip
 unzip nacl_sdk.zip
 cd nacl_sdk
 ./naclsdk update

 export NACL_SDK_ROOT=/home/autobuild/nacl_sdk/pepper_49/
 cd /home/autobuild/
 git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
 export PATH=`pwd`/depot_tools:"$PATH"
 mkdir webports
 cd webports
 gclient config --unmanaged --name=src https://chromium.googlesource.com/webports.git

 gclient sync --with_branch_heads
 cd src
 git checkout -b pepper_49 origin/pepper_49
 gclient sync
 git config --global user.name "Shailesh"
 git config --global user.email "shailesh.patel2009@gmail.com"
# ./make_all.sh curl
 NACL_ARCH=pnacl make curl
