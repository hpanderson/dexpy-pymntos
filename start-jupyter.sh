export CONDA_ROOT=/opt/conda
export DEXPY_ENV_NAME=dexpy_env
export DEXPY_ENV_ROOT=$CONDA_ROOT/envs/$DEXPY_ENV_NAME
export PATH=$DEXPY_ENV_ROOT/bin:$CONDA_ROOT/bin:$PATH
source activate $DEXPY_ENV_NAME
ln -s /vagrant/dexpy-pymntos/dexpy-demo.ipynb /vagrant/notebook/dexpy-demo.ipynb
cp /vagrant/dexpy-pymntos/img/* /vagrant/notebook/img
jupyter notebook --notebook-dir=/vagrant/notebook --no-browser --ip=0.0.0.0 &
