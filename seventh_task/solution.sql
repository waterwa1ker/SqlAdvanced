begin;

    drop table if exists complex_table;
    drop function if exists multiplication_complex(first complex, second complex);
    drop function if exists division_complex(first complex, second complex);
    drop function if exists subtraction_complex(first complex, second complex);
    drop aggregate if exists addition(complex);
    drop function if exists addition_complex(first complex, second complex);
    drop type if exists complex;

    create type complex as(
        x float,
        y float
    );

    create or replace function addition_complex(first complex, second complex)
    returns complex as
    $$
        begin
            return row(first.x+second.x, first.y+second.y)::complex;
        end;
        $$ language plpgsql;

    create or replace function multiplication_complex(first complex, second complex)
    returns complex as
        $$
            begin
                return row(first.x*second.x - first.y*second.y, first.x*second.y + first.y*second.x)::complex;
            end;
        $$ language plpgsql;

    create or replace function division_complex(first complex, second complex)
    returns complex as
        $$
            begin
                return row(
                    (first.x*second.x + first.y*second.y)/(second.x*second.x + second.y*second.y),
                    (first.y*second.x - first.x*second.y)/(second.x*second.x + second.y*second.y))::complex;
            end;
        $$ language plpgsql;

    create or replace function subtraction_complex(first complex, second complex)
    returns complex as
        $$
            begin
                return row(first.x-second.x, first.y-second.y)::complex;
            end;
        $$ language plpgsql;

    create aggregate addition(complex)(
        sfunc = addition_complex,
        stype = complex,
        initcond = '(0, 0)'
    );

    create table complex_table(
        complex complex
    );

    insert into complex_table values (row(1, 2));
    insert into complex_table values (row(3, 4));
    insert into complex_table values (subtraction_complex(row(3, 4), row(1, 2)));

    select addition(complex) from complex_table;

    select addition_complex(row(1, 1), row(2, 2));
    select multiplication_complex(row(1, 2), row(3, 4));
    select division_complex(row(5, 10), row(5, -1));
    select subtraction_complex(row(45, 12), row(1, 0));


end;