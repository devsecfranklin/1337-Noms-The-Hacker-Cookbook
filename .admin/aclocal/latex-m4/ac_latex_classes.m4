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
# AC_LATEX_CLASSES([<class1>,<class2>,...,<classn>],<variable>)
#
# Test the presences of class1 or class2 or ...
# and set $<variable> to the right value or no if not found
#
dnl @synopsis AC_LATEX_CLASSES([<class1>,<class2>,...],<var>)
dnl
dnl Test if class1 exists and if not class2 and so
dnl and set $var to the right value
dnl
dnl  AC_LATEX_CLASSES([allo,book,bnjour],book)
dnl  should set $book="book"
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
define(_AC_LATEX_CLASSES_INTERNE,[
	ifelse($#,1,[],$#,2,[
		AC_LATEX_CLASS($2,$1)
	],[
		AC_LATEX_CLASS($2,$1)
		if test "$$1" = "yes";
		then
			$1=$2 ; export $1 ;
		else
			_AC_LATEX_CLASSES_INTERNE($1,m4_shift(m4_shift($@)))
		fi;
	])
])

AC_DEFUN([AC_LATEX_CLASSES],[
	_AC_LATEX_CLASSES_INTERNE($2,$1)
	AC_SUBST($2)
])
