
---- Semi Project ----

show user;

select * from tab;

select * from tbl_member;

---- 2021-10-05 eXERD / 10-07 재eXERD ----
drop table tbl_orderdetail purge;
drop table tbl_order purge;
drop table tbl_wishlist purge;
drop table tbl_cart purge;
drop table tbl_order purge;
drop table tbl_recentViewProduct purge;
drop table tbl_product purge;
drop table tbl_spec purge;
drop table tbl_category purge;

select * from tab;

-------------------------------------------------------------------------------------

-- **** 카테고리(상위) 테이블 생성하기 **** --
create table tbl_categoryU
(cuseq       NUMBER(8)               -- 카테고리상위번호
,cuname      VARCHAR2(100) not null  -- 카테고리상위명

,constraint PK_tbl_categoryU primary key(cuseq)
,constraint UK_tbl_categoryU unique(cuname)
);
-- Table TBL_CATEGORYU이(가) 생성되었습니다.

-- **** 카테고리(상위) 시퀀스 생성하기 **** --
create sequence seq_tbl_categoryU_cuseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_CATEGORYU_CUSEQ이(가) 생성되었습니다.

-- **** 카테고리(하위) 테이블 생성하기 **** --
create table tbl_categoryL
(clseq       NUMBER(8)               -- 카테고리하위번호
,clname      VARCHAR2(100) not null  -- 카테고리하위명
,fk_cuseq    NUMBER(8)     not null  -- 카테고리상위번호

,constraint PK_tbl_categoryL primary key(clseq)
,constraint UK_tbl_categoryL unique(clname)
,constraint FK_tbl_categoryL foreign key(fk_cuseq) references tbl_categoryU(cuseq)
);
-- Table TBL_CATEGORYL이(가) 생성되었습니다.

-- **** 카테고리하위 시퀀스 생성하기 **** --
create sequence seq_tbl_categoryL_clseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_CATEGORYL_CLSEQ이(가) 생성되었습니다.

-- **** 제품색상 테이블 생성하기 **** --
create table tbl_pcolor
(cseq      NUMBER(8)                -- 색상번호
,cname     VARCHAR2(100)  not null  -- 색상명

,constraint PK_tbl_pcolor primary key(cseq)
,constraint UK_tbl_pcolor unique(cname)
);
-- Table TBL_PCOLOR이(가) 생성되었습니다.

-- **** 제품색상 시퀀스 생성하기 **** --
create sequence seq_tbl_pcolor_cseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_PCOLOR_CSEQ이(가) 생성되었습니다.

-- **** 제품 테이블 생성하기 **** --
create table tbl_product
(pseq       NUMBER(8)                                   -- 제품번호
,fk_clseq   NUMBER(8)           not null                -- 카테고리하위번호
,pname      VARCHAR2(100)       not null                -- 제품명
,pimage     VARCHAR2(100)       default 'noimage.png'   -- 제품이미지
,price      NUMBER(8)           default 0               -- 제품정가
,pcontent   VARCHAR2(4000)                              -- 제품설명
,point      NUMBER(8)           default 0               -- 포인트점수
,pinputdate DATE                default sysdate         -- 제품입고일자

,constraint PK_tbl_product primary key(pseq)
,constraint FK_tbl_product foreign key(fk_clseq) references tbl_categoryL(clseq)
);
-- Table TBL_PRODUCT이(가) 생성되었습니다.

-- **** 제품테이블 시퀀스 생성하기 **** --
create sequence seq_tbl_product_pseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_PRODUCT_PSEQ이(가) 생성되었습니다.

-- **** 옵션 테이블 생성하기 **** --
create table tbl_poption
(opseq      NUMBER                      -- 옵션번호
,fk_pseq    NUMBER(8)       not null    -- 제품번호
,fk_cseq    NUMBER(8)       not null    -- 색상번호
,cimage     VARCHAR2(100)   not null    -- 색상이미지
,cnt        NUMBER(4)       default 2   -- 옵션재고량
    
,constraint PK_tbl_poption primary key(opseq)
,constraint FK_tbl_poption1 foreign key(fk_pseq) references tbl_product(pseq)
,constraint FK_tbl_poption2 foreign key(fk_cseq) references tbl_pcolor(cseq)
);
-- Table TBL_POPTION이(가) 생성되었습니다.

-- **** 옵션테이블 시퀀스 생성하기 **** --
create sequence seq_tbl_poption_opseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_POPTION_OPSEQ이(가) 생성되었습니다.



-- **** 최근본상품 테이블 생성하기 **** --
create table tbl_recentViewProduct
(recentseq     NUMBER                           -- 최근본상품번호
,fk_userid     VARCHAR2(40) not null            -- 회원아이디 
,fk_pseq       NUMBER(8)    not null            -- 제품번호
,viewday       DATE         default sysdate     -- 최근본일자

,constraint PK_tbl_recentViewProduct primary key(recentseq)
,constraint FK_tbl_recentViewProduct foreign key(fk_userid) references tbl_member(userid)
,constraint FK_tbl_recentViewProduct2 foreign key(fk_pseq) references tbl_product(pseq)
);
--Table TBL_RECENTVIEWPRODUCT이(가) 생성되었습니다.

-- **** 최근본상품 시퀀스 생성하기 **** --
create sequence seq_tbl_rvProduct_recentseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_RVPRODUCT_RECENTSEQ이(가) 생성되었습니다.


-- **** 장바구니 테이블 생성하기 **** --
create table tbl_cart
(cartseq       NUMBER                  -- 장바구니번호
,fk_userid     VARCHAR2(40) not null   -- 회원아이디 
,fk_pseq       NUMBER(8)    not null   -- 제품번호
,oqty          NUMBER(4)    default 0  -- 주문량
,registerday   date     default sysdate -- 입력일자

,constraint PK_tbl_cart primary key(cartseq)
,constraint FK_tbl_cart foreign key(fk_userid) references tbl_member(userid)
,constraint FK_tbl_cart2 foreign key(fk_pseq) references tbl_product(pseq)
);
--Table TBL_CART이(가) 생성되었습니다.

-- **** 장바구니 시퀀스 생성하기 **** --
create sequence seq_tbl_cart_cartseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence SEQ_TBL_CART_CARTSEQ이(가) 생성되었습니다.


-- **** 위시리스트 테이블 생성하기 **** --
create table tbl_wishlist
(wishseq       NUMBER                    -- 위시리스트번호
,fk_userid     VARCHAR2(40) not null     -- 회원아이디 
,fk_pseq       NUMBER(8)    not null     -- 제품번호

,constraint PK_tbl_wishlist primary key(wishseq)
,constraint FK_tbl_wishlist foreign key(fk_userid) references tbl_member(userid)
,constraint FK_tbl_wishlist2 foreign key(fk_pseq) references tbl_product(pseq)
);
--Table TBL_WISHLIST이(가) 생성되었습니다.

-- **** 위시리스트 시퀀스 생성하기 **** --
create sequence seq_tbl_wishlist_wishseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence WISHSEQ이(가) 생성되었습니다.


-- **** 주문 테이블 생성하기 **** --
create table tbl_order
(odrcode        VARCHAR2(20)                     -- 주문코드
,fk_userid      varchar2(40)                     -- 회원아이디
,odrtotalprice  NUMBER  not null                 -- 주문총액
,odrtotalpoint  NUMBER  not null                 -- 주문총포인트
,odrdate        DATE    default sysdate          -- 주문일자

,constraint PK_tbl_order primary key(odrcode)
,constraint FK_tbl_order foreign key(fk_userid) references tbl_member(userid)
);
-- Table TBL_ORDER이(가) 생성되었습니다.

-- **** 주문코드 시퀀스 생성하기 **** --
create sequence seq_tbl_order_odrcode
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence ODRCODESEQ이(가) 생성되었습니다.

-- **** 주문상세 테이블 생성하기 **** --
create table tbl_orderdetail
(odrseqnum      NUMBER                              -- 주문상세일련번호
,fk_odrcode     VARCHAR2(20)    not null            -- 주문코드
,fk_pseq        NUMBER(8)       not null            -- 제품번호
,oqty           NUMBER          not null            -- 주문량
,odrprice       NUMBER          not null            -- 주문가격
,deliverstatus  NUMBER(1)       default 0           -- 배송상태
,deliverdate    DATE                                -- 배송완료일자

,constraint PK_tbl_orderdetail primary key(odrseqnum)
,constraint FK_tbl_orderdetail foreign key(fk_odrcode) references tbl_order(odrcode)
,constraint FK_tbl_orderdetail2 foreign key(fk_pseq) references tbl_product(pseq)
);
-- Table TBL_ORDERDETAIL이(가) 생성되었습니다.

-- **** 주문상세일련번호 시퀀스 생성하기 **** --
create sequence seq_tbl_orderdetail_odrseqnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence ODRSEQNUMSEQ이(가) 생성되었습니다.

----------------------------------------------------------------------------
select * from tbl_categoryU;
select * from tbl_categoryL;
select * from tbl_product;
select * from tbl_pcolor;
select * from tbl_poption;
select * from tbl_recentViewProduct;
select * from tbl_cart;
select * from tbl_wishlist;
select * from tbl_order;
select * from tbl_orderdetail;

select * from tbl_member; -- leess, eomjh

desc tbl_member;
----------------------------------------------------------------------------------

insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'black');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'white');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'gray');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'blue');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'green');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'pink');
-- 1 행 이(가) 삽입되었습니다.
commit;

----------------------------------------------------------------------------------
-- 카테고리상위 테이블 삽입
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'OUTER');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'TOP');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'BLOUSE');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'PANTS');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'SKIRT');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'DRESS');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'BAG');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'ACC');
--1 행 이(가) 삽입되었습니다.

-- 카테고리하위 테이블 삽입
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'JACKET',1);
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'CARDIGAN',1);
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'TSHIRTS',2);
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'KNIT',2);
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'BLOUSE',3);
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'DENIM',4);
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'MINI',5);
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'ONEPIECE',6);
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'BACKPACK',7);
insert into tbl_categoryL(clseq, clname,fk_cuseq) values(seq_tbl_categoryL_clseq.nextval, 'EARRING',8);
--1 행 이(가) 삽입되었습니다.

------------------------------------------------------------------------------------------------------------


-- 최근 본 상품 dao
select pname, pimage1, pimage2, price, fk_sseq, viewday
from tbl_recentViewProduct V JOIN tbl_product P
ON V.fk_pseq = P.pseq
where fk_userid = 'eomjh'
order by viewday desc;

---------------------------------------------------------------------------------