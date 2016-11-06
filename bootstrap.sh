#!/usr/bin/env bash

export CONDA_ROOT=/opt/conda
export DEXPY_ENV_NAME=dexpy_env
export DEXPY_ENV_ROOT=$CONDA_ROOT/envs/$DEXPY_ENV_NAME
export DEXPY_DEPENDENCIES="numpy scipy pandas patsy statsmodels matplotlib seaborn bokeh"
export PATH=$DEXPY_ENV_ROOT/bin:$CONDA_ROOT/bin:$PATH

# install apt packages first
sudo apt-get update
sudo apt-get install -y graphviz

# setup conda python3 environment for jupyter
if [[ ! -d ${CONDA_ROOT} ]]; then
    echo "Installing Miniconda..."
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.16.0-Linux-x86_64.sh
    bash Miniconda3-3.16.0-Linux-x86_64.sh -bf -p ${CONDA_ROOT}
fi

if [ ! -d ${DEXPY_ENV_ROOT} ]; then
    conda create -y -n ${DEXPY_ENV_NAME} python=3.4 ${DEXPY_DEPENDENCIES}
else
    conda install -y -n ${DEXPY_ENV_NAME} ${DEXPY_DEPENDENCIES}
fi

# use rise for interactive jupyter-based slides
conda install -y -n ${DEXPY_ENV_NAME} -c damianavila82 rise

source activate dexpy_env

# install prettypandas for nice tables
pip install prettypandas

# install python bindings for graphviz
pip install graphviz

# this eliminates a seaborn warning about importing from IPython
# see: https://github.com/mwaskom/seaborn/issues/874
pip install ipywidgets

# install latest development version of dexpy
git clone https://github.com/statease/dexpy.git
cd dexpy
python setup.py install

mkdir -p /vagrant/notebook

git config --global user.name "Hank Anderson"
git config --global user.email "hank.p.anderson@gmail.com"
