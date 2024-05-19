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
# AC_TEXMF_PATH
#
# Test for a local texmf path
# and set $texmfpath to the correct value.
#
#
dnl @synopsis AC_TEXMF_PATH
dnl
dnl This macro test for a local texmf path and
dnl set $texmfpath to the correct value
dnl
dnl @version 1.3
dnl @author Mathieu Boretti boretti@eig.unige.ch
dnl
AC_DEFUN([AC_TEXMF_PATH],[
AC_ARG_WITH([texmf-path],AC_HELP_STRING([--with-texmf-path=...],[specify default local texmf path]),[
    if test ! "$withval" = "yes" ;
    then
        ac_cv_texmf_path="$withval" ; export ac_cv_texmf_path;
    fi;
],[
    texmfpath=""; export texmfpath;
])
AC_REQUIRE([AC_PROG_LATEX])
AC_REQUIRE([AC_PROG_AWK])
AC_REQUIRE([AC_LATEX_CLASS_REPORT])
AC_CACHE_CHECK([for texmf local path],[ac_cv_texmf_path],[
    Base=`$kpsewhich report.cls` ; export Base ;
    Base=`echo $Base | $AWK -F / '{for(i=1;i<NF;i++) {if ($i=="texmf") break; OUT=OUT$i"/";} print OUT}'` ; export Base ;
    if test -x "$Base/texmf.local" ; 
    then
        Base="$Base/texmf.local" ; export Base;
    else
        if test -x "$Base/texmf-local" ;
        then
            Base="$Base/texmf-local" ; export Base;
        else
            if test -x "$Base/texmf" ; 
            then
                Base="$Base/texmf" ; export Base;
            else
                Base="no"; export Base;
            fi;
        fi;
    fi;
    ac_cv_texmf_path="$Base" ; export ac_cv_texmf_path;
])
texmfpath=$ac_cv_texmf_path ; export texmfpath;
if test "$texmfpath" = "no" ;
then
    AC_MSG_ERROR([Unable to find a local texmf folder. Use --with-texmf-path=... to specify it])
fi
AC_SUBST(texmfpath)
])
