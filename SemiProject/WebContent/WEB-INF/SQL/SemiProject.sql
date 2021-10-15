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
,topsize            varchar2(1)               -- 상의 사이즈
,bottomsize         varchar2(1)               -- 하의 사이즈
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

desc tbl_member; -- 테이블 구조 보기

delete from tbl_member where userid='seolh'

commit;

insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress)
values ('admin', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '관리자','RMGSA7ZA97cJDEH4ZHV2m7wF6tMl6WnAYGliLJCwg5s=', '4ErLv8Ox8BQxqzjV4rhJ6Q==', '00000' , '0', '0', '0');

commit;

alter table tbl_member modify topsize varchar(1);
alter table tbl_member modify bottomsize varchar(1);

purge recyclebin; -- 휴지통비우기

create table tbl_point
(fk_odrcode     varchar2(20)    not null            -- 주문코드
,fk_userid      varchar2(40)    not null            -- 회원아이디
,fk_odrdate     date default sysdate                -- 주문날짜
,point          number          not null            -- 포인트액
,start_day      date default sysdate+20                -- 시작일
,end_day        date default add_months(sysdate, 6) -- 마감일
,p_status       number(1) default 0                -- 사용유무 (0: 사용전 / 1: 사용후) 
,p_idle         number(1) default 0                -- 기한초과유무 (0:사용가능 /  1:사용불가)
,constraint PK_tbl_point primary key(fk_odrcode, fk_userid)
,constraint FK_tbl_point_userid foreign key(fk_userid) references tbl_member(userid) on delete cascade
,constraint FK_tbl_point_odrcode foreign key(fk_odrcode) references tbl_order(odrcode) on delete cascade
,constraint CK_tbl_point_status check( p_status in(0,1) )
,constraint CK_tbl_point_idle check( p_idle in(0,1) )
);
select *
from user_constraints
where table_name = 'TBL_POINT'

select *
from ALL_CONS_COLUMNS
where table_name = 'TBL_POINT'

select * --FK_ODRCODE, FK_USERID, START_DAY, END_DAY, P_STATUS , P_IDLE, POINT, FK_ODRDATE 
from tbl_point



insert into tbl_orderdetail (ODRSEQNUM, FK_ODRCODE, FK_PSEQ, OQTY, ODRPRICE, DELIVERDATE)
values (1, '1')

insert into tbl_order (ODRCODE, FK_USERID, ODRTOTALPRICE, ODRTOTALPOINT)
values ('1','hje0121',140000,14)

insert into tbl_order (ODRCODE, FK_USERID, ODRTOTALPRICE, ODRTOTALPOINT)
values ('7','leess',560000,56);
insert into tbl_order (ODRCODE, FK_USERID, ODRTOTALPRICE, ODRTOTALPOINT)
values ('8','leess',130000,13);
insert into tbl_order (ODRCODE, FK_USERID, ODRTOTALPRICE, ODRTOTALPOINT)
values ('9','leess',120000,12);

select * from tbl_product;

commit;

select *
from tbl_order

update tbl_order set ODRDATE =
(
    select P.FK_ODRCODE, P.FK_USERID, P.START_DAY, P.END_DAY, P.P_STATUS , P.P_IDLE, P.POINT, P.FK_ODRDATE
    from tbl_point P Inner JOIN tbl_order O
    ON P.fk_ODRDATE = O.ODRDATE;
)
where odrcode ='10'

alter table tbl_point rename column fk_odrdate to odrdate;


select *
from tbl_order

alter table tbl_point add point number not null;

select sum(point)
from tbl_point
where fk_userid= 'leess' and p_status = 0 and p_idle = 0 

alter table tbl_order drop column ODRTOTALPOINT

   select *
   from user_constraints
   where table_name='TBL_POINT'

desc tbl_order
select *
from TBL_ORDERDETAIL;

insert into tbl_point (fk_odrcode, fk_userid, point) values (1,'leess',6);
insert into tbl_point (fk_odrcode, fk_userid, point) values (2,'leess',24);
insert into tbl_point (fk_odrcode, fk_userid, point) values (3,'leess',15);
insert into tbl_point (fk_odrcode, fk_userid, point) values (1,'hje0121',14);

commit;

select *
from tbl_point;
----------------------------------------------------------
select sum(point),fk_odrcode, period
from
(
    select point, fk_odrcode, trunc(end_day - sysdate) AS period
    from tbl_point
    where fk_userid= 'leess' and p_status = 0 and p_idle = 0
)
group by period, fk_odrcode;

String sql = "select sum(point)\n"+
"from\n"+
"(\n"+
"    select point, trunc(months_between(end_day, sysdate)) AS period\n"+
"    from tbl_point\n"+
"    where fk_userid= 'leess' and p_status = 0\n"+
")";


insert into tbl_point (fk_odrcode, fk_userid, point, start_day, end_day) values (4,'leess',14, '21/05/05', '21/10/06');
insert into tbl_point (fk_odrcode, fk_userid, point, start_day, end_day) values (5,'leess',14, '21/07/04', '21/09/06');
insert into tbl_point (fk_odrcode, fk_userid, point, start_day, end_day) values (6,'leess',14, '21/09/04', '21/10/15');
insert into tbl_point (fk_odrcode, fk_userid, point, start_day, end_day,p_status) values (7,'leess',56, '21/09/04', '22/02/15',1);
insert into tbl_point (fk_odrcode, fk_userid, point, start_day, end_day,p_status) values (8,'leess',13, '21/09/17', '22/02/22',1);
insert into tbl_point (fk_odrcode, fk_userid, point, start_day, end_day,p_status) values (9,'leess',12, '21/09/17', '22/02/22',0);
commit;

select fk_odrcode, trunc(sysdate - start_day) AS s_period, trunc(end_day - sysdate) AS e_period 
from tbl_point
where fk_userid= 'leess' and p_status = 0 


delete from tbl_point
where fk_odrcode = 4

update tbl_point set p_idle = 0
where trunc(sysdate - start_day) >= 20;

commit;

select fk_odrcode, fk_userid, start_day, end_day, point,  p_status, p_idle,  trunc(sysdate - start_day) AS s_period, trunc(end_day - sysdate) AS e_period
from tbl_point;

alter table tbl_point modify p_idle         number(1) default 0 

select nvl(sum(point),0)
from tbl_point
where fk_userid = 'leess' and p_status = 0 and p_idle = 0;


select nvl(sum(point),0)
from tbl_point
where fk_userid = 'leess' and p_status = 0 and trunc(end_day - sysdate) > 0

select *
from tab;

select *
from TBL_ORDERDETAIL;

desc TBL_ORDER;

desc tbl_point;

-- selectPagingPoint 페이징처리에 대한 포인트 내용 출력
select start_day, point, fk_odrcode
from
(
    select rownum as rno, start_day, point, fk_odrcode
    from tbl_point
    where fk_userid = 'leess'
)
where rno between 6 and 9

-- Java로 변환
String sql = "select start_day, point, fk_odrcode\n"+
"from\n"+
"(\n"+
"    select rownum, start_day, point, fk_odrcode\n"+
"    from tbl_point\n"+
"    where fk_userid = ?\n"+
")\n"+
"where rownum between ? and ?";

select odrdate, 


create or replace procedure pcd_point_insert
(fk_userid   IN   varchar2
,fk_odrcode     IN   varchar2
,point     IN   Number)
is
begin
    for i in 101..200 loop
        insert into tbl_point(fk_userid, fk_odrcode, point)
        values (fk_userid,i,point);
    end loop;
end pcd_point_insert;

exec pcd_point_insert('leess','',10);
commit;

select *
from tbl_point
where fk_userid ='leess'
order by fk_odrdate;

select fk_odrcode, trunc(sysdate - start_day) AS s_period, trunc(end_day - sysdate) AS e_period 
from tbl_point
where fk_userid= 'leess' and p_status = 0


select fk_odrdate, point, fk_odrcode
from
(
select rownum as rno, fk_odrdate, point, fk_odrcode 
from tbl_point
where fk_userid = 'leess' and p_status = 0 and trunc(sysdate - start_day) < 0 
) 
-- where rno between 1 and 6 
 order by fk_odrdate 
 
delete from tbl_point where to_char(fk_odrdate,'yyyy-mm-dd')=to_char(sysdate,'yyyy-mm-dd')

commit;

select fk_odrdate, point, fk_odrcode 
from 
( 
select rownum as rno, fk_odrdate, point, fk_odrcode 
from tbl_point
where fk_userid = 'leess'
)
where rno between 1 and 10 
order by fk_odrdate

select ceil(count(*)/5)
from tbl_point
where fk_userid = 'leess' and p_status = 1 and p_idle = 0 

select rownum as rno, fk_odrdate, start_day,  point, fk_odrcode 
from tbl_point
where fk_userid = 'leess' and p_status = 0 and trunc(sysdate - start_day) < 0

select ceil(count(*)/5)
from tbl_point
where fk_userid = 'leess' and p_status = 0 and trunc(sysdate - start_day)<0

commit;

select trunc(sysdate - start_day)
from tbl_point

select fk_odrdate, start_day, point, fk_odrcode 
from 
( 
select count(*) --, fk_odrdate, start_day,  point, fk_odrcode
from tbl_point 
where fk_userid = 'leess' and p_status = 0 and trunc(sysdate - start_day) < 0 
order by fk_odrdate 

delete from tbl_point
where fk_odrcode between 10 and 200

commit;

alter table tbl_member drop column point;

desc tbl_member;

select tbl_

select *
from tab
/*

    TBL_CART
    TBL_CATEGORYL
    TBL_CATEGORYU
    TBL_LOGINHISTORY
    TBL_MEMBER
    TBL_NOTICE
    TBL_ORDER
    TBL_ORDERDETAIL
    TBL_PCOLOR
    TBL_POINT
    TBL_POPTION
    TBL_PRODUCT
    TBL_QNA
    TBL_RECENTVIEWPRODUCT
    TBL_WISHLIST
*/

select *
from TBL_ORDER

select *
from user_constraints where table_name = 'TBL_ORDER'
where table_name = 'TBL_ORDERDETAIL'

-- 주문번호, 이미지, 상품정보, 수량, 상품구매금액, 주문처리상태, 취소/교환/반품
select fk_odrcode, pimage, pname  ,oqty , odrprice ,deliverstatus, cancelstatus
from tbl_product P join tbl_orderdetail D
on p.pseq = D.fk_pseq;

desc tbl_orderdetail
desc tbl_product


