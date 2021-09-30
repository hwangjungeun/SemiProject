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

	table{
		width: 70%;
		margin:15px;
		color: #353535;
	    vertical-align: middle;
	    font-size: 13px;
	    font-weight: 500;
	    text-transform: uppercase;
	    background: #fff;
	}
	
	table, th, td{
		border: solid 1px #cdcdd5;
		border-collapse: collapse;
		text-align: center;
	}
	
	.userTbl tbody tr {
		text-align: left;
	}
	

	.basketTbl thead th{
		padding: 12px 0;
	    border-bottom: 1px solid #dfdfdf;
	    color: #353535;
	    vertical-align: middle;
	    font-size: 11px;
	    font-weight: 500;
	    text-transform: uppercase;
	    background: #fff;
	    align: middle;
	}
	
	.basketTbl button{
		display: block;
	    box-sizing: border-box;
	    padding: 2px 8px;
	    border: 1px solid #d1d1d1;
	    border-radius: 0;
	    font-size: 11px;
	    line-height: 18px;
	    font-weight: normal;
	    text-decoration: none;
	    vertical-align: middle;
	    word-spacing: -0.5px;
	    letter-spacing: 0;
	    text-align: center;
	    white-space: nowrap;
	    color: #353535;
	    background-color: #fff;
	    transition: all 0.15s ease;
	    margin:auto;
	    width: 50%;
	}
	
	
	.basketTbl button:first-child{
		background-color: #e3e3e8;
	}
	
	div.buttonArea{
		margin: 15px;
		padding : 10px, 0px;		
	}
	
	div.buttonArea span{
		align: right;
	
	}
	div.buttonArea span:first-child{
		align:left;
	
	}
	
	
	input.btnAreabtn, input.ordAreabtn {
		font-size: 12px;
	    line-height: 18px;
	    font-weight: normal;
	    text-decoration: none;
	    vertical-align: middle;
	    word-spacing: -0.5px;
	    letter-spacing: 0;
	    text-align: center;
	    white-space: nowrap;
		border: 1px solid #b8b8c6;
		background-color: #d5d5dd;
	}
	
	div.moneyArea{
		margin-bottom : 5px;
		margin-top: 20px;
				
	}
	
	div.orderArea{
		margin-bottom:30px;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	
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
			$("input:checkbox[name=basketchkAll]").prop("checked",false); // 전체체크해제
		}
		else{ //체크했을때
			
			if( cnt == cntTrue){ // 모두 체크한 경우 
				$("input:checkbox[name=basketchkAll]").prop("checked",true);
			}
			else{ // 모두 체크하지 않은 경우 
				$("input:checkbox[name=basketchkAll]").prop("checked",false);
			}
		}
		
	}// end of function func_check(bool){}-----------------------------
	
	// 쇼핑계속하기 버튼을 클릭했을때 
	function gohome(){
		
		location.href= "<%= request.getContextPath()%>/index.go"; //맨 처음 페이지로 이동 나중에는 best페이지로 이동 
		
	}// end of function gohome();
	

</script>

<jsp:include page="../header.jsp" />

<div class="container-fluid p-3" id="container" align="center">
	
	<div class="titleArea">
		<ul>
		<h2>shopping cart</h2>
		</ul>
	</div>


	<%-- *** 로그인한 경우 보여지는 테이블을 생성   
	<c:if test="${empty sessionScope.loginuser}">
	밑에 테이블 
	</c:if>
	--%>
		<div class="userArea table-responsive">
			<table class="userTbl">
				<tbody>
					<tr>
						<td rowspan="2">혜택정보</td>
						<td colspan="9">(고객이름)님은 (회원등급)회원입니다.</td>
					</tr>
					<tr>
						<td colspan="9">가용적립금 :(적립금) 쿠폰:(쿠폰)개</td>
					</tr>
				</tbody>
			</table>
		</div>
	

	<div>
		<table class="basketTbl">
				<thead>
					<tr>
						<th><input type="checkbox" id="basketchkAll" name="basketchkAll" onclick="func_allcheck(this.checked)"></th>
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
				
				<tbody>
					<tr>
						<td><input type="checkbox" id="basket_chk_id_1" name="basketchk" onclick="func_check(this.checked)"></td>
						<td style="border-right: none;"><span>(제품이미지)</span></td>
						<td style="border-left: none;"><span>(제품이름)</span></td>
						<td>(한개가격)</td>
						<td><span>(수량변경)</span></td>
						<td>(적립금)</td>
						<td>(배송구분)</td>
						<td rowspan="2">사용하여 합치고 <p>기본배송</p></td>
						<td>(총가격)</td>
						<td class="button">
							<button class="tblbtn" id="btnorder" >onclick사용주문하기</button>
							<button class="tblbtn" id="btnwish" >onclik사용위시리스트</button>
							<button class="tblbtn">삭제하기</button>
						</td>
						
					</tr>
					<tr>
						<td><input type="checkbox" id="basket_chk_id_2" name="basketchk" onclick="func_check(this.checked)"></td>
						<td style="border-right: none;"><span>(제품이미지)</span></td>
						<td style="border-left: none;"><span>(제품이름)</span></td>
						<td>(한개가격)</td>
						<td><span>(수량변경)</span></td>
						<td>(적립금)</td>
						<td>(배송구분)</td>
						<td>(총가격)</td>
						<td class="button">
							<button class="tblbtn" id="btnorder" >onclick사용주문하기</button>
							<button class="tblbtn" id="btnwish" >onclik사용위시리스트</button>
							<button class="tblbtn">삭제하기</button>
						</td>
						
					</tr>
					
				</tbody>
		</table>
	</div>
	
	<div class="buttonArea">
		<span>
			<input type=button class="btnAreabtn" id="btnSelectDelete" value="onclick삭제하기"/>
		</span>
		<span>
			<input type=button class="btnAreabtn" id="btnAllDelete" value="onclick장바구니비우기"/>
			<input type=button class="btnAreabtn" id="btnRecipt" value="onclick견적서출력"/>
		</span>
	</div>
	
	
	<div class="moneyArea table-responsive">
		<table class="basketTbl">
				<thead>
					<tr>
						<th scope="col">총상품금액</th>
						<th scope="col">총배송비</th>
						<th scope="col">총할인금액</th>
						<th scope="col">결제예정금액</th>
						
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td>(가격)</td>
						<td><span>(배송비)</span></td>
						<td>(할인금액)</td>
						<td>(결제예정금액)</td>
					</tr>
					
				</tbody>
		</table>
	</div>
	
	<div class="orderArea">
		<span>
		<input type=button class="ordAreabtn" id="btnAllOrder" value="onclick전체상품주문하기"/>
		<input type=button class="ordAreabtn" id="btnSelectOrder" value="onclick선택상품주문하기"/>
		</span>
		<span><input type=button class="ordAreabtn" id="btnGoshopping" value="onclick쇼핑계속하기" onclick="gohome()"/></span>
		
	</div>
	
	
</div>

<jsp:include page="../footer.jsp" />