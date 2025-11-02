#!/bin/bash

# this shell script takes two arguments and passes them to cht.sh for query

# tell the user how many arguments they passed in 
NUMBER_OF_PARAMS="${#}"
echo "you supplied ${NUMBER_OF_PARAMS} arguments on the command line."
if [[ "${NUMBER_OF_PARAMS}" -lt 2 ]]
then
  echo "usage: ${0} LANGUAGE TOPIC"
  exit 1
fi

# define parameter and pipe query result to bat for easy reading

LANGUAGE="${1}"
TOPIC="${2}"

curlie http://cht.sh/${LANGUAGE}/${TOPIC}
