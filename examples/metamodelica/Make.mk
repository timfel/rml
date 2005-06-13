#
# Root Makefile for the examples hierarchy
#
GOROOT=../..
SUBDIRS=mf miniml petrol assignment assigntwotype exp1 exp2 modassigntwotype pam pamdecl pamtrans petrol2 experiment experiment+
include $(GOROOT)/etc/dispatch.mk
