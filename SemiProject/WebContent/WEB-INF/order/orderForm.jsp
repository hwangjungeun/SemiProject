<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../header.jsp" />


<style>
	
	table tr > th.verticalM { /* 혜택정보 테이블 안에 있는 th태그들을 세로방향으로 가운데정렬  */
		vertical-align: middle;
	}
	
	table > tbody > tr > td.verticalM { /* 국내배송상품 주문내역 테이블 안에 있는 td태그들을 세로방향으로 가운데정렬  */
		vertical-align: middle;
	}
	
	
	
	table#tblDeliveryInfo, table#tblDiscountInfo { /* 배송 정보 테이블  */ /* 결제예정금액(할인정보) 테이블  */
        width: 100%;
	}  
	table#tblDeliveryInfo tr, table#tblDiscountInfo tr {
        /* line-height: 30px; */
        border-top: solid 1px #d9d9d9;
        border-bottom: solid 1px #d9d9d9;
	}
	table#tblDeliveryInfo th, table#tblDiscountInfo th {
		border-right: solid 1px #d9d9d9;
		width: 15%;
		padding-left: 8px;
	}
	table#tblDeliveryInfo td, table#tblDiscountInfo td {
		padding-left: 8px;
		padding-top: 8px;
        padding-bottom: 8px;
	}
	.star { /* 필수 입력 사항 표시 */
		color: red;
        font-weight: bold;
        font-size: 10pt;
	}
	
	
	
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 다음 우편번호찾기 -->

<script type="text/javascript">
	
	var b_flagPostcodeClick = false;
	// 결제하기 버튼을 클릭시 "우편번호찾기" 를 클릭했는지 클릭안했는지를 알아보기위한 용도임.

	$(document).ready(function(){
		
		$("span.error").hide(); // 맨처음에는 입력사항에러페이지가 안나오도록 숨겨줘야함.
		
		$("input#receiverName").blur(function(){
			
			var receiverName = $(this).val().trim();
			if(receiverName == ""){
				// 입력하지 않거나 공백만 입력한 경우
				$("table#tblDeliveryInfo :input").prop("disabled",true); // :input은 모든 input태그, textarea태그, select태그, 버튼태그를 선택자로 잡음.
				$(this).prop("disabled",false);
				
			//	$(this).next().show(); // next() : 바로뒤의 형제태그
			//	또는
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblDeliveryInfo :input").prop("disabled",false);
			//	$(this).next().hide();
			//	또는
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 receiverName 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		
		$("img#zipcodeSearch").click(function(){
			
			b_flagPostcodeClick = true; 
			// 결제하기 버튼을 클릭시 "우편번호찾기" 를 클릭했는지 클릭안했는지를 알아보기위한 용도임.
			
		   new daum.Postcode({
		         oncomplete: function(data) {
		             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		             // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		             var addr = ''; // 주소 변수
		             var extraAddr = ''; // 참고항목 변수
		
		             //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                 addr = data.roadAddress;
		             } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                 addr = data.jibunAddress;
		             }
		
		             // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		             if(data.userSelectedType === 'R'){
		                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                 if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                     extraAddr += data.bname;
		                 }
		                 // 건물명이 있고, 공동주택일 경우 추가한다.
		                 if(data.buildingName !== '' && data.apartment === 'Y'){
		                     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                 }
		                 // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                 if(extraAddr !== ''){
		                     extraAddr = ' (' + extraAddr + ')';
		                 }
		                 // 조합된 참고항목을 해당 필드에 넣는다.
		                 document.getElementById("extraAddress").value = extraAddr;
		             
		             } else {
		                 document.getElementById("extraAddress").value = '';
		             }
		
		             // 우편번호와 주소 정보를 해당 필드에 넣는다.
		             document.getElementById('postcode').value = data.zonecode;
		             document.getElementById("address").value = addr;
		             // 커서를 상세주소 필드로 이동한다.
		             document.getElementById("detailAddress").focus();
		         }
		     }).open();               
		});
		
		
		$("input#detailAddress").blur(function(){
			
			var detailAddress = $(this).val().trim();
			if(detailAddress == ""){
				// 입력하지 않거나 공백만 입력한 경우
				$("table#tblDeliveryInfo :input").prop("disabled",true); 
				$(this).prop("disabled",false);
				
			//	$(this).next().show(); // next() : 바로뒤의 형제태그
			//	또는
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblDeliveryInfo :input").prop("disabled",false);
			//	$(this).next().hide();
			//	또는
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 detailAddress 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		
		$("input#hp2").blur(function(){
			
			var regExp = /^[1-9][0-9]{3}$/i;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
			
			var hp2 = $(this).val();
			
			var bool = regExp.test(hp2);
			
			if(!bool){
				// 국번이 정규표현식에 위배된 경우
				$("table#tblDeliveryInfo :input").prop("disabled",true);
				$(this).prop("disabled",false);
				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				// 국번이 정규표현식에 맞는 경우
				$("table#tblDeliveryInfo :input").prop("disabled",false);
				
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#hp3").blur(function(){
			
		//	var regExp = /^[0-9]{4}$/i;
		//	또는
			var regExp = /^\d{4}$/i;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
			
			var hp3 = $(this).val();
			
			var bool = regExp.test(hp3);
			
			if(!bool){
				// 마지막 전화번호 4자리가 정규표현식에 위배된 경우
				$("table#tblDeliveryInfo :input").prop("disabled",true);
				$(this).prop("disabled",false);
				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				// 마지막 전화번호 4자리가 정규표현식에 맞는 경우
				$("table#tblDeliveryInfo :input").prop("disabled",false);
				
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#email").blur(function(){
			
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			// 이메일 정규표현식 객체 생성
			
			var email = $(this).val();
			
			var bool = regExp.test(email);
			
			if(!bool){
				// 이메일이 정규표현식에 위배된 경우
				$("table#tblDeliveryInfo :input").prop("disabled",true);
				$(this).prop("disabled",false);
				
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else{
				// 이메일이 정규표현식에 맞는 경우
				$("table#tblDeliveryInfo :input").prop("disabled",false);
				
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		////////////////////////////////////////////////////////////////////////////
		$("input#destinationSame").click(function(){ // 배송지 선택에서 "회원 정보와 동일"을 클릭하면 로그인한 회원의 정보를 넣어줌.
			
			$("input#receiverName").val("${sessionScope.loginuser.name}");
			
			b_flagPostcodeClick = false;
			
			$("input#postcode").val("${sessionScope.loginuser.postcode}");
			$("input#address").val("${sessionScope.loginuser.address}");
			$("input#detailAddress").val("${sessionScope.loginuser.detailaddress}");
			$("input#extraAddress").val("${sessionScope.loginuser.extraaddress}");
			
			$("input#hp2").val("${ fn:substring(sessionScope.loginuser.mobile, 3, 7) }");
			$("input#hp3").val("${ fn:substring(sessionScope.loginuser.mobile, 7, 11) }");
			
		});
		
		$("input#destinationNew").click(function(){ // 배송지 선택에서 "새로운 배송지"를 클릭하면 기존 정보 없앰.
			
			$("input#receiverName").val("");
			
			b_flagPostcodeClick = false;
			
			$("input#postcode").val("");
			$("input#address").val("");
			$("input#detailAddress").val("");
			$("input#extraAddress").val("");
			
			$("input#hp2").val("");
			$("input#hp3").val("");
			
		});
		
	});// end of $(document).ready(function(){})----------------------------
	
	
	// 결제하기 버튼 클릭시, 배송 정보를 넘겨줘야함.
	function goPurchase(){
		
		// *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
		var boolFlag = false;
		
		$("input.requiredInfo").each(function(){
			var data = $(this).val().trim();
			if(data == "") {
				alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
				boolFlag = true;
				return false; // break; 라는 뜻이다.
			}
		});
		
		
		if(boolFlag){
			return; // 종료
		}
		
		if(!b_flagPostcodeClick){
			// "우편번호찾기" 를 클릭했는지 클릭안했는지를 알아보기위한 용도임.
			alert("우편번호찾기를 클릭하여 배송 정보에 주소를 입력하세요!!");
			return; // 종료
		}
		
		var frm = document.deliveryInfoFrm;
	//	frm.action = "orderEnd.go"; // 결제완료페이지로 이동#########################################################################################
	//	frm.method = "get"; // (memberRegister회원가입정보는 비공개)#################################################################################
	//	frm.submit();//#######################################################################################################################
		
	
	}// end of function goPurchase()------------------------------------------------
 
	
</script>

	<div class = "container px-0">
		
		<div class="border border-muted mx-auto" style="display:table; width:150px; height:25px; text-align: center;">
			<h4 class="h4" style="display:table-cell; vertical-align: middle">ORDER FORM</h4> <!-- 세로방향으로 가운데정렬 -->
		</div>
		<br>
	
	
		<!-- 혜택정보 시작-->
		<table class="table table-bordered">
			<tr>
				<th class="verticalM" rowspan="2" style="width: 15%;"><div align="center">혜택정보</div></th> <!-- th의 디폴트는 폰트굵게 -->
				<td><strong>홍길동</strong> 님은, [일반회원] 회원이십니다.</td>
			</tr>
			<tr>
				<td>
					<a href="#">가용적립금</a> : 0원
					&nbsp;&nbsp;&nbsp;
					<a href="#">쿠폰</a> : 2개
				</td>
			</tr>
		</table>
  		<!-- 혜택정보 끝 -->
		
		
		<!-- 국내배송상품 주문내역 테이블 시작 -->
		<div style="margin-top: 30px; font-weight: bold; font-size: 12px;">국내배송상품 주문내역</div>
		
		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
					<tr style="text-align: center;"> <!-- 글자 가운데정렬 -->
						<th>
							<!-- 모두선택/해제 => /JavaScriptStudy/WebContent/05checkbox/01checkBoxTest.html를 참고함. -->
							<input type="checkbox" id="allCheck" onClick="fun_allCheck(this.checked);" />
						</th>
						<th>이미지</th>
						<th>상품정보</th>
						<th>판매가</th>
						<th>수량</th>
						<th>적립금</th>
						<th>배송구분</th>
						<th>배송비</th>
						<th>합계</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="verticalM" align="center"> <!-- 모두선택/해제 => 이 부분의 name,id,value 등은 값 바꿔줘야해~~~ -->
							<input type="checkbox" name="product_china" id="product_china1" value="china01" onclick="fun_chinaCheck()" />
						</td>
						<td class="verticalM" align="center"><img alt="305.jpg" src="../images/305.jpg" width="90" height="100"></td>
						<td class="verticalM">
							<strong>상품명이 들어갈 곳 (BURNER) chemi autumn pants (2color) *당일배송가능*</strong>
							<ul style="margin-top: 15px;">
								<li>[옵션: 아이보리/S]</li>
							</ul>
						</td>
						<td class="verticalM" align="center"><strong>29,000원</strong></td>
						<td class="verticalM" align="center">
							<span>1</span>
						</td>
						<td class="verticalM" align="center">
							<img alt="301coins.png" src="../images/301coins.png" width="15" height="15">
							<span>290원</span>
						</td>
						<td class="verticalM" align="center"><span>기본배송</span></td>
						<td class="verticalM" align="center">
							<div>[고정]</div>
						</td>
						<td class="verticalM" align="center"><strong>29,000원</strong></td>
					</tr>
					<tr>
						<td class="verticalM" align="center"> <!-- 모두선택/해제 => 이 부분의 name,id,value 등은 값 바꿔줘야해~~~ -->
							<input type="checkbox" name="product_china" id="product_china1" value="china01" onclick="fun_chinaCheck()" />
						</td>
						<td class="verticalM" align="center"><img alt="306.jpg" src="../images/306.jpg" width="90" height="100"></td>
						<td class="verticalM">
							<strong>상품명이 들어갈 곳 sente knit (3color)</strong>
							<ul style="margin-top: 15px;">
								<li>[옵션: 블루]</li>
							</ul>
						</td>
						<td class="verticalM" align="center"><strong>34,000원</strong></td>
						<td class="verticalM" align="center">
							<span>1</span>
						</td>
						<td class="verticalM" align="center">
							<img alt="301coins.png" src="../images/301coins.png" width="15" height="15">
							<span>340원</span>
						</td>
						<td class="verticalM" align="center"><span>기본배송</span></td>
						<td class="verticalM" align="center">
							<div>[고정]</div>
						</td>
						<td class="verticalM" align="center"><strong>34,000원</strong></td>
					</tr>
					<tr style="border-bottom: 1px solid #d9d9d9;">
						<td></td>
						<td colspan="8">
							<div style="float: left;">[기본배송]</div>
							<div style="float: right;">상품구매금액 63,000 + 배송비 2,500 = 합계 : 65,500원</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 국내배송상품 주문내역 테이블 끝 -->
		
		<div style="margin-bottom: 10px;">상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</div>
		<div style="height: 30px;">
			<div style="float: left;">
				<strong>선택상품을&nbsp;&nbsp;</strong>
				<button type="button" class="btn btn-outline-secondary" style="margin-right: 5px;"><i class="fas fa-times"></i>&nbsp;삭제하기</button>
			</div>
				
			<div style="float: right;">
				<button type="button" class="btn btn-outline-secondary">이전페이지</button>
			</div>
		</div>
		
		
		
		
		
		
		<!-- 배송 정보 form 테이블 시작 -->
		<div style="clear: both; margin-top: 30px;">
			<span style="font-weight: bold; font-size: 12px;">배송 정보</span>
			
			<div style="float: right;">
				<span class="star">*</span>필수입력사항
			</div>
		</div>

		<form name="deliveryInfoFrm">
			<table id="tblDeliveryInfo">
				<tbody>
					<tr>
						<th>배송지 선택</th>
						<td>
							<input type="radio" id="destinationSame" name="destination" checked/><label for="destinationSame" style="margin-left: 1%; font-weight: 400;">회원 정보와 동일</label>
							<input type="radio" id="destinationNew" name="destination" style="margin-left: 2%;" /><label for="destinationNew" style="margin-left: 1%; font-weight: 400;">새로운 배송지</label>
						</td> 
	      			</tr>
	      			<tr>
	      				<th>받으시는 분&nbsp;<span class="star">*</span></th>
	      				<td>
	      					<input type="text" name="receiverName" id="receiverName" value="${sessionScope.loginuser.name}" class="requiredInfo" required/> 
	      					<span class="error">받으시는 분을 입력하세요</span>
						</td> 
					</tr>
					<tr>
						<th>주소&nbsp;<span class="star">*</span></th>
						<td>
							<input type="text" id="postcode" name="postcode" value="${sessionScope.loginuser.postcode}" size="6" maxlength="5" readonly class="requiredInfo" required/>&nbsp;&nbsp;
							<%-- 우편번호 찾기 --%>
							<img id="zipcodeSearch" src="../images/b_zipcode.gif"/><br/>
							
							<input type="text" id="address" name="address" value="${sessionScope.loginuser.address}" size="40" readonly class="requiredInfo" placeholder="주소" required style="margin-top: 4px;"/><br/>
	            			<input type="text" id="detailAddress" name="detailAddress" value="${sessionScope.loginuser.detailaddress}" size="40" class="requiredInfo" placeholder="상세주소" required style="margin-top: 4px;"/><br/>
							<input type="text" id="extraAddress" name="extraAddress" value="${sessionScope.loginuser.extraaddress}" size="40" readonly class="requiredInfo" placeholder="참고항목" required style="margin-top: 4px;"/> 
							
							<span class="error">주소를 입력하세요</span>
						</td> 
					</tr>
					<tr>
						<th>연락처&nbsp;<span class="star">*</span></th>
						<td>
				             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly class="requiredInfo"/>&nbsp;-&nbsp;
				             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 3, 7) }" class="requiredInfo" required/>&nbsp;-&nbsp;
				             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${ fn:substring(sessionScope.loginuser.mobile, 7, 11) }" class="requiredInfo" required/>
				             <span class="error">휴대폰 형식이 아닙니다.</span>
						</td>
					</tr>
					<tr>
						<th>이메일&nbsp;<span class="star">*</span></th>
						<td>
							<input type="text" name="email" id="email" value="${sessionScope.loginuser.email}" class="requiredInfo" required placeholder="abc@def.com"/> 
							<span class="error">이메일 형식에 맞지 않습니다.</span>
							<br>이메일을 통해 주문처리과정을 보내드립니다.
							<br>이메일 주소란에는 반드시 수신가능한 이메일주소를 입력해 주세요.
						</td>
					</tr>
					<tr>
						<th>배송메시지</th>
						<td>
							<textarea rows="2" cols="60" name="deliveryMsg"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 배송 정보 form 테이블 끝 -->
		
		
		
		
		
		<!-- 결제 예정 금액 테이블 시작 -->
		<div style="margin-top: 30px; font-weight: bold; font-size: 12px;">결제 예정 금액</div>
		<table class="table table-bordered" style="text-align: center; margin-bottom: 0px;">
			<thead>
				<tr>
					<th>총 주문 금액</th>
					<th>총 할인 + 부가결제 금액</th>
					<th>총 결제예정 금액</th>
				</tr>	
			</thead>
			<tbody>	
				<tr style="font-weight: bolder; font-size: 13pt;">
					<td>65,500원</td>
					<td>- 6,300원</td>
					<td>= 59,200원</td>
				</tr>
			</tbody>
		</table>
		<table id="tblDiscountInfo">
			<tbody>
				<tr>
					<th>쿠폰할인</th>
					<td><button type="button" class="btn btn-outline-secondary">쿠폰적용</button></td>
				</tr>
				<tr>
					<th>적립금</th>
					<td>
						<input type="text" id="usePoint" style="margin-bottom: 8px;"/>원(총 사용가능 적립금 : <span class="text-danger">0</span>원)
						<ul style="list-style-type: '- '; padding-left: 8px;">
							<li>적립금은 최소 2,000 이상일 때 결제가 가능합니다.</li>
							<li>최대 사용금액은 제한이 없습니다.</li>
							<li>1회 구매시 적립금 최대 사용금액은 0원입니다.</li>
							<li>적립금으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.</li>
						</ul>
					</td>
				</tr>
				<tr>
					<th>총 할인금액</th>
					<td><strong>6,300</strong>원</td>
				</tr>
			</tbody>
		</table>
		<!-- 결제 예정 금액 테이블 끝 -->
		
		<!-- 결제하기 버튼 시작 -->
		<div class="text-center">
			<button type="button" id="btnPurchase" class="btn btn-dark btn-lg" onClick="goPurchase();" style="width: 100%">결제하기</button>
		</div>
		<!-- 결제하기 버튼 끝 -->
		
		
		
		<!-- 무이자 할부 이용안내 시작 -->
		<div style="border: solid 1px #d9d9d9; margin-top: 30px;">
			<h5 style="font-weight: bold; padding: 4px; border-bottom: solid 1px #d9d9d9;">무이자 할부 이용안내</h5>
			<div>
				<ul style="list-style-type: circle; padding-left: 30px;">
					<li>무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다.</li>
					<li>무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.</li>
				</ul>
			</div>
		</div>
		<!-- 무이자 할부 이용안내 끝 -->
		
		<!-- 이용안내 시작 -->
		<div style="border: solid 1px #d9d9d9; margin-top: 15px; margin-bottom: 50px;">
			<h5 style="font-weight: bold; padding: 4px; border-bottom: solid 1px #d9d9d9;">이용안내</h5>
			<div>
				<div style="padding-left: 4px;">WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.</div>
				<ul style="list-style-type: square; padding-left: 30px; margin-top: 4px;">
					<li>
						<a href="javascript:;" onclick="window.open('https://service-api.echosting.cafe24.com/shop/notice_XP_ActiveX.html','','width=795,height=500,scrollbars=yes',resizable=1);">안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치</a>
					</li>
					<li>
						<a href="http://www.microsoft.com/korea/windowsxp/sp2/default.asp" target="_blank">Service Pack 2에 대한 Microsoft사의 상세안내 </a>
					</li>
				</ul>
			</div>
			
			<div>
				<div style="padding-left: 4px; margin-top: 8px;">아래의 쇼핑몰일 경우에는 모든 브라우저 사용이 가능합니다.</div>
				<ul style="list-style-type: square; padding-left: 30px; margin-top: 4px;">
					<li>KG이니시스, KCP, LG U+를 사용하는 쇼핑몰일 경우</li>
					<li>결제가능브라우저 : 크롬,파이어폭스,사파리,오페라 브라우저에서 결제 가능<br>(단, window os 사용자에 한하며 리눅스/mac os 사용자는 사용불가)</li>
					<li>최초 결제 시도시에는 플러그인을 추가 설치 후 반드시 브라우저 종료 후 재시작해야만 결제가 가능합니다.<br>(무통장, 휴대폰결제 포함)</li>
				</ul>
			</div>
			
			<div>
				<div style="padding-left: 4px; margin-top: 8px;">세금계산서 발행 안내</div>
				<ul style="list-style-type: square; padding-left: 30px; margin-top: 4px;">
					<li>부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다.</li>
					<li>세금계산서는 사업자만 신청하실 수 있습니다.</li>
					<li>배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.</li>
					<li>[세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.</li>
					<li>[세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.</li>
				</ul>
			</div>
			
			<div>
				<div style="padding-left: 4px; margin-top: 8px;">부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내</div>
				<ul style="list-style-type: square; padding-left: 30px; margin-top: 4px;">
					<li>변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며</li>
					<li>신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)</li>
					<li>상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.</li>
				</ul>
			</div>
			
		</div>
		<!-- 이용안내 끝 -->
		
		
	</div>

	
<jsp:include page="../footer.jsp" />