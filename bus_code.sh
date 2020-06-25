#!/bin/bash

password_file="$HOME/Notebooks/org/bus_empire.org"

#------------ Check inputs --------------------
if [[ $# -eq 0 ]]; then
	echo 'No input given. Exit'
	exit 1
fi

if [[ -z $1 ]]; then
	echo 'Needs page number'
	exit 1
fi

if [[ -z $2 ]]; then
	echo 'Needs line number'
	exit 1
fi

# get page lines
page_num=$1
line_num=$2
echo 'page =' $page_num'; line =' $line_num

if [[ $page_num -lt 2 ]] || [[ $page_num -gt 46 ]]; then
	echo 'Page number in range [2, 45].'
	exit 1
fi

if [[ $line_num < 1 ]] || [[ $line_num > 40 ]]; then
	echo 'Line number in range [1, 40].'
	exit 1
fi

#---- get line number for given page num --------
page_line=$(grep -n "^|[[:space:]]*${page_num}\b" $password_file | cut -d: -f 1)

#---- get code ----------------------------------
code=$(sed -n "$page_line,+40p" $password_file | grep "^|.*|[[:space:]]*${line_num}\b" | cut -d '|' -f 4 | xargs)
echo 'code =' $code


