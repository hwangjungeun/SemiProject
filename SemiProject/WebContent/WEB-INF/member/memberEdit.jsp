<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri= "http://java.sun.com/jsp/jstl/functions" %>

<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>



<jsp:include page="/WEB-INF/header.jsp" />
<%-- 헤더 끝 --%>


<style>
	
	

 	.titleArea h2 {
    display: inline-block;
    position: relative;
    margin: 20px auto 10px;
    padding: 8px 15px;
    min-width: 150px;
    color: #353535;
    font-size: 16px;
    letter-spacing: 1px;
    border: 1px #ddd solid;
    display: inline;
    text-transform: uppercase;
    height:5em;
    
	}

	h2 {
    display: block;
    font-size: 1.5em;
    margin-block-start: 0.83em;
    margin-block-end: 0.83em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold; 
	}

	.titleArea {
    margin: 0 0 30px;
    text-align: center;
	}
	
	table#tblMemberEdit {
		width: 100%;
		font-size: 15px;
		margin: 10px;
	}
	
	table#tblMemberEdit td {
		margin: 0 5px;
		line-height: 25px;
		padding: 10px 8px;
	}
	
	table#tblMemberEdit td:first-child {
		border: solid 1px #d9d9d9;
		border-left: none;
	}

	table#tblMemberEdit td:last-child {
		border: solid 1px #d9d9d9;
		border-right: none;
	}
	
	.star {
		color: #b4c5e4;
		font-weight: bold;
		font-size: 13pt;
	}
	
	button#btnUpdate{
		width: 120px;
	    padding-left: 8px;
	    padding-right: 8px;
	    display: inline-block;
	    box-sizing: border-box;
	    padding: 10px 16px;
	    border: 1px solid transparent;
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
	    color: #fff;
	    background-color: #555;
	    transition: all 0.15s ease;
	}
	
	button#btnCancle{
		width: 120px;
	    padding-left: 8px;
	    padding-right: 8px;
	    display: inline-block;
	    box-sizing: border-box;
	    padding: 10px 16px;
	    border: 1px solid #bbb;
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
	}



</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	

	var b_flagEmailDuplicateClick = false;
	// 확인 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
	
	$(document).ready(function(){

		$("span.error").hide();
		$("input#name").focus();
		
		$("input#name").blur(function(){
			
			var name = $(this).val().trim();
			if(name == "") {
				// 입력하지 않거나 공백만 입력한 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
				
			//	$(this).next().show();
			//  또는
			    $(this).parent().find(".error").show();
			    $(this).focus();
			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
			//	$(this).next().hide();
			//  또는
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
	
		$("input#pwd").blur(function(){
			
		 // var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
		 // 또는
		    var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		    // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
		    
			var pwd = $(this).val();
		    
			var bool = regExp.test(pwd);
		    
			if(!bool) {
				// 암호가 정규표현식에 위배된 경우
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
			
			var pwd = $("input#pwd").val();
			var pwdcheck = $("input#pwdcheck").val();
			
			if(pwd != pwdcheck) {
				// 암호와 암호확인값이 틀린 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
				$("input#pwd").prop("disabled",false);
			
			    $(this).parent().find(".error").show();
			    $("input#pwd").focus();
			}
			else {
				// 암호와 암호확인값이 같은 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
			
				$(this).parent().find(".error").hide();
			}
			
		});// 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#email").blur(function(){
			
			    var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			    // 이메일 정규표현식 객체 생성
			    
				var email = $(this).val();
			    
				var bool = regExp.test(email);
			    
				if(!bool) {
					// 이메일이 정규표현식에 위배된 경우
					$("table#tblMemberUpdate :input").prop("disabled",true);
					$(this).prop("disabled",false);
				
				    $(this).parent().find(".error").show();
				    $(this).focus();
				}
				else {
					// 이메일이 정규표현식에 맞는 경우
					$("table#tblMemberUpdate :input").prop("disabled",false);
				
					$(this).parent().find(".error").hide();
				}
				
			});// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
			
			
			$("input#hp2").blur(function(){
				
			    var regExp = /^[1-9][0-9]{3}$/i; 
			    // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
			    
				var hp2 = $(this).val();
			    
				var bool = regExp.test(hp2);
			    
				if(!bool) {
					// 국번이 정규표현식에 위배된 경우
					$("table#tblMemberUpdate :input").prop("disabled",true);
					$(this).prop("disabled",false);
				
				    $(this).parent().find(".error").show();
				    $(this).focus();
				}
				else {
					// 국번이 정규표현식에 맞는 경우
					$("table#tblMemberUpdate :input").prop("disabled",false);
				
					$(this).parent().find(".error").hide();
				}
				
			});// 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
			
			
			$("input#hp3").blur(function(){
				
			//  var regExp = /^[0-9]{4}$/i;
			//  또는    
			    var regExp = /^\d{4}$/i; 
			    // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성
			    
				var hp3 = $(this).val();
			    
				var bool = regExp.test(hp3);
			    
				if(!bool) {
					// 마지막 전화번호 4자리가 정규표현식에 위배된 경우
					$("table#tblMemberUpdate :input").prop("disabled",true);
					$(this).prop("disabled",false);
				
				    $(this).parent().find(".error").show();
				    $(this).focus();
				}
				else {
					// 마지막 전화번호 4자리가 정규표현식에 맞는 경우
					$("table#tblMemberUpdate :input").prop("disabled",false);
				
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
			
         // 이메일 값이 변경되면 가입하기 벝튼을 클릭시 "아이디 중복확인" 을 클릭했는지 안했는지
	         	$("input#email").bind("change", function(){  
	         		b_flagEmailDuplicateClick = false;
	         	});
         
         
	});// end of $(document).ready(function(){})---------------------------------
	
	// Function Declaration
	//// ============ 이메일 중복검사하기 ============ ////
	
	function isExistEmailCheck(){

        	 b_flagEmailDuplicateClick = true;
        	// 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
        	
        	// 첫번째 방법
        	$.ajax({
        		url:"<%= ctxPath%>/member/emailDuplicateCheck.go",
        		type:"post",
        		data:{"email":$("input#email").val()},
        		dataType:"json",
        		success:function(json) {

        			if(json.isExists) {
        				
        				// 세션에 올라온 email과 입력해준 email이 같은 경우
        				if( "${sessionScope.loginuser.email}" == $("input#email").val() ) {
        					$("span#emailCheckResult").html($("input#email").val()+ " 은 사용가능합니다").css("color","green");
        					
        				}
        				else{
        					//이메일을 새로이 변경한 경우인데 입력한 email 이 이미 사용중 이라면
        					$("span#emailCheckResult").html($("input#email").val()+" 은 이미 사용중이므로 사용불가 합니다.").css("color","orange");
            				$("input#email").val("");
        				}
        				
        				
        				
        				
        				
        			}
        			else {
        				// 입력한 email 가 DB 테이블에 존재하지 않는 경우라면 
        				$("span#emailCheckResult").html($("input#email").val()+ " 은 사용가능합니다").css("color","green");
        			}
    				
        		},
        		error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
        
	
            });
	}
	
	
	// Function Declaration
	// 수정하기
	function goEdit() {
		
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
	    
		
		if(boolFlag) {
			return; // 종료
		}
		
		var radioCheckedLength = $("input:radio[name=gender]:checked").length;
	
	    if(!b_flagEmailDuplicateClick) {
	    	// "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
	    	alert("이메일중복확인 클릭하여 이메일중복검사를 하세요!!");
	    	return; // 종료
	    } 
	  
				
		var frm = document.editFrm;
		frm.action = "<%= ctxPath%>/member/memberEditEnd.go";
		frm.method = "post";
		frm.submit();
		
	}// end of function goEdit() {}---------------------------------------
	
</script>

<div class="titleArea">
    <h2>MODIFY PROFILE</h2>
</div>
<div class="row" id="divRegisterFrm">
   <div class="col-md-12" align="center">

		
		<form name = "editFrm">
	
		<div id="head" align="right" style = "font-size:12pt;">
	         회원수정 (<span style="font-size: 12pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) 
	      </div>
   
	   <table id="tblMemberEdit">
	      <tbody>
	      <tr>
	         <td style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;">
			    <input type="text" name="userid" id="userid" class="requiredInfo" value="${sessionScope.loginuser.userid }" readonly="readonly" style="background-color: #cccccc;"/>     
				<span class="error">아이디는</span>
			</td>
	      </tr>
	      <tr>
			<td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" required/>
				<span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
			</td>
		</tr>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" required/> 
				<span class="error">암호가 일치하지 않습니다.</span>
			</td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%; font-weight: bold;">이름&nbsp;<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;">
	             <input type="text" name="name" id="name" class="requiredInfo" value="${sessionScope.loginuser.name }"/> 
	            <span class="error">이름은 필수입력 사항입니다.</span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
	        <td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" value= "${sessionScope.loginuser.email }" class="requiredInfo" required/> 
	             <span class="error">이메일 형식에 맞지 않습니다.</span>
	             
	             <span style="display: inline-block; width: 90px;  height: 25px; background-color:#f2f2f2; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="isExistEmailCheck();">이메일중복확인</span> 
	             <span id="emailCheckResult"></span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%; font-weight: bold;">주소<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;">
	            <input type="text" id="postcode" name="postcode" value="${sessionScope.loginuser.postcode }" size="6" maxlength="5"  />&nbsp;&nbsp;
	            <span id="zipcodeSearch" style="display: inline-block; width: 80px;  height: 25px; background-color:#f2f2f2; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; margin-bottom: 5px; cursor: pointer;" >우편번호</span> 
	            <span class="error">우편번호 형식이 아닙니다.</span>
	            <br>
	            <input type="text" id="address" name="address" value="${sessionScope.loginuser.address }" size="40"  /><br/>
			   <input type="text" id="detailAddress" name="detailAddress" value="${sessionScope.loginuser.detailaddress }" size="40"  />&nbsp;<input type="text" id="extraAddress" name="extraAddress" value="${sessionScope.loginuser.extraaddress }" size="40" /> 
	            <span class="error">주소를 입력하세요</span>
	         </td>
	      </tr>
	     
	      <tr>
	         <td style="width: 20%; font-weight: bold;">연락처<span class="star">*</span></td>
	         <td style="width: 80%; text-align: left;">
	             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
	              <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${fn:substring(sessionScope.loginuser.mobile,3,7) }"/>&nbsp;-&nbsp;
			    <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${fn:substring(sessionScope.loginuser.mobile,7,11) }"/>
	             <span class="error">휴대폰 형식이 아닙니다.</span>
	         </td>
	      </tr>
	      
	     
	      
	      <tr>
	         <td style="width: 20%; font-weight: bold;">상세 사이즈</td>
	         <td style="width: 80%; text-align: left;">
	            <span>키: </span>
	            <input type="text" id="height" name="height" size="6" maxlength="3" placeholder="(cm)" style=" margin-right: 2%; width: 60px; text-align: right;" value="${sessionScope.loginuser.height }"/>
	            <span>몸무게: </span>
	            <input type="text" id="weight" name="weight" size="6" maxlength="3"  placeholder="(kg)" style="margin-right: 2%; width: 60px; text-align: right;" value="${sessionScope.loginuser.weight }"/>
	            
	            <span>상의사이즈: </span>
	            <select id="topsize" name="topsize" style="margin-right: 2%; width: 60px; padding: 6px;">
	               <option value="" selected disabled>${sessionScope.loginuser.topsize}</option>
	               <option value ="S">S</option>
	               <option value ="M">M</option>
	               <option value ="L">L</option>
	            </select>
	            
	            <span>하의사이즈: </span>
	            <select id="bottomsize" name="bottomsize" style="margin-right: 2%; width: 60px; padding: 6px;">
	               <option value="" selected disabled>${sessionScope.loginuser.bottomsize }</option>
	               <option value ="S">S</option>
	               <option value ="M">M</option>
	               <option value ="L">L</option>
	            </select>
	           </td>
	         </tr>
	      
	     

	      <tr>
			<td colspan="2"  class="text-center">
				<button type="button" id="btnUpdate" class="btn btn-secondary  mt-3" onClick="goEdit();">회원정보수정</button>
				<button type="button" id="btnCancle" class="btn btn-secondary  mt-3 ml-5" onClick="self.close()">취소</button>
			</td>
		</tr>
	      </tbody>
	   </table>
   </form>
   </div>
</div>







<%-- 풋터 시작 --%> 
<jsp:include page="/WEB-INF/footer.jsp" />