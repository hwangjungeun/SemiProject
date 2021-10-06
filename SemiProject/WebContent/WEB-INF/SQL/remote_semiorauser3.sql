
---- Semi Project ----

show user;

select * from tab;

select * from tbl_member;

---- 2021-10-05 eXERD ----
-- **** 카테고리 테이블 생성하기 **** --
create table tbl_category
(cseq   NUMBER(8)                   -- 카테고리대분류번호
,code   VARCHAR2(20)    not null    -- 카테고리코드
,cname  VARCHAR2(100)   not null    -- 카테고리명
,constraint PK_tbl_category primary key(cseq)
,constraint UQ_tbl_category unique(code)
);
--Table TBL_CATEGORY이(가) 생성되었습니다.

-- **** 카테고리대분류번호 시퀀스 생성하기 **** --
create sequence cseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence CSEQ이(가) 생성되었습니다.

-- **** 제품스펙 테이블 생성하기 **** --
create table tbl_spec
(sseq   NUMBER(8)                   -- 스펙번호
,sname  VARCHAR2(100)   not null    -- 스펙명
,constraint PK_tbl_spec primary key(sseq)
,constraint UQ_tbl_spec unique(sname)
);
--Table TBL_SPEC이(가) 생성되었습니다.

-- **** 스펙번호 시퀀스 생성하기 **** --
create sequence sseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence SSEQ이(가) 생성되었습니다.

-- **** 제품 테이블 생성하기 **** --
create table tbl_product
(pseq           NUMBER(8)                               -- 제품번호
,pname          VARCHAR2(100)   not null                -- 제품명
,fk_cseq        NUMBER(8)       not null                -- 카테고리대분류번호
,pimage1        VARCHAR2(100)   default 'noimage.png'     -- 제품이미지1
,pimage2        VARCHAR2(100)   default 'noimage.png'     -- 제품이미지2
,pqty           NUMBER(8)       default 2               -- 제품재고량
,price          NUMBER(8)       default 0               -- 제품정가
,fk_sseq        NUMBER(8)                               -- 스펙번호
,pcontent       VARCHAR2(4000)                          -- 제품설명
,point          NUMBER(8)       default 0               -- 포인트점수
,pinputdate     DATE            default sysdate         -- 제품입고일자
,constraint PK_tbl_product primary key(pseq)
,constraint FK_tbl_product foreign key(fk_cseq) references tbl_category(cseq)
,constraint FK_tbl_product2 foreign key(fk_sseq) references tbl_spec(sseq)
);
-- Table TBL_PRODUCT이(가) 생성되었습니다.

-- **** 제품번호 시퀀스 생성하기 **** --
create sequence pseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence PSEQ이(가) 생성되었습니다.
-------------------------------------------------------------------------
-- **** 장바구니 테이블 생성하기 **** --
create table tbl_cart
(cartseq       NUMBER                   -- 장바구니번호
,fk_userid     VARCHAR2(40) not null    -- 회원아이디 
,fk_pseq       NUMBER(8)    not null    -- 제품번호
,oqty          NUMBER(4)    default 0   -- 주문량
,registerday   date     default sysdate -- 입력일자
,constraint PK_tbl_cart primary key(cartseq)
,constraint FK_tbl_cart foreign key(fk_userid) references tbl_member(userid)
,constraint FK_tbl_cart2 foreign key(fk_pseq) references tbl_product(pseq)
);
-- --Table TBL_CART이(가) 생성되었습니다.

-- **** 장바구니 시퀀스 생성하기 **** --
create sequence cartseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- --Sequence CARTSEQ이(가) 생성되었습니다.

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
create sequence odrcodeseq
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
create sequence odrseqnumseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence ODRSEQNUMSEQ이(가) 생성되었습니다.

-------------------------------------------------------------------------------

---- *** tbl_category(카테고리) 예시 insert *** ----
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'OUTER_jk', '아우터_재킷');
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'OUTER_cardi', '아우터_가디건');
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'TOP_tshirts', '탑_티셔츠');
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'TOP_knit', '탑_니트');
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'BLOUSE_blouse', '블라우스_블라우스');
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'PANTS_denim', '팬츠_데님');
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'SKIRT_mini', '스커트_미니');
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'DRESS_onepiece', '드레스_원피스');
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'BAG_backpack', '백_백팩');
insert into tbl_category(cseq, code, cname) values(cseq.nextval, 'ACC_earring', '악세사리_귀걸이');
-- 1 행 이(가) 삽입되었습니다.
commit;
--커밋 완료.

select * from tbl_category;


---- *** tbl_spec(제품스펙) 예시 insert *** ----
insert into tbl_spec(sseq, sname) values(sseq.nextval, 'BL_S'); -- 블랙_ S
insert into tbl_spec(sseq, sname) values(sseq.nextval, 'BL_M'); -- 블랙_ M
insert into tbl_spec(sseq, sname) values(sseq.nextval, 'WH_S'); -- 화이트_S
insert into tbl_spec(sseq, sname) values(sseq.nextval, 'WH_M'); -- 화이트_M
insert into tbl_spec(sseq, sname) values(sseq.nextval, 'GR_S'); -- 그린_S
insert into tbl_spec(sseq, sname) values(sseq.nextval, 'GR_M'); -- 그린_M
-- 1 행 이(가) 삽입되었습니다.
update tbl_spec set sname = 'Black_M'
where sseq = 2;
update tbl_spec set sname = 'Black_S'
where sseq = 1;
update tbl_spec set sname = 'Green_M'
where sseq = 6;
update tbl_spec set sname = 'Green_S'
where sseq = 5;
update tbl_spec set sname = 'White_M'
where sseq = 4;
update tbl_spec set sname = 'White_S'
where sseq = 3;
-- 1 행 이(가) 업데이트되었습니다.
insert into tbl_spec(sseq, sname) values(sseq.nextval, 'BLUE_M');
insert into tbl_spec(sseq, sname) values(sseq.nextval, 'BLUE_S');
commit;
--커밋 완료.

select * from tbl_spec;

---- *** tbl_product(제품) 예시 insert *** ----
insert into tbl_product(pseq,pname,fk_cseq,pimage1,pimage2,pqty,price,fk_sseq,pcontent,point,pinputdate)
values(pseq.nextval,'pomme kint',4,'307.jpg','308.jpg',2,22100,4,'크롭기장의 꽈배기 니트 보여드려요 ! 부드러운 감촉이 매력적이 제품으로로 까슬거림없이 착용가능한 니트제품입니다 ! 적당한 두께감으로 단독으로 착용하거나 한겨울 이너로도 착용하기 좋은 두께감으로 자주 손이 갈 아이템입니다 .',22100*0.01,sysdate);

insert into tbl_product(pseq,pname,fk_cseq,pimage1,pimage2,pqty,price,fk_sseq,pcontent,point,pinputdate)
values(pseq.nextval,'standard jacket',1,'309.jpg','310.jpg',2,69000,1,'군더더기 없는 디자인에 정돈된 핏이 돋보이는 싱글버튼 자켓이에요 :) 어깨패드가 숄더라인 실루엣을 잡아주어 부담스럽지 않은 오버핏을 선사하고, 매트한 질감의 폴리혼방 소재로 매끈하고 고급스러운 원단이 매력적이에요! 스탠다드 자켓 추천해요 :)',69000*0.01,sysdate);

insert into tbl_product(pseq,pname,fk_cseq,pimage1,pimage2,pqty,price,fk_sseq,pcontent,point,pinputdate)
values(pseq.nextval,'riha angora cardigan',2,'300.jpg','300_2.jpg',4,28900,6,'데일리한 무드로 활용도 높게 착용하기 좋은 브이넥 니트가디건 소개해드려요 데일리하게 내어입기 좋은 핏이며, 티셔츠에나, 단독으로 입으셔도 타이트 하지 않은 여유있는 핏으로 더욱 슬림하게 연출해드려요, 컬러는 총 5가지 컬러보여드릴게요',28900*0.01,sysdate);

insert into tbl_product(pseq,pname,fk_cseq,pimage1,pimage2,pqty,price,fk_sseq,pcontent,point,pinputdate)
values(pseq.nextval,'toy cotton pants',6,'302.jpg','302_2.jpg',2,28900,4,'군더더기없는 깔끔한 아웃핏의 팬츠입니다 ! 일자로 깔끔하게 떨어지는 스트레이트라인으로 슬림한 연출이 가능해요 어디에나 매치하기좋은 깔끔한 디자인으로 차분한 톤 색감이 주는 멋스러운 무드가 돋보이는 팬츠로 계절구애없이 착용가능합니다 ♡',28900*0.01,sysdate);

update tbl_product set pimage1='300_1.jpg'
where pseq = 11;

update tbl_product set pimage1='302_1.jpg'
where pseq = 12;

insert into tbl_product(pseq,pname,fk_cseq,pimage1,pimage2,pqty,price,fk_sseq,pcontent,point,pinputdate)
values(pseq.nextval,'sweep alpaca knit',4,'303_1.jpg','303_2.jpg',2,47600,7,'울과 알파카 소재 혼방으로 따뜻하게 착용하기 좋구요! 롱헤어감이 느껴지는 니트 소재로, 고급스러운 무드가 연출돼요! 톡톡 튀는 컬러감으로 포인트 주기 좋으니, 얼른 소장해보세요! :-)',47600*0.01,sysdate);

insert into tbl_product(pseq,pname,fk_cseq,pimage1,pimage2,pqty,price,fk_sseq,pcontent,point,pinputdate)
values(pseq.nextval,'chemi autumn pants',6,'305_1.jpg','305_2.jpg',2,29000,4,'가을버전의 버너데님 보여드려요 ! 코튼 소재로 제작된 팬츠로 탄탄한 소재로 데일리하게 입기 좋은 팬츠에요! 적당히 여유있는 일자핏의 팬츠로 블랙과 아이보리의 베이직한 컬러로 보여드릴게요 ♡',29000*0.01,sysdate);

insert into tbl_product(pseq,pname,fk_cseq,pimage1,pimage2,pqty,price,fk_sseq,pcontent,point,pinputdate)
values(pseq.nextval,'sente knit',4,'306_1.jpg','306_2.jpg',5,34000,3,'단가라로 포인트 주기좋은 베이직한 니트예요! 밑단과 소맷단의 탄탄한 시보리라인으로 슬림한 허리라인 연출이 가능한 아이템입니다 ! 손등을 덮는 소매길이로 여리여리한 연출이 가능한 니트입니다 ! 총 세가지 컬러 보여드릴게요',34000*0.01,sysdate);

commit;
-- 커밋 완료.

select * from tbl_product;




----2021-10-06 수------------------------------------------------------------

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
create sequence recentseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence RECENTSEQ이(가) 생성되었습니다.

-- **** 위시리스트 테이블 생성하기 **** --
create table tbl_wishlist
(wishseq     NUMBER                    -- 위시리스트번호
,fk_userid     VARCHAR2(40) not null   -- 회원아이디 
,fk_pseq       NUMBER(8)    not null   -- 제품번호

,constraint PK_tbl_wishlist primary key(wishseq)
,constraint FK_tbl_wishlist foreign key(fk_userid) references tbl_member(userid)
,constraint FK_tbl_wishlist2 foreign key(fk_pseq) references tbl_product(pseq)
);
--Table TBL_WISHLIST이(가) 생성되었습니다.

-- **** 위시리스트 시퀀스 생성하기 **** --
create sequence wishseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence WISHSEQ이(가) 생성되었습니다.

------------------------------------------------
select * from tbl_category;
select * from tbl_spec;
select * from tbl_product;
select * from tbl_cart;
select * from tbl_order;
select * from tbl_orderdetail;
select * from tbl_recentViewProduct;
select * from tbl_wishlist;
select * from tbl_member; -- leess, eomjh

desc tbl_member;

-- 최근 본 상품 Action단
insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(recentseq.nextval,'eomjh',1,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(recentseq.nextval,'eomjh',2,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(recentseq.nextval,'leess',11,sysdate);

insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday)
values(recentseq.nextval,'leess',12,sysdate);

commit;
-- 커밋 완료.


-- 최근 본 상품 dao
select pname, pimage1, pimage2, price, fk_sseq, viewday
from tbl_recentViewProduct V JOIN tbl_product P
ON V.fk_pseq = P.pseq
where fk_userid = 'eomjh'
order by viewday desc;


