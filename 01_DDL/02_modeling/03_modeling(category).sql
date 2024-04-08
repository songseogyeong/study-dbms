/*
    요구사항

    대카테고리, 소카테고리가 필요해요.

    2. 개념 모델링
    대카테고리           소카테고리
    --------------------------------------------------
    번호                번호
    --------------------------------------------------
    이름                 이름
                        대카테고리

    3. 논리 모델링
    대카테고리           소카테고리
    --------------------------------------------------
    번호PK              번호PK
    --------------------------------------------------
    이름NN               이름NN
                        대카테고리FK, NN

    4. 물리 모델링
    tbl_category_A
    --------------------------------------------------
    id: bigint auto_increment primary key
    --------------------------------------------------
    name: varchar(255) not null

    tbl_category_B
    --------------------------------------------------
    id: bigint auto_increment primary key
    --------------------------------------------------
    name: varchar(255) not null,
    category_A_id: bigint not null

    5. 구현
*/

create table tbl_category_A(
    id bigint auto_increment primary key,
    name varchar(255) not null
);

create table tbl_category_B(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    category_A_id bigint not null,
    constraint fk_category_B_category_A foreign key(category_A_id)
                             references tbl_category_A(id)
);

drop table tbl_category_B;
drop table tbl_category_A;