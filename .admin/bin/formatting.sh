#!/usr/bin/env bash
#
# SPDX-FileCopyrightText: 2023 DE:AD:10:C5 <thedevilsvoice@dead10c5.org>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# v0.1 02/25/2022 Maintainer script
# v0.2 05/13/2024 Remove spaces after conversion

set -euo pipefail
IFS=$'\n\t'

# --- Some config Variables ----------------------------------------
MY_DATE=$(date '+%Y-%m-%d-%H')

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
LBLUE='\033[1;34m'
CYAN='\033[0;36m'
LPURP='\033[1;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function path_setup() {
  CURRENT_DIR="${PWD}"
  PROG_DIR="$0"
  SCRIPT_DIR=$(echo $PROG_DIR | sed 's|\(.*\)/.*|\1|')
  SUB_DIR=$(echo $SCRIPT_DIR | rev | cut -d'/' -f2- | rev)
  echo "Sub dir: $SUB_DIR"
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
  else
    echo -e "${LGRED}Did not find log dir: ${LCYAN}${RAW_OUTPUT}${NC}"
    LOGGING_DIR="."
    RAW_OUTPUT="${LOGGING_DIR}/${RAW_OUTPUT}"
  fi
}

function shell_script_fmt() {
  echo -e "${CYAN}Formatting shell scripts...${NC}"
  shfmt -i 2 -l -w ../bootstrap.sh
  shfmt -i 2 -l -w formatting.sh
  shfmt -i 2 -l -w generate_book.sh
}

function convert_rst_to_md() {
  FILES=*.rst
  if [ ! -n "${FILES}" ]; then
    for f in $FILES; do
      filename="${f%.*}"
      echo "Converting ${f} to ${filename}.md"
      $(pandoc $f -f rst -t markdown -o ${filename}.md)
    done
  fi
}

function format_markdown() {
  FILES=*.md
  for f in $FILES; do
    filename="${f%.*}"
    echo "Removing spaces from ${filename}.md"
    cat ${filename}.md | tr -s ' ' >/tmp/tmp_file
    mv /tmp/tmp_file ${filename}.md
    echo "Running markdown lint on ${filename}.md"
    mdl ${filename}.md
  done
}

function main() {
  shell_script_fmt
  convert_rst_to_md
  format_markdown
}

main "$@"
