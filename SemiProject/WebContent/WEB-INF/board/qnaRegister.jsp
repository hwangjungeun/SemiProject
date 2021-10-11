<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     

<%
	String ctxPath = request.getContextPath();
	//		/SemiProject
%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="/SemiProject/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<jsp:include page="../header.jsp" />

</head>

<body>


<script type="text/javascript">
	
	window.onload = function(){
		
		alert("글이 성공적으로 등록되었습니다!");
		
		var frm = document.registerFrm;
		frm.action = "<%= ctxPath%>/board/qnaList.go"
		frm.method = "post";
		frm.submit();
		
	}// end of window.onload = function(){}-----------------------------
</script>

</head>
<body>
	<form name="registerFrm">
		 <c:forEach var="bvo" items="${requestScope.boardList}">
		            <tr>
		               <td>${bvo.board_num}</td>
		               <td>${bvo.board_id}</td>
		               <td>${bvo.board_subject}</td>
		               <td>${bvo.board_count}</td>
		               <td>${bvo.board_date}</td>
		            </tr>
		         </c:forEach>
	</form> 

</body>
</html>




<jsp:include page="../footer.jsp" />

