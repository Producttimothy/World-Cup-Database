#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
# Do not change code above this line. Use the PSQL variable above to query your database.

# TRUNCATE TABLE command deletes the data inside a table, but not the table itself

echo $($PSQL "TRUNCATE teams, games")

echo $($PSQL "UPDATE help SET winner='Costa_Rica' WHERE winner='Costa Rica'")
# echo $($PSQL "SELECT winner FROM help UNION SELECT opponent FROM help AS new_name ORDER BY winner")

echo $($PSQL "UNION winner, opponent INTO new5 FROM help GROUP BY winner")



INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);
