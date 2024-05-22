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
# AC_PROG_LATEX2PNG
#
# Test for latex2png
# and set $latex2png to the correct value.
#
#
dnl @synopsis AC_PROG_LATEX2PNG
dnl
dnl This macro test if latex2png is installed. If latex2png
dnl is installed, it set $latex2png to the right value
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
AC_DEFUN([AC_PROG_LATEX2PNG],[
AC_CHECK_PROGS(latex2png,[latex2png],no)
export latex2png;
if test $latex2png = "no" ;
then
	AC_MSG_ERROR([Unable to find a LaTeX2png application]);
fi
AC_SUBST(latex2png)
])
