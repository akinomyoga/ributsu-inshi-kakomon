#!/bin/bash

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
\documentclass{article}
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

make_tex "$1" "$2"
