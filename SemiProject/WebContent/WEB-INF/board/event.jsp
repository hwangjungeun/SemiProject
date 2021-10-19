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
<<<<<<< HEAD
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


</style>

<jsp:include page="../header.jsp" />

 <div class="container-fluid">
      <div id="contents">
	  <div class="titleArea" >
           <h2 id="event" align="center" ><font color="#333333">EVENT</font> </h2>
           <p class="desc" align="center">이벤트 공지 게시판입니다.</p>
           <p class="imgArea"><img src="https://nearwear.co.kr/web/upload/bc4d43b5f82e421450e1539def2717e1.jpg"></p>
      </div>


	<div class="xans-element- xans-board xans-board-list-8 xans-board-list xans-board-8">	
	<ul>
		<li class="xans-record-" style="list-style-type: none">
             <div class="box">
                 <a href="<%=ctxPath%>/board/eventShow.go" class="imgLink"><img src="../images/event.png" alt="" /></a>
                 <a href="<%=ctxPath%>/board/eventShow.go" class="imgLink"><br> 2021 가을맞이 무료배송 이벤트 </a>
                 <div>
                 <br>
                     <strong>oh! daily</strong>
                 </div>
             </div>
        </li>
</ul>
</div>
		<div class="ec-base-button"><span class="gLeft">
            <form id="boardSearchForm">
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
					<input id="search" name="search" class="inputTypeText" placeholder="" value="" type="text"> <a href="#none" class="btnBasic" onclick="BOARD.form_submit('boardSearchForm');">찾기</a></p>
				</fieldset>
</div>
</form>
</div>



            
</div>

<jsp:include page="../footer.jsp" />
