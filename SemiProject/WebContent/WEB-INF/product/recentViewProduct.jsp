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
			<h4 class="h4" style="display:table-cell; vertical-align: middle">RECENT LIST</h4> <!-- 세로방향으로 가운데정렬 -->
		</div>
		<br>
		
		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
					<tr style="text-align: center;"> <!-- 글자 가운데정렬 -->
						<th>이미지</th>
						<th>상품명</th>
						<th>옵션정보</th>
						<th>판매가</th>
						<th>주문</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="verticalM"><div>상품이미지.jpg</div></td>
						<td class="verticalM"><div>상품명이 들어갈 곳 moreover blouse(3color) *당일배송가능*</div></td>
						<td class="verticalM">
							<ul>
								<li>
									컬러 : <br>
									<select style="width: 100%"> <!-- select태그의 너비를 양옆으로 쫙 넓힘 -->
										<option>-[필수]옵션을 선택해 주세요-</option>
										<option>아이보리</option>
										<option>블루</option>
										<option>카키</option>
										<option>피치[품절]</option>
									</select>
								</li>
								<li>
									사이즈 : <br>
									<select style="width: 100%">
										<option>-[필수]옵션을 선택해 주세요-</option>
										<option>S</option>
										<option>M</option>
									</select>
								</li>
							</ul>
						</td>
						<td class="verticalM" align="center"><strong>39,000원</strong></td>
						<td class="verticalM" align="center"> <!-- align을 통해 내부를 가운데정렬 -->
							<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">장바구니</button>
							<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">주문하기</button>
							<button type="button" class="btn btn-outline-secondary" style="display: block;">삭제하기</button>
						</td>
					</tr>
					<tr>
						<td class="verticalM"><div>상품2이미지.jpg</div></td>
						<td class="verticalM"><div>상품명이 들어갈 곳 sweep alpaca knit(5color)</div></td>
						<td class="verticalM">
							<ul>
								<li>
									컬러 : <br>
									<select style="width: 100%"> <!-- select태그의 너비를 양옆으로 쫙 넓힘 -->
										<option>-[필수]옵션을 선택해 주세요-</option>
										<option>라이트그레이</option>
										<option>다크그레이[품절]</option>
										<option>아이보리[품절]</option>
									</select>
								</li>
							</ul>
						</td>
						<td class="verticalM" align="center"><strong>47,600원</strong></td>
						<td class="verticalM" align="center">
								<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">장바구니</button>
								<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">주문하기</button>
								<button type="button" class="btn btn-outline-secondary" style="display: block;">삭제하기</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<nav>
		  <ul class="pagination justify-content-center">
		  	<li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&laquo;&laquo;</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&laquo;</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">1</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">2</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">3</span></a></li>
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&raquo;</span></a></li> 
		    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&raquo;&raquo;</span></a></li> 
		  </ul>
		</nav>
		
	</div>
	
<jsp:include page="../footer.jsp" />