<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      


<%--
<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>
--%>
<jsp:include page="../header.jsp" />

<style type="text/css">

	.titleArea h2{	
	 	display: inline-block;
	    position: relative;
	    margin: 20px 10px;
	    padding: 8px 15px;
	    min-width: 150px;
	    color: #353535;
	    font-size: 13px;
	    letter-spacing: 1px;
	    border: 1px #ddd solid;
	    text-align: center;
	}
	
	
	div.titleArea::after{ /*상품목록 영역이 조건별조회영역 침범하지 않게 하기 위해서*/
		display:block;
		content:"";
		clear:both;
	}
	
	div.fuction::before, div.fuction::after{ /*상품목록 영역이 조건별조회영역 침범하지 않게 하기 위해서*/
		display:block;
		content:"";
		clear:both;
	}

	div.category::before, div.category::after{ /*상품목록 영역이 조건별조회영역 침범하지 않게 하기 위해서*/
		display:block;
		content:"";
		clear:both;
	}

	
	
	nav.orderBy ul li:first-child {border-left:none;}
	
	
	/*조건별 조회 영역 css*/
	nav.orderBy ul, nav.menuCategory{
		padding-top:10px; /*  상단 여백 10px  */
	}  
	             
	                    
	nav.orderBy ul li, nav.menuCategory ul li {
	    display:inline;    /*  세로나열을 가로나열로 변경 */
	    border-left:1px solid #999;  /* 각 메뉴의 왼쪽에 "|" 표시(분류 표시) */
		padding : 0 10px;
	}
	
	
	nav.orderBy ul li:first-child {border-left:none;}
	
	nav.menuCategory ul li:first-child {border-left:none;}
	
	
	
	
</style>


<script type="text/javascript">


	$(document).ready(function(){
		 
		//alert("확인용");
		
		
	});

</script>



<!-- 해야할 기능들: 베스트품목가져오기/전체품목갯수가져오기/조건별조회/페이징처리/상품상세페이지 -->

<!-- 중앙 컨텐츠 시작 -->
<div class="container">

	<!-- 페이지 제목(best item)영역-->
	<div class="titleArea m-5" align="center">
		<h2>페이지이름</h2>
	</div>
	
	<!-- 베스트 아이템 영역 -->
	<div class="bestItem">
	
		<div class="my-5">
			<h2 class ="text-center" style="letter-spacing: 1px;">
           		<span>-BEST ITEM-</span>
       		</h2>
       	</div>
       	
		<ul class="text-center mb-5">
			<!-- 베스트 상품 품목 보여주는 영역 -->
			<c:forEach var="pvo" items="${requestScope.productList}">
				<li  style="list-style-type:none; margin:7px; float: left;">
					<div class="box" style="width:260px; height:310px;">
						<a>
							<img src="${pvo.imgSource}" class="card-img-top" alt="...">
						</a>
					</div>
				</li>
			</c:forEach>
		</ul>
		
		
		<div class="category my-5"><!-- 상단 카테고리에서 미리 나눌거면 이 영역 삭제해도 됨-->
			
			<hr class="mb-5">
	
			<nav class="menuCategory" style="align:center;">
				<ul class="menuCategory" style="text-align:center; font-size:15px;">
					<li><a href="#">세부1</a></li>
					<li><a href="#">세부2</a></li>
					<li><a href="#">세부3</a></li>
					<li><a href="#">세부4</a></li>
				</ul>
			</nav>
		</div>
	
	</div>


	<!-- 전체 항목/조건별 조회 영역  -->
	<div class="fuction mb-5">
		<p class="prdcount" style="float:left;"> 
			Total: &nbsp;
			<strong>(49)</strong>
			&nbsp; items
		</p>
		<nav class="orderBy" style="float:right;">
			<ul>
				<li><a href="#">신상품</a></li>
				<li><a href="#">상품명</a></li>
				<li><a href="#">낮은가격</a></li>
				<li><a href="#">높은가격</a></li>
				<li><a href="#">사용후기</a></li>
			</ul>
		</nav>
	</div>

	
    <!-- 상품목록 영역 : 데이터 불러와서 넣어줄 예정입니당.(베스트상품 페이지도 동일하게 처리하면 됨)-->
    <!-- 수정부분 : ProductVO 클래스 생성/ header.jsp에 jquery부분 주석해제/ jquery폴더 추가/ ProductListFormAction.java 수정함 -->
    <!-- 해결할 부분 : 1행에 카드 갯수 제한(4개씩) => 카드 크기 고정해야하나? 안됨 따흑,,-->
    <div class="card-deck mb-5">
	    <c:forEach var="pvo" items="${requestScope.productList}">
	    	<div class="col-auto mx-n4"><%--col-auto: 카드 크기 고정, n4는 margin값 음수로 설정 --%>
		    	<div class="card h-50" style="width:255px;">
		   			 <img src="${pvo.imgSource}" class="card-img-top" alt="...">
		   				<div class="card-body">
		     				<h5 class="card-title">${pvo.title}</h5>
		     				<p class="card-text">${pvo.price}</p>
		     				<hr>
		     				<p class="card-text"><small class="text-muted">${pvo.comment}</small></p>
		  				</div>
		 		</div>
	 		</div>
		</c:forEach>
    </div>
       
       
    
    <!-- 페이징영역: -->   
    
    
    
    
     <!-- 실제 들어갈 영역이 아닌 참고영역입니당.-->
    이 밑으로는 실제영역이 아니라 참고영역입니당. 
    
    <div class="card-deck mb-5">
	  <div class="card">
	    <img src="//nearwear.co.kr/web/product/medium/202108/4827ec19d896aea7b1e76aa6bd69f293.webp" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">(unusually) hailey cable cardigan (2color) 파인울50</h5>
	      <p class="card-text">38,000원</p>
	      <hr>
	      <p class="card-text"><small class="text-muted">주문폭주!✨ 겨울까지 계속 꺼내입기좋은 내추럴한 무드의 울 가디건♡ 특별히 신경쓴, 흔치 않은 꽈배기 짜임으로 제작되어 소장가치있는 가디건이에요 :) 원버튼 디테일로 귀여움을 더했구요 클로징하거나 오픈해서 자유롭게 연출이 가능해요!</small></p>
	    </div>
	  </div>
	  <div class="card">
	    <img src="//nearwear.co.kr/web/product/medium/202108/871a4352d70191286fa7af833bc18e9a.webp" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">after jogger pants(3color)</h5>
	      <p class="card-text">25,500원</p>
	      <hr>
	      <p class="card-text"><small class="text-muted">코지한 느낌의 조거팬츠입니다 ! 루즈하고 힙한 핏과 부드러운 코튼원단으로 편안하게 즐기실수있어요! 군더더기없는 라인의 베이직한 라인의 조거팬츠예요 베이직한컬러와 통통 튀는 민트컬러 준비했어요 ♡</small></p>
	    </div>
	  </div>
	  <div class="card">
	    <img src="//nearwear.co.kr/web/product/medium/202108/8d81bfdc61a863a451788241b10d5b34.webp" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">demo zipup mtm (2color) *여유있는 주문 부탁드립니다 :)</h5>
	      <p class="card-text">33,500원</p>
	      <hr>
	      <p class="card-text"><small class="text-muted">코튼소재의 귀여운 집업 맨투맨 입니다! 간절기에 가볍게 걸쳐입기좋은 집업맨투맨으로 이너와 레이어드 하거나 단독으로 입기좋은 두께감이구요, 허리 라인을 살짝 덮는 길이의 귀여운 기장의 맨투맨입니다 , 스커트나 데님에 매치하기좋은 손이자주갈 아이템 추천드려요</small></p>
	    </div>
	  </div>
	  <div class="card">
	    <img src="//nearwear.co.kr/web/product/medium/202109/05695770f20f51bd8aa42ed26fcc61ab.webp" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">weekend cardigan (7color) </h5>
	      <p class="card-text">20,000원</p>
	      <hr>
	      <p class="card-text"><small class="text-muted">캐주얼한 무드의 크롭 가디건이에요, 귀여운 기장감과 부드러운 소재로 단품은 물론 미니멀한 아우터로 활용하기 좋으며, 슬림한 바디라인을 만들어주는 가디건 추천드려요 ♡ 베이직한 컬러들부터 포인트 주기 좋은 다양한 컬러들로 준비했어요 :)</small></p>
	    </div>
	  </div>
	</div>
	<!-- best item 끝 -->
       
	<!-- new item 시작 -->
	<h2 class ="text-center my-5">
           <span>NEW ITEM</span>
       </h2>
       
       <div class="card-deck mb-5">
	  <div class="card">
	    <img src="//www.nearwear.co.kr/web/product/medium/202109/6f7713cdfeeed0b8ea8ca9d5fa86c7f2.webp" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">♡NEW 5%할인!♡ slom alpaca knit (4color) 알파카52 + 울16</h5>
	      <p class="card-text">52,000원</p>
	      <hr>
	      <p class="card-text">가볍지만 보온성은 높여주었고 촉감이 부드러우면서 보송보송해서 아주 편안한 착용감의 라운드넥 니트예요 알파카원단과 울이 블렌딩 되어있는 원단으로 보온성과 편안한 착용감을 도와드려요 바디에 핏되는 라인이아닌 여유잇는 아웃핏의 니트예요 ♡<small class="text-muted"></small></p>
	    </div>
	  </div>
	  <div class="card">
	    <img src="//www.nearwear.co.kr/web/product/medium/202109/fcf525af2a6b1b83541ce1c872a2003d.webp" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">♡NEW 5%할인!♡ maria wool collar knit (3color) 울40</h5>
	      <p class="card-text">49,300원</p>
	      <hr>
	      <p class="card-text">적당한 두께감으로 간절기에 단독으로 입기 좋은 니트 보여드려요! 안정감 있게 파인 브이넥라인이 답답함 없이 착용하기 좋은 제품으로 울과 캐시미어가 블렌딩된 원단으로 소장가치또한 높은 제품입니다 ! 귀여운 단가라니트 총 세가지 컬러 보여드릴게요 !<small class="text-muted"></small></p>
	    </div>
	  </div>
	  <div class="card">
	    <img src="//www.nearwear.co.kr/web/product/medium/202109/e6d1cd4101ac8065a42956df5e7e399c.webp" class="card-img-top" alt="...">
	    <div class="card-body">
	      <h5 class="card-title">ragu crop knit (5color)</h5>
	      <p class="card-text">23,800원</p>
	      <hr>
	      <p class="card-text">심플하게 착용기가능한 베이직한 무드의 니트보여드려요! 전체적으로 노멀한 핏과 기장으로 데일리하게 매치하기 좋은제품이구요 부드러운 착용감으로 까슬거림없이 착용가능한 니트입니다 . 베이직한 컬러들로 총 다섯가지 컬러 보여드릴게요 !<small class="text-muted"></small></p>
	    </div>
	  </div>
	  <div class="card">
	    <img src="//www.nearwear.co.kr/web/product/medium/202109/ac7baf9d6da32e17f369a47d036f6bbe.webp"  class="card-img-top"  alt="...">
	    <div class="card-body">
	      <h5 class="card-title">(unusually) wrap short pants (2color) *베이지컬러 당일배송가능*</h5>
	      <p class="card-text">32,000원</p>
	      <hr>
	      <p class="card-text"><small class="text-muted">클린한 무드의 3부 숏 팬츠 보여드려요 . 많이 짧지않은 기장감의 팬츠로 슬림한 레그라인 연출이 가능하구요 허릿단의 랩디자인으로 포인트를 준 제품입니다 . 적당한 두께감의 팬츠로 데일리하게 꺼내입기 좋은 두께감입니다 두가지 컬러감 보여드릴게요 ♡</small></p>
	    </div>
	  </div>
	</div>
	<!-- new item 끝 -->
</div>
<!-- 중앙 컨텐츠 끝 -->


<jsp:include page="../footer.jsp" />
    