#
# Makefile for the plain runtime
#
GOROOT=../..

CSRC=	array.c boolean.c integer.c list.c logicalvar.c real.c string.c vector.c internal.c \
	p-gccore.c p-gcuser-plain.c p-usergc.c controlflow.c reference.c system.c value.c root.c \
	parse-command.c scan-command.c parse-rdb.c scan-rdb.c load.c \
	socket.c command.c handler.c debug.c \
	main.c

RMLHSRC=../common/rml-start.h ../common/rml-core.h rml-labels.h ../common/rml-predef.h\
	../debugging/command.h ../debugging/socket.h ../debugging/handler.h ../debugging/load.h \
	../debugging/debug.h ../common/rml-end.h
	 
p-gccore.h=../common/p-gccore.h 

default:	librml.a

YSIZEDEP=p-gccore.c p-gcuser.c
$(YSIZEDEP:.c=.o):	$(p-gccore.h)
$(YSIZEDEP:.c=.g.o):	$(p-gccore.h)
$(YSIZEDEP:.c=.p.o):	$(p-gccore.h)

# Specifics for the plain runtime
XCSRC=	
RMLCRUNTIME=plain
xtra-install:

# Common rules
include $(GOROOT)/etc/runtime.mk


