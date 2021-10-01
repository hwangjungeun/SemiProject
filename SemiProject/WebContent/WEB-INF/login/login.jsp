<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      

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
   
   button#btnSubmit{
    width: 80%;
     display: block;
    margin: 0 0 5px;
    padding: 15px;
    font-size: 15px;
    font-weight: bold;
    background-color: #a6a6a6;
   }
   
</style>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>::: LOGIN :::</title>
</head>
<body>
<jsp:include page="/WEB-INF/header.jsp" />
<%-- 헤더 끝 --%>
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
	               <td style="width: 80%; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="text" id="loginUserid" name="userid" size="20" class="box" autocomplete="off" /></th>
	            </tr>   
	            <tr id = "PWD">
	               <th style="width: 20%; border-top: hidden; border-bottom: hidden; border-right: hidden; padding: 10px;">암호</th>
	               <td style="width: 80%; border-top: hidden; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="password" id="loginPwd" name="pwd" size="20" class="box" /></td>
	            </tr>
	            
	            <%-- === 아이디 찾기, 비밀번호 찾기 === --%>
	            <tr>
	               <td colspan="2" align="center">
	                  <a style="cursor: pointer;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">아이디찾기</a> /
	                  <a style="cursor: pointer;" data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" data-backdrop="static">비밀번호찾기</a>
	               </td>
	            </tr>
	            
	            <tr>
	               <td colspan="2" align="center" style="padding: 10px;">
	                  <input type="checkbox" id="saveid" name="saveid" /><label for="saveid">아이디저장</label>
	               <%--    
	                  <button type="button" id="btnSubmit" style="width: 67px; height: 27px; background-image: url('<%= request.getContextPath()%>/images/login.png'); vertical-align: middle; border: none;"></button>
	               --%>
	                   <button type="button" id="btnSubmit" ><span style ="color:white">로그인</span></button>
	                   <button type="button" id="btnRegister" ><span style ="color:white">로그인</span></button>
	               </td>
	            </tr>
	            
	         </tbody>
	       </table>
	   </form>  
	</div>

<%-- 풋터 시작 --%> 
<jsp:include page="/WEB-INF/footer.jsp" />
</body>
</html>