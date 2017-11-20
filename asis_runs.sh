#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
source ~/tf-v1.4.0/bin/activate


vars=(
#nodistortions
num_batches="1100"
num_gpus="1 2 4"
model="resnet50"
batch_size="64"
local_parameter_device="gpu"
variable_update="replicated"
#use_fp16=True
#fp16_loss_scale=1
dataset="imagenet:/path-to-TFR/ImageNet synthetic"

)

#nvprof="/usr/local/cuda/bin/nvprof -o"
if [ "$nvprof" != "" ] ; then
  nv_extra="--num_warmup_batches=1 --display_every=1"
fi

iters=3
results_dir="results"
mkdir -p $results_dir

ext=$(date +%d%b%Y_%H%M%S)
base="x86"

cmds="python tf_cnn_benchmarks.py"

for elm in "${vars[@]}" ; do
  option=$(echo $elm | cut -d'=' -f 1)
  value=$(echo $elm | cut -d'=' -f 2)
  if [ "${value}" == "${option}" ] ; then
    cmds=$(echo "${cmds}" | sed "s/$/ --"${option}"/g")
  else
    tmpcmds="${cmds}"
    cmds=""
    for val in ${value} ; do
      val=$(echo $val | sed 's/\//\\\//g')
      if [ "$option" == "dataset" ] ; then
        for v in $val ; do
          if [ "$v" == "synthetic" ] ; then
            data_name="synthetic"
            cmds="${tmpcmds}\n"
          else
            data_name=$(echo $v | cut -d':' -f 1)
            data_dir=$(echo $v | cut -d':' -f 2)
            tcmds=$(echo "${tmpcmds}" | sed "s/$/ --data_name="${data_name}" --data_dir="${data_dir}"/g")
             cmds="${cmds}$tcmds\n"
          fi
        done
      else
        tcmds=$(echo "${tmpcmds}" | sed "s/$/ --"${option}"="${val}"/g")
        cmds="${cmds}$tcmds\n"
      fi
    done
  fi
  cmds=$(echo -e "$cmds" )
  l=$(echo "$cmds" | wc -l)
  cmds=$(echo "$cmds" | head -$l)
done

cmds=$(echo "$cmds" | sed 's/ /:/g')

for cmd in $cmds ; do
  cmd=$(echo $cmd | tr ':' ' ')
  logfile=$(echo "$cmd" | tr '_' '-' | tr ' ' '_' | sed 's/--//g' | sed 's/python_tf-cnn-benchmarks.py_//g' | tr '=' '-')
  if echo $logfile | grep data-dir > /dev/null 2>&1 ; then
    logfile=$(echo $logfile | sed 's/_data-dir-[^_$][^_$]*//g')
  else
    logfile="${logfile}_data-name-synthetic"
  fi
  iter=0
  while [ $iter -lt $iters ] ; do
    log="${results_dir}/${base}_${logfile}_${ext}_${iter}"
    _cmd=$cmd
    if [ "$nvprof" != "" ] ; then
      _cmd="${nvprof} ${log}.nvvp ${cmd} ${extra_nv}"
    fi
    log="${log}.log"
    echo "$log"
    #echo $_cmd
    #echo
    echo $_cmd >> ${log} 2>&1
    eval $_cmd >> ${log} 2>&1

    iter=$(expr $iter + 1)
  done
done
