# Makefile for the RML V2 Definition document
GOROOT=../../..
SHELL=/bin/sh
TEXSRC=	def-dynamic.tex def-initial.tex def-intro.tex def-lexical.tex\
	def-notation.tex def-preface.tex def-reorder.tex def-static.tex\
	def-syntax.tex def.tex macros.tex
AUXSRC=	$(TEXSRC:.tex=.aux)
JUNK=	def.bbl def.blg def.log def.toc

default:
	latex def.tex

def.dvi:	$(TEXSRC) def.bbl
	latex def.tex
	touch def.dvi def.bbl

def.bbl:	def.aux
	bibtex def
	latex def.tex

def.aux:	$(TEXSRC)
	latex def.tex

configure:

boot:

install:

distclean:	realclean

realclean:	clean
	rm -f def.dvi def.ps def.2ps def.4ps def.ps.gz def.dvi.gz

clean:
	rm -f $(AUXSRC) $(JUNK)
