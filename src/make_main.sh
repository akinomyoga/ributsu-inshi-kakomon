#!/bin/bash

function enumerate-years {
  source make_dirs.in
  # echo "${inshi_subdir[@]}"

  local iy
  for((iy=${#inshi_subdir[@]}-1;iy>=0;iy--)); do
    echo "${inshi_subdir[$iy]}"
  done
}

function include-questions {
  local years year kamoku file
  years=($(enumerate-years))
  for year in "${years[@]}"; do
    source "$year/make.in"
    for kamoku in "${docs[@]}"; do
      eval "local title=\"\${_${kamoku}_title}\""
      eval "local cov=(\"\${_${kamoku}_cov[@]}\")"
      eval "local prb=(\"\${_${kamoku}_prb[@]}\")"
      eval "local ans=(\"\${_${kamoku}_ans[@]}\")"

      echo '\inshikamoku'"{$kamoku}{$title}"
      echo '{'
      echo '  \inshirebase{../'"$year"'}'
      for file in "${cov[@]}"; do
        echo '  \input'"{${file%.tex}}"
      done
      for file in "${prb[@]}"; do
        echo '  \inputquestion'"{${file%.tex}}"
      done
      echo '}'
      echo
    done
  done
}

function include-answers {
  local years year kamoku file
  years=($(enumerate-years))
  for year in "${years[@]}"; do
    source "$year/make.in"
    for kamoku in "${docs[@]}"; do
      eval "local title=\"\${_${kamoku}_title}\""
      eval "local cov=(\"\${_${kamoku}_cov[@]}\")"
      eval "local prb=(\"\${_${kamoku}_prb[@]}\")"
      eval "local ans=(\"\${_${kamoku}_ans[@]}\")"
      test ${#ans[@]} -eq 0 && continue

      echo '\inshikamoku'"{$kamoku}{$title}"
      echo '{'
      echo '  \inshirebase{../'"$year"'}'
      for file in "${ans[@]}"; do
        echo '  \inputanswer{'"${file%.tex}"'}'
      done
      echo '}'
      echo
    done
  done
}

fout=main/main-content.te_

{
  echo '%% -*- mode:latex;coding:sjis -*-'
  echo
  include-questions
  include-answers
} | iconv -c -f utf-8 -t cp932 > "$fout"
