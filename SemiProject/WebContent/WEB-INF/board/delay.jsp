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
    text-align: center;
}
a {
	font-size: 10pt;
}
strong {
	font-size: 10pt;
}


</style>

<jsp:include page="../header.jsp" />

 <div class="container-fluid">
      <div id="contents">
	  <div class="titleArea" >
	            <h2 id="event" align="center" ><font color="#333333">EVENT</font> </h2>
	            <p class="desc" align="center">이벤트 공지 게시판입니다.</p>
	            <p class="imgArea"><img src="https://nearwear.co.kr/web/upload/bc4d43b5f82e421450e1539def2717e1.jpg"></p>
	           
	</div>


<div class="typeWrite ">
            <table class="tbl">

			<col style="width:70px;">
			<col style="width:135px;" class="displaynone">
			<col style="width:auto;">
			<col style="width:120px;">
			
			</colgroup>
<thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 "><tr style=" ">
<th scope="col"> no</th>
                    <th scope="col" class="displaynone">category</th>
                    <th scope="col">contents</th>
                    <th scope="col">name</th>
                    <th scope="col" class="">date</th>
                </tr></thead>
<tbody class="xans-element- xans-board xans-board-notice-1002 xans-board-notice xans-board-1002 center">
                    <tr class="xans-record-">
<td> 공지</td>
                    <td class="displaynone"></td>
                    <td class="subject left">
                        <strong> <a href="/article/delay/1002/29545/" style="color:#555555;">10/1 금 기준 입고 예정일 안내</a> <img src="http://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_hit.gif" alt="HIT" class="ec-common-rwd-image"><span class="txtEm"></span></strong>
                    </td>
                    <td>nearwear</td>
                    <td class="">2020-11-10</td>
                    
                </tr>
</tbody>
</table><p class="xans-element- xans-board xans-board-empty-1002 xans-board-empty xans-board-1002 message  ">검색결과가 없습니다.</p>
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
</select> <select id="search_key" name="search_key">
<option value="subject">제목</option>
<option value="content">내용</option>
<option value="writer_name">글쓴이</option>
<option value="member_id">아이디</option>
<option value="nick_name">별명</option>
</select> <input id="search" name="search" class="inputTypeText" placeholder="" value="" type="text"> <a href="#none" class="btnBasic" onclick="BOARD.form_submit('boardSearchForm');">찾기</a></p>
                </fieldset>
</div>
</form>
</div>



            
</div>

<jsp:include page="../footer.jsp" />

