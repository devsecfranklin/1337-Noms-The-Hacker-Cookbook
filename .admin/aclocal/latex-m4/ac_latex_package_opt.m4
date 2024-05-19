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
# AC_LATEX_PACKAGE_OPT(<packagen>,<class>,<variable>,<option>)
#
# Test the presences of package using class <class>
# and option <option> and set $<variable> to yes or no
#
#
dnl @synopsis AC_LATEX_PACKAGE_OPT(<package>,<class>,<variable>,<option>)
dnl
dnl This macro test if package in <class> with option <option> exists
dnl and set <variable> to the right value (yes or no)
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl

define(_AC_LATEX_PACKAGE_OPT_INTERNE,[
changequote(*, !)dnl
\documentclass{$2}
\usepackage[$3]{$1}
\begin{document}
\end{document}
changequote([, ])dnl

])

AC_DEFUN([AC_LATEX_PACKAGE_OPT],[
if test "$[ac_cv_latex_class_]translit($2,[-],[_])" = "" ;
then
	AC_LATEX_CLASS($2,boretti_classesansparametre)
	export boretti_classesansparametre;
else
	boretti_classesansparametre=$[ac_cv_latex_class_]translit($2,[-],[_]) ;
	export boretti_classesansparemetre;
fi;
if test $boretti_classesansparametre = "no" ;
then
    AC_MSG_ERROR([Unable to find $1 class])
fi
AC_CACHE_CHECK([for $1 in class $2 with $4 as option],[ac_cv_latex_]translit($1,[-],[_])[_]translit($2,[-],[_])[_]translit($4,[-],[_]),[
_AC_LATEX_TEST([
_AC_LATEX_PACKAGE_OPT_INTERNE($1,$2,$4)
],[ac_cv_latex_]translit($1,[-],[_])[_]translit($2,[-],[_])[_]translit($4,[-],[_]))
])
$3=$[ac_cv_latex_]translit($1,[-],[_])[_]translit($2,[-],[_])[_]translit($4,[-],[_]); export $3;
AC_SUBST($3)
])
