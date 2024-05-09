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
# AC_LATEX_DVIPS_T(<paper>,<var>,[<on|off>])
#
# Test dvips with option -o ... -T <paper> et set $<var> to the right value
#
#
dnl @synopsis AC_LATEX_DVIPS_T(<paper>,<var>) or AC_LATEX_DVIPS_T(<paper>,<var>,on|off)
dnl
dnl This macro test if dvips -o ... -t <paper> works. When using the on option, test
dnl if dvips -o ... -t <paper> -t landscape works.
dnl if it works, set $var to yes, else $var="no"
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
AC_DEFUN([AC_LATEX_DVIPS_T],[
AC_REQUIRE([AC_LATEX_CLASS_BOOK])
if test "$3" = "on" ;
then
_ac_latex_dvips_local=" -t landscape" ; export _ac_latex_dvips_local ;
else
_ac_latex_dvips_local=" " ; export _ac_latex_dvips_local ;
fi
AC_CACHE_CHECK([for option -t $1 $_ac_latex_dvips_local with dvips],[ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]),[
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
[ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_])="yes"; export [ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]);
$dvips -o test.ps test.dvi -t $1 $_ac_latex_dvips_local 2>&1 1>/dev/null | (grep "dvips: no match for papersize" 1>/dev/null 2>&1 && [ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_])="no"; export [ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]))
cd ..
rm -rf .dvips
])
$2=$[ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]); export $2;
AC_SUBST($2)
])
