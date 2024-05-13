#!/usr/bin/env bash
#
# SPDX-FileCopyrightText: 2023 DE:AD:10:C5 <thedevilsvoice@dead10c5.org>
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -euo pipefail
#IFS=$'\n\t'

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
LCYAN='\033[1;36m'
LPURP='\033[1;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Some config Variables ----------------------------------------
CATEGORIES=("APPETIZERS" "BREAKFAST" "COOKWARE" "DESSERTS" "DRINKS" "ENTREES" "SAUCES" "SIDES" "SNACKS")
MY_DATE=$(date '+%Y-%m-%d-%H')
RAW_OUTPUT="generate_cookbook_${MY_DATE}.txt" # log file name
TEX_OUTPUT="cookbook/hacker_cookbook.tex"

function path_setup() {
  # path madness
  CURRENT_DIR="${PWD}"
  #echo -e "${LGREEN}Current dir: ${LCYAN}${CURRENT_DIR}${NC}" | tee -a "${RAW_OUTPUT}"
  PROG_DIR="$0"

  SCRIPT_DIR=$(echo $PROG_DIR | sed 's|\(.*\)/.*|\1|')
  #echo -e "${LGREEN}Found script dir: ${LCYAN}${SCRIPT_DIR}${NC}" | tee -a "${RAW_OUTPUT}"
  SUB_DIR=$(echo $SCRIPT_DIR | rev | cut -d'/' -f2- | rev)
  #echo "Sub dir: $SUB_DIR"
  if [ "$SUB_DIR" != "bin" ]; then
    LOGGING_DIR="$CURRENT_DIR/$SUB_DIR/logs"
    DATA_DIR="$CURRENT_DIR/$SUB_DIR/data"
  else
    LOGGING_DIR="$CURRENT_DIR/logs"
    DATA_DIR="$CURRENT_DIR/data"
  fi

  if [ -d "${LOGGING_DIR}" ]; then
    RAW_OUTPUT="${LOGGING_DIR}/${RAW_OUTPUT}"
    echo -e "\n${LCYAN}------------------ Starting Backup Tool ------------------${NC}" | tee -a "${RAW_OUTPUT}"
    echo -e "${LGREEN}Found log dir: ${LCYAN}${LOGGING_DIR}${NC}" | tee -a "${RAW_OUTPUT}"
    echo -e "${LGREEN}Log file path is: ${LCYAN}${RAW_OUTPUT}${NC}" | tee -a "${RAW_OUTPUT}"
    echo -e "${LGREEN}LaTeX file path is: ${LCYAN}${TEX_OUTPUT}${NC}" | tee -a "${RAW_OUTPUT}"
  else
    echo -e "${LRED}Did not find log dir: ${LCYAN}${RAW_OUTPUT}${NC}"
    LOGGING_DIR="."
    RAW_OUTPUT="${LOGGING_DIR}/${RAW_OUTPUT}"                                                                      
  fi                                                                                                               
}

function frontmatter() {
  cat ${CURRENT_DIR}/cookbook/frontmatter/header.tex \
    ${CURRENT_DIR}/cookbook/frontmatter/frontmatter.tex
}

function main() {
  path_setup
  frontmatter
}

main "$@"
