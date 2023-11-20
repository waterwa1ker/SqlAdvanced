--create sql-advanced database to execute this script
sudo pgbench -d sql-advanced -f sql_function.sql -c 10 -T 100
sudo pgbench -d sql-advanced -f pgsql_function.sql -c 10 -T 100
