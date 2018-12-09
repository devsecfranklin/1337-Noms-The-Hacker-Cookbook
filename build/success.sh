#!/bin/bash - 
#===============================================================================
#
#          FILE: success.sh
# 
#         USAGE: ./success.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 09/09/2018 20:09
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

if [ $TRAVIS_TEST_RESULT -eq 0 ]
then
  MY_JSON=`echo -e "{\"body\":\""[RECIPE BOT] Markdown scan successful."\"}"`
  curl -H "Authorization: token ${GH_TOKEN}" -X POST \
	 -d "${MY_JSON}" \
	 "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"
else 
	  MY_JSON=`echo -e "{\"body\":\""[RECIPE BOT] Markdown scan FAIL"\"}"`
	  curl -H "Authorization: token ${GH_TOKEN}" -X POST \
		 -d "${MY_JSON}" \
		 "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"
fi