select * from tbl_field_trip
where id in (
    select ft.id from tbl_apply a
    right outer join tbl_field_trip ft
    on a.field_trip_id = ft.id
    group by ft.id
    having count(child_id) < (
    select floor(avg(ac.apply_count)) from (
        select field_trip_id, count(child_id) apply_count from tbl_apply
        group by field_trip_id) ac)
);

create view view_target_field_trip as (
    select * from tbl_field_trip
where id in (
    select ft.id from tbl_apply a
    right outer join tbl_field_trip ft
    on a.field_trip_id = ft.id
    group by ft.id
    having count(child_id) < (
    select floor(avg(ac.apply_count)) from (
        select field_trip_id, count(child_id) apply_count from tbl_apply
        group by field_trip_id) ac)
    )
);

select * from view_target_field_trip;