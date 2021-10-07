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


userid
pwd
name
email
mobile
posetcode
address
detailaddress
extraaddress
birthday
height
weight
topsize
bottomsize
point
registerday
lastpwdchangedate
status
idle

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

