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
# AC_LATEX_DVIPS_O_STDOUT
#
# Test dvips with option -o- and set $dvips_o_stdout to the right value
#
#
dnl @synopsis AC_LATEX_DVIPS_O_STDOUT
dnl
dnl test if dvips -o- works. If so, set $dvips_o_stdout to yes else to no
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
AC_DEFUN([AC_LATEX_DVIPS_O_STDOUT],[
AC_REQUIRE([AC_LATEX_CLASS_BOOK])
AC_CACHE_CHECK([for option -o- in dvips],ac_cv_dvips_o_stdout,[
rm -rf .dvips
mkdir .dvips
cd .dvips
cat > test.tex << EOF
\documentclass{book}
\begin{document}
Test
\end{document}
EOF
$latex test.tex 1>/dev/null 2>&1
ac_cv_dvips_o_stdout="no"; export ac_cv_dvips_o_stdout;
$dvips -o- test.dvi   1>/dev/null 2>&1 && ac_cv_dvips_o_stdout="yes"; export ac_cv_dvips_o_stdout 
cd ..
rm -rf .dvips
])
DVIPS_O_STDOUT=$ac_cv_dvips_o_stdout; export DVIPS_O_STDOUT;
if test $DVIPS_O_STDOUT = "no" ;
then
    AC_MSG_ERROR(Unable to find the option -o- in dvips)
fi
AC_SUBST(DVIPS_O_STDOUT)
])
