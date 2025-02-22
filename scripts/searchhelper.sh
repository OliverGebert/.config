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

SEARCH="${1}"

grep -nH --color=always ${SEARCH} ~/.config/*Helper.md
