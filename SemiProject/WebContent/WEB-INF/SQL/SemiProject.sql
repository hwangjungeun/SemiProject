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

