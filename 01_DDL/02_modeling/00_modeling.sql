use test;
/*
    1. 요구 사항
    마이페이지에서 회원 프로필을 구현하고 싶습니다.
    회원당 프로필을 여러 개 설정할 수 있고,
    대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.

    2. 개념 모델링
    user              profile             mypage
    ---------------------------------------------------
    번호              번호                 번호
    ---------------------------------------------------
    아이디             대표 이미지          프로필 번호
    비밀번호           회원 번호
    이름
    주소
    생일


    3. 논리 모델링
    user              profile             mypage
    ---------------------------------------------------
    번호PK             번호PK              번호PK
    ---------------------------------------------------
    아이디U,NN         대표 이미지NN        프로필 번호FK
    비밀번호NN          회원 번호FK
    이름NN
    주소NN
    생일date

    4. 물리 모델링
    tbl_user
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    user_id: varchar(255) unique not null
    password: varchar(255) not null
    name: varchar(255) not null
    address: varchar(255) not null
    brith: date

    tbl_profile
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    file_path: varchar(255) not null
    user(id) bigint

    tbl_page
    --------------------------------------------------
    id: bigint primary key
    --------------------------------------------------
    profile(id) bigint



    5. 구현

*/

/*
tbl_user 테이블 생성
    id 컬럼을 primary key로 두고 자료형 bigint으로 설정,
    user_id부터 addres의 자료형은 varchar로 두고 null이 없도록 설정,
    user_id 컬럼은 중복이 불가하여 unique로 설정,
    birth는 날짜 자료형인 date로 설정
*/
create table tbl_user(
    id bigint primary key,
    user_id varchar(255) unique not null,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    brith date
);

/*
tbl_file 테이블 생성
    id 컬럼을 primary key로 두고 자료형 bigint으로 설정,
    file_path 컬럼은 자료형 varchar을 두고 디폴트 값을 '/upload/'로 설정,
    file_name 컬럼은 자료형 varchar,
    is_main 컬럼은 자료형 varchar을 두고 디폴트 값을 'ELSE'로 설정,
    user_id 컬럼은 자료형 bigint을 두기,
    user_id 컬럼은 tbl_user의 pk인 id 컬럼을 연결하여 fk로 가져온 것이며,
    해당 제약조건의 이름은 fk_file_user이다.
*/
create table tbl_file(
    id bigint primary key,
    file_path varchar(255) default '/upload/',
    file_name varchar(255),
    is_main varchar(255) default 'ELSE',
    user_id bigint,
    constraint fk_file_user foreign key(user_id)
                        references tbl_user(id)
);

drop table tbl_file;
drop table tbl_user;

/*
    요구사항

    학사 관리 시스템에 학생과 교수, 과목을 관리합니다.
    학생은 학번, 이름, 전공 학년이 필요하고
    교수는 교수 번호, 이름, 전공, 직위가 필요합니다.
    과목은 고유한 과목 번호와 과목명, 학점이 필요합니다.
    학생은 여러 과목을 수강할 수 있으며,
    교수는 여러 과목을 강의할 수 있습니다.
    학생이 수강한 과목은 성적이 모두 기록됩니다.

    2. 개념 모델링
    student             professor               subject             student_subject             lecture
    ----------------------------------------------------------------------------------------------------
    학번                 사번                    과목코드              수강번호                     강의번호
    ----------------------------------------------------------------------------------------------------
    이름                 이름                    과목명                학점                        사번
    전공                 전공                    성적                  수강상태                    과목코드
    학년                 직위                    학번
                                                과목코드
                                                사번

    3. 논리 모델링
    student             professor               subject             student_subject             lecture
    --------------------------------------------------------------------------------------------------------------------
    학번PK               사번PK                  과목코드PK            수강번호PK                   강의번호PK
    --------------------------------------------------------------------------------------------------------------------
    이름var, NN          이름var, NN             과목명var, NN         학점var, N                  사번bigint, NN
    전공var, NN          전공var, NN             성적int, D=0          수강상태var, D='수강중'      과목코드bigint, NN
    학년int, D=1         직위var, NN             학번bigint, NN
                                                과목코드bigint, NN
                                                사번bigint, NN

    4. 물리 모델링
    tbl_student
    --------------------------------------------------
    id: bigint auto_increment primary key
    --------------------------------------------------
    name: varchar(255) not null
    major: varchar(255) not null
    grade: int default 1

    tbl_professor
    --------------------------------------------------
    id: bigint auto_increment primary key
    --------------------------------------------------
    name: varchar(255) not null
    major: varchar(255) not null
    position: varchar(255) not null

    tbl_subject
    --------------------------------------------------
    id: bigint auto_increment primary key
    --------------------------------------------------
    name: varchar(255) not null
    score: int default 0

    tbl_student_subject
    --------------------------------------------------
    id: bigint auto_increment primary key
    --------------------------------------------------
    grand: varchar(255) null
    status: varchar(255) default '수강중'
    student_id: bigint not null
    subject_id: bigint not null
    professor_id: bigint not null

    tbl_lecture
    --------------------------------------------------
    id: bigint auto_increment primary key
    --------------------------------------------------
    professor_id: bigint not null
    subject_id: bigint not null

    5. 구현

*/
/*
tbl_student 테이블 생성
    id 컬럼을 primary key로 두고 자료형 bigint으로 설정하는데 auto_increment을 사용해 숫자를 하나씩 증가,
    name 컬럼의 자료형은 varchar로 두고 null이 없도록 설정,
    major 컬럼의 자료형은 varchar로 두고 null이 없도록 설정,
    grade 컬럼의 자료형은 int로 두고 디폴트 값을 1로 설정
*/
create table tbl_student(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    major varchar(255) not null,
    grade int default 1
);

create table tbl_professor(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    major varchar(255) not null,
    position varchar(255) not null
);

create table tbl_subject(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    score int default 0
);

create table tbl_student_subject(
    id bigint auto_increment primary key,
    grand varchar(255) null,
    status varchar(255) default '수강중',
    student_id bigint not null,
    subject_id bigint not null,
    professor_id bigint not null,
    constraint check_status check (status in('수강중' , '수강완료')),
    constraint fk_student_subject_student foreign key(student_id)
                                references tbl_student(id),
    constraint fk_student_subject_subject foreign key(subject_id)
                                references tbl_subject(id),
    constraint fk_student_subject_professor foreign key(professor_id)
                                references tbl_professor(id)
);

create table tbl_lecture(
    id bigint auto_increment primary key,
    professor_id bigint not null,
    subject_id bigint not null,
    constraint fk_lecture_professor foreign key(professor_id)
                        references tbl_professor(id),
    constraint fk_lecture_subject foreign key(subject_id)
                        references tbl_subject(id)
);

drop table tbl_lecture;
drop table tbl_student_subject;
drop table tbl_subject;
drop table tbl_professor;
drop table tbl_student;


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