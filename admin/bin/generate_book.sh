#!/usr/bin/env bash
#
# SPDX-FileCopyrightText: 2023 DE:AD:10:C5 <thedevilsvoice@dead10c5.org>
#
# SPDX-License-Identifier: GPL-3.0-or-later

Set -euo pipefail
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
RAW_OUTPUT="cookbook/hacker_cookbook.tex"


function header() {
  
  cat <<EOF > ${RAW_OUTPUT}
% !TeX encoding = UTF-8
% !TeX root = hacker_cookbook.tex
% !TeX TXS-program:compile = txs:///pdflatex/[--shell-escape]

\include{preamble}
\begin{document}

EOF
}

function frontmatter(){
  cat <<EOF > ${RAW_OUTPUT}
% frontmatter: half title, title page, colophon (copyright page), epigraph, toc, preface, acknowledgements
\tableofcontents
\listoffigures
\listoftables

EOF

}
 
function main() {

}

main "$@"
