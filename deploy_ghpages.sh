#!/bin/bash

export CONDA_ROOT=/opt/conda
export DEXPY_ENV_NAME=dexpy_env
export DEXPY_ENV_ROOT=$CONDA_ROOT/envs/$DEXPY_ENV_NAME
export PATH=$DEXPY_ENV_ROOT/bin:$CONDA_ROOT/bin:$PATH

source activate $DEXPY_ENV_NAME
jupyter nbconvert --to slides dexpy-demo.ipynb --reveal-prefix=reveal.js

# save off files we need for gh-pages
mkdir -p /tmp/workspace
cp dexpy-demo.slides.html /tmp/workspace/index.html
cp reveal.js /tmp/workspace

# switch to gh-pages and remove everything
git checkout -fB gh-pages
git rm -rf .
git checkout master .gitignore
git reset HEAD

cp -r /tmp/workspace/* .

# add and commit
touch .nojekyll
git add -A
git rm .gitignore -f
git commit -m "Generated gh-pages for $(git log master -1 --pretty=short --abbrev-commit)"
git push --force --quiet origin gh-pages

# switch back to master
git checkout master
rm -rf /tmp/workspace
