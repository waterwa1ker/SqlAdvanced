begin;

    drop table if exists gist_table;
    drop index if exists idx_content_gist;

    create table gist_table(
        id integer,
        content varchar
    );

    insert into gist_table
    select number, concat('Content ', number)
    from generate_series(1, 100000) number;

    create index idx_content_gist on gist_table using gist(content gist_trgm_ops);

    SELECT *
    FROM gist_table
    WHERE content LIKE '%nt 3%';

end;