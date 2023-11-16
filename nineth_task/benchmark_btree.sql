begin;

    drop table if exists btree_table;
    drop index if exists idx_content_btree;

    create table btree_table(
        id integer,
        content varchar
    );


    insert into btree_table
    select number, concat('Content ', number)
    from generate_series(1, 100000) number;


    create index idx_content_btree on btree_table(content);

    SELECT *
    FROM btree_table
    WHERE content LIKE '%nt 3%';

end;