<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
   //      /MyMVC
%>

    
<jsp:include page="../header.jsp" />

<style>
   table#tblMemberRegister {
          width: 93%;
          
          /* 선을 숨기는 것 */
          border: hidden;
          
          margin: 10px;
   }  
   
   table#tblMemberRegister #th {
         height: 40px;
         text-align: center;
         background-color: silver;
         font-size: 14pt;
   }
   
   table#tblMemberRegister td {
         /* border: solid 1px gray;  */
         line-height: 30px;
         padding-top: 8px;
         padding-bottom: 8px;
   }
   
   .star { color: red;
           font-weight: bold;
           font-size: 13pt;
   }
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type ="text/javascript">
	
	var b_flagIdDuplicateClick = false;
	// 가입하기 버튼을 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
	var b_flagEmailDuplicateClick = false;
   // 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
   
	$(document).ready(function(){
		
		$("span.error").hide();
		$("input#name").focus();
		
		$("input#name").blur(function(){
			// blur ==> focus가 있다가 focus를 잃어버림
			
			var name = $(this).val().trim();
			if(name == "") {
				// 입력하지 않거나 공백만 입력한 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
				// $(this).next().show();
				// $("input#name")의 형제태그는 보여줘라
				$(this).parent().find(".error").show();
				//$("input#name")의 부모태그에서  클래스가 error인것을 보여라
				$(this).focus();
			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				// $(this).next().hide();
				// $("input#name")의 형제태그를 감춰라
				$(this).parent().find(".error").hide();
				//$("input#name")의 부모태그에서  클래스가 error인것을 감춰라
			}
			
		});// 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#userid").blur(function(){
			// blur ==> focus가 있다가 focus를 잃어버림
			
			
			var userid = $(this).val().trim();
			if(userid == "") {
				// 입력하지 않거나 공백만 입력한 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
				// $(this).next().next().next().show();
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				// $(this).next().next().next().hide();
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 userid 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#pwd").blur(function(){
			// blur ==> focus가 있다가 focus를 잃어버림
			
			// var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			var regExp= new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			
			var pwd = $(this).val();
			
			var bool = regExp.test(pwd);
			
			
			if(!bool) {
				// 암호가 정규표현식에 틀린 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 암호가 정규표현식에 맞는 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		

		$("input#pwdcheck").blur(function(){
			// blur ==> focus가 있다가 focus를 잃어버림
			
			var pwd = $("input#pwd").val();
			var pwdcheck = $(this).val();
			
			if(pwd != pwdcheck) {
				// 암호와 암호확인 값이 틀린 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$("input#pwd").prop("disabled",false);
				$(this).prop("disabled",false);
				
				$(this).parent().find(".error").show();
				$("input#pwd").focus();
			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

		$("input#email").blur(function(){
			// blur ==> focus가 있다가 focus를 잃어버림
			
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			// 이메일 정규표현식 객체 생성
			
			var email = $(this).val();
			
			var bool = regExp.test(email);
			
			if(!bool) {
				// 암호가 정규표현식에 틀린 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 암호가 정규표현식에 맞는 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		

		$("input#hp2").blur(function(){
			// blur ==> focus가 있다가 focus를 잃어버림
			
			var regExp = /^[1-9][0-9]{3}$/i;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
			
			var hp2 = $(this).val();
			
			var bool = regExp.test(hp2);
			
			if(!bool) {
				// 국번이 정규표현식에 위배된 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 국번이 정규표현식에  맞는 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		

		$("input#hp3").blur(function(){
			// blur ==> focus가 있다가 focus를 잃어버림
			
// 			var regExp = /^[0-9]{4}$/i;
			var regExp = /^\d{4}$/i;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
			
			var hp3 = $(this).val();
			
			var bool = regExp.test(hp3);
			
			if(!bool) {
				// 마지막 전화번호 4자리가 정규표현식에 위배된 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 마지막 전화번호 4자리가 정규표현식에  맞는 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("img#zipcodeSearch").click(function(){
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

		////////////////////////////////////////////////////////////////////////			
		
		var mmhtml ="";
		for (var i=1; i<=12; i++) {
			if(i<10) {
				mmhtml += "<option>0"+i+"</option>"
			}
			else {
				mmhtml += "<option>"+i+"</option>"
			}
		}
		$("select#birthmm").html(mmhtml);
		
		var ddhtml ="";
		for (var i=1; i<=31; i++) {
			if(i<10) {
				ddhtml += "<option>0"+i+"</option>"
			}
			else {
				ddhtml += "<option>"+i+"</option>"
			}
		}
		$("select#birthdd").html(ddhtml);
		
		// === jQuery UI 의 datepicker === //
		$("input#datepicker").datepicker({
	                 dateFormat: 'yy-mm-dd'  //Input Display Format 변경
	                ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	                ,changeYear: true        //콤보박스에서 년 선택 가능
	                ,changeMonth: true       //콤보박스에서 월 선택 가능                
	                ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	                ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	                ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	                ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	                ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
	                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	              //,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	              //,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
		});                    
	            
		//초기값을 오늘 날짜로 설정
		$('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 
	    /////////////////////////////////////////////////////
		
		// === 전체 datepicker 옵션 일괄 설정하기 ===  
        //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
          $(function() {
              //모든 datepicker에 대한 공통 옵션 설정
              $.datepicker.setDefaults({
                  dateFormat: 'yy-mm-dd' //Input Display Format 변경
                  ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                  ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                  ,changeYear: true //콤보박스에서 년 선택 가능
                  ,changeMonth: true //콤보박스에서 월 선택 가능                
               // ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
               // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
               // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
               // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                  ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                  ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                  ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                  ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                  ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
               // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
               // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
              });
   
              //input을 datepicker로 선언
              $("input#fromDate").datepicker();                    
              $("input#toDate").datepicker();
              
              //From의 초기값을 오늘 날짜로 설정
              $('input#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
              
              //To의 초기값을 3일후로 설정
              $('input#toDate').datepicker('setDate', '+3D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
          });
		
		///////////////   아이디 중복검사하기     ////////////////////////////////////////////////////
		$("img#idcheck").click(function(){
			b_flagIdDuplicateClick = true;
			
			// 첫번째 방법
			$.ajax({
				url: "<%= ctxPath%>/member/idDuplicateCheck.up",
				type: "post",
				data: {"userid":$("input#userid").val()},
// 				dataType: "json",
				success: function(text) {
					// text ==> "{"isExists":false}" (문자열) 
					// text ==> "{"isExists":true}"  (문자열)
					
					// alert("확인용 typeof(text): "+typeof(text));
					// 확인용 typeof(text): String 
					// 확인용 typeof(text): object <== dataType: "json"쓴 경우
					
					JSON.stringify;	// 자바객체를 String Type으로 변경해주는 것
					
					var jsonObj =  JSON.parse(text);	// Obj
					// JSON.parse(text); 은 JSON 형식으로 되어진 문자열을 자바스크립트 객체로 변환해주는 것이다.
                    // 조심할 것은 text 는 반드시 JSON 형식으로 되어진 문자열이어야 한다.
					
					// alert("확인용 typeof(jsonObj): "+typeof(jsonObj));
					// 확인용 typeof(jsonObj): object
					
					if(jsonObj.isExists) {
						// true, 입력한 userid가 이미 사용 중이라면
						$("span#idcheckResult").html($("input#userid").val()+"은 이미 사용 중 이므로 사용불가 합니다.").css("color","orange");
						$("input#userid").val("");
						
					
					}
					else {
						// false, 입력한 userid가 DB 테이블에 존재하지 않는 경우
						$("span#idcheckResult").html($("input#userid").val()+"은 사용가능 합니다.").css("color","green");
					}
				},
				error: function(request, status, error){
	                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                   }
			}); 
			
			// 두번째 방법
			<%-- 
			$.ajax({
				url: "<%= ctxPath%>/member/idDuplicateCheck.up",
				type: "post",
				data: {"userid":$("input#userid").val()},
				dataType: "json",
				success: function(json) {
					// json 자체가 객체
					
					
					if(json.isExists) {
						// true, 입력한 userid가 이미 사용 중이라면
						$("span#idcheckResult").html($("input#userid").val()+"은 이미 사용 중 이므로 사용불가 합니다.").css("color","orange");
						$("input#userid").val("");
					}
					else {
						// false, 입력한 userid가 DB 테이블에 존재하지 않는 경우
						$("span#idcheckResult").html($("input#userid").val()+"은 사용가능 합니다.").css("color","green");
					}
					
				},
				error: function(request, status, error){
	                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                   }
			}); 
			--%>
			
			
		}); // end of $("img#idCheck").click(function(){})
		

		// 아이디값이 변경되면 가입하기 버튼 클릭 시 아이디가 중복되었는지 알아보기 위해 중복검사여부를 초기화
		$("input#userid").bind("change",function(){
			b_flagIdDuplicateClick = false;
		});
			
		// 이메일이 변경되면 가입하기 버튼 클릭 시 이메일이 중복되었는지 알아보기 위해 경우 중복검사여부를 초기화
		$("input#email").bind("change",function(){
			b_flagEmailDuxplicateClick = false;
		});
		
	});// end of $(document).ready(function(){})
	
	// Function Declaration
	function goRegister() {
		
		var arr_requiredInfo = document.getElementsByClassName("requiredInfo");
		var boolFlag = false;
		// 필수 입력사항에 모두 입력되었다면 false 하나라도 아니라면 true
		/* 자바스크립트로
		for(var i =0; i<arr_requiredInfo.length; i++) {
			var val = arr_requiredInfo[i].value.trim();
			
			if (val == "") {
				alert("필수입력사항을 모두 입력해주세요.");
				boolFlag = true;
				break;
			}
		}//end of for
		 */
		
		 // 또는 jQuery로
		 $("input.requiredInfo").each(function(index,item){
			 var data = $(this).val().trim();
			 if(data == "") {
				 alert("* 표시된 필수입력사항을 모두 입력해주세요.");
					boolFlag = true;
					return false;
			 }
		 });
		 
		 
		if(boolFlag) {
			return;	// 종료
		}
		var radioCheckedLength = $("input:radio[name=gender]:checked").length;
		
		if(radioCheckedLength == 0) {
			alert("성별을 선택하여 주세요");
			return;
		}
		
		var checkboxCheckedLength = $("input:checkbox[id=agree]:checked").length;
		if(checkboxCheckedLength == 0) {
			alert("이용약관에 동의해 주세요");
			return;
		}
		
		 
		if(!b_flagIdDuplicateClick){
			// 가입하기 버튼을 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
			alert("아아디 중복확인을 클릭하여 ID 중복검사를 하세요!!");
			return;
		}
		
		if(!b_flagEmailDuplicateClick){
			// 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
			alert("이메일 중복확인을 클릭하여 이메일 중복검사를 하세요!!");
			return;
		}
	
	
		var frm = document.registerFrm;
		
		frm.action= "memberRegister.up";
		frm.method= "post";
		frm.submit();
		
	}// end of function goRegister()
	
	
	
	///////////////   이메일 중복검사하기     ////////////////////////////////////////////////////
	function isExistEmailCheck() {
		
		b_flagEmailDuplicateClick = true;
		
		// 첫번째 방법
		$.ajax({
			url: "<%= ctxPath%>/member/emailDuplicateCheck.up",
			type: "post",
			data: {"email":$("input#email").val()},
			dataType: "json",
			success: function(json) {
				
				if(json.isExists) {
					// true, 입력한 email이 이미 사용 중이라면
					$("span#emailCheckResult").html($("input#email").val()+"은 이미 사용 중 이므로 사용불가 합니다.").css("color","orange");
					$("input#email").val("");
				
				}
				else {
					// false, 입력한 email이 DB 테이블에 존재하지 않는 경우
					$("span#emailCheckResult").html($("input#email").val()+"은 사용가능 합니다.").css("color","green");
				}
				
			},
			error: function(request, status, error){
                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                   }
		}); 
		
	} // end of isExistEmailCheck()
	
</script>

<div class="row" id="divRegisterFrm">
   <div class="col-md-12" align="center">
   <form name="registerFrm">
   
   <table id="tblMemberRegister">
      <thead>
      <tr>
          <%-- 아래의 ${name_scope_request}&nbsp; 은 <c:set var="변수명" value="${값}" scope="" /> 를 테스트 하기 위해서 사용하는 것임. --%> 
           <th colspan="2" id="th">::: 회원가입 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::</th>
      </tr>
      </thead>
      <tbody>
      <tr>
         <td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;">
             <input type="text" name="name" id="name" class="requiredInfo" /> 
            <span class="error">성명은 필수입력 사항입니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;">
             <input type="text" name="userid" id="userid" class="requiredInfo" />&nbsp;&nbsp;
             <!-- 아이디중복체크 -->
             <img id="idcheck" src="../images/b_id_check.gif" style="vertical-align: middle;" />
             <span id="idcheckResult"></span>
             <span class="error">아이디는 필수입력 사항입니다.</span>
         </td> 
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" />
            <span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" /> 
            <span class="error">암호가 일치하지 않습니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
         <td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" class="requiredInfo" placeholder="abc@def.com" /> 
             <span class="error">이메일 형식에 맞지 않습니다.</span>
             
             <%-- ==== 퀴즈 시작 ==== --%>
             <span style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span> 
             <span id="emailCheckResult"></span>
             <%-- ==== 퀴즈 끝 ==== --%>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">연락처</td>
         <td style="width: 80%; text-align: left;">
             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
             <span class="error">휴대폰 형식이 아닙니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">우편번호</td>
         <td style="width: 80%; text-align: left;">
            <input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
            <%-- 우편번호 찾기 --%>
            <img id="zipcodeSearch" src="../images/b_zipcode.gif" style="vertical-align: middle;" />
            <span class="error">우편번호 형식이 아닙니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">주소</td>
         <td style="width: 80%; text-align: left;">
            <input type="text" id="address" name="address" size="40" placeholder="주소" /><br/>
            <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
            <span class="error">주소를 입력하세요</span>
         </td>
      </tr>
      
      <tr>
         <td style="width: 20%; font-weight: bold;">성별</td>
         <td style="width: 80%; text-align: left;">
            <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
            <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
         </td>
      </tr>
      
      <tr>
         <td style="width: 20%; font-weight: bold;">생년월일</td>
         <td style="width: 80%; text-align: left;">
            <input type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" value="1995" style="width: 80px;" required />
            
            <select id="birthmm" name="birthmm" style="margin-left: 2%; width: 70px; padding: 8px;">
               <%-- 
               <option value ="01">01</option>
               <option value ="02">02</option>
               <option value ="03">03</option>
               <option value ="04">04</option>
               <option value ="05">05</option>
               <option value ="06">06</option>
               <option value ="07">07</option>
               <option value ="08">08</option>
               <option value ="09">09</option>
               <option value ="10">10</option>
               <option value ="11">11</option>
               <option value ="12">12</option>
               --%>
            </select> 
            
            <select id="birthdd" name="birthdd" style="margin-left: 2%; width: 70px; padding: 8px;">
               <%-- 
               <option value ="01">01</option>
               <option value ="02">02</option>
               <option value ="03">03</option>
               <option value ="04">04</option>
               <option value ="05">05</option>
               <option value ="06">06</option>
               <option value ="07">07</option>
               <option value ="08">08</option>
               <option value ="09">09</option>
               <option value ="10">10</option>
               <option value ="11">11</option>
               <option value ="12">12</option>
               <option value ="13">13</option>
               <option value ="14">14</option>
               <option value ="15">15</option>
               <option value ="16">16</option>
               <option value ="17">17</option>
               <option value ="18">18</option>
               <option value ="19">19</option>
               <option value ="20">20</option>
               <option value ="21">21</option>
               <option value ="22">22</option>
               <option value ="23">23</option>
               <option value ="24">24</option>
               <option value ="25">25</option>
               <option value ="26">26</option>
               <option value ="27">27</option>
               <option value ="28">28</option>
               <option value ="29">29</option>
               <option value ="30">30</option>
               <option value ="31">31</option>
               --%>
            </select> 
         </td>
      </tr>
      
      <tr>
         <td style="width: 20%; font-weight: bold;">생년월일</td>
         <td style="width: 80%; text-align: left;">
            <input type="text" id="datepicker">
         </td>
      </tr>
      
      <tr>
         <td style="width: 20%; font-weight: bold;">재직기간</td>
         <td style="width: 80%; text-align: left;">
            From: <input type="text" id="fromDate">&nbsp;&nbsp; 
            To: <input type="text" id="toDate">
         </td>
      </tr>
         
      <tr>
         <td colspan="2" style="text-align: center; vertical-align: middle;">
            <iframe src="../iframeAgree/infoagree.html" width="85%" height="150px" class="box" ></iframe>
            <!-- WEB_INF에는 jsp파일만 넣을 수 있다.  -->
         </td>
      </tr>
      <tr>
         <td colspan="2">
            <label for="agree">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
         </td>
      </tr>
      <tr>
         <td colspan="2" style="text-align: center; vertical-align: middle;">
            <iframe src="../iframeAgree/shoppingagree.html" width="85%" height="150px" class="box" ></iframe>
            <!-- WEB_INF에는 jsp파일만 넣을 수 있다.  -->
         </td>
      </tr>
      <tr>
         <td colspan="2">
            <label for="agree">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
         </td>
      </tr>
      <tr>
         <td colspan="2" style="line-height: 90px;" class="text-center">
            <%-- 
            <button type="button" id="btnRegister" style="background-image:url('/MyMVC/images/join.png'); border:none; width: 135px; height: 34px;" onClick="goRegister();"></button> 
            --%>
            <button type="button" id="btnRegister" class="btn btn-dark btn-lg" onClick="goRegister();">가입하기</button> 
         </td>
      </tr>
      </tbody>
   </table>
   </form>
   </div>
</div>

<jsp:include page="../footer.jsp" />    