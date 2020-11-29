#! /bin/bash

if [ -z $GITBUCKET_SERVER ]; then GITBUCKET_SERVER="http://localhost:8080"; fi
if [ -z $GITBUCKET_OWNER ]; then GITBUCKET_OWNER="root"; fi
if [ -z $GITBUCKET_REPO ]; then GITBUCKET_REPO="test1"; fi
if [ -z $GITHUB_SERVICE ]; then GITHUB_SERVICE="https://github.com"; fi
if [ -z $GITHUB_OWNER ]; then GITHUB_OWNER="dmckinstry"; fi


md tmp
cd tmp
SOURCE_REPO=$GITBUCKET_SERVER+"/git/"+$GITBUCKET_OWNER+"/"$GITBUCKET_REPO+".git"
git clone $SOURCE_REPO
cd $GITBUCKET_REPO

gh repo create --private $GITHUB_OWNER+"/"+$GITBUCKET_REPO
git status
git remote set-url origin $GITHUB_SERVICE+"/"+$GITHUB_OWNER+"/"+$GITBUCKET_REPO+".git"
git push

#cd ../..
#rm -rf tmp