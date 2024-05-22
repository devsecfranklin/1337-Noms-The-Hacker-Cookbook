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
# AC_LATEX_PACKAGE_FONTENC
#
# Test if \usepackage[T1]{fontenc}
# if yes -> $fontenc = T1
# else
# Test if \usepckage[OT1]{fontenc}
# if yes -> $fontenc = OT1
# else
# Error
#
# Use the book class for the test
#
#
dnl @synopsis AC_LATEX_PACKAGE_FONTENC
dnl
dnl This macro test if \usepackage[T1]{fontenc} works. If yes
dnl it set $fontenc="T1"
dnl else if \usepackage[OT1]{fontenc} works, set $fontenc="OT1"
dnl else ERROR
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
define(_AC_LATEX_PACKAGE_FONTENC_INTERNE,[
changequote(*, !)dnl
\documentclass{book}
\usepackage[$1]{fontenc}
\begin{document}
\end{document}
changequote([, ])dnl

])

AC_DEFUN([AC_LATEX_PACKAGE_FONTENC],[
    AC_LATEX_CLASS_BOOK
    AC_CACHE_CHECK([for fontenc],[ac_cv_latex_package_fontenc_opt],[
        _AC_LATEX_TEST([_AC_LATEX_PACKAGE_FONTENC_INTERNE(T1)],[ac_cv_latex_package_fontenc_opt])
        if test $ac_cv_latex_package_fontenc_opt = "yes" ;
        then
            ac_cv_latex_package_fontenc_opt="T1"; export ac_cv_latex_package_fontenc_opt;
        else
            _AC_LATEX_TEST([_AC_LATEX_PACKAGE_FONTENC_INTERNE(OT1)],[ac_cv_latex_package_fontenc_opt])
            if test $ac_cv_latex_package_fontenc_opt = "yes" ;
            then
                ac_cv_latex_package_fontenc_opt="OT1"; export ac_cv_latex_package_fontenc_opt;
            fi
        fi
        
    ])
    if test $ac_cv_latex_package_fontenc_opt = "no" ;
    then
        AC_MSG_ERROR([Unable to use fontenc with T1 nor OT1])
    fi
    fontenc=$ac_cv_latex_package_fontenc_opt ; export fontenc ;
    AC_SUBST(fontenc)
])