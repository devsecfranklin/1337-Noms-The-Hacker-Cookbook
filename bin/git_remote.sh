#!/bin/bash

# devsecfranklin@duck.com
# Dec 28, 2022

# add the user as a git remote
git remote add ${1} git@github.com:${1}/1337-Noms-The-Hacker-Cookbook.git
# get their operable branches
git fetch ${1}
# list the branches out
git branch -v -a | grep ${1}
# checkout a branch to work on
git checkout --track ${1}/$2}


# If you want to create a new branch to retain commits you create, you may
# do so (now or later) by using -c with the switch command. Example:
# git switch -c <new-branch-name>
git switch -c dev-${2}

# Or undo this operation with:
# git switch -

