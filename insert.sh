#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# TRUNCATE TABLE command deletes the data inside a table, but not the table itself
# echo $($PSQL "TRUNCATE year, round, winner, opponent, winner_goals, opponent_goals")

# get data from csv (name for teams name): 
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  if [[ $YEAR != "year" ]]
  then
    # get help_id
    HELP_ID=$($PSQL "SELECT help_id FROM help WHERE year='$YEAR'")
    fi

    # if not found
    if [[ -z $HELP_ID ]]
    then
      # set to null
      HELP_ID=null
    fi

    # insert data
    INSERT_HELP_RESULT=$($PSQL "INSERT INTO help(year, round, winner, opponent, winner_goals, opponent_goals) VALUES($YEAR, $ROUND, $WINNER, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS)")
    if [[ $INSERT_HELP_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into help, $YEAR, $ROUND, $WINNER, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS
    fi

done





#UNION winner and opponent and keep unique (UNION drops duplicate entries during the merge. UNION ALL keeps duplicate entries.)
TEAM_NAME=$($PSQL "SELECT winner FROM help UNION SELECT opponent FROM help ORDER BY winner")

#Insert TEAM NAME in teams

INSERT_TEAM_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM_NAME')")
  if [[ $INSERT_TEAM_NAME == "INSERT 0 1" ]]
  then
      echo Inserted into temas, $TEAM_NAME
  fi