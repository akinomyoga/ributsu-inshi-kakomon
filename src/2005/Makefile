# -*- Makefile -*-

.PHONY: all
all: target_files

#-------------------------------------------------------------------------------
target_files:=$(target_files) 2005math.pdf 2005math.ps.gz

2005math_files:=2005math.tex 2005mathC.tex 2005mathQ1.tex 2005mathQ1.tex 2005mathA.tex
2005math.dvi: $(2005math_files)
	platex 2005math.tex
	platex 2005math.tex

2005math.pdf: 2005math.dvi
	dvipdfmx $<

2005math.ps.gz: 2005math.dvi
	dvipsk -f $< | gzip -9 > $@
#-------------------------------------------------------------------------------
target_files:=$(target_files) 2005phys.pdf 2005phys.ps.gz

2005phys_files:=2005phys.tex 2005physC.tex
2005phys_files:=$(2005phys_files) 2005physA1.tex 2005physQ1.tex 2005phys1_1.eps 2005phys1_2.eps 2005phys1_3.eps
2005phys_files:=$(2005phys_files) 2005physA2.tex 2005physQ2.tex
2005phys_files:=$(2005phys_files) 2005physA3.tex 2005physQ3.tex
2005phys_files:=$(2005phys_files) 2005physA4.tex 2005physQ4.tex 2005phys4_1.eps
2005phys_files:=$(2005phys_files) 2005physA5.tex 2005physQ5.tex 2005phys5_1.eps
2005phys_files:=$(2005phys_files) 2005physA6.tex 2005physQ6.tex 2005phys6_1.eps

2005phys.dvi: $(2005phys_files)
	platex $<
	platex $<
2005phys.pdf: 2005phys.dvi
	dvipdfmx $<
2005phys.ps.gz: 2005phys.dvi
	dvipsk -f $< | gzip -9 > $@
#-------------------------------------------------------------------------------

.PHONY: target_files
target_files: $(target_files)
