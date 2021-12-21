debs=(
http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/./nvidia-dkms-455_455.45.01-0ubuntu1_amd64.deb
https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64/./xserver-xorg-video-nvidia-455_455.45.01-0ubuntu1_amd64.deb
https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64/./nvidia-driver-455_455.45.01-0ubuntu1_amd64.deb 
https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64/./libnvidia-encode-455_455.45.01-0ubuntu1_amd64.deb
http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/./libnvidia-decode-455_455.45.01-0ubuntu1_amd64.deb
https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64/./libnvidia-extra-455_455.45.01-0ubuntu1_amd64.deb
https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64/./libnvidia-fbc1-455_455.45.01-0ubuntu1_amd64.deb
http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/./libnvidia-gl-455_455.45.01-0ubuntu1_amd64.deb
https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64/./libnvidia-ifr1-455_455.45.01-0ubuntu1_amd64.deb
http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/./nvidia-kernel-common-455_455.45.01-0ubuntu1_amd64.deb
https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64/./libxnvctrl0_460.27.04-0ubuntu1_amd64.deb
https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64/./nvidia-compute-utils-455_455.45.01-0ubuntu1_amd64.deb
https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64/./nvidia-utils-455_455.45.01-0ubuntu1_amd64.deb)

for deb in ${debs[@]}; do
    wget $deb
done
