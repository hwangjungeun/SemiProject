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
    width: 950px;
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

span.button {
	width: 96px;
	height: 35;
	border: 1px solid #b3b3b3;
    float: right;
    text-align: center;
    padding: 5px;
    margin-right: 150px;
}




</style>

<jsp:include page="../header.jsp" />

</head>
<script type="text/javascript">

$(document).ready(function(){
	

});
	

</script>

<div id="container">
    <div id="contents">

		<div class="titleArea">
            <h2><font color="#333333">Q & A</font> </h2>
            <p class="desc">Q&A 게시판입니다.</p>
    	</div>
    	
	<br>

<div class="typeWrite ">
<div id="num"> ♥&nbsp; ${requestScope.board_num}번 답글 &nbsp;♥ </div>
<br><br>
            <table class="tbl">

			<colgroup>
			<col style="width:150px;">
			<col style="width:650px;">
			<col style="width:150px;">
			</colgroup> 
				<tr id="top">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성자<span id="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${requestScope.board_id}</span></th>
				   <td> </td>
				   <td><span class="date">hit</span><span class="txtNum">&nbsp;&nbsp;${requestScope.board_count}</span></td>
                </tr>
                <tr id="mid">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목<span id="txt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${requestScope.board_subject}</span></th>
				   <td> </td>
				   <td><span class="date">date</span><span class="txtNum">&nbsp;&nbsp;${requestScope.board_date}</span></td>
				</tr>
                <tr id="btt">
				   <td style="width:800px; height:250px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${requestScope.board_content}</td>
				</tr>

</table>
<br><br>
<span class="button">	
		         <a href="<%=ctxPath%>/board/qnaList.go">목록</a> 
</span>

</div>
</div>
</div>

</body>
</html>

<jsp:include page="../footer.jsp" />

