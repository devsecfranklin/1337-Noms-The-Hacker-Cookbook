#!/bin/bash - 
#===============================================================================
#
#          FILE: get_version.sh
# 
#         USAGE: ./get_version.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/25/2019 10:53
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#{ "addon_plan_names":[], "app":{ "id":"d4921f22-5510-45b3-a3e6-08a142dec22b", "name":"hacker-cookbook" }, "created_at":"2019-03-23T19:05:11Z", "description":"Initial release", "status":"succeeded", "id":"17e9bc9a-1d27-45ba-baac-10ce080e0906", "slug":null, "updated_at":"2019-03-23T19:05:11Z", "user":{ "email":"frank378@gmail.com", "id":"752aa062-0012-44db-9145-43a6c3511cce" }, "version":1, "current":false, "output_stream_url":null },

VERSION_DATA=$(curl -s -n https://api.heroku.com/apps/hacker-cookbook/releases/ \
	            -H "Accept: application/vnd.heroku+json; version=3" | jq -r 'addon_plan_names.version')

for item in ${VERSION_DATA}
do
  echo ${item}
done
