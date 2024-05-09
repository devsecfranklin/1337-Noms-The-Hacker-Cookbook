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
# AC_LATEX_PACKAGE_AMSMATH
#
# Test the presences of amsmath and amsfonts and in case of error
# amstex and set $amsmath to the right values
#
# Use the book class to do the test
#
#
dnl @synopsis AC_LATEX_PACKAGE_AMSMATH
dnl
dnl This macro test if \usepackage{amsmath,amsfonts} works. If yes, it set 
dnl $amsmath="\usepackage{amsmath,amsfonts}"
dnl Else if \usepackage{amstex} works, set $amsmath="\usepackage{amstex}"
dnl else ERROR
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
AC_DEFUN([AC_LATEX_PACKAGE_AMSMATH],[
AC_LATEX_CLASS_BOOK
AC_CACHE_CHECK([for amsmath],[ac_cv_latex_package_f_amsmath],[
_AC_LATEX_TEST([
\documentclass{book}
\usepackage{amsmath,amsfonts}
\begin{document}
\end{document}
],[ac_cv_latex_package_f_amsmath])
if test $ac_cv_latex_package_f_amsmath = "yes" ;
then
    [ac_cv_latex_package_f_amsmath]="\\usepackage{amsmath,amsfonts}" ; export [ac_cv_latex_package_f_amsmath] ;
else
    _AC_LATEX_TEST([
    \documentclass{book}
    \usepackage{amstex}
    \begin{document}
    \end{document}
    ],[ac_cv_latex_package_f_amsmath])
    if test $ac_cv_latex_package_f_amsmath = "yes" ;
    then
        [ac_cv_latex_package_f_amsmath]="\\usepackage{amstex}" ; export [ac_cv_latex_package_f_amsmath] ;
    else
        AC_MSG_ERROR([Unable to find amsmath])
    fi
fi
])
amsmath=$[ac_cv_latex_package_f_amsmath]; export amsmath;
AC_SUBST(amsmath)
])
