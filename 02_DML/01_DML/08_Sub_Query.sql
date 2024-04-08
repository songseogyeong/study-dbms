/* tbl_order 테이블을 생성 */
create table tbl_order(
    id bigint auto_increment primary key,
    name varchar(255),
    price int default 0
);

/*
    서브쿼리(Sub Query)
    서브쿼리는 쿼리 안에 쿼리를 작성하는 것
    서브쿼리 사용 시 where절에서 집계함수 사용 가능

    from절: in line view
    select절: scalar
    where절: sub query
*/

/* 상품별 가격 총 합과 전체 상품의 총 합 조회 */
select name, sum(price) total, (select sum(price) from tbl_order)
from tbl_order
group by name;

/* 상품 중 "우"가 들어간 상품별 총 합 조회 */
select o.name, sum(o.price) from
(
    select name, price
    from tbl_order
    where name like '%우%'
) o
group by o.name;


/* 상품의 평균 가격이 1000원 이하의 상품의 개별 가격 조회 */
select id, name, price from tbl_order
where name in
      (select name
       from tbl_order
       group by name
       having avg(price) <= 1000
);