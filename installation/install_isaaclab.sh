#!/bin/bash

# refer: https://isaac-sim.github.io/IsaacLab/v2.0.2/source/setup/installation/pip_installation.html

#1) install isaacsim4.5
echo "1) enable conda and create virtual env named: env_isaaclab ..."
source ~/miniconda3/bin/activate
if [ $(conda env list | grep "env_isaaclab" | awk '{print($1)}') == "env_isaaclab" ]; then
	echo "existing env_isaaclab"
else
	conda create -n env_isaaclab python=3.10
fi

echo "2) activate env_isaaclab..."
conda activate env_isaaclab
#echo "3) installing torch (this is optional for linux) ..."
#pip install torch==2.5.1 --index-url https://download.pytorch.org/whl/cu118
echo "4) upgrade pip ..."
pip install --upgrade pip
# switch to use bash instead of zsh
bash && source ~/miniconda3/bin/activate && conda activate env_isaaclab
echo "5) installing issacsim..."
pip install isaacsim[all,extscache]==4.5.0 --extra-index-url https://pypi.nvidia.com
source ~/miniconda3/bin/activate && conda activate env_isaaclab

# veriyf isaacsim
echo "6) verifying isaacsim ..."
isaacsim



#2) install isaaclab2.0

echo "7) mkdir workspace and clone IsaacLab ..."
mkdir -p  ~/workspace && cd ~/workspace
git clone git@github.com:isaac-sim/IsaacLab.git

echo "8) install cmake and build-essential ..."
sudo apt-get update
sudo apt install cmake build-essential
#source ~/miniconda3/bin/activate && conda activate env_isaaclab

echo "9) Install Isaaclab  ..."
cd IsaacLab && git checkout 2.0.2 && ./isaaclab.sh -i


#3) install other rl framework, such as st_rl, rsl_rl, skrl, 


#4) issues:
    #i) ModuleNotFoundError: No module named 'omni.isaac.lab'
        # solution: there are some old api package, it should be repalced by 'isaaclab'
    #ii) NUCLEUS asset, loading issue: 
        # soultion: cd IssacLab && vim source/isaaclab/isaaclab/utils/assets.py, 
        # change this NUCLEUS_ASSET_ROOT_DIR = carb.settings.get_settings().get("/persistent/isaac/asset_root/cloud")
        # to be NUCLEUS_ASSET_ROOT_DIR = "omniverse://localhost/NVIDIA/Assets/Isaac/4.5" if you install local nucleus 
        # or your other asset address: 

    #iii) For 50 series GPUs, please use the latest PyTorch nightly build instead of PyTorch 2.5.1, which comes with Isaac Sim:
        # ./isaaclab.sh -p scripts/tutorials/00_sim/create_empty.py


