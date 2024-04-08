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

/* tbl_parent 테이블 데이터 추가 */
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
    like
        포함된 문자열 값을 찾을 때 사용한다.

    예시)
    '%A': A로 끝나는 모든 값(SFDSA, FDSFDSA, ...)
    'A%': A로 시작하는 모든 값(ABD, Apple, ...)
    '%A%': A가 포함된 모든 값(Java, FFFAF, ...)
*/

/* tbl_parent 테이블에서 남양이 포함된 모든 값 조회 */
select id, name, age, gender, address, phone from tbl_parent
where address like '%남양%';

/* tbl_parent 테이블에서 경으로 시작하는 모든 값 조회 */
select id, name, age, gender, address, phone from tbl_parent
where address like '경%';

/* tbl_parent 테이블에서 경으로 끝나는 모든 값 조회 */
select id, name, age, gender, address, phone from tbl_parent
where address like '%경';

/* 핸드폰 번호에 5가 들어간 학부모 정보 전체 조회*/
select id, name, age, gender, address, phone from tbl_parent
where phone like '%5%';

/* 주소에 서울이 들어간 학부모 전체 조회 */
select id, name, age, gender, address, phone from tbl_parent
where address like '%서울%';