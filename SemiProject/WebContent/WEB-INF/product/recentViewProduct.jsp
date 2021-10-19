<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 돈을 형식에 맞게 찍어주기 위함. -->

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
					 		
					 		html += "<option value="+item.OPSEQ+">"+item.CNAME+"</option>";
					 		
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
	
	
	// Function Declaration
	
	// 해당 제품을 장바구니페이지로 보내주는 함수(그러면 거기서 테이블에 insert도 할꺼임.)
	function goCart(recentseq){
		
		opseq = selectedOpseq(recentseq);
		
		if(opseq == 0){
			alert("필수 옵션을 선택해주세요.");
		}
		else{
			
			// POST방식으로 전송하기위해 폼태그 사용
			var frm = document.RecentViewProdFrm;
			frm.opseq.value = opseq; // 필수옵션을 폼태그의 value값에 넣어줌.
			
			frm.action = "<%= request.getContextPath()%>/order/basket.go";
			frm.method = "POST";
			frm.submit();
			
			// 장바구니에 POST방식으로 전송하면, 거기서 장바구니 테이블에 해당 제품을 insert할꺼다.
			// insert가 되면 최근본상품테이블에 있는 해당 제품도 delete해줄꺼다.
			
		}
		
	}// end of function goCart(recentseq){}------------------------------------
	
	
	// 주문폼 작성시 필요한, 주문예정내역을 보내주는 함수
	function goOrderForm(recentseq){
		
	//	console.log("확인용 recentseq => " + recentseq);
		
		opseq = selectedOpseq(recentseq);
	//	console.log("받아온 opseq => " + opseq);
		
		if(opseq == 0){
			alert("필수 옵션을 선택해주세요.");
		}
		else{
			// 자바스크립트에서 페이지 이동 (최근본상품->주문하기)
			location.href = "<%= request.getContextPath()%>/order/orderForm.go?userid=${sessionScope.loginuser.userid}&opseq="+opseq;
			//																  // ##################################뿌잉##################################
		}
		
	}// end of function goOrderForm(recentseq)----------------------------------
	
	
	// select태그에 선택된 value값을 알아오는 함수
	function selectedOpseq(recentseq){
		
	//	console.log("확인용 => " + $('select#'+recentseq).html());
		
		// jquery로 값 가져오기(★select태그의 id값을 이용해 선택된 값 읽기)
		var opseq = $('select#'+recentseq+' option:selected').val(); // opseq가 0이면 선택을 안한거다.
	//	console.log("확인용 select태그에 선택된 값 => " + opseq);
		// blue에 해당하는 3, pink에 해당하는 4가 나온다. -> opseq
		
		return opseq;
	}// end of function selectedOpseq(recentseq)-----------------------------------
	
	
	// 해당 상품을 최근에본목록에서 삭제하는 함수
	function deleteRecentViewProd(recentseq){
		
		// 정말로 삭제하시겠습니까?
		var bool = confirm("정말로 삭제하시겠습니까?");
	//	console.log("확인용 bool => " + bool);
		
		if(bool){
		
			$.ajax({
				url:"<%= request.getContextPath()%>/product/deleteRecentViewProd.go",
				type:"poST", // 안쓰면 기본 get방식임.
				data:{"recentseq":recentseq},
				dataType:"json",
	    		success:function(json){
	    			
	    			if(json.deleted){
	    				alert("성공적으로 삭제되었습니다.");
	    			}
	    			else{
	    				alert("죄송하지만, 삭제가 실패되었습니다.");
	    			}
	    			
	    		},
	    		error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			});
		
		}
		
		// 삭제하고 난 이후에는 웹브라우저창을 새로고침해야하는데, history.go(0)이 아닌 recentViewProduct.go로 가서 페이지바를 새로 가져온다.
	//	location.href = "javascript:history.go(0)";
		location.href = "<%= request.getContextPath()%>/product/recentViewProduct.go";
		 
	}// end of function deleteRecentViewProd(rentseq)---------------------------------------------------
	
	
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
											<select name="colorOptSelect" id="${rvpvo.recentseq}" style="width: 100%"> <!-- select태그의 너비를 양옆으로 쫙 넓힘 --> <!-- select태그가 여러개 나오므로 id말고 name을 줌 -->
												<option value="0">-[필수]옵션을 선택해 주세요-</option>
												<!-- <option>아이보리</option>
												<option>피치[품절]</option> -->
											</select>
											<input type="hidden" value="0"> <!-- 색상을 select했는지 알아오는 용도 -->
										</li>
									</ul>
								</td>
								<td class="verticalM" align="center"><strong><fmt:formatNumber value="${rvpvo.pvo.price}" pattern="#,###"/>원</strong></td>
								<td class="verticalM" align="center"> <!-- align을 통해 내부를 가운데정렬 -->
									<c:set var="recentseq" value="${rvpvo.recentseq}" />
									<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;" onclick="goCart(${recentseq});">장바구니</button>
									<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;" onclick="goOrderForm(${recentseq});">주문하기</button>
									<button type="button" class="btn btn-outline-secondary" style="display: block;" onclick="deleteRecentViewProd(${recentseq});">삭제하기</button>
								</td>
							</tr>
							
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
			<!-- 장바구니에 POST방식으로 넘기기 위한 폼태그 -->
			<form name="RecentViewProdFrm">
				<input type="hidden" name="opseq" value="" />
			</form>

			<!-- 최근본상품 리스트 테이블 끝 -->
			
			
			
			<!-- 페이지바 시작 -->
			<nav> <!-- 페이지바는 페이지네비게이션(pagination) 이용 -->
				<ul class="pagination justify-content-center" style="margin-top: 30px;">${requestScope.pageBar}</ul>
			</nav>
			<!-- 페이지바 끝 -->
			
			
		</c:if>
		<!-- productList가 존재하는지 존재안하는지에 따라 달라짐. 끝 -->
		
		
	</div>
	
<jsp:include page="../footer.jsp" />
