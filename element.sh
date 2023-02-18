#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else 
  # find if element type is a number (ID) or string (name or symbol)
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    QUERY_CONDITIONAL="atomic_number=$1"
  else
    QUERY_CONDITIONAL="symbol='$1' OR name ILIKE '$1'"
  fi
  # query database to find element in argument
  ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $QUERY_CONDITIONAL;")

  # if found print it
  if [[ ! -z $ELEMENT ]] 
  then
    echo "$ELEMENT" | while read ELEMENT_TYPE_ID BAR ELEMENT_ATOMIC_NUMBER BAR ELEMENT_SYMBOL BAR ELEMENT_NAME BAR ELEMENT_ATOMIC_MASS BAR ELEMENT_MELTING_POINT_CELSIUS BAR ELEMENT_BOILING_POINT_CELSIUS BAR ELEMENT_TYPE
      do 
        echo -e "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT_CELSIUS celsius and a boiling point of $ELEMENT_BOILING_POINT_CELSIUS celsius."
      done
  else
    echo "I could not find that element in the database."
  fi
fi
