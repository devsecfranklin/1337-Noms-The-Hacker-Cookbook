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
# AC_PROG_PS2PDF
#
# Test for ps2pdf14 ou ps2pdf13 or ps2pdf12 or ps2pdf
# and set $ps2pdf to the correct value.
#
#
dnl @synopsis AC_PROG_PS2PDF
dnl
dnl This macro test if ps2pdf is installed. If ps2pdf
dnl is installed, it set $ps2pdf to the right value
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
AC_DEFUN([AC_PROG_PS2PDF],[
AC_CHECK_PROGS(ps2pdf,[ps2pdf14 ps2pdf13 ps2pdf12 ps2pdf],no)
export ps2pdf;
if test $ps2pdf = "no" ;
then
	AC_MSG_ERROR([Unable to find a ps2pdf application]);
fi
AC_SUBST(ps2pdf)
])
