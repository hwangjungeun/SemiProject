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

#contents {
    position: relative;
    margin: 0 auto;
    min-height: 750px;
    width:1250px;
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
p.desc {
	font-size: 9pt;
}
.box{
	text-align: center;
}

img {
	display: block;
	width: 500px;
	height: auto;
	margin: auto;
}
.ec-base-button {
    padding: 10px 0;
    text-align: center;
}
a.imgLink {
	font-size: 10pt;
}
strong {
	font-size: 10pt;
}
select{
	display: inline-block;
    min-width: 100px;
    height: 22px;
    margin: 0 2 0 0px;
    padding: 0 0 0 5px;
    color: #333;
    border: 1px #d5d5d5 solid;   
}
input {
    height: 22px;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
}
a.btnBasic {
    display: inline-block;
    box-sizing: border-box;
    padding: 2px 8px;
    border: 1px solid #d5d5d5;
    line-height: 16px;
    text-align: center;
    color: #353535;
}

.xans-board-listpackage .boardSort {
    float: left;
    margin: 0 0 10px;
}
.ec-base-table.typeList table {
	margin:auto;
	width:100%;
    border-top: 1px solid #dfdfdf;
    border-left: none;
    border-right: none;
}
.ec-base-table table {
    position: relative;
    margin: 10px 0 0;
    border-top: 1px solid #dfdfdf;
    border-bottom: 1px solid #dfdfdf;
    border-top: 0;
    color: #fff;
    line-height: 1.5;
}

.ec-base-table th:first-child {
    border-left: 0;
}
.ec-base-table thead th {
    padding: 12px 0;
    border-bottom: 1px solid #dfdfdf;
    color: #353535;
    vertical-align: middle;
    font-size: 11px;
    font-weight: 500;
    text-transform: uppercase;
    background: #fff;
    text-align: center;
}
.ec-base-table th {
    word-break: break-all;
    word-wrap: break-word;
}

.ec-base-table.typeList .center td.left {
    padding-left: 10px;
}
.ec-base-table.typeList .center td, .ec-base-table.typeList td.center {
    padding-left: 0;
    padding-right: 0;
}
.xans-board-listpackage .ec-base-table .subject {
    font-size: 12px;
}
.ec-base-table.typeList td {
    padding: 14px 10px;
    border-top: 1px #f1f1f1 solid;
}
.ec-base-table .left {
    text-align: left;
}
.ec-base-table td {
    padding: 12px 10px 12px;
    border-top: 1px solid #dfdfdf;
    color: #353535;
    font-size: 11px;
    vertical-align: middle;
    word-break: break-all;
    word-wrap: break-word;
}
th, td {
    border: 0;
    vertical-align: top;
    text-align: center;
}
.left {text-align:left;}
caption {display:none;}
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
		<div class="boardSort">
			<div class="ec-base-table typeList">
				<table border="1" summary="공지사항 게시판">
					<caption>게시판 목록</caption>
					<colgroup>
						<col style="width: 10%;">
						<col>
						<col style="width: 12%;">
						<col style="width: 10%;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">no</th>
							<th scope="col">contents</th>
							<th scope="col">name</th>
							<th scope="col">date</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td class="left">
								<strong><a href="/SemiProject/board/noticeShow.go" style="color:#353535;">가을맞이 리뷰 이벤트!</a></strong>
							</td>
							<td>oh! daily</td>
							<td>2021-10-10</td>
						</tr>
						<tr>
							<td>2</td>
							<td class="left">
								<strong><a href="/SemiProject/board/noticeShow.go" style="color:#353535;">클릭시 페이지 이동</a></strong>
							</td>
							<td>oh! daily</td>
							<td>2021-10-03</td>
						</tr>
						<tr>
							<td>3</td>
							<td class="left">
								<strong><a href="/SemiProject/board/noticeShow.go" style="color:#353535;">클릭시 페이지 이동</a></strong>
							</td>
							<td>oh! daily</td>
							<td>2021-09-28</td>
						</tr>
						<tr>
							<td>4</td>
							<td class="left">
								<strong><a href="/SemiProject/board/noticeShow.go" style="color:#353535;">클릭시 페이지 이동</a></strong>
							</td>
							<td>oh! daily</td>
							<td>2021-08-03</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />
</body>
</html>

