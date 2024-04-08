/* tbl_order 테이블을 생성 */
create table tbl_order(
    id bigint auto_increment primary key,
    name varchar(255),
    price int default 0
);

/*
    group by:  ~별

    group by [컬럼명]
    having [조건식]
*/

/* tbl_order 테이블 데이터 추가 */
insert into tbl_order (name, price)
values ('지우개', 3000);

insert into tbl_order (name, price)
values ('마우스', 5000);

insert into tbl_order (name, price)
values ('지우개', 3000);

insert into tbl_order (name, price)
values ('키보드', 15000);

insert into tbl_order (name, price)
values ('키보드', 15000);

insert into tbl_order (name, price)
values ('사과', 2000);

insert into tbl_order (name, price)
values ('사과', 2000);

insert into tbl_order (name, price)
values ('자두', 500);

insert into tbl_order (name, price)
values ('자두', 1000);

/* tbl_order 테이블 전체 조회 */
select id, name, price from tbl_order;

/* group by 사용 시 select 절에 쓴 집계 함수는 그룹핑 된 것들 */
select name, count(name) total from tbl_order
group by name;

/* 주문된 상품별 평균 가격 조회 */
select name, round(avg(price), 0) average from tbl_order
group by name;

/* where절에서는 집계함수를 사용할 수 없다 */
/* 집계 함수를 조건식에 넣고 싶으면 having 사용 */
select name, round(avg(price), 0) average from tbl_order
group by name
having avg(price) >= 5000;