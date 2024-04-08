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