--create database sql-advanced to run this script
sudo pgbench -T 100 -c 10 -d sql-advanced -f benchmark_gin.sql
sudo pgbench -T 100 -c 10 -d sql-advanced -f benchmark_gist.sql
sudo pgbench -T 100 -c 10 -d sql-advanced -f benchmark_btree.sql
