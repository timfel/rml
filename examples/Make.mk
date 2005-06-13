#
# Root Makefile for the examples hierarchy
#
GOROOT=..
SUBDIRS=metamodelica rml 

default: configure

include $(GOROOT)/etc/dispatch.mk
