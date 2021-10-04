<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      


<%--
<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>
--%>

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
	    vertical-align: middle;
	    text-align: center;
	    font-size: 13px;
	    font-weight: 500;
	    text-transform: uppercase;
	    background: #fff;
	}
	
	
	table, th, td{
		border: solid 1px #cdcdd5;
		border-collapse: collapse;
		vertical-align: middle;
	}
	
	
	a:hover{
		font-weight: bold;
	}
	
	a.change{
		border: 1px #ddd solid; 
		padding: 3px;
		margin: 3px;
	}
	
	<%-- 수량조절버튼 크기 안먹힘
	span.cntChange{
		dispaly: inline-block;
		width: 50px;
    	margin: 0 0 2px 0;
    	text-align: left;
	
	}
	--%>
	
	input.cntChange{
		dispaly: inline-block;
		width: 50px;
    	margin: 0 0 2px 0;
    	text-align: left;
	
	}
		
	.btn {
		display: block;
	    padding: 5px 10px;
	    border-radius: 0;
	    font-size: 11px;
	    vertical-align: middle;
	    text-align: center;
	    color: #353535;
	    background-color: #fff;
	    width: 75px;
		margin-bottom: 3px;
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
		padding: 10px 15px;
		font-size: 15px;
		border-radius: 5px;
	    vertical-align: middle;
	    width:auto;
		height:auto;
	}
 	
 	
 	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		alert("확인용!");
	
	});		
	
	//Function Declaration
	
	
	// 전체품목 체크/해제
	function func_allcheck(bool){ 
		
		//alert("확인용 bool =>" + bool);
		$("input:checkbox[name=basketchk]").prop("checked",bool);
	
	}// end of func_allcheck(bool){}-------------------------------------
 
	
	
	// 하나의 품목 체크/해제 했을 때
	function func_check(bool){ 
		
	//	alert("확인용 bool =>" + bool);
	
		var cnt = $("input:checkbox[name=basketchk]").length; // 전체 체크박스 갯수 
		var cntTrue = $("input:checkbox[name=basketchk]:checked").length; // 체크된 체크박스 갯수 
		
	//	alert("확인용 cntTrue => "+ cntTrue);
	
		if(!bool){ // 해제했을때
			$("input:checkbox[id=basketchkAll]").prop("checked",false); // 전체체크해제
		}
		else{ //체크했을때
			
			if( cnt == cntTrue){ // 모두 체크한 경우 
				$("input:checkbox[id=basketchkAll]").prop("checked",true);
			}
			else{ // 모두 체크하지 않은 경우 
				$("input:checkbox[id=basketchkAll]").prop("checked",false);
			}
		}
		
	}// end of function func_check(bool){}-----------------------------
	
	// 쇼핑계속하기 버튼을 클릭했을때 
	function gohome(){
		
		location.href= "<%= request.getContextPath()%>/index.go"; //맨 처음 페이지로 이동 나중에는 best페이지로 이동 
		
	}// end of function gohome();
	

</script>

<jsp:include page="../header.jsp" />


<div class="container" align="center">
	
	<!-- 페이지 이름 영역 시작-->
	<div class="titleArea">
		<h2>shopping cart</h2>
	</div>
	<!-- 페이지 이름 영역 끝-->


	<!-- 로그인시 회원정보 시작-->
	<%--<c:if test="${not empty sessionScope.loginuser}"></c:if>--%>
		<div class="table-responsive">
			<table class="table usertbl">
				<tbody>
					<tr>
						<td rowspan="2" ><h3>혜택정보</h3></td>
						<td id="second" colspan="9" style="text-align:left">(고객이름)님은 (회원등급)회원입니다.</td>
					</tr>
					<tr>
						<td id="second" colspan="9" style="text-align:left">가용적립금 :(적립금) 쿠폰:(쿠폰)개</td>
					</tr>			
				</tbody>
			</table>
		</div>
	<!-- 로그인시 회원정보 끝-->


	<!-- 장바구니에 담은 것이 하나도 없는 경우 보여주는 테이블  -->
	<%--<c:if test="${empty sessionScope.장바구니VO를담은 리스트}"></c:if>--%>
		<div class="emptyBasket">
			<span>장바구니가 비었습니다.</span>
		</div>

	<!-- 장바구니 테이블 시작: 데이터 받아와서 보여주는 테이블/form submit할때 name다시 확인/-->
	<%--<c:if test="${not empty requestScope.장바구니VO를담은 리스트}"></c:if>--%>
	<form>
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
						<th scope="col">배송비</th>
						<th scope="col">합계</th>
						<th scope="col">선택</th>
					</tr>
				</thead>
				
	<%--<c:forEach var="mvo" items="${requestScope.장바구니VO를 담은 리스트}">tbody는 form태그로 넣어야하나(form에서 데이터 넘기는 부분은 input태그써야함) tfoot전까지</c:forEach>--%>
				<tbody>
					<tr>
						<td><input type="checkbox" id="basket_chk_id_1" name="basketchk" onclick="func_check(this.checked)"></td>
						<td style="border-right: none;"><span>(제품이미지)</span></td>
						<td style="border-left: none;"><span>(제품이름)</span></td>
						<td><div>(한개가격)</div></td>
						<td>
						<span>
							<span><input type="number" class="cntChange my-3" name="" min="1" max="100" value="1" step="1"/></span>
							<a href="#" class="change" style="text-decoration:none;">변경</a>
						</span>
						</td>
						<td><span>(적립금)</span></td>
						<td><div>(배송구분)</div></td>
						<td rowspan="2"><p>기본배송</p></td>
						<td><div>(총가격dfdfdddfd)</div></td>
						<td class="button">
							<!-- onclick 설정해야합니다 -->
							<!-- <input type=button class="btn btn-outline-secondary" id="btnAllDelete" value="onclick장바구니비우기"/>-->
							<button class="btn btn-secondary" id="btnOrder" style="margin-bottom: 3px;" onclick="">주문하기</button>
							<button class="btn btn-outline-secondary" id="btnWish" style="margin-bottom: 3px;" onclick="">위시리스트</button>
							<button class="btn btn-outline-secondary" id="btnDel" onclick="">삭제하기</button>
						</td>
					</tr>

					<tr>
						<td><input type="checkbox" id="basket_chk_id_1" name="basketchk" onclick="func_check(this.checked)"></td>
						<td style="border-right: none;"><span>(제품이미지)</span></td>
						<td style="border-left: none;"><span>(제품이름)</span></td>
						<td>(한개가격)</td>
						<td>
						<span>
							<span><input type="number" class="cntChange my-3" name="" min="1" max="100" value="1" step="1"/></span>
							<a  href="#" class="change" style="text-decoration:none;">변경</a>
						</span>
						</td>
						<td>(적립금)</td>
						<td>(배송구분)</td>
						<td >(총가격dfdfdddfd)</td>
						<td class="button">
							<!-- onclick 설정해야합니다 -->
							<!-- <input type=button class="btn btn-outline-secondary" id="btnAllDelete" value="onclick장바구니비우기"/>-->
							<button class="btn btn-secondary" id="btnOrder" style="margin-bottom: 3px;" onclick="">주문하기</button>
							<button class="btn btn-outline-secondary" id="btnWish" style="margin-bottom: 3px;" onclick="">위시리스트</button>
							<button class="btn btn-outline-secondary" id="btnDel" onclick="">삭제하기</button>
						</td>
					</tr>
				</tbody>	
				
				<tfoot>
					<td colspan="10">
						<span style="float:left;"><strong>기본배송</strong></span>
						<span style="float:right;">
							상품구매금액
							<strong>(86,200원)</strong>
							+ 배송비
							<span id="fee">(2500원)</span>
							<span>
							-상품할인금액
							</span>
							<span>(8200원)</span>
							= 합계 :
							<strong>
								<span>(76,300)</span>
								원
							</strong>
						</span>
					</td>
				</tfoot>
			</table>
	</div>
	</form>
	<!-- 장바구니 테이블 끝-->


	<!-- 삭제 버튼영역 시작-->
	<div class="btnArea">
		<span style="float:left;  inline-height:24px;"><strong>선택상품을&nbsp;</strong></span>
		<span style="float:left;">
			<button class="btn btn-outline-secondary" id="btnchooseDel"  style="margin-right: 5px;" onclick=""><i class="fas fa-times"></i>&nbsp;삭제하기</button>		
		</span>
		<span style="float:right;">
			<button class="btn btn-outline-secondary" id="btnAllDel"  style="margin-right: 3px;" onclick="">장바구니비우기</button>		
			<button class="btn btn-outline-secondary" id="btnRecipt"  onclick="">견적서출력</button>		
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
					<th>총할인금액</th>
					<th>결제예정금액</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>(가격)</td>
					<td>(배송비)</td>
					<td>(할인금액)</td>
					<td>(결제예정금액)</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 결제금액 테이블 끝 -->

	
	<!-- 결제버튼영역 시작-->
	<div>
		<div class="ordArea">
		<span >
			<button class="btn my-5 btn-secondary" id="btnAllorder"  style="margin-right: 1px;" onclick="">전체상품주문하기</button>		
			<button class="btn my-5 btn-outline-secondary" id="btnSelectorder"  onclick="">선택상품주문하기</button>		
		</span>
		<span style="float:right;">
			<button class="btn my-5 btn-outline-secondary" id="btnGoshop"  onclick="gohome()">쇼핑계속하기</button>		
		</span>
	</div>
	
	</div>
	<!-- 결제버튼영역 끝 -->


</div>




<jsp:include page="../footer.jsp" />