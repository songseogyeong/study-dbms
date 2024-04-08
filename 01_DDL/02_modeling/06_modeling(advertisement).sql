/*
    요구사항

    안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
    광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
    광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
    기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.

    2. 개념 모델링
    기업                  광고              대카테고리           중카테고리           소카테고리           기업 종류
    -------------------------------------------------------------------------------------------------------------
    번호PK                번호PK            번호PK              번호PK              번호PK              번호PK
    -------------------------------------------------------------------------------------------------------------
    이름                  제목              이름                 이름               이름                기업 종류
    주소                  내용                                  대카테고리PK        소카테고리PK
    대표번호               기업 번호 FK
    기업종류              소카테고리FK

    3. 논리 모델링
    기업                  광고               대카테고리           중카테고리           소카테고리           기업 종류
    -------------------------------------------------------------------------------------------------------------
    번호PK                번호PK             번호PK              번호PK              번호PK              번호PK
    -------------------------------------------------------------------------------------------------------------
    이름NN                 제목NN            이름NN               이름NN              이름NN              기업 종류NN
    주소NN                 내용NN                                대카테고리PK, NN      소카테고리PK, NN
    대표번호NN              기업 번호FK, NN
    기업종류FK, NN          소카테고리FK, NN

    4. 물리 모델링
    tbl_business_category
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    type: varchar(255) not null

    tbl_client
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null
    number: varchar(255) not null
    category(id): bigint not null

    tbl_main
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null

    tbl_middle
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null
    main(id): bigint not null

    tbl_sub
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null
    middle(id): bigint not null

    tbl_commercial
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    title: varchar(255) not null
    content: varchar(255) not null
    client(id): bigint not null
    sub(id): bigint not null

    5. 구현
*/
create table tbl_company_type(
    id bigint auto_increment primary key,
    type varchar(255)
);

create table tbl_company(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    company_type_id bigint,
    constraint fk_company_company_type foreign key (company_type_id)
                        references tbl_company_type(id)
);

create table tbl_ad_category_A(
    id bigint auto_increment primary key,
    name varchar(255) not null
);

create table tbl_ad_category_B(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    ad_category_A_id bigint not null,
    constraint fk_ad_category_B_ad_category_A foreign key (ad_category_A_id)
                           references tbl_ad_category_A(id)
);

create table tbl_ad_category_C(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    ad_category_B_id bigint not null,
    constraint fk_ad_category_C_ad_category_B foreign key (ad_category_B_id)
                           references tbl_ad_category_B(id)
);


create table tbl_advertisement(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    ad_category_C_id bigint not null,
    constraint fk_advertisement_ad_category_C foreign key (ad_category_C_id)
                           references tbl_ad_category_C(id)
);

create table tbl_ad_apply(
    id bigint auto_increment primary key,
    company_id bigint not null,
    advertisement_id bigint not null,
    created_date datetime default current_timestamp,
    updated_date datetime default current_timestamp on update current_timestamp,
    constraint fk_apply_company foreign key (company_id)
                           references tbl_company(id),
    constraint fk_apply_advertisement foreign key (advertisement_id)
                           references tbl_advertisement(id)
);

drop table tbl_ad_apply;
drop table tbl_advertisement;
drop table tbl_ad_category_C;
drop table tbl_ad_category_B;
drop table tbl_ad_category_A;
drop table tbl_company;
drop table tbl_company_type;