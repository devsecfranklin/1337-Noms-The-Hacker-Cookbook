#
#   Copyright (C) 2004  Boretti Mathieu
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#
# Internal macro to test a latex file
#

AC_DEFUN([_AC_LATEX_TEST],[
AC_REQUIRE([AC_PROG_LATEX])
rm -rf .tmps_latex 
mkdir .tmps_latex 
cd .tmps_latex 
ifelse($#,2,[
$2="no"; export $2;
cat > testconf.tex << \EOF
$1
EOF
],$#,3,[
echo "\\documentclass{$3}" > testconf.tex
cat >> testconf.tex << \EOF
$1
EOF
],$#,4,[
echo "\\documentclass{$3}" > testconf.tex
echo "\\usepackage{$4}" > testconf.tex
cat >> testconf.tex << \EOF
$1
])
cat testconf.tex | $latex 2>&1 1>/dev/null && $2=yes; export $2;
cd .. 
rm -rf .tmps_latex 
])
