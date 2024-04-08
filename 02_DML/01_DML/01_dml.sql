/* tbl_parent 테이블 생성 */
create table tbl_parent(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    age tinyint default 1,
    gender varchar(255) default '선택안함',
    address varchar(255) not null,
    phone varchar(255) not null,
    constraint check_gender check ( gender in ('선택안함', '여자', '남자') )
);

/*
전체를 의미한 *은 직접 컬럼을 작성한 것보다 더 많은 연산이 필요하기 때문에
대량의 데이터 조회 시 사용을 지양 한다.

select * from tbl_parent;
*/


/* tbl_parent 테이블의 id, name, age, gender, address, phone 컬럼을 조회 */
select id, name, age, gender, address, phone
from tbl_parent;


/* tbl_parent 테이블 데이터 추가
    (name, age, address, phone) 컬럼에 ('한동석', 20, '경기도 남양주', '01012341234') 값 추가
    id의 경우에는 자동 증가함으로 따로 작성하지 않아도 되고, gender도 디폴트 값 사용 시 작성하지 않아도 된다. */
insert into tbl_parent
(name, age, address, phone)
values ('한동석', 20, '경기도 남양주', '01012341234');


/* tbl_parent 테이블 업데이트(수정)
    age 컬럼의 값을 40으로 변경하는데,
    id 컬럼의 값이 1인 데이터의 값을 변경*/
update tbl_parent
set age = 40
where id = 1;


/* tbl_parent 테이블의 전체 데이터 삭제 */
delete from tbl_parent;


/* tbl_parent 테이블의 데이터 삭제하는데,
    id 컬럼의 값이 1인 데이터만 삭제 */
delete from tbl_parent
where id = 1;


/* 학부모 정보 추가 */
insert into tbl_parent
(name, age, gender, address, phone)
values ('또치', 5, '여자', '경기도 남양주', '01012341234');

insert into tbl_parent
(name, age, gender, address, phone)
values ('둘리', 51, '여자', '서울시 강남구', '01055556666');

insert into tbl_parent
(name, age, gender, address, phone)
values ('마이콜', 55, '남자', '경기도 광주', '0108888999');


/* 전체 테이블 조회 */
select id, name, age, gender, address, phone from tbl_parent;


/* 부모 중, 나이가 51세 이상인 부모의 이름 조회 */
select name, age from tbl_parent
where age >= 51;


/* 경기도 남양주에 살고 있는 부모의 핸드폰 번호 조회 */
select phone, address from tbl_parent
where address = '경기도 남양주';


/* 성별이 남자인 학부모를 선택안함으로 변경 */
update tbl_parent
set gender = '선택안함'
where gender = '남자';


/* 전체 테이블 조회 */
select id, name, age, gender, address, phone from tbl_parent;


/* 성별이 선택안함인 학부모를 모두 삭제 */
delete from tbl_parent
where gender = '선택안함';


/* 전체 테이블 조회 */
select id, name, age, gender, address, phone from tbl_parent;


/*
    실행 순서
    1. from
    2. where
    3. group by
    4. having
    5. select
    6. order by
*/