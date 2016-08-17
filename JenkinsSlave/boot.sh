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
 git config --global user.name "flamingice"
 git config --global user.email "flamingice@users.noreply.github.com"
# ./make_all.sh curl
 NACL_ARCH=pnacl make curl


# Download Android NDK 
cd /home/autobuild && wget http://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip -O android-ndk.zip
cd /home/autobuild && unzip android-ndk.zip
cd /home/autobuild && rm -f android-ndk.zip
cd /home/autobuild && mv android-ndk-r12b ndk
cd /home/autobuild && ls -al

# Additional steps
cd /home/autobuild/ndk && build/tools/make-standalone-toolchain.sh --toolchain=arm-linux-androideabi-4.9 --platform=android-21 --install-dir=/home/autobuild/ndkTC 
cd /home/autobuild && ls -al && rm -rf SuperNET
cd /home/autobuild && git clone https://github.com/jl777/SuperNET.git
cd /home/autobuild && cp -a SuperNET/OSlibs/android/lib/lib* ndkTC/sysroot/usr/lib/
cd /home/autobuild && cp -av SuperNET/OSlibs/android/include/openssl ndkTC/sysroot/usr/include/
cd /home/autobuild && cp -av SuperNET/OSlibs/android/include/curl ndkTC/sysroot/usr/include/
cd /home/autobuild && rm -rf SuperNET
