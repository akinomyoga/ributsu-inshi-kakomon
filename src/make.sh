#!/usr/bin/env bash

function make_tex {
  local doc="$1"
  local tex="$2"
  source make.in
  eval "local cov=(\"\${_${doc}_cov[@]}\")"
  eval "local prb=(\"\${_${doc}_prb[@]}\")"
  eval "local ans=(\"\${_${doc}_ans[@]}\")"
  eval "local title=\"\${_${doc}_title}\""

  {
    cat <<EOF
\documentclass{jsarticle}
%% \usepackage[dvipdfm]{graphicx}
\usepackage{inshi}
\allowdisplaybreaks
\begin{document}
\inshikamoku{$doc}{$title}

EOF

    local file
    for file in "${cov[@]}"; do
      echo "\\input{${file%.tex}}"
    done
    for file in "${prb[@]}"; do
      echo "\\inputquestion{${file%.tex}}"
    done
    for file in "${ans[@]}"; do
      echo "\\inputanswer{${file%.tex}}"
    done

    cat <<EOF

\end{document}
EOF
  } > "$tex"
}

function link {
  local src=$1 dst=${1##*/}
  [[ -e $dst ]] ||
    ln -sf "$src" "$dst"
}

function sub:build {
  local name=$1
  if [[ ! $name =~ ^[0-9]{4} ]]; then
    echo "build: invalid document name '$name'" >/dev/tty
    return 2
  fi
  local year=$BASH_REMATCH
  (
    set -e
    mkdir -p "build/$year"
    cd "build/$year"
    for file in ../../"$year"/*; do
      link "$file" "${file##*/}"
    done
    link ../../inshi.sty
    link ../../underlinedtext.sty
    [[ -f ../../$year/$name.tex ]] ||
      make_tex "$name" "$name.tex"
    platex -kanji=utf8 "$name.tex"
    dvipdfmx "$name.dvi"
    mv "$name.pdf" ..
  )
}

function collect_deps {
  deps=()
  local name=$1 suffix
  for suffix in cov prb ans dep; do eval "deps+=(\"\${_${name}_${suffix}[@]}\")"; done
}

function sub:autogen {
  {
    echo 'all:'
    echo 'extra:'
    echo '.PHONY: all extra'
    for y in {19,20}[0-9][0-9]; do
      source "$y/make.in"
      for doc in "${docs[@]}"; do
        collect_deps "$doc"
        echo "all: build/$doc.pdf"
        echo "build/$doc.pdf: ${deps[*]/#/$y/}"
        printf '\t./make.sh build %s\n' "$doc"
      done
      for doc in "${docs_ex[@]}"; do
        collect_deps "$doc"
        echo "extra: build/$doc.pdf"
        echo "build/$doc.pdf: ${deps[*]/#/$y/}"
        printf '\t./make.sh build %s\n' "$doc"
      done
      unset -v docs docs_ex
    done
  } > Makefile
}

sub:"$@"
