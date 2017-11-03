#!/bin/bash

function init-make.in {
  local year=$1
  local fmin=$2
  if [[ ! -s $fmin ]]; then
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
  if [[ -s $fmak && -s $fmin && $fmak -nt $fmin && $fmak -nt $0 ]]; then
    echo "$fmak: up to date" >&2
    return
  fi

  init-make.in "$year" "$fmin"
  source "$fmin"

  local doc rules=
  local -a src_all=() tex_files=()
  for doc in "${docs[@]}" "${docs_ex[@]}"; do
    eval "local -a deps=(\"\${_${doc}_cov[@]}\" \"\${_${doc}_prb[@]}\" \"\${_${doc}_ans[@]}\" \"\${_${doc}_dep[@]}\")"
    local pdf='$(OUTDIR)'/$doc.pdf
    local dvi='$(OUTDIR)'/$doc.dvi
    local tex='$(OUTDIR)'/$doc.tex
    printf -v dep_files ' $(OUTDIR)/%s' "${deps[@]}"

    src_all+=("${deps[@]}")
    tex_files+=("$tex")
    rules+="
all: $pdf
$pdf: $dvi
	cd \$(OUTDIR) && \$(DVIPDF) ${dvi##*/}
$dvi: $tex $dep_files \$(common_deps)
	cd \$(OUTDIR) && \$(LATEX) ${tex##*/} && \$(LATEX) ${tex##*/} && \$(LATEX) ${tex##*/}
"
  done

  sources=$(printf '  $(OUTDIR)/%s \\\n' "${src_all[@]}" | sort -u)
  sources=${sources%' \'}
  export sources

  sources_dep=$(for src in "${src_all[@]}"; do printf '$(OUTDIR)/%s: %s | $(OUTDIR)\n' "$src" "$src"; done | sort -u)
  sources_dep=${sources_dep%' \'}
  export sources_dep

  printf -v generated '  %s \\\n' "${tex_files[@]}"
  generated=${generated%$' \\\n'}
  export generated

  export rules
  export year
  awk '
    /^%sources%$/ {print ENVIRON["sources"]; next;}
    /^%sources_dep%$/ {print ENVIRON["sources_dep"]; next;}
    /^%generated%$/ {print ENVIRON["generated"]; next;}
    /^%rules%$/ {print ENVIRON["rules"]; next;}
    {
      gsub(/%year%/, ENVIRON["year"]);
      print
    }
  ' make_dirs.mk > "$fmak"
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

