#!/bin/bash
export LANG=en_US.UTF-8
if [ "$1" = "" ]
  then
  dir=$PWD
  parameter="." 
  else 
  dir="$1"
  parameter=$1
fi

echo "$parameter"

files=0
dirs=0




search() {
    local dir=$1
	local parent=$2
	
	local list=($dir/*)
	
	local len_list="${#list[@]}"
	
        for each in "${!list[@]}"
	do
		
		local parent_add=$'\u2502\u00A0\u00A0\u0020'
		local child=$'\u251c\u2500\u2500\u0020'
		
		local name=${list[$each]}
		name=${name##*/}
			
		if [ $each -eq $((len_list-1)) ]
		then
			child=$'\u2514\u2500\u2500\u0020'
			parent_add=$'\u0020\u0020\u0020\u0020'
		fi
		
		echo "$parent$child$name"
		
		if [ -d "$dir/$name" ]
		then 
			dirs=$((dirs+1))
			search "$dir/$name" "$parent$parent_add"
		else
			files=$((files+1))
		fi
	done
}
search "${dir}" 
echo
f="file"
ff="files"
d="directory"
dd="directories"
te=$dd
xt=$ff

echo "$dirs $te, $files $xt"

