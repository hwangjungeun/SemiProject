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
	
	// Function Declaration
	// == 체크박스 전체선택 / 전체해제 == //
	function fun_allCheck(bool){
		
		// console.log("확인용 bool => " + bool);
		
		var arrProduct_wish = document.getElementsByName("product_wish");
		
		for(var i=0; i<arrProduct_wish.length; i++){
			arrProduct_wish[i].checked = bool; /* 넘어온게 true면 true, false면 false */
		}// end of for-------------------------------
			
	}// end of function fun_allCheck(bool){}----------------------------
	
	
	// == 체크박스 전체선택 / 전체해제 에서 
	//    하위 체크박스에 체크가 1개라도 체크가 해제되면 체크박스 전체선택/전체해제 체크박스도 체크가 해제되고
	//    하위 체크박스에 체크가 모두 체크가 되어지면  체크박스 전체선택/전체해제 체크박스도 체크가 되어지도록 하는 것 == // 
	function fun_wishCheck(){
		
		var arrProduct_wish = document.getElementsByName("product_wish");
		
		var bFlag = false;
		for(var i=0; i<arrProduct_wish.length; i++){
			
			if( !arrProduct_wish[i].checked ){
				// 하위 체크박스(위시리스트 제품 체크박스)에 체크가 1개라도 체크가 해제되면
				bFlag = true;
				break; /* 더이상 나머지 체크박스에 해제된게 있는지 확인할 필요는 없음 */
			}
			
		}// end of for---------------------------------
		
		if(bFlag){
			// 하위 체크박스(위시리스트 제품 체크박스)에 체크가 1개라도 체크가 해제되면
			document.getElementById("allCheck").checked = false;
		}
		else{
			// 하위 체크박스(위시리스트 제품 체크박스)에 모두가 체크가 된 경우라면
			document.getElementById("allCheck").checked = true;
		}
		
	}// end of function fun_wishCheck(){-------------------------------
	
	
</script>
	
	<div class = "container px-0">
	
		<div class="border border-muted mx-auto" style="display:table; width:150px; height:30px; text-align: center;">
			<h3 class="h3" style="display:table-cell; vertical-align: middle">WISH LIST</h3> <!-- 세로방향으로 가운데정렬 -->
		</div>
		<br>
		
		
		
		<!-- wishList가 존재하는지 존재안하는지에 따라 달라짐. 시작-->
		<c:if test="${empty requestScope.wishList}"> <!-- 없든지 텅빈거다. -->
			<h4 style="border-top: solid 1px #d9d9d9; border-bottom: solid 1px #d9d9d9; padding-top: 50px; padding-bottom: 50px;" align="center">위시리스트 내역이 없습니다.</h4>
		</c:if>
		
		<c:if test="${not empty requestScope.wishList}">
		
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
						<c:forEach var="wlvo" items="${requestScope.wishList}" >
							
							<tr>
								<td class="verticalM" align="center"> <!-- 모두선택/해제 => 이 부분의 name,id,value 등은 값 바꿔줘야해~~~ -->
									<input type="checkbox" name="product_wish" onclick="fun_wishCheck()" />
								</td>
								<td class="verticalM" align="center"><img alt="${wlvo.povo.cimage}" src="../images/${wlvo.povo.cimage}" width="90" height="100"></td>
								<td class="verticalM">
									<strong>${wlvo.pvo.pname}(5color)</strong>
									<ul style="margin-top: 15px;">
										<li>[옵션: ${wlvo.povo.pcvo.cname}]</li>
									</ul>
								</td>
								<td class="verticalM" align="center"><strong>${wlvo.pvo.price}원</strong></td>
								<td class="verticalM" align="center">
									<img alt="301coins.png" src="../images/301coins.png" width="15" height="15">
									<span>${wlvo.pvo.point}원</span>
								</td>
								<td class="verticalM" align="center"><span>기본배송</span></td>
								<td class="verticalM" align="center">
									<div>조건부무료</div>
									<button type="button" class="btn btn-outline-secondary" data-toggle="tooltip" data-placement="bottom" title="10만원이상 무배! (기본2,500원)">자세히▶</button>
								</td>
								<td class="verticalM" align="center"><strong>${wlvo.pvo.price+2500}원</strong></td> <!-- ★더하기 계산하는법 -->
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
			
		</c:if>
		<!-- wishList가 존재하는지 존재안하는지에 따라 달라짐. 끝-->
		
	</div>
	
<jsp:include page="../footer.jsp" />