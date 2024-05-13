#!/usr/bin/env bash
#
# SPDX-FileCopyrightText: 2023 DE:AD:10:C5 <franklin@dead10c5.org>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# v0.1 | 02/15/2024 | initial version | franklin

set -euo pipefail
IFS=$'\n\t'

shfmt -i 2 -l -w ../bootstrap.sh
shfmt -i 2 -l -w convert_rst_md.sh
shfmt -i 2 -l -w generate_book.sh
