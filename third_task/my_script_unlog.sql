begin;

    drop table if exists unlog;

    create unlogged table unlog(
        id bigint primary key ,
        name varchar
    );

    insert into unlog
    select number, concat('Unlog ', number)
    from generate_series(1, 100000) number;

end;

