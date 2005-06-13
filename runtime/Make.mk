#
# Root Makefile for the runtime hierarchy
#
# -----------------------------------------------
# adrpo@ida.liu.se 2002-12-12
#  please let debug be the first in the SUBDIRS!!!
#   'cause it needs to generate the lexer & bison
#   files in order for plain to compile!

GOROOT=..
SUBDIRS=debugging plain mask diff
include $(GOROOT)/etc/dispatch.mk
