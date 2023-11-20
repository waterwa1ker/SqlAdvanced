begin;

    drop table if exists example_table;
    drop function if exists find_by_id(_id int);

    create table example_table(
        id int,
        name varchar
    );

    create function find_by_id(_id int)
    returns varchar
    language plpgsql
    as
    $$
    declare content varchar;
    begin
        select name
        into content
        from example_table
        where id = _id;
        return content;
    end;
    $$;

    insert into example_table
    select number, concat('User ', number)
    from generate_series(1, 100) number;

    select find_by_id(20);

end;