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

<style>
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

body {
	font-family: 'Nanum Gothic', sans-serif;
}
</style>

<script type="text/javascript">
	function move(url) {
		location.href=url;
	}
	function boardReplyCheck() {
		var form = document.BoardReplyForm;
		return true;
	}
</script>
</head>

<body>
	<table summary="전체 테이블 구성">
 	<tr>
  		<td bgcolor=#dcdcdc height=25 align=center>답변달기</td>
 	</tr>
	</table><br>

	<table summary= "답변 테이블 구성">
	<form name="BoardReplyForm" method="post" action="Board_Reply_action.jsp" 
														onsubmit="return boardReplyCheck();" >
 	<tr>
		<td>
		<table border=0 width=100% align=center>
	    <tr>
			<td align="center">작성자</td>
			<td ><input type=text name=name size=10 maxlength=8></td>
    	</tr>
    	<tr>
	 		<td align="center">E-Mail</td>
	 		<td><input type=text name=email size=30 maxlength=30></td>
    	</tr>
    	<tr>
			<td align="center">홈페이지</td>
			<td><input type=text name=homepage size=40 maxlength=30></td>
	    </tr>
		<tr>
			<td width=10% align="center">제 목</td>
			<td width=50%><input type=text name=title size=50 maxlength=30 value="RE : 게시판 글입니다."></td>
		</tr>
		<tr>
			<td width=10% align="center">내 용</td>
			<td><textarea name=content rows=10 cols=70> 가나다라마바사

----------------------------------------------

|댓글|

		</textarea></td>
		</tr>
		<tr>
			<td width=10% align="center">비밀 번호</td> 
			<td width=70% ><input type=password name="password" size=15 maxlength=15></td>
		    </tr>
		<tr>
			<td colspan=2><hr size=2></td>
		</tr>
		<tr>
			<td colspan="3" align="center">
			<input type="submit" value="답변 등록" class="btn" >&nbsp;
			<input type="button" value="뒤로가기" onclick="javascript:history.back()">
			</td>
		</tr> 
		</table>
		</td>
		</tr>
		</form> 
	</table>


</body>
</html>

<jsp:include page="../footer.jsp" />