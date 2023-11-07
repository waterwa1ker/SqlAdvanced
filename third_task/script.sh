echo "RESULTS FOR LOGGED TABLE (100_000 records)"
sudo pgbench -T 300 -c 1 -f my_script_log.sql sql-advanced | grep -e tps -e latency

echo "\nRESULTS FOR UNLOGGED TABLE (100_000 records)"
sudo pgbench -T 300 -c 1 -f my_script_unlog.sql sql-advanced | grep -e tps -e latency
