
#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# TRUNCATE TABLE command deletes the data inside a table, but not the table itself



TEAM=$($PSQL "SELECT winner FROM help UNION SELECT opponent FROM help as name")

for i in $TEAM
do 
  echo $i
done




for name in $TEAM
do
  INSERT_TEAM_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$name')")
  if [[ $INSERT_TEAM_NAME == "INSERT 0 1" ]]
  then
      echo Inserted into teams, $name
  fi
done