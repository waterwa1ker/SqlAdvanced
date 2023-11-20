begin;

    drop table if exists example_table;
    drop function if exists find_by_id(_id integer);

    create table example_table(
        id integer,
        name varchar
    );

    create or replace function find_by_id(_id integer)
    returns varchar as
    $$
        select name from example_table
        where id = _id;
    $$ language sql;

    insert into example_table
    select number, concat('User ', number)
    from generate_series(1, 100) number;

    select find_by_id(20);

end;