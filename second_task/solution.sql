create table first_table(
    first_column int,
    second_column varchar(100)
) with (fillfactor = 50);

create table second_table(
    first_column int,
    second_column varchar(100)
) with (fillfactor = 75);

create table third_table(
    first_column int,
    second_column varchar(100)
) with (fillfactor = 90);

create table fourth_table(
    first_column int,
    second_column varchar(100)
) with (fillfactor = 100);

insert into first_table values (generate_series(1, 10000), repeat('A', 50));
insert into second_table values (generate_series(1, 10000), repeat('B', 50));
insert into third_table values (generate_series(1, 10000), repeat('C', 50));
insert into fourth_table values (generate_series(1, 10000), repeat('D', 50));

update first_table set (second_column = concat(second_column, second_column))
where first_column > 0;