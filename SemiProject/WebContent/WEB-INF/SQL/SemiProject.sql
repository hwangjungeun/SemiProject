create user SEMIORAUSER3 identified by cclass
default tablespace users;

grant connect, resource, unlimited tablespace, create view to SEMIORAUSER3;

--Grant을(를) 성공했습니다.

show user;
--USER이(가) "SEMIORAUSER3"입니다.

select * from tab;

select *
from member_board