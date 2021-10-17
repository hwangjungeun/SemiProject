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

<style type="text/css">


#container {
    width: 1250px;
    margin: auto;
}

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: 1300px;
}	

.titleArea {
    margin: 0 0 30px;
    text-align: center;
}

.titleArea h2 {
    display: inline-block;
    position: relative;
    margin: 10px auto 10px;
    padding: 8px 15px;
    min-width: 180px;
    color: #353535;
    font-size: 11pt;
    font-weight: bold;
    letter-spacing: 1px;
    border: 1px #ddd solid;
}

table {
	margin: auto;
	position: relative;
    border: 1px solid #dfdfdf;
    line-height: 1.5;
    border-collapse: collapse;
}

</style>

<jsp:include page="../header.jsp" />

</head>
<script type="text/javascript">

// Function Declaration

function goShow(){
	   var frm = document.boardFrm;
	   frm.action = "qnaShow.go";
	   frm.method = "GET";
	   frm.submit();
}

</script>

<c:if test="${empty requestScope.bvo}">
	존재하지 않는 글입니다.<br>
</c:if> 

<c:if test="${not empty requestScope.bvo}">
	<c:set var="board_date" value="${requestScope.bvo.board_date}" />
	
	<h3>::: ${requestScope.bvo.board_id}님의 게시글 :::</h3>
	
	<div id="mvoInfo">
		<ol>
			<li><span class="myli">글번호 : </span>${requestScope.bvo.board_num}</li>
		 	<li><span class="myli">작성자 : </span>${requestScope.bvo.board_id}</li>
		 	<li><span class="myli">제목 : </span>${requestScope.bvo.board_subject}</li>
		 	<li><span class="myli">내용 : </span>${requestScope.bvo.board_content}</li>	
		 	<li><span class="myli">조회수 : </span>${requestScope.bvo.board_count}</li>
		 	<li><span class="myli">작성일 : </span>${requestScope.bvo.board_date}</li>
		 	
		</ol>
	</div>
	


</c:if>  

<div>
	<button style="margin-top: 50px;" type="button" onclick="javascript:history.back();">회원목록[history.back()]</button>
    &nbsp;&nbsp;3
</div>

</body>
</html>

<jsp:include page="../footer.jsp" />