begin;
    drop table if exists log;

    create table log(
        id bigint primary key ,
        name varchar
    );

    insert into log
    select number, concat('User ', number)
    from generate_series(1, 100000) number;

end;