<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>


<jsp:include page="/WEB-INF/header.jsp" />
<%-- 헤더 끝 --%>
<style>

	div#loginpage{
	position: relative;
    margin: 100px auto 150px;
    padding: 0;
    clear: both;
    overflow: hidden;
    text-align: center;
	
	}
	
   table#loginTbl {
   	  display: inline-block;
    margin: 0 auto;
    padding: 25px 48px;
    width: 330px;
    border: 1px #e5e5e5 solid;
    text-align: left;
     
      
   }
   
   table#loginTbl #th {
      
      font-size: 14pt;
      text-align: center;
      height: 30px;
   }
   
   table#loginTbl td {
     
      line-height: 30px;
   }
   
   tr#ID{
    width: 98%;
    height: 32px;
    line-height: 32px;
    padding: 2px 2px 2px 3px;
    border: 0 none;
    color: #353535;
    font-size: 12px;
    letter-spacing: 1px;
   }
   
   tr#PWD{
    width: 98%;
    height: 32px;
    line-height: 32px;
    padding: 2px 2px 2px 3px;
    border: 0 none;
    color: #353535;
    font-size: 12px;
    letter-spacing: 1px;
   }
   
   tr#find{
   font-size: 9pt;
   
   }
   
   button#btnSubmit{
    width: 100%;
    height: 30pt;
     display: block;
    margin: 0 0 5px;
    /* padding: 15px; */
    font-size: 15px;
    font-weight: bold;
    background-color: #a6a6a6;
   
   }
   
   button#btnRegister{
     width: 100%;
    height: 30pt;
     display: block;
    margin: 0 0 5px;
    /* padding: 15px; */
    font-size: 15px;
    font-weight: bold;
    background-color: #fff;
   }
   
   a:hover { color:maroon; 
          font-weight: bold; }
          
          
          
   
</style>


<script type = "text/javascript">

	$(document).ready(function(){
		
		// === 로컬스토리지(localStorage)에 저장된 key 가 "saveid"인  userid 값을 불러와서 input 태그 userid에 넣어주기 === //
		var loginUserid = localStorage.getItem('saveid');
		
		if(loginUserid != null) {
			$("input#loginUserid").val(loginUserid);
			$("input:checkbox[id=saveid]").prop("checked",true);
		}
		
		
		
	  $("button#btnSubmit").click(function(){
		  goLogin(); // 로그인 시도합니다.
	  })
	  // 암호 입력후 엔터를 눌러 로그인 하기
	  $("input#loginPwd").bind("keyup",function(event){
		  if(event.keyCode == 13){ //엔터를 눌렀을 경우 입니다.
			  goLogin(); // 로그인 시도합니다.
		  }
	  })  
	 
	})
  
  function goLogin(){
	  
	  var loginUserid = $("input#loginuserid").val().trim(); // 공백이 없어야 합니다.
	  var loginPwd = $("input#loginPwd").val().trim();
	  
	  if(loginUserid == ""){	// 아이디 입력을 하지 않았을 경우
		  alert("아이디를 입력하세요!!");
		  $("input#loginUserid").val("");
		  $("input#loginUserid").focus();
		  return // 종료
	  }
	  if(loginPwd == ""){
		  alert("암호를 입력하세요!!");
		  $("input#loginPwd").val("");
		  $("input#loginPwd").focus();
		  return; // 종료
	  }
	 
		if ($("input:checkbox[id=saveid]").prop("checked")) {
			alert("아이디저장 체크를하셨네요.");

			localStorage.setItem('saveid', $("input#loginUserid").val());
			//  로컬스토리지에 저장한다.
		} else {
			//alert("아이디저장 체크를 해제 하셨네요.");
			localStorage.removeItem('saveid'); // 체크를 해제하면 지워버린다.
		}
		
		var frm = document.loginFrm;
		frm.action = "<%= request.getContextPath()%>/login/login.go",
		frm.method = "post";
		frm.submit();	
		
	} // end of function goLogin(){}-----------------------------------------
	
</script>


	<div id = "loginpage">
	<form name="loginFrm">
	       <table id="loginTbl">
	         <thead>
	            <tr>
	            <%-- 아래의 ${name_scope_page} 은 <c:set var="변수명" value="${값}" scope="" /> 를 테스트 하기 위해서 사용하는 것임. --%>  
               <%-- 변수의 선언은 header.jsp 파일에서 선언 하였음 --%>
               <th colspan="2" id="th">Registered Customers</th>
            	<%-- 끝 --%>
	            </tr>
	         </thead>
	         
	         <tbody>
	            <tr id = "ID">
	               <th style="width: 20%; border-bottom: hidden; border-right: hidden; padding: 10px;">ID</th>
	               <td style="width: 80%; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="text" id="loginUserid" name="userid" size="20" class="box" autocomplete="off" /></td>
	            </tr>   
	            <tr id = "PWD">
	               <th style="width: 20%; border-top: hidden; border-bottom: hidden; border-right: hidden; padding: 10px;">암호</th>
	               <td style="width: 80%; border-top: hidden; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="password" id="loginPwd" name="pwd" size="20" class="box" /></td>
	            </tr>
	          
	            <tr>
	               <td colspan="2" align="center" style="padding: 10px;">
	                  <input type="checkbox" id="saveid" name="saveid" /><label for="saveid">아이디저장</label>
	         
	                   <button type="button" id="btnSubmit" ><span style ="color:white;" >로그인</span></button>
	                   <button type="button" id="btnRegister" onclick="location.href='<%= ctxPath %>/member/memberRegister.go'"><span style ="color:black">회원가입 하기</span></button>
	               </td>
	               
	               
	            </tr>
	             <%-- === 아이디 찾기, 비밀번호 찾기 === --%>
	            <tr id = "find" >
	               <td colspan="2" align="center">
	                  <a style="cursor: pointer;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal" data-backdrop="static">아이디찾기</a> &nbsp; | &nbsp;
	                  <a style="cursor: pointer;" data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" data-backdrop="static">비밀번호찾기</a>
	               </td>
	            </tr>
	            
	         </tbody>
	       </table>
	   </form>  
	</div>
	
  <div class="modal" tabindex="-1" role="dialog" id="userIdfind">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">아이디 찾기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
      	<div id="idFind">
        	<iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath() %>/login/idSearch.go">
             </iframe>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger myclose" data-dismiss="modal" onClick= "window.location.reload()" >Close</button>
      </div>
    </div>
  </div>
</div>
	
 
  
	 <div class="modal" tabindex="-1" role="dialog" id="passwdFind">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">비밀번호 찾기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" >
      	<div id="pwFind">
        	<iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath() %>/login/pwdSearch.go">
             </iframe>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger myclose" data-dismiss="modal" onClick= "window.location.reload()" >Close</button>
      </div>
    </div>
  </div>
</div>
	
	
	
<%-- 풋터 시작 --%> 
<jsp:include page="/WEB-INF/footer.jsp" />
