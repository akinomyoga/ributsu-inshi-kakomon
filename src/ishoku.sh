#!/bin/bash

function extract {
  local file="$1" name hoge
  name="${file##*/}"
  name="${name%.tex}"

  nkf -w "$file" | gawk '
    BEGIN{
      name="'"$name"'"
      _q="'\''"
    }
    /\\def\\exam\{([^}]+)\}/{
      match($0,/\\def\\exam\{([^}]+)\}/,capt);
      exam=capt[1];
    }
    /\chapter\{([0-9]+)\}/{
      match($0,/\chapter\{([0-9]+)\}/,capt);
      year=capt[1];
    }
    /\\inputquestion\{[^}]+\}/{
      match($0,/\\inputquestion\{([^}]+)\}/,capt);
      prb=prb " " capt[1];
    }
    /\\inputquestion\{[^}]+\}/{
      match($0,/\\inputquestion\{([^}]+)\}/,capt);
      ans=ans " " capt[1];
    }
    END{
      if(exam!=""){
        sub(/^ /,"",ans);
        sub(/^ /,"",prb);
        sub(/（/," (",exam);sub(/）/,")",exam);
        print "_" name "_title=" _q year "年度実施 " exam _q 
        print "_" name "_cov=()"
        print "_" name "_prb=(" prb ")"
        print "_" name "_ans=(" ans ")"
        print "_" name "_dep=()"
        print ""
      }
    }
  '
}

function extract_eps {
  local name="$1"
  local file="$2"
  sed '
    s/{/\n{/g
    s/}/}\n/g
  ' "$file" | gawk '
    BEGIN{
      name="'"$name"'"
    }
    /\{(.*\.eps)\}/{
      match($0,/\{(.*\.eps)\}/,capt);
      dep=dep " " capt[1];
    }
    END{
      sub(/^ /,"",dep);
      print "_" name "_prb=(" dep ")"
    }
  '
}

# year="$1"
# cp -p ../sources/src/$year/* $year/
# for tex in $year/*.tex; do
#   extract "$tex"
# done
# ( cd $year && ls -1 *.eps *.tpc)

# extract_eps "$1" "$2"
