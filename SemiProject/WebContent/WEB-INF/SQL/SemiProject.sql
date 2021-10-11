
create user SEMIORAUSER3 identified by cclass
default tablespace users;

grant connect, resource, unlimited tablespace, create view to SEMIORAUSER3;

select * from tbl_member;

select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender      , birthyyyy, birthmm, birthdd, coin, point, registerday, pwdchangegap      , NVL(lastlogingap, trunc( months_between(sysdate,registerday) )) AS lastlogingap  from  (  select userid, name, email, mobile, postcode, address, detailaddress, extraaddress       ,substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd       ,trunc(months_between(sysdate, lastpwdchangedate)) AS pwdchangegap  from tbl_member  where status = 1 and userid = admin  ) M  CROSS JOIN  (  select trunc(months_between(sysdate, max(logindate))) AS lastlogingap  from tbl_loginhistory  where fk_userid = admin  ) H; 

select userid, 
name,
email,
mobile,
postcode,
address,
detailaddress,
extraaddress,
birthday,
height,
weight,
topsize,
bottomsize,
point,
registerday,
lastpwdchangedate,
status,
idle from tbl_member where userid = 'admin';

select * from tbl_member;

create table tbl_loginhistory
(fk_userid   varchar2(40) not null 
,logindate   date default sysdate not null
,clientip    varchar2(20) not null
,constraint FK_tbl_loginhistory foreign key(fk_userid) 
                                references tbl_member(userid)  
);

-- Table TBL_LOGINHISTORY이(가) 생성되었습니다. --

select userid, name, email, mobile, postcode, address, detailaddress, extraaddress,
birthyyyy, birthmm, birthdd, height, weight, topsize, bottomsize, point, registerday, pwdchangegap,
 NVL(lastlogingap, trunc( months_between(sysdate,registerday) )) AS lastlogingap
from
(
select userid, name , email, mobile, postcode, address, detailaddress, extraaddress,
substr(birthday,1,4) as birthyyyy, substr(birthday,6,2) as birthmm, substr(birthday,9) as birthdd
, height, weight, topsize, bottomsize, point, registerday,
trunc(months_between(sysdate, lastpwdchangedate)) as pwdchangegap
from tbl_member
where status = 1 and userid = 'admin' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
) M
 CROSS JOIN
 (
 select trunc(months_between(sysdate, max(logindate))) AS lastlogingap
 from tbl_loginhistory
 where fk_userid = 'admin'
 ) H;

-- Semi Project --

show user;

select *
from tab;

create table tbl_member
(userid             varchar2(40)   not null  -- 회원아이디
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,name               varchar2(30)   not null  -- 회원명
,email              varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,mobile             varchar2(200)  not null  -- 연락처 (AES-256 암호화/복호화 대상) 
,postcode           varchar2(5)    not null  -- 우편번호
,address            varchar2(200)  not null  -- 주소
,detailaddress      varchar2(200)  not null  -- 상세주소
,extraaddress       varchar2(200)  not null  -- 참고항목
,birthday           varchar2(10)             -- 생년월일
,height             number default 0         -- 키
,weight             number default 0         -- 몸무게
,topsize            varchar(1)               -- 상의 사이즈
,bottomsize         varchar(1)               -- 하의 사이즈
,point              number default 0         -- 포인트 
,registerday        date default sysdate     -- 가입일자 
,lastpwdchangedate  date default sysdate     -- 마지막으로 암호를 변경한 날짜  
,status             number(1) default 1 not null     -- 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
,idle               number(1) default 0 not null     -- 휴면유무      0 : 활동중  /  1 : 휴면중 
,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint UQ_tbl_member_mobile  unique(mobile)
,constraint CK_tbl_member_status check( status in(0,1) )
,constraint CK_tbl_member_idle check( idle in(0,1) )
);

select *
from tbl_member;

insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress)
values ('admin', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '관리자','RMGSA7ZA97cJDEH4ZHV2m7wF6tMl6WnAYGliLJCwg5s=', '4ErLv8Ox8BQxqzjV4rhJ6Q==', '00000' , '0', '0', '0');

commit;

update tbl_member set email = 'ezuJ8cfVXdLkTPrarCqmNQ==', mobile='lxoQ3qJ/PB7qxAGbBP9J6g=='

insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, birthday, height, weight, topsize, bottomsize)
values('hje0121', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382',  '황정은', 'RMGSA7ZA97cJDEH4ZHV2m7wF6tMl6WnAYGliLJCwg5s=', '4ErLv8Ox8BQxqzjV4rhJ6Q==',  '16709' , '경기 수원시 영통구 청명북로 81', '408동 1202호', ' (영통동, 청명마을주공아파트)', '1998-01-21', 170, 70, 's', 'l'); 

alter table tbl_member modify topsize varchar2(2) default '-'; 
alter table tbl_member modify bottomsize varchar2(2) default '-'; 
>>>>>>> branch 'main' of https://github.com/hwangjungeun/SemiProject.git
=======
show user;

select *
from tab;

select *
from tbl_member;

drop table tbl_qna purge;

CREATE TABLE tbl_qna
( 
  board_num NUMBER,             -- 글 번호
  board_id VARCHAR2(50),        -- 글 작성자 
  board_subject VARCHAR2(100),  -- 글 제목
  board_content VARCHAR2(2000), -- 글 내용
  board_count number default 0 not null,          -- 글 조회수
  board_date date default sysdate, -- 작성일
  CONSTRAINT PK_tbl_qna PRIMARY KEY(board_num)
);
-- Table tbl_qna이(가) 생성되었습니다.

create sequence board_num
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle;
-- 게시판 시퀀스

drop sequence board_num;

select *
from tbl_qna;

select board_num, board_id, board_subject, board_content, board_count, board_date
from tbl_qna;

insert into tbl_qna(board_num, board_subject, board_id, board_count, board_date) values(board_num.nextval,'상품 문의', 'j*****', default, default);
insert into tbl_qna(board_num, board_subject, board_id, board_count, board_date) values(board_num.nextval,'상품 문의', 'k*****', default, default);


commit;

select count(*) -- 207
from tbl_qna
where board_id != 'admin';

>>>>>>> refs/heads/kimminkyung
