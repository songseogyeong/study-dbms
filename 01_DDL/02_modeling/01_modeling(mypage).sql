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