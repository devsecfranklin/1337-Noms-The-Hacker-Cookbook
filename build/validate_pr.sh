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
#        AUTHOR: @theDevilsVoice, 
#  ORGANIZATION: DEAD10C5 
#       CREATED: 09/09/2018 18:33
#      REVISION:  ---
#===============================================================================

#set -o nounset    # Treat unset variables as an error

# collet new markdown filenames
NEW_MD=$(git diff --name-only $TRAVIS_COMMIT_RANGE | grep -rlI --include=\*.md .)

# install ruby
echo "Install Ruby"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io -o rvm.sh
cat rvm.sh | bash -s stable
source ~/.rvm/scripts/rvm
rvm install ruby --default

# install markdown lint https://github.com/markdownlint/markdownlint
echo "Installing ruby gems..."
gem install mdl travis travis-lint
echo "Finished installing ruby gems."

# run markdown lint on new markdown files
echo "Run markdown lint on new .md files: ${NEW_MD}"
MDL_RESULTS=$(mdl ${NEW_MD})
MDL_JSON=`echo -e "{\"body\":\""[RECIPE BOT]\n$MDL_RESULTS"\"}"`
echo "Here are your results:"
echo "${MDL_JSON}"

curl -i -H "Authorization: token ${GH_TOKEN}" \
        -H "Content-Type: application/json" \
        -X POST -d "${MDL_JSON}" \
        https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments


# run mdcheckr on new markdown files
echo "Run mdcheckr on new markdown files"
MD_CHK_RES=$(/usr/local/bin/mdcheckr ${NEW_MD})
MD_JSON=`echo -e "{\"body\":\""[RECIPE BOT]\n$MD_CHECK_RES"\"}"`

curl -i -H "Authorization: token ${GH_TOKEN}" \
	-H "Content-Type: application/json" \
	-X POST -d "${MD_JSON}" \
	https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments