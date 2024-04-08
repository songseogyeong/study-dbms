show databases;
use test;

create table tbl_member(
  member_name varchar(255),
  member_age int
);

show tables;

drop table tbl_member;

/*
    자동차 테이블 생성
    1. 자동차 번호
    2. 자동차 브랜드
    3. 출시 날짜
    4. 색상
    5. 가격
*/

create table tbl_car(
    number bigint primary key,
    brand varchar(255),
    release_date date,
    color varchar(255),
    price int
);

show tables;

drop table tbl_car;

/*
    동물 테이블 생성
    1. 번호
    2. 종류
    3. 먹이
*/

create table tbl_animal(
    number bigint primary key,
    type varchar(255) not null unique,
    feed varchar(255)
);

show tables;

drop table tbl_animal;


