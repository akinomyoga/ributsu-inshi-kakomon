# Makefile -*- mode: makefile-gmake -*-

all: 
.PHONY: all

include ../common.mk

Makefile: make.in ../make_dirs.sh ../make_dirs.mk
	cd .. && ./make_dirs.sh %year%

OUTDIR := ../../out/%year%
$(OUTDIR):
	mkdir -p $@

.PHONY: clean
clean:
	-rm -rf $(OUTDIR)/*.{aux,toc,log,dvi} $(generated)

generated := \
%generated%

$(generated): make.in ../make_tex.sh | $(OUTDIR)
	target=$@; name=$${target%.tex}; name=$${name##*/}; ../make_tex.sh $$name $@

sources := \
%sources%

%sources_dep%

$(OUTDIR)/inshi.sty: ../inshi.sty | $(OUTDIR)
$(OUTDIR)/underlinedtext.sty: ../underlinedtext.sty | $(OUTDIR)

$(sources) $(OUTDIR)/inshi.sty $(OUTDIR)/underlinedtext.sty:
	$(COPY) $< $@

common_deps := $(OUTDIR)/inshi.sty $(OUTDIR)/underlinedtext.sty

%rules%
