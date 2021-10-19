<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     


<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>


<jsp:include page="../header.jsp" />
<style type="text/css">

 	
 	.titleArea h2{	
	 	display: inline-block;
	    position: relative;
	    margin: 20px auto 10px;
	    padding: 8px 15px;
	    min-width: 150px;
	    color: #353535;
	    font-size: 13px;
	    letter-spacing: 1px;
	    border: 1px #ddd solid;
	    text-transform: uppercase;
	}
	
	div{
		margin: 10px, 0px;
	}
	
	div.emptyBasket{
		color: #353535;
	    vertical-align: middle;
	    text-align: center;
	    font-size: 13px;
	    font-weight: 500;
	    text-transform: uppercase;
	}
	
	table{
		width: 70%;
		margin-top:15px;
		color: #353535;
	    vertical-align: center;
	    text-align: center;
	    font-size: 13px;
	    font-weight: 500;
	    text-transform: uppercase;
	    background: #fff;
	}
	
	
	table,th,td{
		border: solid 1px #cdcdd5;
		border-collapse: collapse;
		vertical-align: middle;
		text-align: middle;

	}

	
	input#spinnerOqty{
		dispaly: inline-block;
		width: 50px;
    	margin: 0 0 2px 0;
    	text-align: left;
	
	}
		
		
	.btn {
	    padding: 5px 10px;
	    border-radius: 3px;
	    font-size: 11px;
	    text-align: center;
	    color: #353535;
	    background-color: #fff;
	    width: 75px;
	   
		display: block;
		margin-bottom: 3px;
	}
	
	td.button > button {
		 margin: 5px auto;
	}
	
	div.btnArea, div.ordArea {
		display:inline;
		padding:0px;
		vertical-align: middle;
		font-size:15px;
	}

	
	div.btnArea button {
	  	font-size: 11px;
		color: #353535;
	    background-color: #fff;
	    width:auto;
	}
	
	
	div.ordArea button{
		display:inline-block;
		padding: 10px 15px;
		font-size: 15px;
		border-radius: 5px;
	    width:auto;
		height:auto;
	}
 	
  	input[type=number]::-webkit-inner-spin-button {opacity: 1}
 	
 	[data-tooltip-text]:hover{
 		position:relative;
 	}
 	
 	[data-tooltip-text]:hover:after{
 		background-color: #000000;
		background-color: rgba(0, 0, 0, 0.8);
	
		-webkit-box-shadow: 0px 0px 3px 1px rgba(50, 50, 50, 0.4);
		-moz-box-shadow: 0px 0px 3px 1px rgba(50, 50, 50, 0.4);
		box-shadow: 0px 0px 3px 1px rgba(50, 50, 50, 0.4);
	
		-webkit-border-radius: 5px;
		-moz-border-radius: 5px;
		border-radius: 5px;
	
		color: #FFFFFF;
		font-size: 12px;
		content: attr(data-tooltip-text);
	
	 	margin-bottom: 10px;
		top: 130%;
		left: 50%;    
		padding: 7px 12px;
		position: absolute;
		width: 230px;
		height:auto;
		word-wrap: break-word;
	
		z-index: 9999;
	 }
 	
 	
</style>

<script type="text/javascript">

	
	$(document).ready(function(){
	
		// 스피너 값이 변하는 경우
		$("input#spinnerOqty").bind("change",function(){
			
			var $target = $(this); 
			var oqty = $target.val();
			console.log(oqty); 
			
			var cartseq = $target.attr("value2");
			console.log(cartseq); 
			
			// update를 위해 보내주기
			$.ajax({
				url:"/SemiProject/order/updateThis.go",
				data:{"cartseq":cartseq,
					  "oqty":oqty},
				method:"POST",
				success:function(){
					//console.log("성공"); // 일단 확인용 
					javascript:history.go(0); // 다시 읽어오기 
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		         }
				
			});
			
		});// end of $("input#spinnerOqty").bind("spinstop")
		
	});	// end of $(document).ready(function)-------------------------

		
	//Function Declaration
	
	// 전체품목 체크/해제
	function func_allcheck(bool){ 
		
		//alert("확인용 bool =>" + bool);
		$("input:checkbox[id=basketchk]").prop("checked",bool);
	
	}// end of func_allcheck(bool){}-------------------------------------
 
	
	// 하나의 품목 체크/해제 했을 때
	function func_check(bool){ 
		
		//alert("확인용 bool =>" + bool);
	
		var cnt = $("input:checkbox[id=basketchk]").length; // 전체 체크박스 갯수 
		var cntTrue = $("input:checkbox[id=basketchk]:checked").length; // 체크된 체크박스 갯수 
		
		//alert("확인용 cntTrue => "+ cntTrue);
	
		if(!bool){ 		// 해제했을때
			$("input:checkbox[id=basketchkAll]").prop("checked",false); // 전체체크해제
		}
		else{ 			//체크했을때
			if( cnt == cntTrue){ // 모두 체크한 경우 
				$("input:checkbox[id=basketchkAll]").prop("checked",true);
			}
			else{ // 모두 체크하지 않은 경우 
				$("input:checkbox[id=basketchkAll]").prop("checked",false);
			}
		}
		
	}// end of function func_check(bool){}-----------------------------
	
	
	//체크한 상품 주문하기 
	function goSubmitSelect(){
		
		var cnt = $("input:checkbox[id=basketchk]:checked").length; // 체크된 박스갯수
		
		if( cnt > 0 ){//체크한 것이 하나 이상인 경우  잘 나옴 
		
			var cartseqArr = new Array();
		
			$("input:checkbox[id=basketchk]:checked").each(function(){
				cartseqArr.push($(this).val());
			});
			
			var cartseq = cartseqArr.join();
			
			$("input:hidden[name=cartseq]").val(cartseq);
			
			//console.log("확인용 => " + cartseq); 
			
			var frm = document.cartFrm;
			
			frm.action = "testbasket.go";
			frm.method = "POST";
			frm.submit();
		
		}
		else{
			
			alert("한 개 이상 체크해주세요!"); // 잘 나옴 
			return false;
		}
		
	}// end of function goSubmitAll(){}--------------------------------------------
	
	
	//전체 상품 주문하기
	function goSubmitAll(){
		
		var cartseqArr = new Array();

		$("input:checkbox[id=basketchk]").each(function(){
			cartseqArr.push($(this).val());
		});
		
		var cartseq = cartseqArr.join();
		
		$("input:hidden[name=cartseq]").val(cartseq);
		
		//console.log("확인용 => " + cartseq); 
		
		var frm = document.cartFrm;
		
		frm.action = "testbasket.go";
		frm.method = "POST";
		frm.submit();
		
	}// end of function goSubmitAll(){}--------------------------------------------
	
	//하나의 상품만 주문하기
	function goSubmitThis(){
		
		var $target = $(event.target); 
		
		var cartseq =  $target.val(); 								// 해당 cartseq가져오기
		
		console.log("확인용 =>"+ cartseq); 							// 나옴 
		
		$("input:hidden[name=cartseq]").val(cartseq); 			// 값 넣어주기
		
		// 넘겨주기 
		var frm = document.cartFrm;
		
		frm.action = "testbasket.go"; 							//이 부분 수정 
		frm.method = "POST";
		frm.submit();
		
	}// end of function goSubmitThis(){}--------------------------------------------
	
	
	//하나의 상품 지우기
	function goDelThis(){
		
		var bool = confirm("해당상품을 삭제하시겠습니까?");
		
		if(bool){
			
			var $target = $(event.target); 
			
			var cartseq =  $target.val(); 								// 해당 cartseq가져오기
			
			$.ajax({
				url:"/SemiProject/order/deleteThis.go",
				data:{"cartseq":cartseq},
				method:"POST",
				success:function(){
					//console.log("성공"); // 일단 확인용 
					javascript:history.go(0); // 다시 읽어오기 
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		         }
				
			});
			
		}
		else{
			alert("해당상품 삭제를 취소하셨습니다.");
		}
	
	}// end of function goDelThis(){}--------------------------------------------	
		
	
	//선택 상품 지우기 
	function goDelSelect(){
		
		//위에랑 중복되는데 함수로 따로 빼야하나?
		var cnt = $("input:checkbox[id=basketchk]:checked").length; // 체크된 박스갯수
		
		if( cnt > 0 ){//체크한 것이 하나 이상인 경우  잘 나옴 
		
			var bool = confirm("선택하신 상품을 삭제하시겠습니까?");
			
			if(bool){
				var cartseqArr = new Array();
	
				$("input:checkbox[id=basketchk]:checked").each(function(){
					cartseqArr.push($(this).val());
				});
				
				var cartseq = cartseqArr.join();
				
				$("input:hidden[name=cartseq]").val(cartseq);
				
				$.ajax({
					url:"/SemiProject/order/deleteThis.go",
					data:{"cartseq":cartseq},
					success:function(){
						//console.log("성공"); // 일단 확인용 
						javascript:history.go(0); // 다시 읽어오기 
					},
					error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			         }
				});
			}
			else{
				alert("선택하신 상품 삭제를 취소하셨습니다.");
			}
		}
	else{
			alert("한 개 이상 체크해주세요!"); // 잘 나옴 
			return false;
		}
	
	}// end of function goDelSelect(){}--------------------------------------------
	
	
	//전체 상품 지우기
	function goDelAll(){
		
		var bool = confirm("전체상품을 삭제하시겠습니까?");
		
		if(bool){
			
			var cartseqArr = new Array();
			
			$("input:checkbox[id=basketchk]").each(function(){
				cartseqArr.push($(this).val());
			});
			
			var cartseq = cartseqArr.join();
			
			$("input:hidden[name=cartseq]").val(cartseq);
			
			//cartseq = $("input:hidden[name=cartseq]").val();
			
			
			$.ajax({
				url:"/SemiProject/order/deleteThis.go",
				data:{"cartseq":cartseq},
				success:function(){
					//console.log("성공"); // 일단 확인용 
					javascript:history.go(0); // 다시 읽어오기 
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		         }
			});
		}
		else{
			alert("전체상품 삭제를 취소하셨습니다.");
		}
		
	}// end of function goDelThis(){}--------------------------------------------
	
	
	// 쇼핑계속하기 버튼을 클릭했을때 
	function gohome(){
		location.href= "<%= request.getContextPath()%>/index.go"; //맨 처음 페이지로 이동 나중에는 best페이지로 이동 
	}// end of function gohome();
	
</script>



<div class="container" align="center">
	
	<!-- 페이지 이름 영역 시작-->
	<div class="titleArea">
		<h2>shopping cart</h2>
	</div>
	<!-- 페이지 이름 영역 끝-->


	<!-- 로그인시 회원정보 시작 로그인유저받와서함 근데 적립금도 필요한데 그러면 abstract에서 해야하나?-->
	<%--<c:if test="${not empty sessionScope.loginuser}"></c:if>--%>
		<div class="table-responsive">
			<table class="table usertbl">
				<tbody>
					<tr>
						<td rowspan="2" ><h3>혜택정보</h3></td>
						<td id="second" colspan="9" style="text-align:left">${sessionScope.loginuser.name}님의 가용적립금은 ${sessionScope.loginuser.point} 입니다.</td>
					</tr>
				</tbody>
			</table>
		</div>
	<!-- 로그인시 회원정보 끝-->


	<!-- 장바구니에 담은 것이 하나도 없는 경우 보여주는 테이블  -->
	<c:if test="${sessionScope.basketCnt eq 0}">
		<div class="emptyBasket m-5">
			<strong>장바구니가 비었습니다.</strong>	
		</div>
	</c:if>
	<!-- 없는 겅우 보여주는 테이블 끝  -->

	
	<!-- 장바구니 테이블 시작: 데이터 받아와서 보여주는 테이블/form submit할때 name다시 확인/-->
	<c:if test="${sessionScope.basketCnt != 0 }">
		<form name="cartFrm">
			<div class="table-responsive">
				<table class="table">
					<colgroup>
						<col style="width:27px">
						<col style="width:90px">
						<col style="width:auto">
						<col style="width:98px">
						<col style="width:75px">
						<col style="width:98px">
						<col style="width:98px">
						<col style="width:85px">
						<col style="width:98px">
						<col style="width:110px">
					</colgroup>
					
					<thead>
						<tr>
							<th><input type="checkbox" id="basketchkAll" onclick="func_allcheck(this.checked)"></th>
							<th scope="col" style="border-right: none;">이미지</th>
							<th scope="col" style="border-left: none;">상품정보</th>
							<th scope="col">판매가</th>
							<th scope="col">수량</th>
							<th scope="col">적립금</th>
							<th scope="col">배송구분</th>
							<th scope="col">배송비
							<i data-tooltip-text="10만원이상 구매시 무료배송!" class="fas fa-bullhorn"></i>
							</th>
							<th scope="col">합계</th>
							<th scope="col">선택</th>
						</tr>
					</thead>
					
		<%--<c:forEach var="mvo" items="${requestScope.장바구니VO를 담은 리스트}">tbody는 form태그로 넣어야하나(form에서 데이터 넘기는 부분은 input태그써야함) tfoot전까지</c:forEach>--%>
					<tbody class="cartList">
						<c:set var = "len" value="${fn:length(cartList)}"/>
						<c:set var ="sum" value="0"/> 
						<c:forEach var="cvo" items="${requestScope.cartList}" varStatus="status">
							<tr>
								<td>
									<input type="checkbox" value="${cvo.cartseq}" id="basketchk" onclick="func_check(this.checked)">
								</td>
								<td style="border-right: none;">
									<a href="<%= ctxPath%>/product/productDetail.go?pseq=${cvo.fk_pseq.pseq}">
										<img src="../images/${cvo.fk_opseq.cimage}" class="card-img-top" alt="...">
									</a>
								</td>
								<td style="border-left: none;"><span style="font-weight:bold">${cvo.fk_pseq.pname}</span><br><span>[옵션: ${cvo.fk_opseq.fk_cseq.cname}]</span></td>
								<td class="price${status.index}" ><fmt:formatNumber value="${cvo.fk_pseq.price}" pattern="#,###" />원</td>
								<td>
									<span>
										<!--<input  class="spinnerOqty${status.index}" id="spinnerOqty" value="${cvo.oqty}" value2="${cvo.cartseq}"
										style="background-color:white"/>-->
										<span><input type="number" class="cntChange my-3" id="spinnerOqty" min="1" max="100" value="${cvo.oqty}" value2="${cvo.cartseq}"step="1"/></span> 
										<!--  <button type="button" class="btn-secondary" style="" onclick="goCntChange()">변경</a> -->
									</span>
								</td>
								<td><span>${cvo.fk_pseq.point}</span></td>
								<td>기본배송</td>
									<c:if test="${status.first}">
										<td rowspan="${len}"><p>2,500원<br>고정</p></td>
									</c:if>
								<td class="sumPrice">
									<fmt:formatNumber value="${cvo.fk_pseq.price * cvo.oqty}" pattern="#,###" />원
									<br><span>[${cvo.fk_pseq.point * cvo.oqty}]</span>
									</td>
								<td class="button">
									<button type="button" class="btn frmbtn btn-secondary" id="btnOrder" value="${cvo.cartseq}" onclick="goSubmitThis()" style="margin-bottom: 3px;" >주문하기</button>
									<button type="button" class="btn frmbtn btn-outline-secondary" id="btnDel" value="${cvo.cartseq}" onclick="goDelThis()">삭제하기</button>
								</td>
							</tr>
						<c:set var ="sum" value="${sum + (cvo.fk_pseq.price * cvo.oqty)}"/> 
						</c:forEach>
					</tbody>	
					
					<tfoot>
						<td colspan="10">
							<span style="float:left;"><strong>기본배송</strong></span>
							<span style="float:right;">
								상품구매금액
								<strong>&nbsp;<fmt:formatNumber value="${sum}" pattern="#,###" />원</strong>
								+ 배송비
								<span id="fee">
									<c:choose>
		                              <c:when test="${sum >= 100000}">
		                                	<c:set var="delivery" value="0원" />
		                                	<c:set var="deliveryFee" value="0" />
		                                 	&nbsp;<Strong>
		                                 		${delivery}(무료배송)
		                                 	</Strong>
		                              </c:when>
		                              <c:otherwise>
		                                	<c:set var="delivery" value="2,500원" />
		                              		<c:set var="deliveryFee" value="2500" />
		                                 	&nbsp;${delivery}(기본배송)
		                              </c:otherwise>
		                           </c:choose>
								</span>
								= 합계 :
								<strong>
									<span><fmt:formatNumber value="${sum + deliveryFee}" pattern="#,###" />원</span>
								</strong>
							</span>
						</td>
					</tfoot>
				</table>
			</div>
		
			<!-- 삭제 버튼영역 시작-->
			<div class="btnArea">
				<span style="float:left;  inline-height:24px;"><strong>선택상품을&nbsp;</strong></span>
				<span style="float:left;">
					<button class="btn btn-outline-secondary" id="btnchooseDel" style="margin-right: 5px;" onclick="goDelSelect()"><i class="fas fa-times"></i>&nbsp;삭제하기</button>		
				</span>
				<span style="float:right;">
					<button class="btn btn-outline-secondary" id="btnAllDel"  style="margin-right: 3px;" onclick="goDelAll()">장바구니비우기</button>		
				</span>
			</div>
			<!-- 삭제 버튼영역 끝 -->
			
			<!-- 결제금액 테이블 시작-->
			<div class=" table-responsive">
				<table class="ordTbl table">
					<thead>
						<tr>
							<th>총상품금액</th>
							<th>총배송비</th>
							<th>결제예정금액</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><fmt:formatNumber value="${sum}" pattern="#,###" />원</td>
							<td>${delivery}</td>
							<td><fmt:formatNumber value="${sum + deliveryFee}" pattern="#,###" />원</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 결제금액 테이블 끝 -->
		
			<!-- 결제버튼영역 시작-->
			<div>
				<div class="ordArea">
						<button type="button" class="btn my-5 btn-secondary" id="btnAllorder" onclick="goSubmitAll()">전체상품주문하기</button>		
						<button type="button" class="btn my-5 btn-outline-secondary" id="btnSelectorder" onclick="goSubmitSelect()">선택상품주문하기</button>		
				</div>
			</div>
			<!-- 결제버튼영역 끝 -->
			
			<input type="hidden" name="cartseq" value="">						
			<input type="hidden" name="userid" value="${requestScope.loginuserid}">
			
		</form>
	</c:if>
	
	<button type="button" class="btn my-5 btn-outline-secondary" style="float:right; width:auto;" id="btnGoshop" onclick="gohome()">쇼핑계속하기
</button>		
	<!-- 장바구니 테이블 끝-->
	
</div>




<jsp:include page="../footer.jsp" />