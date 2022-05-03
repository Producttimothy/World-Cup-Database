#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

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

# rename cost_rica # US bc otherwise split at " " --> fix later!!!
echo $($PSQL "UPDATE help SET winner='Costa_Rica' WHERE winner='Costa Rica'")
echo $($PSQL "UPDATE help SET opponent='Costa_Rica' WHERE opponent='Costa Rica'")
echo $($PSQL "UPDATE help SET opponent='United_States' WHERE opponent ='United States'")


#UNION winner and opponent and keep unique (UNION drops duplicate entries during the merge. UNION ALL keeps duplicate entries.)

TEAM=$($PSQL "SELECT winner FROM help UNION SELECT opponent FROM help as name ORDER BY winner")
for name in $TEAM
do
  INSERT_TEAM_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$name')")
  if [[ $INSERT_TEAM_NAME == "INSERT 0 1" ]]
  then
      echo Inserted into teams, $name
  fi
done

# rename cost_rica # US back
echo $($PSQL "UPDATE teams SET name='Costa Rica' WHERE name='Costa_Rica'")
echo $($PSQL "UPDATE teams SET name='United States' WHERE name='United_States'")

# insert data into games
INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$WINNER_GOALS', '$OPPONENT_GOALS')")

# get data from csv (name for help name): 
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
# insert data
  INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$WINNER_GOALS', '$OPPONENT_GOALS')")

done