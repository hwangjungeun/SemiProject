<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" />

<style>

	table > tbody > tr > td.verticalM { /* 테이블 안에 있는 td태그들을 세로방향으로 가운데정렬  */
		vertical-align: middle;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("select#colorOptSelect").click(function(){
			
			$.ajax({
				url:"<%= request.getContextPath()%>/product/viewColorOption.go",
				
			});
			
		});
		
	});// end of $("select#colorOptSelect").click(function(){})--------------------------------
	
</script>
	
	<div class = "container px-0">
	
		<div class="border border-muted mx-auto" style="display:table; width:150px; height:25px; text-align: center;">
			<h4 class="h4" style="display:table-cell; vertical-align: middle">RECENT LIST</h4> <!-- 세로방향으로 가운데정렬 -->
		</div>
		<br>
		
		
		
		<!-- 최근본상품 리스트 테이블 시작 -->
		<c:if test="${empty requestScope.productList}"> <!-- 없든지 텅빈거다. -->
			<h4 style="border-top: solid 1px #d9d9d9; border-bottom: solid 1px #d9d9d9; padding-top: 50px; padding-bottom: 50px;" align="center">최근 본 상품 내역이 없습니다.</h4>
		</c:if>
		
		<c:if test="${not empty requestScope.productList}">
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
						<c:forEach var="rvpvo" items="${requestScope.productList}">
							
							<tr>
								<td class="verticalM" align="center"><img alt="${rvpvo.pvo.pimage}" src="../images/${rvpvo.pvo.pimage}" width="90" height="100"></td>
								<td class="verticalM"><div>${rvpvo.pvo.pname}(3color)</div></td>
								<td class="verticalM">
									<ul>
										<li>
											컬러 : <br>
											<select id="colorOptSelect" style="width: 100%"> <!-- select태그의 너비를 양옆으로 쫙 넓힘 -->
												<option>-[필수]옵션을 선택해 주세요-</option>
												<!-- <option>아이보리</option>
												<option>블루</option>
												<option>카키</option>
												<option>피치[품절]</option> -->
											</select>
										</li>
									</ul>
								</td>
								<td class="verticalM" align="center"><strong>${rvpvo.pvo.price}원</strong></td>
								<td class="verticalM" align="center"> <!-- align을 통해 내부를 가운데정렬 -->
									<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">장바구니</button>
									<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;">주문하기</button>
									<button type="button" class="btn btn-outline-secondary" style="display: block;">삭제하기</button>
								</td>
							</tr>
							
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- 최근본상품 리스트 테이블 끝 -->
		</c:if>
		
		
		
		
		<!-- 페이지바 시작 -->
		<nav>
		  <ul class="pagination justify-content-center" style="margin-top: 30px;">
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