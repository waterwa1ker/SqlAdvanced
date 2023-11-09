begin;

    create table example_non_vacuum(
        id integer,
        name varchar
    );

    insert into example_non_vacuum values (1, 'name');

    update example_non_vacuum set name = 'new name'
    where id = 1;

    select pg_size_pretty(pg_table_size('example_non_vacuum'));

    VACUUM FULL example_non_vacuum;

    select pg_size_pretty(pg_table_size('example_non_vacuum'));
end;