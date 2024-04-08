create table tbl_field_trip(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    count tinyint default 0
);

/*
    order by: 정렬

    order by [컬럼명] asc: 오름차순, asc 생략 가능
    order by [컬럼명] desc: 내림차순
*/

/* count 컬럼을 오름차순으로 정렬(오름차순은 asc 생략 가능) */
select id, title, content, count from tbl_field_trip
order by count;

/* count 컬럼을 내림차순으로 정렬 */
select id, title, content, count from tbl_field_trip
order by count desc;