#!/bin/bash

# this shell script takes one search argument and queries existing *helper.md files and returns matches

# tell the user how many arguments they passed in 
#
NUMBER_OF_PARAMS="${#}"
echo "you supplied ${NUMBER_OF_PARAMS} arguments on the command line."
if [[ "${NUMBER_OF_PARAMS}" -lt 1 ]]
then
  echo "usage: ${0} searchtext"
  exit 1
fi

# define parameter and pipe query result to bat for easy reading
GREEN="\033[0;32m"
STD="\033[0m"

SEARCH="${1}"
DIR="/Users/oli/.config"

for FILE in "${DIR}"/*Helper.md; do
    if [ -e "${FILE}" ]; then
        echo -e "\n${GREEN}*** Search: ${FILE}${STD}"
        grep -nh --color=always ${SEARCH} "${FILE}" | awk -F '|' 'NF>2 {printf "%-5s %-40s %-40s\n", $1, $2, $3}'
    else
        echo "no file found"
    fi
done
