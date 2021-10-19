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
		
		/*
		$("button#goModal").click(function(){ // 장바구니,주문하기 버튼이 클릭된 경우
			pseq = $(this).val();
			console.log("pseq => " + pseq);
			$("span#realInsert").text(pseq);
			// ##################################################이런느낌으로, 주문하기/장바구니 버튼 클릭시 주문번호와 관련된 정보들을, 모달창에 넣어주도록 하자.
		});// 아................모달창 필요가 없다................ 이미 옵션 기본으로 넣었었다................
		*/
		
	});// end of $(document).ready(function(){})-----------------------------------------------------


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
		
	 	
	// 주문폼 작성시 필요한, 주문예정내역을 보내주는 함수
	function goOrderForm(opseq){
	 
		// 원래 모달창 또는 팝업창으로 옵션선택하려했는데 나는 이미 옵션을 선택했었다.......똥멍청이............
		<%-- 
		// 옵션(색상)과 수량을 선택하는 팝업창 띄우기
		var url = "<%= request.getContextPath()%>/mypage/product/chooseProdOption.go?pseq="+pseq;
		
		// 너비 800, 높이 400 인 팝업창을 화면 가운데 위치시키기
		var pop_width = 800;
		var pop_height = 400; 
		var pop_left = Math.ceil( (window.screen.width - pop_width)/2 ); 스크린의 화면은 소수점이 나오는 경우가 있으므로, 정수로 만듦
		var pop_top = Math.ceil( (window.screen.height - pop_height)/2 ); 정수로 만듦
		
		window.open(url, "chooseProdOption",
					"left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height+", location=no");
		 --%>
		
	//	console.log("확인용 opseq => " + opseq);
		 
		// 자바스크립트에서 페이지 이동 (위시리스트->주문하기)
		location.href = "<%= request.getContextPath()%>/order/orderForm.go?userid=${(sessionScope.loginuser).userid}&opseq="+opseq;
		//																   // ##################################뿌잉##################################
		
	}// end of function goOrderForm(wishseq)-------------------------
	 
	
	// 해당 제품을 장바구니페이지로 보내주는 함수(그러면 거기서 테이블에 insert도 할꺼임.)
	function goCart(opseq){
		
		// POST방식으로 전송하기위해 폼태그 사용
		var frm = document.WishListFrm;
		frm.opseq.value = opseq; // 필수옵션을 폼태그의 value값에 넣어줌.
		
		frm.action = "<%= request.getContextPath()%>/order/basket.go";
		frm.method = "POST";
		frm.submit();
		
		// 장바구니에 POST방식으로 전송하면, 거기서 장바구니 테이블에 해당 제품을 insert할꺼다.
		// insert가 되면 최근본상품테이블에 있는 해당 제품도 delete해줄꺼다.
		
	}// end of function goCart(opseq){}------------------------------------
	
	
	// 해당 상품을 위시리스트에서 삭제하는 함수
	function deleteWishList(wishseq){
		
		// 정말로 삭제하시겠습니까?
		var bool = confirm("정말로 삭제하시겠습니까?");
	//	console.log("확인용 bool => " + bool);
		
		console.log("확인용 wishseq => " + wishseq);
		
		if(bool){
		
			$.ajax({
				url:"<%= request.getContextPath()%>/mypage/deleteWishList.go",
				type:"poST", // 안쓰면 기본 get방식임.
				data:{"wishseq":wishseq},
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
		
		// 삭제하고 난 이후에는 웹브라우저창을 새로고침해야하는데, history.go(0)이 아닌 wishList.go로 가서 페이지바를 새로 가져온다.
	//	location.href = "javascript:history.go(0)";
		location.href = "<%= request.getContextPath()%>/mypage/wishList.go";
		 
	}// end of function deleteWishList(wishseq)---------------------------------------------------
	
	
	// 선택된 체크박스의 opseq들을 장바구니로 보내주는 함수
	function goCheckboxCart(){
		
		// 체크박스가 체크된 것들의 opseq를 문자열 형태로 바꿔줌(예를 들어 "1,15,65,49" 이런식이다.)
		var str_Opseq = checkboxOpseq();
	//	alert("이거 넘겨야해 장바구니 페이지로 => " + str_Opseq);
	
		if(str_Opseq == ""){
			alert("선택된 상품이 없습니다.");
		}
		else{
			goCart(str_Opseq);
		}
		
	}// end of function goCheckboxCart()-----------------------------------------------
	
	
	// 체크가 된 체크박스들의 opseq를 String타입으로 묶어서 반환하는 함수
	function checkboxOpseq(){
		
		// 자바스크립트의 배열은 아래와 같이 나타낸다.(배열도 객체이다.)
		var arrOpseq = new Array();
		// 배열명.push("~~~");
		
		
		var arrProduct_wish = document.getElementsByName("product_wish");
		
		for(var i=0; i<arrProduct_wish.length; i++){ // 체크박스 길이만큼 반복돌림
			
			if( arrProduct_wish[i].checked ){
				// 하위 체크박스(위시리스트 제품 체크박스)에 체크가 된 것이 있다라면
				
				var opseq = arrProduct_wish[i].value;
			//	console.log("체크된 체크박스의 opseq => " + opseq);
				
				arrOpseq.push(opseq);
			}
			
		}// end of for---------------------------------------------
		
		var str_Opseq = arrOpseq.join(",");
	//	alert("확인용 문자열 opseq들의 모임 => " + str_Opseq);
		
		return str_Opseq;
		
	}// end of function checkboxOpseq()-------------------------------------------
	
	
	// 선택된 체크박스의 opseq들을 주문하기로 보내주는 함수
	function goCheckboxOrderForm(){
		
		var str_Opseq = checkboxOpseq();
		
		if(str_Opseq == ""){
			alert("선택된 상품이 없습니다.");
		}
		else{
			goOrderForm(str_Opseq);
		}
		
	}// end of function goCheckboxOrderForm()------------------------------------
	
	
	// 선택된 체크박스의 wishseq들을 위시리스트목록에서 delete하는 함수
	function deleteCheckboxWishList(){
		
		// 정말로 삭제하시겠습니까?
		var bool = confirm("선택하신 상품을 삭제하시겠습니까?");
	//	console.log("확인용 bool => " + bool);
		
		if(bool){ // 삭제진행
			/////////////////////////////////////////////////////////////////////////
			// 자바스크립트의 배열은 아래와 같이 나타낸다.(배열도 객체이다.)
			var arrWishseq = new Array();
			// 배열명.push("~~~");
			
			var arrProduct_wish = document.getElementsByName("product_wish");
			
			for(var i=0; i<arrProduct_wish.length; i++){ // 체크박스 길이만큼 반복돌림
				
				if( arrProduct_wish[i].checked ){
					// 하위 체크박스(위시리스트 제품 체크박스)에 체크가 된 것이 있다라면
					
					var wishseq = arrProduct_wish[i].id;
				//	console.log("체크된 체크박스의 wishseq => " + wishseq);
					
					arrWishseq.push(wishseq);
				}
				
			}// end of for---------------------------------------------
			
			var str_Wishseq = arrWishseq.join(",");
		//	alert("확인용 문자열 wishseq들의 모임 => " + str_Wishseq);
			/////////////////////////////////////////////////////////////////////////	
			
			if(str_Wishseq == ""){
				alert("선택된 상품이 없습니다.");
			}
			else{
				$.ajax({
					url:"<%= request.getContextPath()%>/mypage/deleteWishList.go",
					type:"poST", // 안쓰면 기본 get방식임.
					data:{"wishseq":str_Wishseq},
					dataType:"json",
		    		success:function(json){
		    			
		    			if(json.deleted){
		    				alert("관심상품이 삭제되었습니다.");
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
			
		}
		
	
		// 삭제하고 난 이후에는 웹브라우저창을 새로고침해야하는데, history.go(0)이 아닌 wishList.go로 가서 페이지바를 새로 가져온다.
	//	location.href = "javascript:history.go(0)";
		location.href = "<%= request.getContextPath()%>/mypage/wishList.go";
		
	}// end of function deleteCheckboxWishList()--------------------------------
	
	
	// 위시리스트의 목록을 다 비우기
	function deleteAllWishList() {
		
		var bool = confirm("관심상품을 비우시겠습니까?");
	//	console.log("확인용 bool => " + bool);
		
		if(bool){
			
			$.ajax({
				url:"<%= request.getContextPath()%>/mypage/deleteAllWishList.go",
				type:"poST",
				data:{"fk_userid":"${sessionScope.loginuser.userid}"}, // ##################################뿌잉##################################
				dataType:"json",
	    		success:function(json){
	    			
	    			if(json.deleted){
	    				alert("관심상품이 삭제되었습니다.");
	    			}
	    			else{
	    				alert("죄송하지만, 관심상품 삭제가 실패되었습니다.");
	    			}
	    			
	    		},
	    		error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			});
			
		}
		
	// 삭제하고 난 이후에는 웹브라우저창을 새로고침해야하는데, history.go(0)이 아닌 wishList.go로 가서 페이지바를 새로 가져온다.
	//	location.href = "javascript:history.go(0)";
		location.href = "<%= request.getContextPath()%>/mypage/wishList.go";	
			
	}// end of function deleteAllWishList()----------------------------------------
	
	
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
						
							<c:set var="opseq" value="${wlvo.povo.opseq}" />
							<c:set var="wishseq" value="${wlvo.wishseq}" />
							
							<tr>
								<td class="verticalM" align="center"> <!-- 모두선택/해제 -->
									<input type="checkbox" name="product_wish" onclick="fun_wishCheck()" value="${opseq}" id="${wishseq}" />
								</td>
								<td class="verticalM" align="center"><img alt="${wlvo.povo.cimage}" src="../images/${wlvo.povo.cimage}" width="90" height="100"></td>
								<td class="verticalM">
									<strong>${wlvo.pvo.pname}(5color)</strong>
									<ul style="margin-top: 15px;">
										<li>[옵션: ${wlvo.povo.pcvo.cname}]</li>
									</ul>
								</td>
								<td class="verticalM" align="center"><strong><fmt:formatNumber value="${wlvo.pvo.price}" pattern="#,###"/>원</strong></td>
								<td class="verticalM" align="center">
									<img alt="301coins.png" src="../images/301coins.png" width="15" height="15">
									<span><fmt:formatNumber value="${wlvo.pvo.point}" pattern="#,###"/>원</span>
								</td>
								<td class="verticalM" align="center"><span>기본배송</span></td>
								<td class="verticalM" align="center">
									<div>조건부무료</div>
									<button type="button" class="btn btn-outline-secondary" data-toggle="tooltip" data-placement="bottom" title="10만원이상 무배! (기본2,500원)">자세히▶</button>
								</td>
								<td class="verticalM" align="center"><strong><fmt:formatNumber value="${wlvo.pvo.price+2500}" pattern="#,###"/>원</strong></td> <!-- ★더하기 계산하는법 -->
								<td class="verticalM" align="center"> <!-- align을 통해 내부를 가운데정렬 -->
									<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;" onclick="goCart(${opseq});">장바구니</button>
									<button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;" onclick="goOrderForm(${opseq});">주문하기</button>
									<%-- <button type="button" class="btn btn-outline-secondary" style="display: block; margin-bottom: 3px;" data-toggle="modal" data-target="#chooseProdOption" id="goModal" value="${pseq}">주문하기</button> --%>
									<button type="button" class="btn btn-outline-secondary" style="display: block;" onclick="deleteWishList(${wishseq});">삭제하기</button>
								</td>
							</tr>
							
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- 위시리스트 테이블 끝 -->
			
			<div>
				<div style="float: left;">
					<button type="button" class="btn btn-outline-secondary" style="margin-right: 5px;" onclick="deleteCheckboxWishList();" ><i class="fas fa-times"></i>&nbsp;삭제하기</button>
					<button type="button" class="btn btn-outline-secondary" style="margin-right: 5px;" onclick="deleteAllWishList();">관심상품 비우기</button>
					<button type="button" class="btn btn-outline-secondary" style="margin-right: 5px;" onclick="goCheckboxCart();" >장바구니 담기</button>
				</div>
				
				<div style="float: right;">
					<button type="button" class="btn btn-dark btn-lg" onclick="goCheckboxOrderForm();">선택상품주문</button>
				</div>
			</div>
			
			
			
			<!-- 장바구니에 POST방식으로 넘기기 위한 폼태그 시작 -->
			<form name="WishListFrm">
				<input type="hidden" name="opseq" value="" />
			</form>
			<!-- 장바구니에 POST방식으로 넘기기 위한 폼태그 끝 -->
			
			
			
			<!-- 페이지바 시작 -->
			<nav style="clear: both;"> <!-- 페이지바는 페이지네비게이션(pagination) 이용 -->
				<ul class="pagination justify-content-center" style="margin-top: 50px;">${requestScope.pageBar}</ul>
			</nav>
			<!-- 페이지바 끝 -->
			
			
		</c:if>
		<!-- wishList가 존재하는지 존재안하는지에 따라 달라짐. 끝-->
		
		
		
	</div>
	


<%-- 

<!-- 장바구니담기/주문하기 Modal -->
<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
<div class="modal" id="chooseProdOption">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <!-- Modal header -->
      <div class="modal-header">
        <h5 class="modal-title">제품명~~~~~~~~~</h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        Modal body....<span id="realInsert"></span>
        
	        <div id="idFind">
	           <iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath()%>/login/idFind.up">
	           </iframe>
	        </div> 
       
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger">바로구매하기</button>
        <button type="button" class="btn btn-primary">장바구니담기</button>
      </div>
    </div>
  </div>
</div>

--%>








	
<jsp:include page="../footer.jsp" />

