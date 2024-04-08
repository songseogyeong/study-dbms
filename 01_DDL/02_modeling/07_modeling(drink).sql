/*
    요구사항

    음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다.
    음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
    당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.

    2. 개념 모델링
    음료수            당첨자            상품            배송
    ------------------------------------------------------------------
    당첨번호           번호             번호            번호
    ------------------------------------------------------------------
    이름               이름             이름            상태
                      나이             당첨번호         상품
                      주소                            당첨자
                      번호
                      당첨번호

    3. 논리 모델링
    음료수            당첨자            상품            배송
    ------------------------------------------------------------------
    당첨번호PK         번호PK           번호PK          번호PK
    ------------------------------------------------------------------
    이름NN             이름NN           이름NN          상태NN
                      나이NN           당첨번호FK, NN   상품FK, NN
                      주소NN                           당첨자FK, NN
                      번호NN
                      당첨번호FK, NN

    4. 물리 모델링
    tbl_drink
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null

    tbl_winner
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null
    age: int not null
    address: varchar(255) not null
    phone: varchar(255) not null
    drink(id): bigint not null

    tbl_prize
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    id: bigint primary key
    name: varchar(255) not null
    drink(id): bigint not null

    tbl_delivery
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    state: varchar(255) not null
    winner(id): bigint not null
    prize(id): bigint not null

    5. 구현
*/

create table tbl_member(
    id varchar(255) primary key,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_soft_drink(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    price int default 0
);

create table tbl_product(
    id bigint auto_increment primary key,
    name varchar(255) not null
);

create table tbl_lottery(
    id bigint auto_increment primary key,
    number varchar(255) not null,
    product_id bigint,
    constraint fk_lottery_product foreign key (product_id)
                        references tbl_product(id)
);

create table tbl_circulation(
    id bigint auto_increment primary key,
    soft_drink_id bigint not null,
    lottery_id bigint not null,
    constraint fk_circulation_soft_drink foreign key (soft_drink_id)
                            references tbl_soft_drink(id),
    constraint fk_circulation_lottery foreign key (lottery_id)
                            references tbl_lottery(id)
);

create table tbl_delivery(
    id bigint auto_increment primary key,
    status varchar(255),
    member_id varchar(255) not null,
    product_id bigint not null,
    constraint check_delivery_status check ( status in ('상품준비중', '배송중', '배송완료') ),
    constraint fk_delivery_member foreign key (member_id)
                         references tbl_member(id),
    constraint fk_delivery_product foreign key (product_id)
                         references tbl_product(id)
);


drop table tbl_delivery;
drop table tbl_circulation;
drop table tbl_lottery;
drop table tbl_product;
drop table tbl_soft_drink;
drop table tbl_member;