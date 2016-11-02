#!/bin/bash

export CONDA_ROOT=/opt/conda
export DEXPY_ENV_NAME=dexpy_env
export DEXPY_ENV_ROOT=$CONDA_ROOT/envs/$DEXPY_ENV_NAME
export PATH=$DEXPY_ENV_ROOT/bin:$CONDA_ROOT/bin:$PATH

source activate $DEXPY_ENV_NAME
jupyter nbconvert --to slides dexpy-demo.ipynb --reveal-prefix=reveal.js

# save off files we need for gh-pages
mkdir -p /tmp/workspace
mv dexpy-demo.slides.html /tmp/workspace/index.html
cp -r reveal.js /tmp/workspace

# create a folder for gh-pages branch
mkdir -p /tmp/gh-pages
cp -r .git /tmp/gh-pages

# switch to gh-pages and remove everything
cd /tmp/gh-pages
# could delete the gh-pages branch here, if we wanted to keep it at 1 commit
# not sure if there's an advantage to having a history for it
git checkout -fB gh-pages
git rm -rf .
git checkout master .gitignore
git reset HEAD

# add and commit
cp -r /tmp/workspace/* .
touch .nojekyll
git add -A
git rm .gitignore -f
git commit -m "Generated gh-pages for $(git log master -1 --pretty=short --abbrev-commit)"
git push --force --quiet origin gh-pages

# clean up
rm -rf /tmp/workspace
rm -rf /tmp/gh-pages
