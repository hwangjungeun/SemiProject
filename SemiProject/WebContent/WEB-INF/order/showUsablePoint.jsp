<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 돈을 형식에 맞게 찍어주기 위함. -->

<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>

<!-- <!DOCTYPE html> -->
<html>
<head>
<meta charset="UTF-8">
<title>oH!DaiLY 적립금 조회/사용</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%=ctxPath %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%=ctxPath %>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%=ctxPath %>/jquery-ui-1.11.4.custom/jquery-ui.js"></script> 

</head>


<script type="text/javascript">
	
	$(document).ready(function(){
		
	});
	
	// Function Declaration
	
	// == 체크박스 전체선택 / 전체해제 == //
	function fun_allCheck(bool){
		
		// console.log("확인용 bool => " + bool);
		
		var arrPointChoice = document.getElementsByName("pointChoice");
		
		for(var i=0; i<arrPointChoice.length; i++){
			arrPointChoice[i].checked = bool; /* 넘어온게 true면 true, false면 false */
		}// end of for-------------------------------
			
	}// end of function fun_allCheck(bool){}----------------------------
	
	
	// == 체크박스 전체선택 / 전체해제 에서 
	//    하위 체크박스에 체크가 1개라도 체크가 해제되면 체크박스 전체선택/전체해제 체크박스도 체크가 해제되고
	//    하위 체크박스에 체크가 모두 체크가 되어지면  체크박스 전체선택/전체해제 체크박스도 체크가 되어지도록 하는 것 == // 
	function fun_wishCheck(){
		
		var arrPointChoice = document.getElementsByName("pointChoice");
		
		var bFlag = false;
		for(var i=0; i<arrPointChoice.length; i++){
			
			if( !arrPointChoice[i].checked ){
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
	
	
	// 선택한 것들의 총합을 구해주는 함수
	function sumTotalPoint(){
		
		var sumPoint = 0;
		
		var arrPointChoice = document.getElementsByName("pointChoice");
		
		for(var i=0; i<arrPointChoice.length; i++){ // 체크박스 길이만큼 반복돌림
			
			if( arrPointChoice[i].checked ){
				// 하위 체크박스(위시리스트 제품 체크박스)에 체크가 된 것이 있다라면
				
				var point = arrPointChoice[i].id;
			//	console.log("체크된 체크박스의 point => " + point);
				
				sumPoint += Number(point); // 8609
			
			}
			
		}// end of for---------------------------------------------
		
	//	alert("확인용 선택된 point들의 합 => " + sumPoint);
		
		$("span#checkedPointSum").text(sumPoint);
		
	}// end of function sumTotalPoint()--------------------------------
		
	
	// 체크가 된 체크박스들의 fk_odrcode를 String타입으로 묶어서 반환하는 함수
	function checkboxFk_odrcode(){
		
		// 자바스크립트의 배열은 아래와 같이 나타낸다.(배열도 객체이다.)
		var arrFk_odrcode = new Array();
		// 배열명.push("~~~");
		
		var arrPointChoice = document.getElementsByName("pointChoice");
		
		for(var i=0; i<arrPointChoice.length; i++){ // 체크박스 길이만큼 반복돌림
			
			if( arrPointChoice[i].checked ){
				// 하위 체크박스(위시리스트 제품 체크박스)에 체크가 된 것이 있다라면
				
				var fk_odrcode = arrPointChoice[i].value;
			//	console.log("체크된 체크박스의 fk_odrcode => " + fk_odrcode);
				
				arrFk_odrcode.push(fk_odrcode);
			}
			
		}// end of for---------------------------------------------
		
		var str_Fk_odrcode = arrFk_odrcode.join("_"); // 부모창의 함수에 넘길때, ","는 파라미터의 구분자로 인식하고 "/"는 나누기로 인식하므로 " "로 하였음.
	//	alert("확인용 문자열 fk_odrcode들의 모임 => " + str_Fk_odrcode);
		
		return str_Fk_odrcode;
		
	}// end of function checkboxFk_odrcode()-------------------------------------------	
		

	// 적립금 사용하기 버튼을 클릭한 경우
	function goUsePoint(){
		
		var sumTotalPoint = $("span#checkedPointSum").text();
	//	console.log("사용할 총포인트금액 : " + sumTotalPoint);
		
		var str_Fk_odrcode = checkboxFk_odrcode(); // fk_odrcode의 모음 "9_22_24_25"
	//	console.log("확인용  str_Fk_odrcode : " + str_Fk_odrcode);
	//	console.log("확인용  typeof(str_Fk_odrcode) : " + typeof(str_Fk_odrcode)); // string타입
	
	
		// 부모창의 input태그에 값 넣어주기(함수에 파라미터로 넘기려고하니까 부모창에서 파라미터들을 number로 인식해버린다.)
		opener.document.getElementById("str_Fk_odrcode").value = str_Fk_odrcode;
		
		// 팝업창에서 부모창 함수 호출하기
		opener.location.href = "javascript:showDiscountMoney("+sumTotalPoint+")";
		
		self.close(); // 팝업창 닫기
		
	}// end of function goUsePoint()----------------------------------------------
		
		
	// 사용취소하기 버튼을 클릭한 경우
	function goBack(){
		
		self.close(); // 팝업창 닫기
		
	}// end of function goBack()----------------------------------------------
		
</script>

<body>

	<div class="container-fluid p-3" style="background-color: #ffe6e6; height: 7%; font-weight: bold; font-size: 15px;" >적립금 조회/사용</div>
	
	<!-- 적립금 사용에 따른 유의사항 시작 -->
	<div style="border: solid 1px #d9d9d9; margin-top: 20px; margin-bottom: 10px; ">
		<h5 style="font-weight: bold; padding: 4px; border-bottom: solid 1px #d9d9d9; font-size: 12px;">적립금 사용에 따른 유의사항</h5>
		<div>
			<ul style="list-style-type: circle; padding-left: 30px; font-size: 13px;">
				<li>사용 가능한 적립금만 보여지게 됩니다.</li>
				<li>적립금으로만 결제할 경우, 총 결제예정 금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.</li>
				<li>주문이 완료되면 선택하셨던 금액만큼 기존 적립금에서 차감됩니다.</li>
			</ul>
		</div>
	</div>
	<!-- 적립금 사용에 따른 유의사항 끝 -->
	
	
	<div style="margin-top: 40px; margin-bottom: 10px; font-weight: bold; font-size: 12px;">적립금 조회 내역</div>
	<!-- 사용가능한 포인트의 목록 보여주기 시작 -->
	<c:if test="${empty requestScope.pointList}"> <!-- 없든지 텅빈거다. -->
		<h4 style="border-top: solid 1px #d9d9d9; border-bottom: solid 1px #d9d9d9; padding-top: 50px; padding-bottom: 50px;" align="center">사용가능한 적립 내역이 없습니다.</h4>
	</c:if>
	
	<c:if test="${not empty requestScope.pointList}">
	
		<!-- 포인트 테이블 시작 -->
		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
					<tr style="text-align: center;"> <!-- 글자 가운데정렬 -->
						<th>
							<!-- 모두선택/해제 => /JavaScriptStudy/WebContent/05checkbox/01checkBoxTest.html를 참고함. -->
							<input type="checkbox" id="allCheck" onClick="fun_allCheck(this.checked);" />
						</th>
						<th>No</th>
						<th>사용가능한 포인트 금액</th>
						<th>만료예정일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="pointvo" items="${requestScope.pointList}" varStatus="status" >
					
						<tr>
							<td class="verticalM" align="center"> <!-- 모두선택/해제 -->
								<input type="checkbox" name="pointChoice" onclick="fun_wishCheck()" value="${pointvo.fk_odrcode}" id="${pointvo.point}" />
							</td>
							<td class="verticalM" align="center">${status.index}</td>
							
							<td class="verticalM" align="center">
								<img alt="301coins.png" src="../images/301coins.png" width="15" height="15">
								<span><fmt:formatNumber value="${pointvo.point}" pattern="#,###"/>원</span>
							</td>
							
							<td class="verticalM" align="center">${pointvo.end_day}</td> 
							
						</tr>
						
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 포인트 테이블 끝 -->
	
	</c:if>
	<!-- 사용가능한 포인트의 목록 보여주기 끝 -->
	
	
	
	<!-- 선택된 체크박스들의 point합 시작 -->
	<table class="table table-bordered" style="text-align: center; margin-top: 20px; margin-bottom: 0px;">
		<thead>
			<tr>
				<th>선택한 포인트 합계 <button type="button" class="btn btn-outline-danger" onclick="sumTotalPoint()">계산</button></th>
			</tr>	
		</thead>
		<tbody>	
			<tr style="font-weight: bolder; font-size: 13pt;">
				<td>
					<img alt="301coins.png" src="../images/301coins.png" width="15" height="15">
					<span id="checkedPointSum">0</span>원
				</td>
			</tr>
		</tbody>
	</table>
	<!-- 선택된 체크박스들의 point합 끝 -->
	
	<div align="center" style="margin-top: 40px; margin-bottom: 20px;">
		<button type="button" class="btn btn-dark btn-lg" onclick="goUsePoint();">적립금 사용하기</button>
		<button type="button" class="btn btn-outline-secondary btn-lg" onclick="goBack();">사용 취소하기</button>
	</div>
	
	
</body>
</html>