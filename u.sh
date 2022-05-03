#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# TRUNCATE TABLE command deletes the data inside a table, but not the table itself

# TRUNCATE TABLE command deletes the data inside a table, but not the table itself
echo $($PSQL "TRUNCATE help, teams, games")

# get data from csv (name for help name): 
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  # insert data
  INSERT_HELP_RESULT=$($PSQL "INSERT INTO help(year, round, winner, opponent, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$WINNER', '$OPPONENT', '$WINNER_GOALS', '$OPPONENT_GOALS')")
  if [[ $INSERT_HELP_RESULT == "INSERT 0 1" ]]
  then
      echo Inserted into help, $YEAR, $ROUND, $WINNER, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS
  fi
done


TEAM="$($PSQL "SELECT winner FROM help UNION SELECT opponent FROM help as name")"
while IFS=" " read TEAM
do
  INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM')") 
done
