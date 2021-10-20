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
    min-height: auto;
}

div.typeWrite{
	width: 1250px;
	vertical-align: middle;
	margin: auto;
}

table.tbl {
    width: 1250px;
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
	border-top: 1px solid #dfdfdf;
	border-bottom: 1px solid #dfdfdf;
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
    display: inline-block;
    min-width: 100px;
    height: 22px;
    line-height: 22px;
    margin: 0 2 0 0px;
    padding: 0 0 0 5px;
    color: #333;
    border: 1px #d5d5d5 solid;
}
a.btn {
    padding: 2px 8px;
    border: 1px solid #d5d5d5;
    font-size: 9px;
    line-height: 17px;
    vertical-align: middle;
    text-align: center;
    color: #353535;
}


</style>


<jsp:include page="../header.jsp" />



<div id="container">
     <div id="contents">


	<div class="titleArea">
            <h2><font color="#333333">DELAY</font> </h2>
            <p class="desc">입고 지연 게시판입니다.</p>
    </div>

	<br>

	<div class="typeWrite ">
            <table class="tbl">

			<colgroup>
			<col style="width:100px;">
			<col style="width:900;">
			<col style="width:100px;">
			<col style="width:100px;" class="">
			</colgroup>

				<thead class="thd">
				<tr id="top">
					<th scope="col">NO</th>
                    <th scope="col">CONTENTS</th>
                    <th scope="col">NAME</th>
                    <th scope="col">DATE</th>
                </tr>
                </thead>
				<tbody class="tdy">
				<tr id="bt">
				<td>공지</td>
                    <td class="subject">
                        <strong> <a href="<%=ctxPath%>/board/delayShow.go" style="color:#555555;">10/1 금 기준 입고 예정일 안내</a> <img src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_hit.gif" alt="HIT" class="ec-common-rwd-image"><span class="txtEm"></span></strong>
                    </td>
                    <td>oh! daily</td>
                    <td class="">2021-10-15</td>
                </tr>
	</tbody>
	</table><br><br><br><p class="searchresult">검색결과가 없습니다.</p>
    </div>

</div>

<div class="xans-element- xans-board xans-board-buttonlist-8 xans-board-buttonlist xans-board-8 ec-base-button "><span class="gLeft">
            <form id="boardSearchForm" name="" action="/board/event/8" method="get" target="_top" enctype="multipart/form-data">
				<input id="board_no" name="board_no" value="8" type="hidden">
				<input id="page" name="page" value="1" type="hidden">
				<input id="board_sort" name="board_sort" value="" type="hidden"><div class="xans-element- xans-board xans-board-search-8 xans-board-search xans-board-8 "><fieldset class="boardSearch">
				<br><br><br>
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

<br><br><br><br><br><br><br><br><br><br><br><br>


</div>

<jsp:include page="../footer.jsp" />
