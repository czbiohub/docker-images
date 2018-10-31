#!/usr/bin/env bash
set -xe

pip install --upgrade pip

# 1. Install PyTorch
# Use conda package if pytorch_branch = 'release'.
# Else, install from source, using git branch `pytorch_branch`

if [ ${pytorch_branch} = "release" ]
then
    conda install -y pytorch=0.4.0 torchvision -c pytorch
    if [ ${cuda} = 1 ]; then conda install -y cuda90 -c pytorch; fi
else
    conda install -y numpy pyyaml mkl mkl-include setuptools cmake cffi typing
    if [ ${cuda} = 1 ]; then conda install -y cuda90 -c pytorch; fi
    git clone --recursive https://github.com/pytorch/pytorch.git
    pushd pytorch && git checkout ${pytorch_branch}
    python setup.py install
    popd
fi

# 2. Install Pyro
# Use pypi wheel if pyro_branch = 'release'.
# Else, install from source, using git branch `pyro_branch`
if [ ${pyro_branch} = "release" ]
then
    pip install pyro-ppl
else
    git clone https://github.com/uber/pyro.git
    (cd pyro && git checkout ${pyro_branch} && pip install .[dev])
fi


# install jupyterlab, scVI, umap, scanpy
conda install -y jupyterlab
conda install -y matplotlib scikit-learn numba
conda install -y umap-learn -c conda-forge

git clone https://github.com/czbiohub/simscity.git
cd simscity && python setup.py install && cd -
