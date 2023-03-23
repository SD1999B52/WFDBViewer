# file: Makefile	G. Moody	 9 June 1983
#			Last revised:	 23 May 2000
# UNIX 'make' description file for WFDB applications
#
# -----------------------------------------------------------------------------
# WFDB applications: programs for working with annotated signals
# Copyright (C) 2000 George B. Moody
#
# These programs are free software; you can redistribute them and/or modify
# them under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your
# option) any later version.
#
# These programs are distributed in the hope that they will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along with
# these programs; if not, see <http://www.gnu.org/licenses/>.
#
# You may contact the author by e-mail (wfdb@physionet.org) or postal mail
# (MIT Room E25-505A, Cambridge, MA 02139 USA).  For updates to this software,
# please visit PhysioNet (http://www.physionet.org/).
# _____________________________________________________________________________
#
# This file is used with the UNIX `make' command to install the standard
# applications that come with the WFDB software package.  Before using it
# for the first time, check that the site-specific variables below are
# appropriate for your system.  To build and install the applications, just
# type `make' (from within this directory).  To print a set of source listings,
# type `make listing'.
# _____________________________________________________________________________
# file: version.def		G. Moody	24 May 2000
#				Last revised:	25 January 2018
# Each release of the WFDB Software Package is identified by a three-part
# version number, defined below.  Be sure to leave a single space before
# and after the "=" in each of the next three lines!
MAJOR = 10
MINOR = 7
RELEASE = 0
VERSION = 10.7.0

# RPMRELEASE can be incremented if changes are made between official
# releases.  It should be reset to 1 whenever the VERSION is changed.
RPMRELEASE = 1

# VDEFS is the set of C compiler options needed to set version number variables
# while compiling the WFDB Software Package.
VDEFS = -DWFDB_MAJOR=$(MAJOR) -DWFDB_MINOR=$(MINOR) -DWFDB_RELEASE=$(RELEASE)

# WAVEVERSION is the WAVE version number.
WAVEVERSION = 6.12
# _____________________________________________________________________________

# Definitions generated by 'configure'

PACKAGE = wfdb-10.7.0
SRCDIR = -WFDB_HOME
LONGDATE = 20 March 2023
SHORTDATE = MARCH 2023
YEAR = 2023
ARCH = x86_64-MINGW64_NT-6.1-7601
BUILD_CC = $(CC)
# _____________________________________________________________________________

# file: mingw.def		I. Henry and G. Moody       11 February 2005 
#				Last revised:                  18 May 2022
#
# This file contains default 'make' definitions for compiling the WFDB Software
# Package under MS Windows using the free Mininmalist GNU for Windows (MinGW) 
# gcc ANSI C compiler, availble from http://www.mingw.org/ and from 
# http://www.cygwin.com/.  To use this successfully, you need to have installed
# MinGW
#
# Choose a value for WFDBROOT to determine where the WFDB Software Package will
# be installed.  One of the following is usually a reasonable choice.
# Installing in /usr generally requires root permissions, but will be easiest
# for future software development (no special -I or -L options will be needed
# to compile software with the WFDB library, since the *.h files and the
# library will be installed in the standard directories).
WFDBROOT = /usr/local
# Installing in /usr/local usually requires root permissions.  On a multi-user
# system where it is desirable to keep the OS vendor's software separate from
# other software, this is a good choice.  Another common choice in such cases
# is /opt .
# WFDBROOT = /usr/local
# To install without root permissions, a good choice is to set WFDBROOT to the
# name of your home directory, as in the example below (change as needed).
# WFDBROOT = /home/frodo

# LC and LL are used to determine C compiler and linker options needed to
# enable NETFILES (code that allows applications linked to the WFDB library to
# read input from HTTP and FTP servers, in addition to the standard filesystem
# support available without NETFILES).  The WFDB library can use either
# libcurl (recommended) or libwww to provide NETFILES support.  To use libcurl,
# set LC to `curl-config --cflags` (note the backquotes) and LL to
# `curl-config --libs`.  Otherwise, to use libwww, set LC to
# `libwww-config --cflags` and LL to `libwww-config --libs`.  If neither
# libcurl nor libwww is available, LC and LL should be empty (and NETFILES
# will be disabled).
LC = 
LL = 

# LIBFLAC_CFLAGS and LIBFLAC_LIBS specify the set of C compiler and
# linker options needed to link with the FLAC library.
LIBFLAC_CFLAGS = 
LIBFLAC_LIBS = 

# BINDIR specifies the directory in which the applications will be installed;
# it should be a directory in the PATH of those who will use the applications.
BINDIR = $(WFDBROOT)/bin

# DBDIR specifies the name of a directory in which to install the contents
# of the `data' directory.
DBDIR = $(WFDBROOT)/database

# INCDIR specifies the name of a directory in which to install the WFDB
# library's #include <...> files.
INCDIR = $(WFDBROOT)/include

# INFODIR is the GNU info directory (optional, needed to `make info').
INFODIR = $(WFDBROOT)/info

# LIBDIR specifies the name of a directory in which to install the WFDB
# library.  Under Windows, this is the same as BINDIR (above).
LIBDIR = $(WFDBROOT)/bin

# MANDIR is the root of the man page directory tree.  On most systems, this is
# something like /usr/man or /usr/local/man (type 'man man' to find out).
MANDIR = $(WFDBROOT)/man

# PSPDIR specifies the name of a directory in which to install the PostScript
# prolog (*.pro) files from the 'app' directory.
PSPDIR = $(WFDBROOT)/lib/ps

# CC is the name of your C compiler.  The WFDB library can be compiled with K&R
# C compilers (`cc' on most if not all UNIX systems) as well as with ANSI C
# compilers such as GNU C (`gcc').
CC = gcc 
# On systems where `gcc' is the standard C compiler, `gcc' may also be known as
# `cc'; in such cases, it doesn't matter if CC is cc or gcc.

# CCDEFS is the set of C compiler options needed to set preprocessor variables
# while compiling the WFDB Software Package.  CCDEFS should always include
# VDEFS.  Add the following options to CCDEFS as appropriate (separating them
# by spaces if you use more than one):
#   -DISPRINTF	  if you do not have `stdlib.h' and your `sprintf' returns an
#		   int (see wfdblib.h)
#   -DMSDOS	  if the target platform is MS-DOS or MS-Windows without a
#   		   POSIX compatibility layer such as Cygwin
#   -DNETFILES	  if you have libwww and want to be able to access WFDB files
#		   remotely via http or ftp (as well as local files)
#   -DNOSTRTOK	  if your standard C library does not include function `strtok'
#		   (see wfdbio.c)
#   -DNOTIME	  if you do not have `time.h' (see signal.c)
#   -DNOVALUES_H  if you do not have `values.h' (see psd/log10.c)
#   -DOLDC	  if you have neither `stdarg.h' nor `varargs.h' (see wfdbio.c)
# If your C compiler fails to compile `signal.c', add -DBROKEN_CC to CCDEFS
# and try again (see signal.c).
CCDEFS = $(VDEFS) -DWFDB_LARGETIME -DMSDOS -DNOVALUES_H -DNOMKSTEMP

# MFLAGS is the set of architecture-dependent (-m*) compiler options, which
# is usually empty.  See the gcc manual for information about gcc's -m options.
MFLAGS =

# CFLAGS is the set of C compiler options.  CFLAGS should always include
# CCDEFS.
CFLAGS = -Wno-implicit -Wformat $(MFLAGS) -g -O $(CCDEFS) $(LC) $(LIBFLAC_CFLAGS) \
 -I$(DESTDIR)$(INCDIR) WFDBReader.o `pkgconf --cflags gtk+-3.0` `pkgconf --cflags gtkdatabox`

# LDFLAGS is appended to the C compiler command line to specify loading the
# WFDB library.
LDFLAGS = -L$(DESTDIR)$(LIBDIR) -lwfdb `pkgconf --libs gtk+-3.0` `pkgconf --libs gtkdatabox`

# EXEEXT is a suffix appended to the names of all executable programs.
EXEEXT = .exe

# WFDBLIB is the name of the standard WFDB library.  In order to access it via
# `-lwfdb', WFDBLIB should be `libwfdb.a'.
WFDBLIB = libwfdb.a

# If your system requires indexed libraries, uncomment the next line.
RANLIB = ranlib
# Otherwise, uncomment the next line.
# RANLIB = :

# AR is the name of the command used to build a standard library from `.o'
# files, and ARFLAGS is the set of options used when doing so.  AR and ARFLAGS
# are usually `make' builtins and need not be defined here;  under HP UX, and
# perhaps other versions of UNIX, however, you will need to define these
# variables by uncommenting the next two lines.
# AR = ar
# ARFLAGS = rv

# BUILDLIB is the command that creates the static WFDB library once its
# components have been compiled separately;  the list of *.o files that
# make up the library will be appended to BUILDLIB.
BUILDLIB = $(AR) $(ARFLAGS) $(WFDBLIB)

# PRINT is the name of the program used to produce listings (including any
# options for the desired formatting).
PRINT = lpr

# SETPERMISSIONS is the command needed to make the installed files accessible
# to those who will use them.  The value given below makes them readable by
# everyone, and writeable by the owner only.  (If you perform the installation
# as `root', `root' is the owner of the installed files.)
SETPERMISSIONS = chmod 644

# SETDPERMISSIONS is similarly used to make directories created during the
# installation accessible.
SETDPERMISSIONS = chmod 755

# SETLPERMISSIONS is the command needed to make the WFDB library usable by
# programs linked to it.
SETLPERMISSIONS = chmod 644

# SETXPERMISSIONS is the command needed to make the applications accessible.
SETXPERMISSIONS = $(SRCDIR)/conf/exechmod 755

# STRIP is the command used to compact the compiled binaries by removing their
# symbol tables.  'exestrip' is a script that appends the '.exe' suffix to the
# files in its argument list before passing their names to 'strip' itself.
STRIP = $(SRCDIR)/conf/exestrip
# To retain the symbol tables for debugging, comment out the previous line, and
# uncomment the next line.
# STRIP = :

# RM is the command used to delete binaries. 'exerm' is a script that appends
# the '.exe' suffix to the files in its argument list before deleting.
RM = $(SRCDIR)/conf/exerm

# ...........................................................................
# This section of definitions is used only when compiling WAVE, which is
# possible only if the XView and Xlib libraries and include files have been
# installed.  This is not currently possible using mingw, and is unlikely to
# become possible in the future, although it can be done using cygwin.

# OPENWINHOME specifies the root directory of the OpenWindows hierarchy.
# This is usually /usr/openwin.
OPENWINHOME = /usr/openwin

# OWINCDIR is the directory in which the `xview' directory containing XView
# *.h files is found.
OWINCDIR = $(OPENWINHOME)/include

# OWLIBDIR is the directory in which the XView library is found.
OWLIBDIR = $(OPENWINHOME)/lib

# XHOME specifies the root directory of the X11 hierarchy.
# This is usually /usr/X11R6 (or /usr/X11).
XHOME = /usr/X11R6

# XINCDIR is the directory in which the 'X11' directory containing X11 *.h
# files is found.  This is usually /usr/X11R6/include, although there is often
# a link connecting /usr/include/X11 to this directory.
XINCDIR = $(XHOME)/include

# XLIBDIR is the directory in which the X11 libraries are found.
XLIBDIR = $(XHOME)/lib

# WCFLAGS is the set of C compiler options to use when compiling WAVE.
WCFLAGS = $(CFLAGS) -I$(OWINCDIR) -I$(XINCDIR)

# HELPOBJ can be set to "help.o" if you wish to recompile the XView spot help
# functions in "wave/help.c" (recommended under Linux).
# HELPOBJ = help.o
# Otherwise, use the version in libxview by uncommenting the next line:
HELPOBJ =

# WLDFLAGS is the set of loader options appended to the C compiler command line
# to specify loading the WFDB, XView, and Xlib libraries.
WLDFLAGS = $(LDFLAGS) -L$(OWLIBDIR) -L$(XLIBDIR) -lxview -lolgx -lX11
# ...........................................................................

# `make' (with no target specified) will be equivalent to `make all'.
make-all:	all

# `make lib-post-install' should be run after installing the WFDB library.
lib-post-install:
	echo "Nothing to be done for lib-post-install"

lib-post-uninstall:
	echo "Nothing to be done for lib-post-uninstall"

.SUFFIXES: .exe

.c.exe:
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
# _____________________________________________________________________________
# file: Makefile.tpl		G. Moody	  23 May 2000
#				Last revised:	 24 April 2020
# This section of the Makefile should not need to be changed.

CFILES = ann2rr.c bxb.c calsig.c ecgeval.c epicmp.c fir.c gqfuse.c gqpost.c \
 gqrs.c hrstats.c ihr.c mfilt.c mrgann.c mxm.c nguess.c nst.c plotstm.c \
 pscgen.c pschart.c psfd.c rdann.c rdsamp.c rr2ann.c rxr.c sampfreq.c sigamp.c \
 sigavg.c signame.c signum.c skewedit.c snip.c sortann.c sqrs.c sqrs125.c \
 stepdet.c sumann.c sumstats.c tach.c time2sec.c wabp.c wfdb-config.c \
 wfdbcat.c wfdbcollate.c wfdbdesc.c wfdbmap.c wfdbsignals.c wfdbtime.c \
 wfdbwhich.c wqrs.c wrann.c wrsamp.c xform.c
CFFILES = gqrs.conf
HFILES = signal-colors.h
XFILES = \
 ann2rr$(EXEEXT) \
 bxb$(EXEEXT) \
 calsig$(EXEEXT) \
 ecgeval$(EXEEXT) \
 epicmp$(EXEEXT) \
 fir$(EXEEXT) \
 gqfuse$(EXEEXT) \
 gqpost$(EXEEXT) \
 gqrs$(EXEEXT) \
 hrstats$(EXEEXT) \
 ihr$(EXEEXT) \
 mfilt$(EXEEXT) \
 mrgann$(EXEEXT) \
 mxm$(EXEEXT) \
 nguess$(EXEEXT) \
 nst$(EXEEXT) \
 plotstm$(EXEEXT) \
 pscgen$(EXEEXT) \
 pschart$(EXEEXT) \
 psfd$(EXEEXT) \
 rdann$(EXEEXT) \
 rdsamp$(EXEEXT) \
 rr2ann$(EXEEXT) \
 rxr$(EXEEXT) \
 sampfreq$(EXEEXT) \
 sigamp$(EXEEXT) \
 sigavg$(EXEEXT) \
 signame$(EXEEXT) \
 signum$(EXEEXT) \
 skewedit$(EXEEXT) \
 snip$(EXEEXT) \
 sortann$(EXEEXT) \
 sqrs$(EXEEXT) \
 sqrs125$(EXEEXT) \
 stepdet$(EXEEXT) \
 sumann$(EXEEXT) \
 sumstats$(EXEEXT) \
 tach$(EXEEXT) \
 time2sec$(EXEEXT) \
 wabp$(EXEEXT) \
 wfdb-config$(EXEEXT) \
 wfdbcat$(EXEEXT) \
 wfdbcollate$(EXEEXT) \
 wfdbdesc$(EXEEXT) \
 wfdbmap$(EXEEXT) \
 wfdbsignals$(EXEEXT) \
 wfdbtime$(EXEEXT) \
 wfdbwhich$(EXEEXT) \
 wqrs$(EXEEXT) \
 wrann$(EXEEXT) \
 wrsamp$(EXEEXT) \
 xform$(EXEEXT)
SCRIPTS = cshsetwfdb setwfdb pnwlogin
PSFILES = pschart.pro psfd.pro 12lead.pro
MFILES = Makefile

# General rule for compiling C sources into executable files.  This is
# redundant for most versions of `make', but at least one System V version
# needs it.
.c:
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

# `make all': build applications
all:	$(XFILES)
	$(STRIP) $(XFILES)

# `make' or `make install':  build and install applications
install:	all $(DESTDIR)$(BINDIR) $(DESTDIR)$(PSPDIR) scripts
	rm -f pschart psfd pschart.exe psfd.exe
# be sure compiled-in paths are up-to-date
	$(MAKE) pschart$(EXEEXT) psfd$(EXEEXT)
	$(STRIP) pschart$(EXEEXT) psfd$(EXEEXT)
	$(SETXPERMISSIONS) $(XFILES)
	../install.sh $(DESTDIR)$(BINDIR) $(XFILES)
	cp $(PSFILES) $(DESTDIR)$(PSPDIR)
	cd $(DESTDIR)$(PSPDIR); $(SETPERMISSIONS) $(PSFILES)

# 'make collect': retrieve the installed applications
collect:
	../conf/collect.sh $(BINDIR) $(XFILES) $(SCRIPTS)
	../conf/collect.sh $(PSPDIR) $(PSFILES)

# `make scripts': install customized scripts for setting WFDB path
scripts: $(DESTDIR)$(BINDIR)
	sed s+/usr/local/database+$(DBDIR)+g <setwfdb >$(DESTDIR)$(BINDIR)/setwfdb
	sed s+/usr/local/database+$(DBDIR)+g <cshsetwfdb >$(DESTDIR)$(BINDIR)/cshsetwfdb
	sed s+/usr/local/database+$(DBDIR)+g <pnwlogin >$(DESTDIR)$(BINDIR)/pnwlogin
	cd $(DESTDIR)$(BINDIR); $(SETPERMISSIONS) *setwfdb; $(SETXPERMISSIONS) pnwlogin

uninstall:
	../uninstall.sh $(DESTDIR)$(PSPDIR) $(PSFILES)
	../uninstall.sh $(DESTDIR)$(BINDIR) $(XFILES) $(SCRIPTS)
	../uninstall.sh $(DESTDIR)$(LIBDIR)

# Create directories for installation if necessary.
$(DESTDIR)$(BINDIR):
	mkdir -p $(DESTDIR)$(BINDIR)
	$(SETDPERMISSIONS) $(DESTDIR)$(BINDIR)
$(DESTDIR)$(PSPDIR):
	mkdir -p $(DESTDIR)$(PSPDIR)
	$(SETDPERMISSIONS) $(DESTDIR)$(PSPDIR)

# `make clean':  remove intermediate and backup files
clean:
	rm -f $(XFILES) *.o *~

# `make listing':  print a listing of WFDB applications sources
listing:
	$(PRINT) README $(MFILES) $(CFILES) $(HFILES) $(CFFILES) $(PSFILES)

# Rules for compiling applications that require non-standard options

bxb$(EXEEXT):		bxb.c
	$(CC) $(CFLAGS) bxb.c -o $@ $(LDFLAGS) -lm
ihr$(EXEEXT):		ihr.c
	$(CC) $(CFLAGS) ihr.c -o $@ $(LDFLAGS) -lm
hrstats$(EXEEXT):	hrstats.c
	$(CC) $(CFLAGS) hrstats.c -o $@ $(LDFLAGS) -lm
mxm$(EXEEXT):		mxm.c
	$(CC) $(CFLAGS) mxm.c -o $@ $(LDFLAGS) -lm
nguess$(EXEEXT):	nguess.c
	$(CC) $(CFLAGS) nguess.c -o $@ $(LDFLAGS) -lm
nst$(EXEEXT):		nst.c
	$(CC) $(CFLAGS) nst.c -o $@ $(LDFLAGS) -lm
plotstm$(EXEEXT):	plotstm.c
	$(CC) $(CFLAGS) plotstm.c -o $@
pschart$(EXEEXT):
	$(CC) $(CFLAGS) -DPROLOG=\"$(PSPDIR)/pschart.pro\" pschart.c -o $@ \
          $(LDFLAGS)
psfd$(EXEEXT):
	$(CC) $(CFLAGS) -DPROLOG=\"$(PSPDIR)/psfd.pro\" psfd.c -o $@ $(LDFLAGS)
sigamp$(EXEEXT):	sigamp.c
	$(CC) $(CFLAGS) sigamp.c -o $@ $(LDFLAGS) -lm
wfdbmap$(EXEEXT):	wfdbmap.c signal-colors.h
	$(CC) $(CFLAGS) wfdbmap.c -o $@ $(LDFLAGS)
wqrs$(EXEEXT):		wqrs.c
	$(CC) $(CFLAGS) wqrs.c -o $@ $(LDFLAGS) -lm
