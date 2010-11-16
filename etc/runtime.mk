# Generic runtime makefile
# Parameters:	GOROOT CSRC XCSRC RMLHSRC YSIZEDEP xtra-install DESTDIR
SHELL=/bin/sh
COMPILE.c=$(CC) $(CFLAGS) $(CPPFLAGS) -c -I.
ARFLAGS=ruv

.SUFFIXES:	.c .o .g.o .p.o .t.o

.c.o:
	$(COMPILE.c) $(COFLAGS) $<
.c.g.o:
	$(COMPILE.c) $(CGFLAGS) -o $@ $<
.c.p.o:
	$(COMPILE.c) $(COFLAGS) $(CPFLAGS) -o $@ $<
.c.t.o:
	$(COMPILE.c) $(COFLAGS) $(CTFLAGS) -o $@ $<

OBJS=	$(CSRC:.c=.o) $(XCSRC:.c=.o)
GOBJS=	$(CSRC:.c=.g.o) $(XCSRC:.c=.g.o)
POBJS=	$(CSRC:.c=.p.o) $(XCSRC:.c=.p.o)
TOBJS=	$(CSRC:.c=.t.o) $(XCSRC:.c=.t.o)
CLEAN=	$(OBJS) $(GOBJS) $(POBJS) $(TOBJS) librml.a librml_g.a librml_p.a librml_t.a z-ysize.h

# DEBUGLIB is set in config.cache to librml_g.a or the empty string
# PROFLIB  is set in config.cache to librml_p.a or the empty string
# TRACLIB  is set in config.cache to librml_t.a or the empty string
default:	rml.h librml.a $(DEBUGLIB) $(PROFLIB) $(TRACLIB)

install:	normal-install xtra-install

normal-install:	rml.h librml.a $(DEBUGLIB) $(PROFLIB) $(TRACLIB)
	$(GOROOT)/etc/mkdirhier $(DESTDIR)$(PREFIX)/include/$(RMLCRUNTIME)
	$(GOROOT)/etc/mkdirhier $(DESTDIR)$(PREFIX)/lib/$(RMLCRUNTIME)
	cp rml.h $(DESTDIR)$(PREFIX)/include/$(RMLCRUNTIME)/rml.h
	cp librml.a $(DESTDIR)$(PREFIX)/lib/$(RMLCRUNTIME)/librml.a
	$(RANLIB) $(DESTDIR)$(PREFIX)/lib/$(RMLCRUNTIME)/librml.a
	if [ ! -z "$(DEBUGLIB)" ]; then \
		cp librml_g.a $(DESTDIR)$(PREFIX)/lib/$(RMLCRUNTIME)/librml_g.a; \
		$(RANLIB) $(DESTDIR)$(PREFIX)/lib/$(RMLCRUNTIME)/librml_g.a; \
	fi
	if [ ! -z "$(PROFLIB)" ]; then \
		cp librml_p.a $(DESTDIR)$(PREFIX)/lib/$(RMLCRUNTIME)/librml_p.a; \
		$(RANLIB) $(DESTDIR)$(PREFIX)/lib/$(RMLCRUNTIME)/librml_p.a; \
	fi
	if [ ! -z "$(TRACLIB)" ]; then \
		cp librml_p.a $(DESTDIR)$(PREFIX)/lib/$(RMLCRUNTIME)/librml_t.a; \
		$(RANLIB) $(DESTDIR)$(PREFIX)/lib/$(RMLCRUNTIME)/librml_t.a; \
	fi

librml.a:	$(OBJS)
	$(AR) $(ARFLAGS) librml.a $(OBJS)
	$(RANLIB) librml.a

librml_g.a:	$(GOBJS)
	$(AR) $(ARFLAGS) librml_g.a $(GOBJS)
	$(RANLIB) librml_g.a

librml_p.a:	$(POBJS)
	$(AR) $(ARFLAGS) librml_p.a $(POBJS)
	$(RANLIB) librml_p.a

librml_t.a:	$(TOBJS)
	$(AR) $(ARFLAGS) librml_t.a $(TOBJS)
	$(RANLIB) librml_t.a

$(OBJS):	rml.h
$(GOBJS):	rml.h
$(POBJS):	rml.h
$(TOBJS):	rml.h

$(YSIZEDEP:.c=.o):	z-ysize.h
$(YSIZEDEP:.c=.g.o):	z-ysize.h
$(YSIZEDEP:.c=.p.o):	z-ysize.h
$(YSIZEDEP:.c=.t.o):	z-ysize.h

rml.h:	$(GOROOT)/config.cache rml-select.h $(RMLHSRC)
	cat rml-select.h $(GOROOT)/config/$(TARGET)/config.h $(RMLHSRC) > rml.h

test-access:
	cat rml-select.h $(GOROOT)/config/$(TARGET)/config.h $(TESTH) $(RMLHSRC) > rml.h

z-ysize.h:
	touch z-ysize.h

test-ysize:
	echo '#undef RML_YOUNG_SIZE' > z-ysize.h
	echo "#define RML_YOUNG_SIZE ($(TEST)*1024)" >> z-ysize.h
	echo '#define RML_TRAIL_SIZE (1*1024)' >> z-ysize.h
	echo '#define RML_STACK_SIZE (16*1024)' >> z-ysize.h

Makefile: $(GOROOT)/config.cache Make.mk
	echo include $(GOROOT)/config.cache > Makefile
	. $(GOROOT)/config.cache; cat $(GOROOT)/config/$$TARGET/variables.mk >> Makefile
	cat Make.mk >> Makefile
	echo '# fake VPATH rules' >> Makefile
	$(GOROOT)/etc/fakevpath ../common o '$$(COMPILE.c) $$(COFLAGS)' $(CSRC) >> Makefile
	$(GOROOT)/etc/fakevpath ../common g.o '$$(COMPILE.c) $$(CGFLAGS)' $(CSRC) >> Makefile
	$(GOROOT)/etc/fakevpath ../common p.o '$$(COMPILE.c) $$(COFLAGS) $$(CPFLAGS)' $(CSRC) >> Makefile
	$(GOROOT)/etc/fakevpath ../common t.o '$$(COMPILE.c) $$(COFLAGS) $$(CTFLAGS)' $(CSRC) >> Makefile
# adrpo added 
	$(GOROOT)/etc/fakevpath ../debugging o '$$(COMPILE.c) $$(COFLAGS)' $(CSRC) >> Makefile
	$(GOROOT)/etc/fakevpath ../debugging g.o '$$(COMPILE.c) $$(CGFLAGS)' $(CSRC) >> Makefile
	$(GOROOT)/etc/fakevpath ../debugging p.o '$$(COMPILE.c) $$(COFLAGS) $$(CPFLAGS)' $(CSRC) >> Makefile
	$(GOROOT)/etc/fakevpath ../debugging t.o '$$(COMPILE.c) $$(COFLAGS) $$(CTFLAGS)' $(CSRC) >> Makefile

configure:	clean-configure Makefile

clean-configure:	clean
	rm -f Makefile rml.h

distclean:	realclean clean-configure
realclean:	clean

clean:
	rm -f a.out core mon.out gmon.out $(CLEAN)
