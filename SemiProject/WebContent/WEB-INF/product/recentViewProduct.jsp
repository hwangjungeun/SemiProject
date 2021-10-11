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
		
		$("select[name=colorOptSelect]").click(function(){
			
		//	console.log("확인용 : select 태그를 클릭하셨습니다.");
			
			var index = $("select[name=colorOptSelect]").index(this); // 여러개의 select태그 중에서 내가 클릭한 곳(this)의 인덱스 // ★name과 index이용
		//	console.log("~~ 확인용 index => " + index);
			
			
			var OnlyOneExecute = $("select[name=colorOptSelect]").eq(index).next().val(); // 색상을 ajax로 select했는지 알아오는 용도
		//	console.log("OnlyOneExecute ==> " + OnlyOneExecute); // 처음엔 0인데 색상을 가져오면 1로 변경된다.
			
			if(OnlyOneExecute == "0"){ // select태그를 클릭하고 '딱 한번만' option태그에 색상들의 종류를 넣도록 하기 위함.
				
				var pseq = $(this).prev().prev().val();
			//	console.log("$(this).prev().prev().val() => " + $(this).prev().prev().val()); // pseq(제품번호)가 나옴. // prev()는 br이므로 한번 더 prev()함.
				
				$.ajax({
					url:"<%= request.getContextPath()%>/product/viewColorOption.go",
				//	type:"post", // 안쓰면 get방식이다.
					data:{"pseq":pseq},
					dataType:"json",
					success:function(json){
						// json ==> [{"CNAME":"blue"},{"CNAME":"pink"}]
						// 예시1) json ==> {"isExists":true} // 예시2) json ==> {"isUse":true} 또는 {"isUse":false}
					 	
					 	var html = "";
					 	
					 	$.each(json,function(index,item){
					 		
					 		html += "<option>"+item.CNAME+"</option>";
					 		
					 	});// json을 반복문 돌림.
					 	
				 		$("select[name=colorOptSelect]").eq(index).append(html); // html로 하면 select-option태그를 누르면 select태그가 다시 초기화되므로, 원하는 값으로 변경이 안된다. 따라서 append사용 // ★eq(index)이용
				 		$("select[name=colorOptSelect]").eq(index).next().val("1");
					},
					error: function(request, status, error){
		            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
				});// end of $.ajax()------------------------------------------------------------------------------
				
			}// end of if(OnlyOneExecute == "0")-------------------------------------------------------------------
			
		});// end of $("select#colorOptSelect").click(function(){})------------------------------------------------
		
	});// end of $(document).ready(function(){})----------------------------------------------------------------------------
	
</script>
	
	<div class = "container px-0">
	
		<div class="border border-muted mx-auto" style="display:table; width:150px; height:30px; text-align: center;">
			<h3 class="h3" style="display:table-cell; vertical-align: middle">RECENT LIST</h3> <!-- 세로방향으로 가운데정렬 -->
		</div>
		<br>
		
		
		
		<!-- productList가 존재하는지 존재안하는지에 따라 달라짐. 시작 -->
		<c:if test="${empty requestScope.productList}"> <!-- 없든지 텅빈거다. -->
			<h4 style="border-top: solid 1px #d9d9d9; border-bottom: solid 1px #d9d9d9; padding-top: 50px; padding-bottom: 50px;" align="center">최근 본 상품 내역이 없습니다.</h4>
		</c:if>
		
		<c:if test="${not empty requestScope.productList}">
		
			<!-- 최근본상품 리스트 테이블 시작 -->
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
						<c:forEach var="rvpvo" items="${requestScope.productList}" >
							
							<tr>
								<td class="verticalM" align="center"><img alt="${rvpvo.pvo.pimage}" src="../images/${rvpvo.pvo.pimage}" width="90" height="100"></td>
								<td class="verticalM"><div>${rvpvo.pvo.pname}(3color)</div></td>
								<td class="verticalM">
									<ul>
										<li>
											컬러 : <input type="hidden" value="${rvpvo.pvo.pseq}"/> <br>
											<select name="colorOptSelect" style="width: 100%"> <!-- select태그의 너비를 양옆으로 쫙 넓힘 --> <!-- select태그가 여러개 나오므로 id말고 name을 줌 -->
												<option>-[필수]옵션을 선택해 주세요-</option>
												<!-- <option>아이보리</option>
												<option>피치[품절]</option> -->
											</select>
											<input type="hidden" value="0"> <!-- 색상을 select했는지 알아오는 용도 -->
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
			
		</c:if>
		<!-- productList가 존재하는지 존재안하는지에 따라 달라짐. 끝 -->
		
		
	</div>
	
<jsp:include page="../footer.jsp" />