#!/bin/bash
#
# Author: @theDevilsVoice
#
# Date: 10/13/2017
#
# Script Name: makebook.sh
#
# Description: Use this shell script to ensure your system
#              is ready for the class.
#
# Run Information:
#
# Error Log: Any output found in /path/to/logfile

BUILD_DIR=/tmp/cookbook
if [ -f "/.dockerenv" ]; then
  SRC_DIR="/app"
else 
  SRC_DIR=${PWD}
fi

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
CYAN='\033[0;36m'
LPURP='\033[1;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


function main {

  cat <<'EOF'

    _                _                             _    _                 _    
   | |__   __ _  ___| | _____ _ __  ___ ___   ___ | | _| |__   ___   ___ | | __
   | '_ \ / _` |/ __| |/ / _ | '__ / __/ _ \ / _ \| |/ | '_ \ / _ \ / _ \| |/ /
   | | | | (_| | (__|   |  __| |  | (_| (_) | (_) |   <| |_) | (_) | (_) |   < 
   |_| |_|\__,_|\___|_|\_\___|_|   \___\___/ \___/|_|\_|_.__/ \___/ \___/|_|\_\
	                                                                               
EOF

  if [ -f "${BUILD_DIR}/output.md" ]
  then
    echo -e "${LPURP}"
    echo "Building PDF..."
    echo -e "${NC}"
    #md2pdf ${BUILD_DIR}/output.md
    # what version of python is this
    PYV=$(python -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";)
    mkdir -p /usr/local/lib/python${PYV}/site-packages/markdown2pdf/themes
    # what is this stupid missing parens
    find /usr/local/lib/python${PYV}/site-packages/markdown2pdf/__init__.py -type f -exec sed -i 's/print css_file/print (css_file)/g' {} \;
    cp ${SRC_DIR}/makebook/frank.css /usr/local/lib/python${PYV}/site-packages/markdown2pdf/themes/
    /usr/local/bin/md2pdf ${BUILD_DIR}/output.md --theme frank
    #md2pdf ${BUILD_DIR}/output.md --theme ${BASE_DIR}/style.css
    #md2pdf output.md --theme=path_to_style.css
  else
    echo -e "${YELLOW}" 
    echo "Cannot find output.md, check makebook.py"  
    echo -e "${NC}"
    exit 1
  fi

  if [ -f "${BUILD_DIR}/output.pdf" ]
  then
    cp ${BUILD_DIR}/output.pdf ${SRC_DIR}/hacker_cookbook.pdf
    echo -e "${LGREEN}"
    echo "Success!"
    echo -e "${NC}"
  else
    echo -e "${YELLOW}"
    echo "Could not find ${BUILD_DIR}/output.pdf"
    echo -e "${NC}"
    exit 1
  fi

} # //main()

if [ -z "$ARGS" ] ; then
  main $@
else
  main $ARGS
fi
