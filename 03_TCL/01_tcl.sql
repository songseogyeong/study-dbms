/* 위 쿼리는 DDL이기 때문에 트랜잭션과 무상관함 */
create table tbl_member(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null
);

/* 트랜젝션은 DML의 것, DDL은 반영이 안 된다. */

insert into tbl_member(name, address)
values('홍길동', '서울시 강남구');

select * from tbl_member;

commit;

select * from tbl_member;

delete from tbl_member
where id = 1;

rollback;