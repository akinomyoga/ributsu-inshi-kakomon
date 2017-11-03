#!/bin/sh

###########################################################
#
#   renfiles : rename name of some files 
#   ver 1.3
# 
#   2006.12.03 MIURA Koichi
#
#   NOTE : This script works correctly only on bash. 
###########################################################


## initialize variables
 mode_i=false # interactive mode option
 mode_I=false # redundunt interactive mode option


###########################################################
#
#   Sub routines
#
#    show_usage : show usage of this script
#    parse_args : parsing arguments
#    show_conversion : show the conversion of file names 
#    change_name : change namas of the files indeed
#
###########################################################

#function show_usage
show_usage ()
{
     echo "Usage: renfiles [-iIe] from_patrn to_pattern files..." 
     echo " options"
     echo "   -i : interactive mode"
     echo "   -I : redundunt interactive mode"
     echo "   -e : replace everything "
     return
}



#function parse_args
parse_args ()
{
    ## option解析
     while getopts "iIe" opt
       do
       case $opt in
 	  i)
 	  ## interactive mode
 	      mode_i=true;;

 	  I)
 	  ## redundunt interactive mode
 	      mode_I=true;;

 	  e)
 	  ## set "g" option for sed command
 	      exact="g";;

 	  *)
 	      show_usage
 	      exit 1;;
       esac
     done
    shift $(($OPTIND-1))


    ## pattern部分だけ取り出す
    from_ptrn=$1
    to_ptrn=$2
    shift 2

    for f in "$@"
      do
      files[$i]="$f"
      i=$((i+1))
    done

    ## ファイルの指定があったかどうかをチェックする

    if [ $# -eq 0 ]
	then
	echo "input files..."
	echo ""
	show_usage
	exit 1
    fi

    return
}


#functions show_conversion
show_conversion ()
{
    ## interactive mode (-i or -I option)
    for ((fno=0; fno < ${#files[@]}; fno++))
      do
      file=${files[$fno]}
      res=${resfiles[$fno]}

      if [ $res = $file ]
	  then
	  echo "renfiles: the name \"$res\" stay unchanged."
      else
	  echo "$file -> $res"

	  if [ $mode_I = true ] 	# redundunt interactive mode 
	      then
	      echo "rename OK? y/n"
	      read ans
	      case $ans in
		  y)
		      echo "CHANGE!"
		      mv $file $res;;
		  n)
		      echo "Nothing is done.";;
		  *)
		      echo "Nothing is done.";;
	      esac
	  fi
      fi
    done
}

#function change_name
change_name ()
{
     for ((fno=0; fno < ${#files[@]}; fno++))
       do
       mv ${files[$fno]} ${resfiles[$fno]}
     done
}



###########################################################
#
#   main routine
#
###########################################################

## argument check
if [ $# -lt 2 ]
then
    show_usage
    exit 1
fi

## parsing arguments
parse_args "$@"

## get CHANGED file names as an array
for ((fno=0; fno < ${#files[@]}; fno++))
do
    file=${files[$fno]}

    if [ -f $file ]
    then
	resfiles[$fno]=`ls $file | sed s/$from_ptrn/$to_ptrn/$exact`
    else
	echo "$file: No such file"
    fi
done


## change names of the files 
if [ $mode_i = true -o $mode_I = true ] 
    then  
    show_conversion

    if [ $mode_I = true ]
	then ## already changed.
	exit
    else ## interactive mode
	echo "OK? (y/n)"
	read ans
	case $ans in
	    y)
		echo "CHANGE!"
		change_name;;
	    n)
		echo "Nothing is done";;
	    *)
		echo "Nothing is done";;
	esac
    fi

else
    ## normal mode
    change_name
fi

