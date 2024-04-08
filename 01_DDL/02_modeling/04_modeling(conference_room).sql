/*
    요구 사항

    회의실 예약 서비스를 제작하고 싶습니다.
    회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
    회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.

    2. 개념 모델링
    회원                 사무실             회의실
    --------------------------------------------------
    번호                 번호               번호
    --------------------------------------------------
    아이디                부서명             사무실 번호
    비밀번호                                 회원
    이름                                    이용가능 시간
    주소
    등급

    3. 논리 모델링
    회원                 사무실             회의실              예약 테이블
    --------------------------------------------------
    번호PK               번호PK             번호PK
    --------------------------------------------------
    아이디NN              부서명NN           사무실 번호FK, NN
    비밀번호NN                               회원 FK, NN
    이름NN                                  이용가능 시간 d=current_timestamp
    주소NN
    등급NN

    4. 물리 모델링
    tbl_user
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    user_id: varchar(255) not null
    password: varchar(255) not null
    name: varchar(255) not null
    address: varchar(255) not null
    grade: varchar(255) not null

    tbl_office
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    part_name: varchar(255) not null

    tbl_meeting_room
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    time: datetime default current_timestamp
    user(id): bigint not null
    office(id): bigint not null

    5. 구현
*/

create table tbl_user(
    id varchar(255) primary key,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date,
    level varchar(255) default '기본',
    constraint check_level check ( level in ('기본', '단골') )
);

create table tbl_office(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    location varchar(255) not null
);

create table tbl_conference_room(
    id bigint auto_increment primary key,
    office_id bigint not null,
    constraint fk_conference_room_office foreign key(office_id)
                                references tbl_office(id)
);

create table tbl_part_time(
    id bigint auto_increment primary key,
    time time not null,
    conference_room_id bigint not null,
    constraint fk_part_time_conference_room foreign key(conference_room_id)
                                references tbl_conference_room(id)
);

create table tbl_reservation(
    id bigint auto_increment primary key,
    time time not null,
    created_date datetime default (current_timestamp),
    user_id varchar(255) not null,
    conference_room_id bigint not null,
    constraint fk_reservation_user foreign key (user_id)
                            references tbl_user(id),
    constraint fk_reservation_conference_room foreign key (conference_room_id)
                            references tbl_conference_room(id)
);


drop table tbl_reservation;
drop table tbl_part_time;
drop table tbl_conference_room;
drop table tbl_office;
drop table tbl_user;