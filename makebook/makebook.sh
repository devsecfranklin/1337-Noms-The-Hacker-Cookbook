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
SRC_DIR=${PWD}

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

function check_installed() {
 
  PACKAGE=$1

  if [ $(dpkg-query -W -f='${Status}' ${PACKAGE} 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
    echo -e "${LPURP}Installing package: ${PACKAGE}"
    echo -e "${NC}"
    sudo apt-get -y install ${PACKAGE}
  else
    echo -e "${LPURP}Found package: ${PACKAGE}"
    echo -e "${NC}"
  fi
 
  return 0
} # //check_installed 

#############################
# Do stuff for Debian based #
#############################
function debian {

  THEMES_DIR="${BUILD_DIR}/local/lib/python2.7/site-packages/markdown2pdf/themes"

  # Python3
  check_installed python3-venv 
  check_installed python3-dev
  
  #/usr/bin/python3 -m venv ${BUILD_DIR}
  if [ ! -f "./makebook.py" ] 
  then
    /usr/bin/python3 "${SRC_DIR}"/makebook/makebook.py 
  else 
    /usr/bin/python3 makebook.py
  fi

  if [ -f "${BUILD_DIR}/output.md" ]
  then
    echo -e "${LGREEN}"
    echo "Successfully generated Markdown file"
    echo -e "${NC}"
  else
    echo -e "${YELLOW}"
    echo "Cannot find output.md, check makebook.py"
    echo -e "${NC}"
    exit 1
  fi
  
  /usr/bin/python3 -m virtualenv ${BUILD_DIR}
  # shellcheck source=/tmp/cookbook
  . /tmp/cookbook/bin/activate
  # https://pypi.python.org/pypi/Markdown2PDF/0.1.3
  if [ -f "${SRC_DIR}/makebook/requirements.txt" ]
  then
    pip3 install -r "${SRC_DIR}"/makebook/requirements.txt
  elif [ -f "${SRC_DIR}/requirements.txt" ]
  then
    pip3 install -r "${SRC_DIR}"/requirements.txt
  else
    echo "Could not find requirements.txt"
    exit 1
  fi

  check_installed libffi-dev

  if [ -f "${BUILD_DIR}/output.md" ] 
  then 
    echo -e "${LPURP}"
    echo "Building PDF..."
    echo -e "${NC}"
    #md2pdf ${BUILD_DIR}/output.md
    PYV=$(python -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";)
    mkdir -p "${BUILD_DIR}"/lib/python"$PYV"/site-packages/markdown2pdf/themes
    # what is this stupid missing parens
    find /tmp/cookbook/lib/python3.5/site-packages/markdown2pdf/ -type f -exec sed -i 's/print css_file/print (css_file)/g' {} \;
    cp "${SRC_DIR}"/makebook/frank.css "${BUILD_DIR}"/lib/python"$PYV"/site-packages/markdown2pdf/themes
    "${BUILD_DIR}"/bin/md2pdf "${BUILD_DIR}"/output.md --theme frank
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
  deactivate 
  return 0

} # //debian()

#######################
# Do stuff for RedHat #
#######################
function redhat {

  return 0
}

########################
# Do stuff for FreeBSD #
########################

########################
# Do stuff for OpenBSD #
########################
function obsd {

  return 0
}

######################
# Do Stuff for Apple #
######################
function apple {
  brew install cairo pango gdk-pixbuf libxml2 libxslt libffi
  return 0
}

function main {

  cat <<'EOF'

    _                _                             _    _                 _    
   | |__   __ _  ___| | _____ _ __  ___ ___   ___ | | _| |__   ___   ___ | | __
   | '_ \ / _` |/ __| |/ / _ | '__ / __/ _ \ / _ \| |/ | '_ \ / _ \ / _ \| |/ /
   | | | | (_| | (__|   |  __| |  | (_| (_) | (_) |   <| |_) | (_) | (_) |   < 
   |_| |_|\__,_|\___|_|\_\___|_|   \___\___/ \___/|_|\_|_.__/ \___/ \___/|_|\_\
	                                                                               
EOF

  if [ "$(uname)" == "Darwin" ]; then
    #apple
    echo -e "${YELLOW}"
    echo "Not set up yet, try running on Debian."
    echo -e "${NC}"
  elif [ "$(uname)" == "OpenBSD" ]; then
    #obsd
    echo -e "${YELLOW}"
    echo "Not set up yet, try running on Debian."
    echo -e "${NC}"
  elif [ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]; then
    #redhat
    echo -e "${YELLOW}"
    echo "Not set up yet, try running on Debian."
    echo -e "${NC}"
  elif [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
    debian
  else
    echo "Unable to run on this architecture"
    exit 1
  fi

} # //main()

if [ -z "$ARGS" ] ; then
  main $@
else
  main $ARGS
fi
