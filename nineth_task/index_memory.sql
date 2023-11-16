begin;

    drop table if exists gin_table, gist_table, btree_table;
    drop index if exists idx_content_btree, idx_content_gin, idx_content_gist;

    create table gin_table(
        id integer,
        content varchar
    );

    create table btree_table(
        id integer,
        content varchar
    );

    create table gist_table(
        id integer,
        content varchar
    );

    insert into gin_table
    select number, concat('Content ', number)
    from generate_series(1, 100000) number;

    insert into btree_table
    select number, concat('Content ', number)
    from generate_series(1, 100000) number;

    insert into gist_table
    select number, concat('Content ', number)
    from generate_series(1, 100000) number;

    create index idx_content_gin on gin_table using gin(content gin_trgm_ops);

    create index idx_content_btree on btree_table(content);

    create index idx_content_gist on gist_table using gist(content gist_trgm_ops);

    select pg_indexes_size('gin_table'), pg_indexes_size('gist_table'), pg_indexes_size('btree_table');

end;