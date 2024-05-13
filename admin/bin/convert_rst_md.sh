#!/usr/bin/env bash
#
# SPDX-FileCopyrightText: 2023 DE:AD:10:C5 <thedevilsvoice@dead10c5.org>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# v0.1 02/25/2022 Maintainer script

FILES=*.rst
for f in $FILES; do
  filename="${f%.*}"
  echo "Converting $f to $filename.md"
  $(pandoc $f -f rst -t markdown -o $filename.md)
done
