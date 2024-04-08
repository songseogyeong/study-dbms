/*
    요구사항

    유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
    아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
    체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
    아이들은 여러 번 체험학습에 등록할 수 있어요.

    2. 개념 모델링
    아이들             학부모             체험학습            이벤트 이미지
    -------------------------------------------------------------------------
    번호               번호              번호                번호
    -------------------------------------------------------------------------
    이름               이름              제목                파일이름
    나이               나이              체험학습 내용        이미지 경로
    성별               주소              아이들 번호          체험학습번호
    학부모번호          전화번호
                      성별

    3. 논리 모델링
    아이들             학부모             체험학습            이벤트 이미지
    -------------------------------------------------------------------------
    번호PK             번호PK            번호PK              번호PK
    -------------------------------------------------------------------------
    이름NN             이름NN            제목NN              파일이름NN
    나이NN             나이NN            체험학습 내용NN      이미지 경로d='/upload/'
    성별NN             주소NN            아이들 번호FK, NN    체험학습번호FK, NN
    학부모번호FK, NN    전화번호NN
                      성별NN

    4. 물리 모델링
    tbl_parent
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null
    age: varchar(255) not null
    address: varchar(255) not null
    phone: varchar(255) not null
    gender: varchar(255) not null

    tbl_children
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null
    age: varchar(255) not null
    gender: varchar(255) not null
    parent(id): bigint not null

    tbl_field_trip
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    title: varchar(255) not null
    content: varchar(255) not null
    children(id): bigint not null

    tbl_image
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    file_name: varchar(255) not null
    file_path: varchar(255) default '/upload/'
    trip(id): bigint not null

    5. 구현
*/
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

drop table tbl_apply;
drop table tbl_field_trip_file;
drop table tbl_file;
drop table tbl_field_trip;
drop table tbl_child;
drop table tbl_parent;