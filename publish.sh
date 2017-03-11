#!/bin/sh

DIR=$(dirname "$0")

#cd $DIR/..

if [[ $(git status -s) ]]
then
    echo "dirty dir - commit pending stuff"
    exit 1;
fi

echo "rm -rf public, and do other attendant stuff"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "check out gh-pages"
git worktree add -B gh-pages public origin/gh-pages

echo "removing existing"
rm -rf public/*

echo "generate site"
hugo

echo "updating gh-pages"
cd public && git add --all && git commit -m "publish to gh-pages w/ publish.sh"
git push origin gh-pages
