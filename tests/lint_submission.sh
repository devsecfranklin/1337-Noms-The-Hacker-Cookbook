#!/bin/bash - 
#===============================================================================
#
#          FILE: lint_submission.sh
# 
#         USAGE: ./lint_submission.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 02/10/2019 08:42
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error



function usage { 
  echo "Usage: $0 [-b <branchname>] [-u <githubusername>]" 
  exit 1 
}

function main {

  while getopts "b:u:" arg; do
    case "${arg}" in
      b)
        b=${OPTARG}
        ;;
      u)
        u=$OPTARG
        ;;
      *)
        usage
        ;; 
    esac
  done
  shift $((OPTIND-1))

  if [ -z "${b}" ] || [ -z "${u}" ]; then
    usage
  fi
 
  checkout 
  cleanup_markdown
  checkin
  
}

function checkout {

  # creds
  git fetch git@github.com:${u}/1337-Noms-The-Hacker-Cookbook.git ${b}:${b}_test
  git checkout ${b}_test
  git remote add my_${b} git@github.com:Nocsetse/1337-Noms-The-Hacker-Cookbook.git
  # find new files
  git rebase master
  MY_LIST=$(git diff --stat origin/master -- | grep ".md" | cut -f1 -d"|" | cut -f2 -d"/")
  while read -r line; do
      echo "Found new Markdown file: $line"
  done <<< "$MY_LINE"

}

function checkin {

  #git push git@github.com:${u}/1337-Noms-The-Hacker-Cookbook.git HEAD:${b}
  git remote rm my_${b}
  git branch -D ${b}_test

}

function cleanup_markdown {

  md009
  md032

}

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

main "$@"
