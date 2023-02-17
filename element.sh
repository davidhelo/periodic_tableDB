#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else 
  # query database to find element in argument
  ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number=$1 OR symbol='$1' OR name ILIKE '$1';")

  # if found print it
  if [[ ! -z $ELEMENT ]] 
  then
    echo "$ELEMENT" | while read ELEMENT_ATOMIC_NUMBER BAR ELEMENT_SYMBOL BAR ELEMENT_NAME BAR ELEMENT_TYPE BAR ELEMENT_ATOMIC_MASS BAR ELEMENT_MELTING_POINT_CELSIUS BAR ELEMENT_BOILING_POINT_CELSIUS BAR ELEMENT_TYPE_ID
      do 
        echo -e "\nThe element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT_CELSIUS celsius and a boiling point of $ELEMENT_BOILING_POINT_CELSIUS celsius."
      done
  else
    echo -e "\nI could not find that element in the database."
  fi
  
  
fi
