#!/bin/bash

# Setup Environment
TEST_ENV=/home/asis/progs/io
SIZE=5 # in Gb
echo "*** Environment Setup ***"
echo
echo "Creating Test directory \"${TEST_ENV}\""
mkdir -p ${TEST_ENV}

FS_SIZE=$(expr $SIZE + 1)

SIZE=$(expr $SIZE \* 1024)
echo "Creating Test file \"${TEST_ENV}/test of ${SIZE}Gb\""
dd bs=1M count=${SIZE} if=/dev/zero of=${TEST_ENV}/test conv=fdatasync

mkdir -p ${TEST_ENV}/tmpdisk
mkdir -p ${TEST_ENV}/ramdisk

FS_SIZE=$(expr $SIZE \* 1024)
mount -t tmpfs -o size=${FS_SIZE}m tmpfs ${TEST_ENV}/tmpdisk
mount -t ramfs -o size=${FS_SIZE}m ramfs ${TEST_ENV}/ramdisk

#Verify
echo "tmpfs and ramfs are mounted."
mount | grep -E "tmp|ram" | grep ${TEST_ENV}

echo "Copying test file to ${TEST_ENV}/tmpdisk/ ..."
dd if=${TEST_ENV}/test of=${TEST_ENV}/tmpdisk/test
echo "Copying test file to ${TEST_ENV}/ramdisk/ ..."
dd if=${TEST_ENV}/test of=${TEST_ENV}/ramdisk/test

#-------------------------------------------------------------------------------
# Test
echo
echo "*** Running Test ***"
echo
echo "Clearing cache..."
sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'
free -h
echo "Test: After clearing cache"
dd if=${TEST_ENV}/test of=/dev/null
#dd if=${TEST_ENV}/test of=/dev/null conv=fdatasync
#dd if=${TEST_ENV}/test of=/dev/null bs=8k
echo "Cache warmed up!"
free -h
echo "Test: After cache warmed"
dd if=${TEST_ENV}/test of=/dev/null
#dd if=${TEST_ENV}/test of=/dev/null conv=fdatasync
#dd if=${TEST_ENV}/test of=/dev/null bs=8k

echo "Clearing cache..."
sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'
free -h
echo "Test: tmpfs"
dd if=${TEST_ENV}/tmpdisk/test of=/dev/null
#dd if=${TEST_ENV}/tmpdisk/test of=/dev/null conv=fdatasync
#dd if=${TEST_ENV}/tmpdisk/test of=/dev/null bs=8k

echo "Clearing cache..."
sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'
free -h
echo "Test: ramfs"
dd if=${TEST_ENV}/ramdisk/test of=/dev/null
#dd if=${TEST_ENV}/ramdisk/test of=/dev/null conv=fdatasync
#dd if=${TEST_ENV}/ramdisk/test of=/dev/null bs=8k

#-------------------------------------------------------------------------------
# Cleaning
echo
echo "Cleaning environment..."
rm ${TEST_ENV}/test
rm ${TEST_ENV}/tmpdisk/test
rm ${TEST_ENV}/ramdisk/test

umount ${TEST_ENV}/tmpdisk
umount ${TEST_ENV}/ramdisk

#Verify
mount | grep -E "tmp|ram" | grep ${TEST_ENV}

rmdir ${TEST_ENV}/tmpdisk ${TEST_ENV}/ramdisk
echo "*** DONE ***"
