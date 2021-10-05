show user;

select *
from tbl_member;

drop table qna_board;

CREATE TABLE qna_board
( 
  board_num NUMBER,             -- 글 번호
  board_id VARCHAR2(50),        -- 글 작성자 
  board_subject VARCHAR2(100),  -- 글 제목
  board_content VARCHAR2(2000), -- 글 내용
  board_count number default 0 not null,          -- 글 조회수
  board_date date default sysdate, -- 작성일
  CONSTRAINT PK_Member_Board PRIMARY KEY(board_num)
);
-- Table MEMBER_BOARD이(가) 생성되었습니다.

create sequence board_num
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle;
-- 게시판 시퀀스

drop sequence board_num;

select *
from qna_board;

select board_num, board_id, board_pwd, board_subject, board_content, board_count, board_date
from qna_board;

insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'j*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'m*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'p*****','배송 문의','배송 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'l*****','교환 문의','교환 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'l*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'h*****','배송 문의','배송 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'c*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'s*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','배송 문의','배송 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'n*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'h*****','기타 문의','기타 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'h*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'p*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','교환/환불 문의','교환/환불 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'o*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'y*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'s*****','기타 문의','기타 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'s*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'c*****','배송 문의','배송 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'c*****','배송 문의','배송 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);
insert into qna_board(board_num, board_id, board_subject, board_content, board_count, board_date) values(board_num.nextval,'k*****','상품 문의','상품 문의 합니다', default, default);


commit;


