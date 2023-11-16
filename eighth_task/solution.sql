begin;

    drop table if exists index_table;
    drop index if exists idx_A, idx_B, idx_C, idx_A_B, idx_A_C, idx_B_C, idx_A_B_C;

    create table index_table(
        A integer,
        B integer,
        C integer
    );

    insert into index_table
    select random() * number, random() * number, random() * number
    from generate_series(1, 1000) number;

    create index idx_A on index_table(A);
    create index idx_B on index_table(B);
    create index idx_C on index_table(C);
    create index idx_A_B on index_table(A, B);
    create index idx_A_C on index_table(A, C);
    create index idx_B_C on index_table(B, C);
    create index idx_A_B_C on index_table(A, B, C);

    explain
    SELECT min(A) OVER(PARTITION BY B,C ORDER BY B,C)
        FROM index_table
     WHERE A = A
     ORDER BY C,B;

    select relid         as r,
           indexrelid    as i,
           schemaname    as s,
           relname       as r2,
           indexrelname  as i2,
           idx_scan      as is2,
           idx_tup_read  as itr,
           idx_tup_fetch as itf
    from pg_stat_user_indexes;

end;