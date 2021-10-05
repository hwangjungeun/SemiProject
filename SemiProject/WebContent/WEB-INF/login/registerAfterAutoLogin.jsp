<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	window.onload = function(){
		
		alert("오!데일리의 회원가입을 축하합니다.");
		
		var frm = document.loginFrm;
		
		frm.action = "<%=ctxPath%>/login/login.go";
		frm.method="post";
		frm.submit();
		
	}

</script>

</head>
<body>
	<form name ="loginFrm">
		<input type="hidden" name="userid"  value="${requestScope.userid }"/>
		<input type="hidden" name="pwd" 	value="${requestScope.pwd }"/>
	</form>
</body>
</html>