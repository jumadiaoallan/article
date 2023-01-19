#!/bin/sh

# check values
if [ -z "${GITHUB_TOKEN}" ]; then
    echo "error: not found GITHUB_TOKEN"
    exit 1
fi

if [ -z "${BRANCH_NAME}" ]; then
   export BRANCH_NAME=main
fi

# initialize git
remote_repo="git@github.com:jumadiaoallan/article.git"
git config http.sslVerify false
git config user.name "Allan Jumadiao"
git config user.email "allanjumadiao.yns@gmail.com"
git remote add publisher "${remote_repo}"
git show-ref # useful for debugging
git branch --verbose

# install lfs hooks
git lfs install

# publish any new files
git checkout ${BRANCH_NAME}
git add -A
timestamp=$(date -u)
git commit -m "Automated publish" || exit 0
git pull origin ${BRANCH_NAME}
git push origin ${BRANCH_NAME}