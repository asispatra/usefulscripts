#!/bin/bash

cmds=(
"hostname ; hostname -s ; hostname -d ; hostname -i ; hostname -a"
"if ! cat /etc/lsb-release 2>/dev/null ; then cat /etc/redhat-release ; fi"
"uname -a"
"uname -r"
"/usr/local/cuda/bin/nvcc --version"
"cat /proc/driver/nvidia/version"
"find /usr -name \"libcudnn*\""
"lscpu"
"cpupower frequency-info 2>/dev/null"
"lspci"
"lspci -v"
"lspci -vv"
"lspci -tv"
"numactl -H"
"free -h"
"nvidia-smi"
"nvidia-smi topo -m"
"nvidia-smi -q"
"cd /usr/local/cuda/samples/1_Utilities ; for dir in \$(ls) ; do cd \$dir ; make clean ; make ; for i in {1..3} ; do echo \"######## \$dir Test \$i\" ; ./\$dir ; done ; cd .. ;  done"
)

hline=$(printf '%80s\n' | tr ' ' '#')

for cmd in "${cmds[@]}" ; do
  echo $hline
  echo "# $cmd"
  eval $cmd
done
echo $hline
