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
# AC_PROG_LATEX2HTML
#
# Test for latex2html
# and set $latex2html to the correct value.
#
#
dnl @synopsis AC_PROG_LATEX2HTML
dnl
dnl This macro test if latex2html is installed. If latex2html
dnl is installed, it set $latex2html to the right value
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
AC_DEFUN([AC_PROG_LATEX2HTML],[
AC_CHECK_PROGS(latex2html,[latex2html],no)
export latex2html;
if test $latex2html = "no" ;
then
	AC_MSG_ERROR([Unable to find a LaTeX2html application]);
fi
AC_SUBST(latex2html)
])
