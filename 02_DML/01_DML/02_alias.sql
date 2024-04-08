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

/* tbl_parent 테이블 데이터 추가*/
insert into tbl_parent
(name, age, gender, address, phone)
values ('또치', 5, '여자', '경기도 남양주', '01012341234');
insert into tbl_parent
(name, age, gender, address, phone)
values ('둘리', 51, '여자', '서울시 강남구', '01055556666');
insert into tbl_parent
(name, age, gender, address, phone)
values ('마이콜', 55, '남자', '경기도 광주', '0108888999');


/*
    as(Alias): 별칭
*/


/* tbl_parent 테이블의 컬럼 값을 조회하는데,
   name 컬럼에 이름이라는 별칭을 두고 조회한다 */
select id, name as 이름, age, gender, address, phone from tbl_parent;


/* as는 생략이 가능하며, 한 칸 띄어 별칭을 작성한다 */
select id, name 이름, age, gender, address, phone from tbl_parent;