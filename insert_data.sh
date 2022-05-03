#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# TRUNCATE TABLE command deletes the data inside a table, but not the table itself
echo $($PSQL "TRUNCATE TABLE help, teams, games")

# get data from csv (name for help name): 
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  # insert data
  TEAM_DATA=$($PSQL "SELECT name FROM teams WHERE='$WINNER'")
  if [[ $WINNER != 'winner' ]]
  then
    if [[ -z $TEAM_DATA ]]
    then
    INSERT_DATA=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ INSERT_DATA == "INSERT 0 1" ]]
      then 
      echo Insertet data!
      fi
    fi
  fi

  TEAM_OPPO=$($PSQL "SELECT name FROM teams WHERE='$OPPONENT'")
  if [[ $OPPONENT != 'opponent' ]]
  then
    if [[ -z $TEAM_OPPO ]]
    then
    INSERT_DATA_OPPO=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    fi
  fi

  TEAM_ID_WINNER=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  TEAM_ID_OPPONENT=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

  if [[ -n $TEAM_ID_WINNER || -n $TEAM_ID_OPPONENT ]]
  then 
    if [[ $YEAR != "year" ]]
    then 
      INSERT_GAME_DATA=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$TEAM_ID_WINNER', '$TEAM_ID_OPPONENT', '$WINNER_GOALS', '$OPPONENT_GOALS')")
    fi
  fi

done
