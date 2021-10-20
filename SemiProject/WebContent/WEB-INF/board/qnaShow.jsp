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

p.desc {
	font-size: 9pt;
}

#container {
    width: 1250px;
    margin: auto;
}

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: 1000px;
}
div#num {
	text-align: center;
	font-size: 11pt;
	font-weight: bold;
}
table.tbl {
    width: 1100px;
    margin: auto;
    border-top: 1.5px solid #dfdfdf;
    border-bottom: 1.5px solid #dfdfdf;
    line-height: 3.5;
    border-left: hidden;
    border-right: hidden;
}
tr#top {
	border-top: 1px solid #dfdfdf;
	border-bottom: hidden;
}
tr#mid {
	border-bottom: 0.5px solid #dfdfdf;
}
tr#bt {
	border-bottom: 1px solid #dfdfdf;
}
th {
	font-size: 9pt;

}
td {
	font-size: 9pt;
    padding: 8px 0px 7px;

}
span#txt {
	font-weight: lighter;
}
span.date {
	font-weight: bold;
}
span.txtNum {
	color: #737373;
}
tr.view {
	border-top: hidden;
	border-bottom: 1px solid #dfdfdf;
}
span#delaylist {
	font-weight: bold;
	font-size: 12pt;
}
span#delayred {
	font-weight: bold;
	font-size: 12pt;
	color: red;
}
span.button {
	width: 90px;
	height: 30px;
	border: 1px solid #8c8c8c;
	background-color: #ffffff;
    float: right;
    text-align: center;
    padding: 5px;
    margin-right: 100px;
}
button#list {
	width: 90px;
	height: 30px;
    float: right;
    text-align: center;
    margin-right: 5px;
    background-color: #444444;
    color: #ffffff;
    padding: 6px;
}

button#btn {
	width: 90px;
	height: 30px;
	border: 1px solid #8c8c8c;
	background-color: #ffffff;
    float: right;
    text-align: center;
    padding: 5px;
    margin-right: 5px;
}

button#reply {
	width: 60px;
	height: 30px;
	border: 1px solid #8c8c8c;
	background-color: ##dfdfdf;
    float: left;
    text-align: center;
    padding: 5px;
    margin-left: 75px;
}



</style>

<jsp:include page="../header.jsp" />

</head>
<script type="text/javascript">

$(document).ready(function(){
	
	$("span.button").click(function(){
		
		if("${requestScope.userid}"=="no"){
			alert("로그인 후 이용 가능합니다");
		}
		else if("${requestScope.userid}"!="${requestScope.bvo.board_id}"){
			alert("다른작성자의 게시글 수정은 불가 합니다.");
		}
		else{
			 var frm = document.goEdit;
			 frm.action = "qnaEdit.go";
			 frm.method = "post";
			 frm.submit();
		}
		
	}); // end of $("span.button").click(function()-------------------------------
	
	$("button#btn").click(function(){
		
		if("${requestScope.userid}"=="no"){
			alert("로그인 후 이용 가능합니다");
		}
		else if("${requestScope.userid}"!="${requestScope.bvo.board_id}"){
			alert("다른작성자의 게시글 삭제는 불가 합니다.");
		}
		else{
			 var frm = document.delFrm;
			 frm.action = "qnaDelete.go";
			 frm.method = "post";
			 frm.submit();
		}
	});
	
	$("button#reply").click(function(){
		
			 var frm = document.goReply;
			 frm.action = "qnaReply.go";
			 frm.method = "post";
			 frm.submit();
	});


});// end of $(document).ready(function(){})-------------------------------------------
	

</script>

<div id="container">
    <div id="contents">

		<div class="titleArea">
            <h2><font color="#333333">Q & A</font> </h2>
            <p class="desc">Q&A 게시판입니다.</p>
    	</div>
    	
	<br>

<div class="typeWrite ">
<div id="num"> ♥&nbsp; ${requestScope.board_num}번 게시글 &nbsp;♥ </div>
<br><br>
            <table class="tbl">

			<colgroup>
			<col style="width:150px;">
			<col style="width:650px;">
			<col style="width:150px;">
			</colgroup> 
				<tr id="top">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성자<span id="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${requestScope.bvo.board_id}</span></th>
				   <td> </td>
				   <td><span class="date">hit</span><span class="txtNum">&nbsp;&nbsp;${requestScope.bvo.board_count}</span></td>
                </tr>
                <tr id="mid">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목<span id="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${requestScope.bvo.board_subject}</span></th>
				   <td> </td>
				   <td><span class="date">date</span><span class="txtNum">&nbsp;&nbsp;${requestScope.bvo.board_date}</span></td>
				</tr>
                <tr id="btt">
				   <td style="width:750px; height:200px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${requestScope.bvo.board_content}</td>
				</tr>

</table>
<br><br>
<div>
	<span class="button" style="margin-right: 75px;">수정</span>
	<button id="list" type="button" onclick="javascript:history.back();">글목록</button>
    <button id="btn" type="button">삭제</button>
    <button id="reply" type="button">답글</button>

</div>

</div>
</div>
</div>

<form name="goEdit">
	<input type="hidden" name="board_num" value="${requestScope.bvo.board_num}"/>
	<input type="hidden" name="board_id" value="${requestScope.bvo.board_id}"/>
	<input type="hidden" name="board_count" value="${requestScope.bvo.board_count}"/>
	<input type="hidden" name="board_subject" value="${requestScope.bvo.board_subject}"/>
	<input type="hidden" name="board_date" value="${requestScope.bvo.board_date}"/>
	<input type="hidden" name="board_content" value="${requestScope.bvo.board_content}"/>
</form>

<form name="delFrm">
	<input type="hidden" name="board_num" value="${requestScope.bvo.board_num}"/>
</form>

<form name="goReply">
	<input type="hidden" name="board_num" value="${requestScope.bvo.board_num}"/>
	<input type="hidden" name="board_content" value="${requestScope.bvo.board_content}"/>
</form>


</body>
</html>

<jsp:include page="../footer.jsp" />

