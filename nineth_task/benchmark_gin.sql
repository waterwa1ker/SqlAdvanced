begin;
    
    drop table if exists gin_table;
    drop index if exists idx_content_gin;

    create table gin_table(
        id integer,
        content varchar
    );

    insert into gin_table
    select number, concat('Content ', number)
    from generate_series(1, 100000) number;


    create index idx_content_gin on gin_table using gin(content gin_trgm_ops);

    SELECT *
    FROM gin_table
    WHERE content LIKE '%nt 3%';

end;