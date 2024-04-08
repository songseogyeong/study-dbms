/*
    요구사항

    이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
    기업의 정보는 기업 이름, 주소, 대표번호가 있고
    사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
    상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
    사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.

    2. 개념 모델링
    사용자             기업            카드             상품               결제
    -----------------------------------------------------------------------------------------
    번호              번호            번호              번호               번호
    -----------------------------------------------------------------------------------------
    이름              이름           사용자 번호         이름               사용자 번호
    주소              주소           카드번호            가격               기업 번호
    전화번호           대표번호        카드사             재고               카드번호
                                                      기업번호            상품

    3. 논리 모델링
    사용자             기업            카드              상품                결제
    -----------------------------------------------------------------------------------------
    번호PK            번호PK          번호PK             번호PK             번호PK
    -----------------------------------------------------------------------------------------
    이름NN            이름NN          사용자 번호FK, NN   이름NN             사용자 번호FK, NN
    주소NN            주소NN          카드번호NN          가격NN             기업 번호 FK, NN
    전화번호NN         대표번호NN       카드사NN           재고d=0            카드번호 FK, NN
                                                       기업번호FK, NN      상품 FK, NN

    4. 물리 모델링
    tbl_company
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null
    address: varchar(255) not null
    phone: varchar(255) not null

    tbl_product
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    name: varchar(255) not null
    price: varchar(255) not null
    stock: int default 0
    company(id): bigint not null

    tbl_e_user
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    id: bigint primary key
    name: varchar(255) not null
    address: varchar(255) not null
    phone: varchar(255) not null

    tbl_card
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    card_company: varchar(255) not null
    card_number: varchar(255) not null
    user(id): bigint not null

    tbl_payment
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    user(id): bigint not null
    card(id): bigint not null
    company(id): bigint not null
    product(id): bigint not null

    5. 구현
*/
create table tbl_corporation(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    tel varchar(255) not null
);

create table tbl_client(
    id varchar(255) primary key,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_card(
    id bigint auto_increment primary key,
    number varchar(255) not null,
    company varchar(255) not null,
    client_id varchar(255) not null,
    constraint fk_card_client foreign key (client_id)
                     references tbl_client(id)
);

create table tbl_item(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    price int default 0,
    stock int default 0,
    corporation_id bigint not null,
    constraint fk_item_corporation foreign key (corporation_id)
                     references tbl_corporation(id)
);

create table tbl_sequence(
    id bigint auto_increment primary key,
    sequence bigint default 0
);

create table tbl_order(
    id bigint,
    created_date date default (current_date),
    primary key (id, created_date)
);

create table tbl_order_item(
    id bigint auto_increment primary key,
    order_id bigint,
    order_created_date date,
    item_id bigint,
    count int default 0,
    constraint fk_order_item_order foreign key (order_id, order_created_date)
                              references tbl_order(id, created_date),
    constraint fk_order_item_product foreign key (item_id)
                              references tbl_item(id)
);

create table tbl_pay(
    id bigint auto_increment primary key,
    order_id bigint,
    order_created_date date,
    card_id bigint,
    constraint fk_pay_order foreign key (order_id, order_created_date)
                              references tbl_order(id, created_date),
    constraint fk_pay_card foreign key (card_id)
                    references tbl_card(id)
);


drop table tbl_pay;
drop table tbl_order_item;
drop table tbl_order;
drop table tbl_sequence;
drop table tbl_item;
drop table tbl_card;
drop table tbl_client;
drop table tbl_corporation;