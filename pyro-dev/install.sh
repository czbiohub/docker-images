#!/usr/bin/env bash
set -xe

pip install --upgrade pip

# 2. Install Pyro
# Use pypi wheel if pyro_branch = 'release'.
# Else, install from source, using git branch `pyro_branch`
if [ ${pyro_branch} = "release" ]
then
    pip install --upgrade networkx tqdm opt_einsum graphviz
    pip install pyro-ppl --no-deps
else
    git clone https://github.com/uber/pyro.git
    (cd pyro && git checkout ${pyro_branch} && pip install .[dev])
fi


# install jupyterlab, umap, altair
conda install -y jupyterlab scikit-learn scipy numpy numba
conda install -y altair -c conda-forge
pip install umap-learn

cd ${HOME}
git clone https://github.com/czbiohub/simscity.git
cd simscity && python setup.py install && cd -
