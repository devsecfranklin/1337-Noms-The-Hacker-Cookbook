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
# AC_PROG_FIG2DEV
#
# Test for fig2dev
# and set $fig2dev to the correct value.
#
#
dnl @synopsis AC_PROG_FIG2DEV
dnl
dnl This macro test if fig2dev is installed. If fig2dev
dnl is installed, it set $fig2dev to the right value
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
AC_DEFUN([AC_PROG_FIG2DEV],[
AC_CHECK_PROGS(fig2dev,[fig2dev],no)
export fig2dev;
if test $fig2dev = "no" ;
then
	AC_MSG_ERROR([Unable to find a fig2dev application]);
fi
AC_SUBST(fig2dev)
])