/*
    실행 순서
    1. from
    2. join
    3. on
    4. where
    5. group by
    6. having
    7. select
    8. order by
*/

create table tbl_user(
    id bigint auto_increment primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_post(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    create_date datetime default current_timestamp,
    user_id bigint not null,
    constraint fk_post_user foreign key(user_id)
                     references tbl_user(id)
);

create table tbl_reply(
    id bigint auto_increment primary key,
    content varchar(255) not null,
    user_id bigint not null,
    post_id bigint not null,
    constraint fk_reply_user foreign key(user_id)
                     references tbl_user(id),
    constraint fk_reply_post foreign key(post_id)
                     references tbl_post(id)
);



insert into tbl_user (user_id, password, name, address, email, birth)
values ('hds1234', '1234', '한동석', '경기도', 'test1234@gmail.com', '2000-12-04');

insert into tbl_user (user_id, password, name, address, email, birth)
values ('hgd3333', '3333', '홍길동', '서울', 'hgd1234@gmail.com', '1920-11-25');

select * from tbl_user;


insert into tbl_post (title, content, user_id)
values ('테스트 제목1', '테스트 내용1', 1);

insert into tbl_post (title, content, user_id)
values ('테스트 제목2', '테스트 내용2', 2);

insert into tbl_post (title, content, user_id)
values ('테스트 제목3', '테스트 내용3', 1);

insert into tbl_post (title, content, user_id)
values ('테스트 제목4', '테스트 내용4', 1);

select * from tbl_post;

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 2, 1);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 2, 2);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 2', 1, 1);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 2', 2, 1);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 1, 2);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 1, 2);

select * from tbl_reply;

/*3이 포함된 게시글 제목을 조회한 뒤 작성자 전체 정보 조회*/
select u.* from tbl_user u join tbl_post p
on p.title like '%3%' and u.id = p.user_id;

/*게시글 내용이 "테스트 내용4"의 작성자가 작성한 댓글 전체 정보 조회*/
select * from tbl_post p join tbl_reply r
on p.content = '테스트 내용4' and p.user_id = r.user_id;

/*게시글 별 댓글 개수*/
select p.id, p.title, p.content, count(r.id)
from tbl_post p join tbl_reply r
on p.id = r.post_id
group by p.id, p.title, p.content;

/*회원 중 gmail을 사용하는 회원이 작성한 게시글 정보 중 제목 조회*/
select p.title from tbl_user u join tbl_post p
on u.email like '%gmail%' and u.id = p.user_id;

/*회원 중 "서울"거주자가 작성한 댓글 조회 */
select * from tbl_user u join tbl_reply r
on u.address like '%서울%' and u.id = r.user_id;

/*댓글 중 같은 게시글에 작성된 댓글 내용 조회*/
select p.id, r.content from tbl_post p join tbl_reply r
on p.id = r.post_id
group by p.id, r.content;

/*댓글 개수가 3개 이상인 게시글 전체 내용 조회 및 회원 이름 조회*/
select p.*, u.name from tbl_user u join tbl_post p
on p.id in (select post_id
               from tbl_reply
               group by post_id
               having count(id) >= 3) and u.id = p.user_id;

/*게시글 전체정보와 회원의 이메일 조회*/
select p.*, u.email from tbl_user u join tbl_post p
on u.id = p.user_id;

/*댓글 작성자 중 게시글을 등록한 회원*/
select distinct u.* from tbl_user u join tbl_post p
on p.user_id in
(select user_id from tbl_reply) and p.user_id = u.id;

/*댓글 작성자 중 게시글을 2번 이상 작성한 회원의 게시글 제목과 게시글 내용 조회*/
select title, content from tbl_post
where user_id in (
    select user_id from tbl_post
    where user_id in (select user_id
                      from tbl_reply
                      group by user_id)
    group by user_id
    having count(id) >= 2);

select p.title, p.content from tbl_post p join
(select user_id from tbl_post
    where user_id in (select user_id
                      from tbl_reply
                      group by user_id)
    group by user_id
    having count(id) >= 2) u
on p.user_id = u.user_id;

/*게시글 작성자 중 댓글을 2번 이상 작성한 회원의 정보와 작성한 댓글의 전체 정보 조회*/
select * from tbl_user u join tbl_reply r
on u.id in
(
    select r.user_id from tbl_reply r
    where r.user_id in
    (select user_id from tbl_post)
    group by r.user_id
    having count(r.id) >= 2
) and u.id = r.user_id;

/*체험학습*/
create table tbl_parent(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    age tinyint default 1,
    gender varchar(255) not null,
    address varchar(255) not null,
    phone varchar(255) not null,
    constraint check_gender check ( gender in ('선택안함', '여자', '남자') )
);

create table tbl_child(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    age tinyint default 1,
    gender varchar(255) not null,
    parent_id bigint not null,
    constraint check_child_gender check ( gender in ('선택안함', '여자', '남자') ),
    constraint fk_child_parent foreign key (parent_id)
                      references tbl_parent(id)
);

create table tbl_field_trip(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    count tinyint default 0
);

create table tbl_file(
    /* 슈퍼키 */
    id bigint auto_increment primary key,
    file_path varchar(255) not null,
    file_name varchar(255) not null
);

create table tbl_field_trip_file(
    /* 서브키 */
    id bigint primary key,
    field_trip_id bigint not null,
    constraint fk_field_trip_file_file foreign key (id)
    references tbl_file(id),
    constraint fk_field_trip_file_field_trip foreign key (field_trip_id)
    references tbl_field_trip(id)
);

create table tbl_apply(
    id bigint auto_increment primary key,
    child_id bigint not null,
    field_trip_id bigint not null,
    constraint fk_apply_child foreign key (child_id)
    references tbl_child(id),
    constraint fk_apply_field_trip foreign key (field_trip_id)
    references tbl_field_trip(id)
);

/* tbl_field_trip 테이블 데이터 삽입 */
insert into tbl_field_trip (title, content, count)
values ('매미 잡기 체험학습', '매미 잡으러 떠나자!', 5);
insert into tbl_field_trip (title, content, count)
values ('메뚜기 때려 잡기 체험학습', '메뚜기 다 잡자!', 50);
insert into tbl_field_trip (title, content, count)
values ('물놀이 체험학습', '한강 수영장으로 퐁당!', 20);
insert into tbl_field_trip (title, content, count)
values ('블루베리 채집 체험학습', '맛있어 블루베리 냠냠!', 25);
insert into tbl_field_trip (title, content, count)
values ('코딩 체험학습', '나도 빌게이츠!', 20);
/* tbl_field_trip 테이블 전체 데이터 조회 */
select * from tbl_field_trip;

/* tbl_parent 테이블 데이터 삽입 */
insert into tbl_parent (name, age, address, phone, gender)
values ('한동석', '40', '경기도 남양주', '01012341234', '남자');
insert into tbl_parent (name, age, address, phone, gender)
values ('홍길동', '50', '서울시 강남구', '01055556666', '여자');
insert into tbl_parent (name, age, address, phone, gender)
values ('이순신', '55', '서울시 강남구', '01077778888', '여자');
/* tbl_parent 테이블 전체 데이터 조회 */
select * from tbl_parent;

/* tbl_child 테이블 데이터 삽입 */
insert into tbl_child (name, age, gender, parent_id)
values ('김철수', 4, '남자', 1);
insert into tbl_child (name, age, gender, parent_id)
values ('김훈이', 5, '남자', 2);
insert into tbl_child (name, age, gender, parent_id)
values ('이유리', 7, '여자', 1);
insert into tbl_child (name, age, gender, parent_id)
values ('김사자', 4, '남자', 3);
insert into tbl_child (name, age, gender, parent_id)
values ('김영희', 4, '여자', 3);
/* tbl_child 테이블 전체 데이터 조회 */
select * from tbl_child;

/* tbl_apply 테이블 데이터 삽입 */
insert into tbl_apply (child_id, field_trip_id)
values (1, 1);
insert into tbl_apply (child_id, field_trip_id)
values (2, 1);
insert into tbl_apply (child_id, field_trip_id)
values (3, 2);
insert into tbl_apply (child_id, field_trip_id)
values (4, 3);
insert into tbl_apply (child_id, field_trip_id)
values (4, 5);
insert into tbl_apply (child_id, field_trip_id)
values (5, 5);
insert into tbl_apply (child_id, field_trip_id)
values (5, 4);
insert into tbl_apply (child_id, field_trip_id)
values (5, 4);
insert into tbl_apply (child_id, field_trip_id)
values (5, 4);
insert into tbl_apply (child_id, field_trip_id)
values (5, 3);
/* tbl_apply 테이블 전체 데이터 조회 */
select * from tbl_apply;



/*매미 체험학습에 신청한 아이의 전체 정보*/
/*1. 서브쿼리만 사용*/
/* 매미 현장 체험 학습 먼저 조회 */
/* tbl_field_trip 테이블 속 title 컬럼에서 매미 잡기 체험학습이 포함된 데이터 조회하기 */
select * from tbl_field_trip
where title like '%매미 잡기 체험학습%';

/* tbl_apply 테이블에서 child_id와 field_trip_id 대조 */
/* tbl_apply의 field_trip_id와 tbl_field_trip 테이블의 id를 대조, title 컬럼에서 매미 잡기 체험학습을 가는 child_id를 조회*/
select child_id from tbl_apply
where field_trip_id in
(
    select id from tbl_field_trip
    where title like '%매미 잡기 체험학습%'
);

/* tbl_child 테이블에서 아이들 전체 정보 가져오기*/
/* tbl_child 테이블의 id와 tbl_apply 테이블의 child_id를 대조하여 전체 데이터 조회 */
select * from tbl_child
where id in
(
    select child_id from tbl_apply
    where field_trip_id in
        (
            select id from tbl_field_trip
            where title like '%매미 잡기 체험학습%'
        )
);



/*2. join만 사용*/
/* tbl_apply의 field_trip_id와 tbl_field_trip 테이블의 id를 대조, title 컬럼에서 매미 잡기 체험학습을 가는 child_id를 조회 */
select child_id from tbl_apply a join tbl_field_trip f
on a.field_trip_id = f.id and f.title like '%매미 잡기 체험학습%';

/* tbl_child 테이블의 id와 tbl_apply 테이블의 child_id를 대조하여 전체 데이터 조회 */
select * from tbl_child c
where c.id in
(
    select child_id from tbl_apply a join tbl_field_trip f
        on a.field_trip_id = f.id and f.title like '%매미 잡기 체험학습%'
);



/* 3번 */
/*체험학습을 2개 이상 신청한 아이의 정보와 부모의 정보 모두 조회*/
/* 체험학습을 신청한 아이 별 id 조회*/
select child_id from tbl_apply
group by child_id

/* 체험학습을 2개 이상 신청한 아이별 id */
select child_id from tbl_apply
where child_id in (
    select child_id from tbl_apply
    group by child_id)
group by child_id
having count(child_id) >=2;

/* 대조한 id를 통한 아이 정보 및 부모 정보 조회*/
select * from tbl_child c join tbl_parent p
on c.parent_id = p.id and c.id in (
    select child_id from tbl_apply
    where child_id in (
        select child_id from tbl_apply
        group by child_id)
    group by child_id
    having count(child_id) >=2);


/* 4번 */
/* 참가자(지원자) 수가 가장 적은 체험학습의 제목과 내용 조회 */
/* 체험학습 별 참가자 수 조회 */
select count(child_id) from tbl_apply
group by field_trip_id;

/* 참가자 수가 가장 적은 체험학습 */
select min(child_id) from tbl_apply
where child_id in (select count(child_id) from tbl_apply
group by field_trip_id);

/* 제목과 내용 조회 */
select title, content from tbl_field_trip
where id in (
    select field_trip_id from tbl_apply
    where field_trip_id in (
        select min(child_id) from tbl_apply
        where child_id in (select count(child_id) from tbl_apply
        group by field_trip_id)
        )
    group by field_trip_id);



/*게시글 작성자 중 댓글을 2번 이상 작성한 회원의 정보와 작성한 댓글의 전체 정보 조회*/
select * from tbl_user u join tbl_reply r
on u.id in
(
    select r.user_id from tbl_reply r
    where r.user_id in
    (select user_id from tbl_post)
    group by r.user_id
    having count(r.id) >= 2
) and u.id = r.user_id;

/*평균 참가자(지원자) 수보다 적은 체험학습의 제목과 내용 조회*/
/* 평균 참가자 수 */
select f.title, f.content from tbl_field_trip f join tbl_apply a
on a.field_trip_id = f.id and a.field_trip_id in (
    select field_trip_id, count(child_id) from tbl_apply
    group by field_trip_id
    having count(child_id) < avg(child_id)
);