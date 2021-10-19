show user;

select *
from tab;

select *
from tbl_member;

select *
from tbl_notice;


delete tbl_notice
where notice_num > 5; 

select * 
from tbl_qna;

delete from tbl_qna
where length(board_id) > 0;

commit;

drop table tbl_qna purge;
drop table tbl_notice purge;



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

drop sequence notice_num;

select *
from tbl_qna;

delete tbl_qna
where board_num > 7; 
 
select board_num, board_id, board_subject, board_content, board_count, board_date
from tbl_qna;


insert into tbl_qna(board_num, board_subject, board_id, board_count, board_date) values(board_num.nextval,'상품 문의', 'k*****', default, default);



commit;

select count(*) -- 207
from tbl_qna
where board_id != 'admin';


CREATE TABLE tbl_notice
( 
  notice_num NUMBER,             -- 글 번호
  notice_id VARCHAR2(50),        -- 글 작성자 
  notice_subject VARCHAR2(100),  -- 글 제목
  notice_content VARCHAR2(2000), -- 글 내용
  notice_count number default 0 not null,          -- 글 조회수
  notice_date date default sysdate, -- 작성일
  CONSTRAINT PK_tbl_notice PRIMARY KEY(notice_num)
);

ALTER TABLE tbl_notice ADD(nimage  varchar2(100) default 'noimage.png');
ALTER TABLE tbl_notice DROP COLUMN NIMAGE;

select *
from tbl_notice;


create sequence notice_num
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle;

commit;


---- *** 이미지 테이블 : tbl_image *** ----
-- drop table tbl_image purge; 
create table tbl_image
(inum           number(8) not null       -- 이미지번호(Primary Key)
,iname          varchar2(100) not null   -- 이미지명
,nimage         varchar2(100) default 'noimage.png' -- 이미지   이미지파일명
,prdmanual_systemFileName varchar2(200)            -- 파일서버에 업로드되어지는 실제 제품설명서 파일명 (파일명이 중복되는 것을 피하기 위해서 중복된 파일명이 있으면 파일명뒤에 숫자가 자동적으로 붙어 생성됨)
,prdmanual_orginFileName  varchar2(200)            -- 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명 

,constraint  PK_tbl_image_inum primary key(inum)
);

-- drop sequence seq_tbl_image_inum;
create sequence seq_tbl_image_inum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_image;


----- ===== 페이징 처리를 위한 SQL문 작성하기 ===== -----
select rownum, board_id, board_subject, board_content
from tbl_qna
where board_id != 'null'
and rownum between 1 and 10;

----- 검색어가 없는 경우의 페이징 처리한 것 -----
select rno, board_id, board_subject, board_content
from
(
    select rownum AS rno, board_id, board_subject, board_content
    from
    (
      select board_id, board_subject, board_content
      from tbl_qna
      where board_id != 'null'
      order by board_date desc
    )  V
) T
where rno between 1 and 10;


-- 검색이 없는 전체페이지 또는 검색이 있는 전체페이지 알아오기
select ceil(count(*)/5)  
from tbl_qna  
where board_id != 'null'; 
