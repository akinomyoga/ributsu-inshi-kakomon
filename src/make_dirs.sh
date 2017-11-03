#!/bin/bash

function init-make.in {
  local year="$1"
  local fmin="$2"
  if test ! -s "$fmin"; then
    cat <<EOF > "$fmin"
#!/bin/bash
# -*- coding:utf-8 -*-

docs=(${year}math)
_${year}math_title='${year}年度実施 数学'
_${year}math_cov=() #(${year}mathC.tex)
_${year}math_prb=() #(${year}mathQ1.tex ${year}mathQ2.tex)
_${year}math_ans=() #(${year}mathA1.tex ${year}mathA2.tex)
_${year}math_dep=()

EOF
  fi
}

function generate-Makefile {
  if test -s "$fmak" -a -s "$fmin" -a "$fmak" -nt "$fmin" -a "$fmak" -nt "$0"; then
    echo "$fmak: up to date" >&2
    return
  fi

  cat <<EOF > "$fmak"
# -*- mode: makefile-gmake -*-

include ../common.mk

all: 
.PHONY: all clean
clean:
	-rm -rf *.aux *.toc *.log *.dvi *.te_

Makefile: make.in ../make_dirs.sh
	cd .. && ./make_dirs.sh "$year"

EOF

  init-make.in "$year" "$fmin"
  source "$fmin"

  local doc
  for doc in "${docs[@]}" "${docs_ex[@]}"; do
    eval "local deps=\"\${_${doc}_cov[@]} \${_${doc}_prb[@]} \${_${doc}_ans[@]} \${_${doc}_dep[@]}\""
    cat <<EOF >> "$fmak"
all: ${doc}.pdf ${doc}.ps.gz
${doc}.pdf: ${doc}.dvi
	\$(DVIPDF) \$<
${doc}.ps.gz: ${doc}.ps
	gzip -c \$< > \$@
${doc}.ps: ${doc}.dvi
	\$(DVIPS) \$<
${doc}.dvi: ${doc}.te_ ${deps}
	\$(LATEX) \$<
	\$(LATEX) \$<
	\$(LATEX) \$<
${doc}.te_: ../make_tex.sh make.in
	../make_tex.sh ${doc} \$@

EOF
  done
}

function create_subdir {
  local year="${1%/}"
  test -d "$year" || mkdir -p "$year"

  local fmak="$year/Makefile"
  local fmin="$year/make.in"
  generate-Makefile
}

if test $# -gt 0; then
  create_subdir "$1"
else
  source make_dirs.in
  for d in "${inshi_subdir[@]}"; do
    create_subdir "$d"
  done
fi

