## NVIDIA driver and CUDA version
```
/usr/local/cuda/bin/nvcc --version

ls -l /usr/local/cuda/lib64/*cudnn*

cat /proc/driver/nvidia/version
```

## GPU utilization
```
# All GPU
nvidia-smi --query-gpu=timestamp,pci.bus_id,index,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free --format=csv -l 1

# GPU 0
nvidia-smi --id=0 --query-gpu=timestamp,pci.bus_id,index,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free --format=csv -l 1
```
