<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../header.jsp" />

<style>

	table > tbody > tr > td.verticalM { /* 테이블 안에 있는 td태그들을 세로방향으로 가운데정렬  */
		vertical-align: middle;
	}
	
</style>
	
	<div class = "container px-0">
	
		<div class="border border-muted mx-auto" style="display:table; width:150px; height:25px; text-align: center;">
			<h4 class="h4" style="display:table-cell; vertical-align: middle">WISH LIST</h4> <!-- 세로방향으로 가운데정렬 -->
		</div>
		<br>
		
		<!-- 위시리스트 테이블 시작 -->
		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
					<tr style="text-align: center;"> <!-- 글자 가운데정렬 -->
						<th>
							<!-- 모두선택/해제 => /JavaScriptStudy/WebContent/05checkbox/01checkBoxTest.html를 참고함. -->
							<input type="checkbox" id="allCheck" onClick="fun_allCheck(this.checked);" />
						</th>
						<th>이미지</th>
						<th>상품명</th>
						<th>판매가</th>
						<th>적립금</th>
						<th>배송구분</th>
						<th>배송비</th>
						<th>합계</th>
						<th>선택</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="verticalM" align="center"> <!-- 모두선택/해제 => 이 부분의 name,id,value 등은 값 바꿔줘야해~~~ -->
							<input type="checkbox" name="product_china" id="product_china1" value="china01" onclick="fun_chinaCheck()" />
						</td>
						<td class="verticalM" align="center"><img alt="300.jpg" src="../images/300.jpg" width="90" height="100"></td>
						<td class="verticalM">
							<strong>상품명이 들어갈 곳 riha angora cardigan(5color)</strong>
							<ul style="margin-top: 15px;">
								<li>[옵션: 브라운]</li>
							</ul>
						</td>
						<td class="verticalM" align="center"><strong>28,900원</strong></td>
						<td class="verticalM" align="center">
							<img alt="301coins.png" src="../images/301coins.png" width="15" height="15">
							<span>289원</span>
						</td>
						<td class="verticalM" align="center"><span>기본배송</span></td>
						<td class="verticalM" align="center">
							<div>조건부무료</div>
							<button type="button" class="btn btn-outline-secondary" data-toggle="tooltip" data-placement="bottom" title="10만원이상 무배! (기본2,500원)">자세히▶</button>
						</td>
						<td class="verticalM" align="center"><strong>31,400원</strong></td>
						<td class="verticalM" align="center"> <!-- align을 통해 내부를 가운데정렬 -->
							<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">장바구니</button>
							<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">주문하기</button>
							<button type="button" class="btn btn-outline-secondary" style="display: block;">삭제하기</button>
						</td>
					</tr>
					<tr>
						<td class="verticalM" align="center"> <!-- 모두선택/해제 => 이 부분의 name,id,value 등은 값 바꿔줘야해~~~ -->
							<input type="checkbox" name="product_china" id="product_china2" value="china02" onclick="fun_chinaCheck()" />
						</td>
						<td class="verticalM" align="center"><img alt="302.jpg" src="../images/302.jpg" width="90" height="100"></td>
						<td class="verticalM">
							<strong>상품명이 들어갈 곳 toy cotton pants(4color)</strong>
						</td>
						<td class="verticalM" align="center"><strong>17,900원</strong></td>
						<td class="verticalM" align="center">
							<img alt="301coins.png" src="../images/301coins.png" width="15" height="15">
							<span>179원</span>
						</td>
						<td class="verticalM" align="center"><span>기본배송</span></td>
						<td class="verticalM" align="center">
							<div>조건부무료</div>
							<button type="button" class="btn btn-outline-secondary" data-toggle="tooltip" data-placement="bottom" title="10만원이상 무배! (기본2,500원)">자세히▶</button>
						</td>
						<td class="verticalM" align="center"><strong>31,400원</strong></td>
						<td class="verticalM" align="center"> <!-- align을 통해 내부를 가운데정렬 -->
							<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">장바구니</button>
							<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">주문하기</button>
							<button type="button" class="btn btn-outline-secondary" style="display: block;">삭제하기</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 위시리스트 테이블 끝 -->
		
		
		<div>
			<div style="float: left;">
				<button type="button" class="btn btn-outline-secondary" style="margin-right: 5px;"><i class="fas fa-times"></i>&nbsp;삭제하기</button>
				<button type="button" class="btn btn-outline-secondary" style="margin-right: 5px;">관심상품 비우기</button>
				<button type="button" class="btn btn-outline-secondary" style="margin-right: 5px;">장바구니 담기</button>
			</div>
			
			<div style="float: right;">
				<button type="button" class="btn btn-dark btn-lg">전체상품주문</button>
			</div>
		</div>
		
		
		
		<!-- 페이지바 시작 -->
		<nav style="clear: both;">
		  <ul class="pagination justify-content-center" style="margin-top: 50px;">
		  	<li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&laquo;&laquo;</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&laquo;</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">1</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">2</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">3</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&raquo;</span></a></li> 
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&raquo;&raquo;</span></a></li> 
		  </ul>
		</nav>
		<!-- 페이지바 끝 -->
		
	</div>
	
<jsp:include page="../footer.jsp" />