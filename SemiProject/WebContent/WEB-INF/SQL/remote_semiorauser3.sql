
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
,fk_opseq      NUMBER       not null     -- 옵션번호

,constraint PK_tbl_wishlist primary key(wishseq)
,constraint FK_tbl_wishlist foreign key(fk_userid) references tbl_member(userid)
,constraint FK_tbl_wishlist2 foreign key(fk_pseq) references tbl_product(pseq)
,constraint FK_tbl_wishlist3 foreign key(fk_opseq) references tbl_poption(opseq)
);
--Table TBL_WISHLIST이(가) 생성되었습니다.

-- 등록일자번호 컬럼 추가하기
alter table tbl_wishlist
add enrollmentday date;
-- Table TBL_WISHLIST이(가) 변경되었습니다.
alter table tbl_wishlist 
modify enrollmentday date default sysdate;
-- Table TBL_WISHLIST이(가) 변경되었습니다.

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
--,odrtotalpoint  NUMBER  not null                 -- 주문총포인트
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

-- 옵션번호 컬럼 추가하기
alter table tbl_orderdetail
add fk_opseq number;
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.
alter table tbl_orderdetail
add constraint FK_tbl_orderdetail3 foreign key(fk_opseq) references tbl_poption(opseq);
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.
alter table tbl_orderdetail
modify fk_opseq not null;
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.


-- **** 주문진행중 테이블 생성하기 **** --
create table tbl_orderProgress
(odrProseq          NUMBER                  -- 주문진행번호
,fk_opseq           NUMBER       not null   -- 옵션번호
,fk_userid          varchar2(40) not null   -- 회원아이디
,wishoqty           NUMBER(4)    not null   -- 구매수량

,constraint PK_tbl_orderProgress primary key(odrProseq)
,constraint FK_tbl_orderProgress foreign key(fk_opseq) references tbl_poption(opseq)
,constraint FK_tbl_orderProgress2 foreign key(fk_userid) references tbl_member(userid)
);
-- Table TBL_ORDERPROGRESS이(가) 생성되었습니다.

-- **** 주문진행번호 시퀀스 생성하기 **** --
create sequence seq_tbl_odrProg_odrProseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_ODRPROG_ODRPROSEQ이(가) 생성되었습니다.



-- ********************************************************* --
-- *************** 여기서부터 개발 시작입니다~~~~ *************** --
-- ********************************************************* --

----------------------------------------------------------------------------------
-- 색상 insert
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'black');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'white');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'gray');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'blue');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'green');
insert into tbl_pcolor(cseq, cname) values(seq_tbl_pcolor_cseq.nextval, 'pink');
-- 1 행 이(가) 삽입되었습니다.
commit;

----------------------------------------------------------------------------------
-- 카테고리상위 insert
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'OUTER');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'TOP');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'BLOUSE');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'PANTS');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'SKIRT');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'DRESS');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'BAG');
insert into tbl_categoryU(cuseq, cuname) values(seq_tbl_categoryU_cuseq.nextval, 'ACC');
--1 행 이(가) 삽입되었습니다.

-- 카테고리하위 insert
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
-- 제품 insert
insert into tbl_product(pseq,fk_clseq,pname,pimage,price,pcontent,point,pinputdate)
values(seq_tbl_product_pseq.nextval,2,'riha angora cardigan','300_0.jpg',28900,'데일리한 무드로 활용도 높게 착용하기 좋은 브이넥 니트가디건 소개해드려요 데일리하게 내어입기 좋은 핏이며, 티셔츠에나, 단독으로 입으셔도 타이트 하지 않은 여유있는 핏으로 더욱 슬림하게 연출해드려요, 컬러는 총 5가지 컬러보여드릴게요',28900*0.01,sysdate);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,1,5,'300_green.jpg',2);
--------------------------------------------------------------------------------------
insert into tbl_product(pseq,fk_clseq,pname,pimage,price,pcontent,point,pinputdate)
values(seq_tbl_product_pseq.nextval,1,'toy cotton pants','302_0.jpg',28900,'군더더기없는 깔끔한 아웃핏의 팬츠입니다 ! 일자로 깔끔하게 떨어지는 스트레이트라인으로 슬림한 연출이 가능해요 어디에나 매치하기좋은 깔끔한 디자인으로 차분한 톤 색감이 주는 멋스러운 무드가 돋보이는 팬츠로 계절구애없이 착용가능합니다 ♡',28900*0.01,sysdate);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,2,2,'302_white.jpg',4);
--------------------------------------------------------------------------------------
insert into tbl_product(pseq,fk_clseq,pname,pimage,price,pcontent,point,pinputdate)
values(seq_tbl_product_pseq.nextval,4,'sweep alpaca knit','303_0.jpg',47600,'울과 알파카 소재 혼방으로 따뜻하게 착용하기 좋구요! 롱헤어감이 느껴지는 니트 소재로, 고급스러운 무드가 연출돼요! 톡톡 튀는 컬러감으로 포인트 주기 좋으니, 얼른 소장해보세요! :-)',47600*0.01,sysdate);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,3,4,'303_blue.jpg',3);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,3,6,'303_pink.jpg',2);
--------------------------------------------------------------------------------------
insert into tbl_product(pseq,fk_clseq,pname,pimage,price,pcontent,point,pinputdate)
values(seq_tbl_product_pseq.nextval,5,'moreover blouse','304_0.jpg',39000,'MD추천♥ 드레이프한 디자인의 블라우스에요>< 넥라인에 자연스러운 주름이 잡혀 여성스러운 느낌을 주면서 차분하고 안정된 컬러로 모던하게 연출하기 좋답니다:) 실키한 소재감으로 터치감이 너무 좋았구요, 은은하게 포인트를 주어 연출하기 좋은 블라우스로 추천드려요!',39000*0.01,sysdate);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,12,1,'304_black.jpg',2);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,12,3,'304_gray.jpg',2);
--------------------------------------------------------------------------------------
insert into tbl_product(pseq,fk_clseq,pname,pimage,price,pcontent,point,pinputdate)
values(seq_tbl_product_pseq.nextval,6,'chemi autumn pants','305_0.jpg',29000,'가을버전의 버너데님 보여드려요 ! 코튼 소재로 제작된 팬츠로 탄탄한 소재로 데일리하게 입기 좋은 팬츠에요! 적당히 여유있는 일자핏의 팬츠로 블랙과 아이보리의 베이직한 컬러로 보여드릴게요 ♡',29000*0.01,sysdate);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,13,1,'305_black.jpg',2);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,13,2,'305_white.jpg',4);
--------------------------------------------------------------------------------------
insert into tbl_product(pseq,fk_clseq,pname,pimage,price,pcontent,point,pinputdate)
values(seq_tbl_product_pseq.nextval,4,'sente knit','306_0.jpg',34000,'단가라로 포인트 주기좋은 베이직한 니트예요! 밑단과 소맷단의 탄탄한 시보리라인으로 슬림한 허리라인 연출이 가능한 아이템입니다 ! 손등을 덮는 소매길이로 여리여리한 연출이 가능한 니트입니다 ! 총 세가지 컬러 보여드릴게요',34000*0.01,sysdate);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,14,4,'306_blue.jpg',7);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,14,2,'306_white.jpg',1);
--------------------------------------------------------------------------------------
insert into tbl_product(pseq,fk_clseq,pname,pimage,price,pcontent,point,pinputdate)
values(seq_tbl_product_pseq.nextval,4,'pomme knit','307_0.jpg',22100,'크롭기장의 꽈배기 니트 보여드려요 ! 부드러운 감촉이 매력적이 제품으로로 까슬거림없이 착용가능한 니트제품입니다 ! 적당한 두께감으로 단독으로 착용하거나 한겨울 이너로도 착용하기 좋은 두께감으로 자주 손이 갈 아이템입니다 .',22100*0.01,sysdate);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,15,5,'307_green.jpg',2);

insert into tbl_poption(opseq,fk_pseq,fk_cseq,cimage,cnt)
values(seq_tbl_poption_opseq.nextval,15,2,'307_white.jpg',3);
--------------------------------------------------------------------------------------
commit;

select * from tbl_product;

desc tbl_product;
desc tbl_poption;

--***********************************************************************************************--
-- 최근 본 상품 insert
insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(seq_tbl_rvProduct_recentseq.nextval,'eomjh',1,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(seq_tbl_rvProduct_recentseq.nextval,'eomjh',2,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(seq_tbl_rvProduct_recentseq.nextval,'leess',2,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(seq_tbl_rvProduct_recentseq.nextval,'eomjh',3,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(seq_tbl_rvProduct_recentseq.nextval,'eomjh',12,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(seq_tbl_rvProduct_recentseq.nextval,'eomjh',13,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(seq_tbl_rvProduct_recentseq.nextval,'eomjh',14,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(seq_tbl_rvProduct_recentseq.nextval,'eomjh',15,sysdate);

commit;

-- 최근 본 상품 dao(테이블 재생성 전-예전꺼)
select pimage, pname, price, fk_sseq, viewday
from tbl_recentViewProduct V JOIN tbl_product P
ON V.fk_pseq = P.pseq
where fk_userid = 'eomjh'
order by viewday desc;


-- V.fk_userid, V.fk_pseq, V.viewday, P.pseq, P.pname, P.pimage, P.price
select P.pname, P.pimage, P.price, P.pseq, V.recentseq
from tbl_recentViewProduct V JOIN tbl_product P
ON V.fk_pseq = P.pseq
where V.fk_userid = 'eomjh'
order by viewday desc;
-- 동일함(아래는 P.V.등 테이블명을 안써준거임).
select pname, pimage, price, pseq, recentseq
from tbl_recentViewProduct V JOIN tbl_product P
ON V.fk_pseq = P.pseq
where fk_userid = 'eomjh'
order by viewday desc;
-- 최근본상품 목록을 보여줄때, 색상옵션은 생각할 필요가 없다. -> 우선 이걸로 최근본상품 목록을 보여주고,
-- 옵션 select태그를 사용자가 누르면, change이벤트가 발생하면 ajax로 처리.

-- 위의 이거에 페이지바를 추가하려면 아래와 같이 해야한다.
select pname, pimage, price, pseq, recentseq
from
(
    select rownum AS RNO, pname, pimage, price, pseq, recentseq
    from
    (
        select pname, pimage, price, pseq, recentseq
        from tbl_recentViewProduct V JOIN tbl_product P
        ON V.fk_pseq = P.pseq
        where fk_userid = 'eomjh'
        order by viewday desc
    ) R
) T
where T.RNO between 3 and 4;

-- 해당 userid에 맞는 최근본상품목록 총 페이지수
select ceil(count(*)/3)
from tbl_recentViewProduct
where fk_userid = 'eomjh';


select P.pname, C.cname, O.opseq
from tbl_product P JOIN tbl_poption O
ON P.pseq = O.fk_pseq
JOIN tbl_pcolor C
ON O.fk_cseq = C.cseq
where P.pseq = '3';
-- 해당하는 제품에 옵션으로, 무슨 색상들이 있는지 보여줌.


select *
from tbl_recentViewProduct V JOIN tbl_product P
ON V.fk_pseq = P.pseq
JOIN tbl_poption O 
ON P.pseq = O.fk_pseq
JOIN tbl_pcolor C
ON O.fk_cseq = C.cseq;
-- 이거 최근본상품,제품,옵션,색상을 묶은건데 사용할 곳 없음.

--***********************************************************************************************--
-- 위시리스트 insert
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq) values(seq_tbl_wishlist_wishseq.nextval,'eomjh',3,4);
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq) values(seq_tbl_wishlist_wishseq.nextval,'eomjh',1,1);
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq) values(seq_tbl_wishlist_wishseq.nextval,'leess',2,2);
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq) values(seq_tbl_wishlist_wishseq.nextval,'eomjh',12,16);
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq) values(seq_tbl_wishlist_wishseq.nextval,'eomjh',12,17);
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq) values(seq_tbl_wishlist_wishseq.nextval,'eomjh',14,20);
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq) values(seq_tbl_wishlist_wishseq.nextval,'eomjh',13,19);
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq) values(seq_tbl_wishlist_wishseq.nextval,'eomjh',14,21);
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq) values(seq_tbl_wishlist_wishseq.nextval,'leess',13,19);

commit;
-- delete from tbl_wishlist;
-- drop table tbl_wishlist purge;
-- drop sequence seq_tbl_wishlist_wishseq;
select * from tbl_wishlist;

-- 위시리스트 dao
-- 이미지,상품명,옵션의 색상명,판매가,적립금,(배송구분,배송비,합계)
select O.cimage, P.pname, C.cname, P.price, P.point
from tbl_wishlist W JOIN tbl_poption O
ON W.fk_opseq = O.opseq
JOIN tbl_pcolor C
ON O.fk_cseq = C.cseq
JOIN tbl_product P
ON W.fk_pseq = P.pseq
where fk_userid = 'eomjh'
order by wishseq desc;
-- 동일함(아래는 P.V.등 테이블명을 안써준거임).
select cimage, pname, cname, price, point
from tbl_wishlist W JOIN tbl_poption O
ON W.fk_opseq = O.opseq
JOIN tbl_pcolor C
ON O.fk_cseq = C.cseq
JOIN tbl_product P
ON W.fk_pseq = P.pseq
where fk_userid = 'eomjh'
order by wishseq desc;

-- 위의 이거에 페이지바를 추가하려면 아래와 같이 해야한다.
select cimage, pname, cname, price, point, opseq, wishseq
from
(
    select rownum AS RNO, cimage, pname, cname, price, point, opseq, wishseq
    from
    (
        select cimage, pname, cname, price, point, opseq, wishseq
        from tbl_wishlist W JOIN tbl_poption O
        ON W.fk_opseq = O.opseq
        JOIN tbl_pcolor C
        ON O.fk_cseq = C.cseq
        JOIN tbl_product P
        ON W.fk_pseq = P.pseq
        where fk_userid = 'eomjh'
        order by wishseq desc
    )R
) T
where T.RNO between 3 and 4;

-- 해당 userid에 맞는 위시리스트목록 총 페이지수
select ceil(count(*)/3)
from tbl_wishlist
where fk_userid = 'eomjh';


--***********************************************************************************************--
-- 옵션번호/주문수량 을 통해 주문FORM테이블 select하기
-- 이미지,제품명,옵션의 색상명,판매가,수량,(적립금,배송구분,배송비,합계)
select O.cimage, P.pname, C.cname, P.price, P.point
from tbl_product P JOIN tbl_poption O
ON P.pseq = O.fk_pseq
JOIN tbl_pcolor C
ON O.fk_cseq = C.cseq
where opseq = 4;
-- 동일함(아래는 P.V.등 테이블명을 안써준거임).
select cimage, pname, cname, price, point
from tbl_product P JOIN tbl_poption O
ON P.pseq = O.fk_pseq
JOIN tbl_pcolor C
ON O.fk_cseq = C.cseq
where opseq = 4;

--***********************************************************************************************--
-- 최근본상품목록에서 해당하는seq 지우기
delete from tbl_recentViewProduct
where recentseq = ? ;

-- 위시리스트목록에서 해당하는seq 지우기
delete from tbl_wishlist
where wishseq = ? ;

-- 해당 유저의 위시리스트 다 지우기
delete from tbl_wishlist
where fk_userid = ? ;

--***********************************************************************************************--
-- <주문> 장바구니 --

-- 장바구니번호를 이용하여 fk_opseq(옵션번호)와 oqty(주문량)을 조회(select)
select fk_opseq, oqty from tbl_cart where cartseq = 2;

-- 주문진행중 테이블에 insert하는 메소드
insert into tbl_orderProgress(odrproseq,fk_opseq,fk_userid,wishoqty)
values(seq_tbl_odrProg_odrProseq.nextval, ?, ?, ?);

-- 주문원하는테이블인 tbl_orderProgress을 이용해, 주문서폼이 원하는 정보orderProgList를 보내준다.
-- 이미지,제품명,옵션컬러명,가격,수량,적립금
select O.cimage, P.pname, C.cname, P.price, g.wishoqty, P.point, P.pseq, O.opseq
from tbl_product P JOIN tbl_poption O
ON P.pseq = O.fk_pseq
JOIN tbl_pcolor C
ON O.fk_cseq = C.cseq
JOIN tbl_orderProgress G
ON O.opseq = G.fk_opseq;


insert into tbl_cart(cartseq,fk_userid,fk_pseq,oqty,registerday,fk_opseq)
values(seq_tbl_cart_cartseq.nextval,'eomjh',14,3,sysdate,20);

insert into tbl_cart(cartseq,fk_userid,fk_pseq,oqty,registerday,fk_opseq)
values(seq_tbl_cart_cartseq.nextval,'eomjh',14,2,sysdate,21);

insert into tbl_cart(cartseq,fk_userid,fk_pseq,oqty,registerday,fk_opseq)
values(seq_tbl_cart_cartseq.nextval,'eomjh',13,1,sysdate,4);

insert into tbl_cart(cartseq,fk_userid,fk_pseq,oqty,registerday,fk_opseq)
values(seq_tbl_cart_cartseq.nextval,'eomjh',3,3,sysdate,19);


--***********************************************************************************************--
-- 회원명,포인트,주소,연락처,이메일 조회하기
select name, postcode, address, detailaddress, extraaddress, mobile, email, userid
from tbl_member
where userid = 'leess';

--***********************************************************************************************--
-- 결제완료시, 각각의 테이블 delete,insert,update등 진행하기
-- 주문테이블 dao
select seq_tbl_order_odrcode.nextval AS odrcode
from dual;
-- 주문테이블에 insert
insert into tbl_order(odrcode,fk_userid,odrtotalprice,odrdate,totalquantity)
values(?,?,?,?,?);
-- 주문상세테이블에 insert
insert into tbl_orderdetail(odrseqnum,fk_odrcode,fk_pseq,oqty,odrprice,deliverstatus,deliverdate,cancelstatus,FK_OPSEQ)
values(seq_tbl_orderdetail_odrseqnum.nextval,?,?,?,?,default,?,default,?); -- deliverdate는 안쓰면 null이므로 그냥 빼도 된다.

-- 주문진행테이블에 해당 userid의 행이 몇개인지 확인
select count(*) 
from tbl_orderProgress
where fk_userid = 'eomjh';
-- 주문진행테이블 모두 delete
delete from tbl_orderProgress
where fk_userid = ?;

-- 장바구니에 해당 옵션번호가 존재하는지 select
select count(*)
from tbl_cart
where fk_userid = 'eomjh' and fk_opseq = 20;
-- 장바구니에서 해당 옵션번호 delete
delete from tbl_cart
where fk_userid = ? and fk_opseq = ?;

-- 위시리스트에 해당 옵션번호가 존재하는지 select
select count(*)
from tbl_wishlist
where fk_userid = 'eomjh' and fk_opseq = 4;
-- 위시리스트에서 해당 옵션번호 delete
delete from tbl_wishlist
where fk_userid = ? and fk_opseq = ?;

-- 해당하는 옵션번호의 재고량 감하기(update)
update tbl_poption set cnt = cnt - ?
where opseq = ?;

--***********************************************************************************************--
-- 상세페이지 dao
-- 최근본목록 리스트에 해당제품이 있는지 select
select count(*)
from tbl_recentViewProduct
where fk_userid = 'eomjh' and fk_pseq = 3;
-- 존재하는 경우 update
update tbl_recentViewProduct set viewday = sysdate
where fk_userid = ? and fk_pseq = ?;
-- 존재하지 않는 경우 insert
insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(seq_tbl_rvProduct_recentseq.nextval,?,?,default);

-- 위시리스트에 해당제품이 있는지 select
select count(*)
from tbl_wishlist
where fk_userid = 'eomjh' and fk_opseq = 20;
-- 위시리스트에 존재하는 건 등록일자를 update
update tbl_wishlist set enrollmentday = sysdate
where fk_userid = ? and fk_opseq = ?;
-- fk_opseq로 fk_pseq알아오기
select P.pseq
from tbl_product P JOIN tbl_poption O
ON P.pseq = O.fk_pseq
where O.opseq = 20;
-- 위시리스트에 insert
insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq,enrollmentday) 
values(seq_tbl_wishlist_wishseq.nextval,?,?,?,default);

--***********************************************************************************************--
-- 적립금 dao
-- 구현을 위해 포인트테이블에 행들 insert함.
insert into tbl_point(fk_odrcode,fk_userid,point)
values('s20211019-33','orange3088',635);

insert into tbl_point(fk_odrcode,fk_userid,point)
values('s20211019-34','orange3088',314);

insert into tbl_point(fk_odrcode,fk_userid,point)
values('s20211019-37','leess',315);

-- 테스트샘플들
insert into tbl_order(odrcode,fk_userid,odrtotalprice,odrdate,totalquantity)
values('22','leess',76500,'210903',1);
insert into tbl_orderdetail(odrseqnum,fk_odrcode,fk_pseq,oqty,odrprice,FK_OPSEQ)
values(32,'22',6,1,76500,7);
insert into tbl_point(fk_odrcode,fk_userid,start_day,end_day,p_status,p_idle,point,odrdate)
values('22','leess','210923','220214',0,0,765,'210903');
--
insert into tbl_order(odrcode,fk_userid,odrtotalprice,odrdate,totalquantity)
values('24','leess',78000,'210902',1);
insert into tbl_orderdetail(odrseqnum,fk_odrcode,fk_pseq,oqty,odrprice,FK_OPSEQ)
values(34,'24',11,1,78000,14);
insert into tbl_point(fk_odrcode,fk_userid,start_day,end_day,p_status,p_idle,point,odrdate)
values('24','leess','210922','220213',0,0,780,'210902');
--
insert into tbl_order(odrcode,fk_userid,odrtotalprice,odrdate,totalquantity)
values('25','leess',86400,'210901',1);
insert into tbl_orderdetail(odrseqnum,fk_odrcode,fk_pseq,oqty,odrprice,FK_OPSEQ)
values(38,'25',4,1,86400,5);
insert into tbl_point(fk_odrcode,fk_userid,start_day,end_day,p_status,p_idle,point,odrdate)
values('25','leess','210921','220212',0,0,864,'210901');

--delete from tbl_order where odrcode = '22';
--delete from tbl_orderdetail where fk_odrcode = '22';
--delete from tbl_point where fk_odrcode = '22';


-- 회원의 모든 포인트 총합 구하기
select sum(point)
from tbl_point
where fk_userid = 'leess' 
and sysdate >= start_day 
and sysdate <= end_day 
and p_status = 0 and p_idle = 0;
-- 사용 가능한 적립금 목록을 보여줌
-- 사용가능한 포인트 : sysdate가 stary_day와 end_day사이에 있고, p_status가 0이고, p_idle이 0인거 비교
select fk_odrcode, end_day, point
from tbl_point
where fk_userid = 'leess' 
and sysdate >= start_day 
and sysdate <= end_day 
and p_status = 0 and p_idle = 0;
-- 주문완료시, 포인트테이블에 insert하기
insert into tbl_point(fk_odrcode,fk_userid,point,p_idle)
values(?,?,?,1);
-- 적립금 사용시, 해당 포인트 테이블의 값 변경하기(p_status,p_idle)
update tbl_point set p_status = 1, p_idle = 0
where fk_odrcode = ?;

----------------------------------------------------------------------------
--delete from tbl_orderProgress;
commit;
rollback;

show user;

select * from tab;

select * from tbl_categoryU;
select * from tbl_categoryL;
select * from tbl_product;
select * from tbl_pcolor;
select * from tbl_poption;
select * from tbl_recentViewProduct;
select * from tbl_cart;
select * from tbl_wishlist order by wishseq desc;
select * from tbl_order;
select * from tbl_orderdetail;

select * from tbl_orderProgress;

select * from tbl_member; -- leess, eomjh

select * from tbl_point;
desc tbl_point;

desc tbl_member;
desc tbl_recentViewProduct;
desc tbl_wishlist;
desc tbl_orderProgress;
desc tbl_cart;
desc tbl_order;
desc tbl_orderdetail;

-- 제약조건 알아보기
select * from user_constraints
where table_name = 'TBL_ORDERDETAIL';
------------------------------------------------------------------------------