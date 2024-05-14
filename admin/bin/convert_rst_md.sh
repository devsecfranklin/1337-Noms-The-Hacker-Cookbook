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

FILES=*.rst
if [ ! -n "${FILES}" ]; then
  for f in $FILES; do
    filename="${f%.*}"
    echo "Converting ${f} to ${filename}.md"
    $(pandoc $f -f rst -t markdown -o ${filename}.md)
  done
fi

FILES=*.md
for f in $FILES; do
  filename="${f%.*}"
  echo "Removing spaces from ${filename}.md"
  cat ${filename}.md | tr -s ' ' > /tmp/tmp_file
  mv /tmp/tmp_file ${filename}.md
done
