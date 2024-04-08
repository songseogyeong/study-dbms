/* tbl_field_trip 테이블 생성 */
create table tbl_field_trip(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    count tinyint default 0
);

/* tbl_field_trip 테이블 데이터 추가 */
insert into tbl_field_trip (title, content, count)
values ('어서와 매미농장', '매미 잡자 어서와', 20);
insert into tbl_field_trip (title, content, count)
values ('아이스크림 빨리 먹기 대회', '아이스크림 누가 더 잘먹나', 100);
insert into tbl_field_trip (title, content, count)
values ('고구마 심기', '고구마가 왕 커요', 10);
insert into tbl_field_trip (title, content, count)
values ('숭어 얼음 낚시', '숭어 잡자 추워도 참아', 80);
insert into tbl_field_trip (title, content, count)
values ('커피 체험 공장', '커비 빈 객체화', 60);
insert into tbl_field_trip (title, content, count)
values ('치즈 제작하기', '여기 치즈 저기 치즈 전부 다 치즈', 5);
insert into tbl_field_trip (title, content, count)
values ('동물 타보기', '이리야!', 9);


/*
    집계 함수

    평균 avg()
    최대값 max()
    최소값 min()
    총 합 sum()
    개수 count()
*/

/* tbl_field_trip 테이블의 전체 데이터 조회 */
select id, title, content, count from tbl_field_trip;

/* tbl_field_trip 테이블의 count 컬럼의 총 합 조회 */
select sum(count) as total from tbl_field_trip;
select avg(count) as average from tbl_field_trip;
select max(count) as max_count from tbl_field_trip;
select min(count) as min_count from tbl_field_trip;
select round(avg(count), 2) as average from tbl_field_trip;
select count(count) as field_trip_count from tbl_field_trip;