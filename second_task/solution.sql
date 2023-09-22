drop table if exists first_table, second_table, third_table, fourth_table;

create table if not exists first_table(
    first_column int,
    second_column varchar(100)
) with (fillfactor = 50);

create table if not exists second_table(
    first_column int,
    second_column varchar(100)
) with (fillfactor = 75);

create table if not exists third_table(
    first_column int,
    second_column varchar(100)
) with (fillfactor = 90);

create table if not exists fourth_table(
    first_column int,
    second_column varchar(100)
) with (fillfactor = 100);

insert into first_table values (generate_series(1, 10000), repeat('A', 50));
insert into second_table values (generate_series(1, 10000), repeat('B', 50));
insert into third_table values (generate_series(1, 10000), repeat('C', 50));
insert into fourth_table values (generate_series(1, 10000), repeat('D', 50));

EXPLAIN ANALYZE update first_table set second_column = concat(second_column, second_column)
where first_column > 0;
EXPLAIN ANALYZE update second_table set second_column = concat(second_column, second_column)
where first_column > 0;
EXPLAIN ANALYZE update third_table set second_column = concat(second_column, second_column)
where first_column > 0;
EXPLAIN ANALYZE update fourth_table set second_column = concat(second_column, second_column)
where first_column > 0;

SELECT nspname || '.' || relname AS "relation",
    pg_size_pretty(pg_relation_size(C.oid)) AS "size"
  FROM pg_class C
  LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
  WHERE nspname NOT IN ('pg_catalog', 'information_schema')
  ORDER BY pg_relation_size(C.oid) DESC;