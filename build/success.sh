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

if [ "$TRAVIS_PULL_REQUEST" != "false" ] ; then
   # hey that's a pull request
   curl -H "Authorization: token ${GH_TOKEN}" -X POST \
	   -d "{\"body\": \"PR looks good. An admin will merge soon.\"}" \
	   "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/issues/${TRAVIS_PULL_REQUEST}/comments"
fi


