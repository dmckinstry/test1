#! /bin/bash

if [ -z $GITBUCKET_SERVER ]; then GITBUCKET_SERVER="http://localhost:8080"; fi
if [ -z $GITBUCKET_OWNER ]; then GITBUCKET_OWNER="root"; fi
if [ -z $GITBUCKET_REPO ]; then GITBUCKET_REPO="test1"; fi
if [ -z $GITHUB_SERVICE ]; then GITHUB_SERVICE="https://github.com"; fi
if [ -z $GITHUB_OWNER ]; then GITHUB_OWNER="dmckinstry"; fi

SOURCE_REPO=$GITBUCKET_SERVER/git/$GITBUCKET_OWNER/$GITBUCKET_REPO.git
DEST_REPO=$GITHUB_SERVICE/$GITHUB_OWNER/$GITBUCKET_REPO.git
echo Migrate $SOURCE_REPO to $DEST_REPO

mkdir tmp
cd tmp

# Create repo...  This will initialize the current folder but we're not going to use it
gh repo create --confirm --private $GITHUB_OWNER/$GITBUCKET_REPO

# Clone the source into a subfolder
git clone --mirror $SOURCE_REPO
cd $GITBUCKET_REPO

# Import it into the new GitHub repo
git remote set-url origin $DEST_REPO
git push --mirror
# TODO: Default on GitHub appears to be the first alphabetically and not the default on the source server

# Clean up
cd ..
rm -rf tmp
