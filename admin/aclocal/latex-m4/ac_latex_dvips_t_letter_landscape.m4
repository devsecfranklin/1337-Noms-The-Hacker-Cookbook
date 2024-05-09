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
# AC_LATEX_DVIPS_T_LETTER_LANDSCAPE
#
# Test dvips -t letter -t landscape and set dvips_t_letter_landscape
#
#
dnl @synopsis AC_LATEX_DVIPS_T_LETTER_LANDSCAPE
dnl
dnl same as AC_LATEX_DVIPS_T(letter,dvips_t_letter_landscape,on)
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
AC_DEFUN([AC_LATEX_DVIPS_T_LETTER_LANDSCAPE],[
AC_REQUIRE([AC_LATEX_DVIPS_T_LETTER])
AC_LATEX_DVIPS_T(letter,dvips_t_letter_landscape,on)
if test $dvips_t_letter_landscape = "no";
then
    AC_MSG_ERROR([Unable to find the -t letter -t landscape option in dvips])
fi
])