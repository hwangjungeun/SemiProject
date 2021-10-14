<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     

<%
	String ctxPath = request.getContextPath();
	//		/SemiProject
%>


<!DOCTYPE html>
<html lang="ko">
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
    min-height: 800px;
}

div.typeWrite{
	width: 1250px;
	vertical-align: middle;
	margin: auto;
}

table.tbl {
    width: 1150px;
    margin: auto;
    border-top: 0.8px solid #dfdfdf;
    border-bottom: 1.5px solid #dfdfdf;
    line-height: 3.8;
    border-left: hidden;
    border-right: hidden;
}
tr#top{
	text-align: center;
}
tr#bt {
	border-top: 0.5px solid #dfdfdf;
	border-bottom: 0.5px solid #dfdfdf;
	text-align: center;
}

th {
	font-size: 9pt;
    padding: 12px 0px 12px 18px;
}
td {
	font-size: 9pt;
    padding: 8px 0px 7px;
}
td.subject{
	text-align: left;
}
span.date {
	font-weight: bold;
}
span.txtNum {
	color: #737373;
}
p.searchresult {
	text-align: center;
	color: #737373;
	font-size: 9pt;
}
form {
	margin-left: 60px;
}
input {
    height: 22px;
    line-height: 22px;
    margin-left: 150px;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
}
select {
    min-width: 100px;
    height: 22px;
    line-height: 22px;
    margin: 0 2 0 0px;
    padding: 0 0 0 5px;
    color: #333;
    border: 1px #d5d5d5 solid;
}
a.btn {
    padding: 2.5px 8px;
    border: 1px solid #d5d5d5;
    font-size: 9px;
    line-height: 17px;
    vertical-align: middle;
    text-align: center;
    color: #353535;
}


</style>
</head>
<body>
<jsp:include page="../header.jsp" />

<div id="container">
	<div id="contents">
		<div class="titleArea">
			<h2><font color="#353535">NOTICE</font> </h2>
			<p class="desc">공지사항입니다.</p>
		</div>
		<br>
	<div class="typeWrite ">
            <table class="tbl">
					<colgroup>
						<col style="width: 10%;">
						<col>
						<col style="width: 12%;">
						<col style="width: 10%;">
					</colgroup>
					<thead>
						<tr id="top">
							<th scope="col">no</th>
							<th scope="col">contents</th>
							<th scope="col">name</th>
							<th scope="col">date</th>
						</tr>
					</thead>
					<tbody>
						<tr id="bt">
							<td>공지</td>
							<td class="subject">
								<strong><a href="<%=ctxPath%>/board/noticeShow1.go" style="color:#353535;">무통장 입금 안내</a></strong>
							</td>
							<td>oh! daily</td>
							<td>2021-10-10</td>
						</tr>
						<tr id="bt">
							<td>공지</td>
							<td class="subject">
								<strong><a href="<%=ctxPath%>/board/noticeShow2.go" style="color:#353535;">적립금&쿠폰 시행 안내(21.09.27 시행)</a></strong>
							</td>
							<td>oh! daily</td>
							<td>2021-09-27</td>
						</tr>
						<tr id="bt">
							<td>공지</td>
							<td class="subject">
								<strong><a href="<%=ctxPath%>/board/noticeShow3.go" style="color:#353535;">구매/반품,취소 안내</a></strong>
							</td>
							<td>oh! daily</td>
							<td>2021-09-27</td>
						</tr>
						<tr id="bt">
							<td>공지</td>
							<td class="subject">
								<strong><a href="<%=ctxPath%>/board/noticeShow4.go" style="color:#353535;">주문 및 결제 안내</a></strong>
							</td>
							<td>oh! daily</td>
							<td>2021-08-03</td>
						</tr>
					</tbody>
				</table>	
			</div>
			<div class="xans-element- xans-board xans-board-buttonlist-8 xans-board-buttonlist xans-board-8 ec-base-button "><span class="gLeft">
            <form id="boardSearchForm" name="" action="/board/event/8" method="get" target="_top" enctype="multipart/form-data">
				<input id="board_no" name="board_no" value="8" type="hidden">
				<input id="page" name="page" value="1" type="hidden">
				<input id="board_sort" name="board_sort" value="" type="hidden"><div class="xans-element- xans-board xans-board-search-8 xans-board-search xans-board-8 "><fieldset class="boardSearch">
				<br><br>
				<p><select id="search_date" name="search_date">
					<option value="week">일주일</option>
					<option value="month">한달</option>
					<option value="month3">세달</option>
					<option value="all">전체</option>
				</select> 
				<select id="search_key" name="search_key">
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<option value="writer_name">글쓴이</option>
					<option value="member_id">아이디</option>
					<option value="nick_name">별명</option>
				</select> 
					<input id="search" name="search" class="inputTypeText" placeholder="" value="" type="text"> <a href="#none" class="btn" onclick="BOARD.form_submit('boardSearchForm');">찾기</a></p>
				</fieldset>
				</div>
			</form>
			</div>
			</div>	
		</div>

<jsp:include page="../footer.jsp" />
</body>
</html>

