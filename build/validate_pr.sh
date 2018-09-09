#!/bin/bash - 
#===============================================================================
#
#          FILE: validate_pr.sh
# 
#         USAGE: ./validate_pr.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 09/09/2018 18:33
#      REVISION:  ---
#===============================================================================

#set -o nounset    # Treat unset variables as an error

# collet new markdown filenames
NEW_MD=$(git diff --name-only $TRAVIS_COMMIT_RANGE | grep *.md)

# install ruby
echo "Install Ruby"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io -o rvm.sh
cat rvm.sh | bash -s stable
source ~/.rvm/scripts/rvm
rvm install ruby --default

# install markdown lint https://github.com/markdownlint/markdownlint
gem install mdl

# run markdown lint on new markdown files
MDL_RESULTS=$(mdl ${NEW_MD})

curl -i -H "Authorization: token $GITHUB_TOKEN" \
        -H "Content-Type: application/json" \
        -X POST -d "\{body\":\"$MDL_RESULTS\"}" \
        https://api.github.com/repos/DEAD10C5/1337-Noms-The-Hacker-Cookbook
/issues/$TRAVIS_PULL_REQUEST/comments


# run mdcheckr on new markdown files
MD_CHK_RES=$(/usr/local/bin/mdcheckr ${NEW_MD})

curl -i -H "Authorization: token $GITHUB_TOKEN" \
	-H "Content-Type: application/json" \
	-X POST -d "\{body\":\"$MD_CHK_RES\"}" \
	https://api.github.com/repos/DEAD10C5/1337-Noms-The-Hacker-Cookbook
/issues/$TRAVIS_PULL_REQUEST/comments
