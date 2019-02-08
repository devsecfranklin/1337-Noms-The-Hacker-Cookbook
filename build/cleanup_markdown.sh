#!/bin/bash - 
#===============================================================================
#
#          FILE: cleanup_markdown.sh
# 
#         USAGE: ./cleanup_markdown.sh 
# 
#   DESCRIPTION: 
# 
#  _                _                             _    _                 _    
# | |__   __ _  ___| | _____ _ __  ___ ___   ___ | | _| |__   ___   ___ | | __
# | '_ \ / _` |/ __| |/ / _ | '__ / __/ _ \ / _ \| |/ | '_ \ / _ \ / _ \| |/ /
# | | | | (_| | (__|   |  __| |  | (_| (_) | (_) |   <| |_) | (_) | (_) |   < 
# |_| |_|\__,_|\___|_|\_\___|_|   \___\___/ \___/|_|\_|_.__/ \___/ \___/|_|\_\
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (@theDevilsVoice), 
#  ORGANIZATION: 
#       CREATED: 02/07/2019 19:39
#      REVISION:  ---
#===============================================================================
set -o nounset                              # Treat unset variables as an error

# MD009 Trailing spaces
function md009 {
  find .. -name '*.md'|while read fname; do
    #echo "$fname"
    #echo "Check for trailing whitespace in ${fname}"
    sed -i 's/[ \t]*$//' "$fname"
  done
}

function md032 {
  find .. -name '*.md'|while read fname; do
    #echo "Check for headers in ${fname}"
    NEXT_LINE=$(sed -n -e '/^#/{n;p;}' "$fname")
    if [ ! -z "$NEXT_LINE" ]; 
    then
      sed -i '/^#/{G;}' "$fname"
    fi
  done
}

function main {

  md009
  md032

}

main $@
