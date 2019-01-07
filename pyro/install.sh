#!/usr/bin/env bash
set -xe

pip install --upgrade pip

# 2. Install Pyro
pip install --upgrade networkx tqdm opt_einsum graphviz
git clone https://github.com/uber/pyro.git
(cd pyro && git checkout ${pyro_branch} && pip install .[dev] --no-deps)
cd ${HOME}

# install jupyterlab, umap, altair
conda install -y jupyterlab scikit-learn scipy numpy numba
conda install -y altair -c conda-forge
pip install umap-learn

git clone https://github.com/czbiohub/simscity.git
(cd simscity && python setup.py install)
cd ${HOME}

git clone https://github.com/czbiohub/drvish.git
(cd drvish && pip install . --no-deps)
cd ${HOME}
