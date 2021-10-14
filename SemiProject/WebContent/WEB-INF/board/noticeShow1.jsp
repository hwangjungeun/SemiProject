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
    width: 1200px;
    margin: auto;
}

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: auto;
}

div.typeWrite{
	width: 1200px;
	vertical-align: middle;
	margin: auto;
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
}
tr#bt {
	border-top: hidden;
	border-bottom: 1px solid #dfdfdf;
}

th {
	font-size: 9pt;
    padding: 12px 0px 12px 18px;
}
td {
	font-size: 9pt;
    padding: 8px 0px 7px;
}
span.date {
	font-weight: bold;
}
span.txtNum {
	color: #737373;
}
td#content {
    font-size: 12px;
    line-height: 22px;
    min-height: 100px;
    text-align: center;
}
td#btt {
	border-bottom: 1px solid #dfdfdf;
}

.button {
	width: 100px;
	height: 32px;
	border: 1px solid #8c8c8c;
    float: right;
    text-align: center;
    font-size: 9pt;
    padding: 5px;
    margin-right: 50px;
}


</style>


<jsp:include page="../header.jsp" />



<div id="container">
     <div id="contents">


	<div class="titleArea">
            <h2><font color="#333333">NOTICE</font> </h2>
            <p class="desc">공지사항입니다.</p>
    </div>
	<br>

	<div class="typeWrite ">
            <table class="tbl">

			<colgroup>
			<col style="width:130px;">
			<col style="width:auto;">
			</colgroup> 

				<tr id="top">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;제목</th>
				   <td>&nbsp;&nbsp;무통장 입금 안내</td>
				</tr>
				<tr id="bt">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;작성자</th>
				   <td id="btt">&nbsp;&nbsp; oh! daily</td>
                            <td><span class="date">date</span><span class="txtNum">&nbsp;2021-10-01</span></td>
		        </tr>
				<tr>
				   <td id="content" colspan="2">
				   <p><br></p>
				   <p><br></p>
				   <p><br></p>
				   <p><br></p>
				   <p><strong>결제 예정 금액이 동일한 무통장입금 주문건이&nbsp;</strong></p>
				   <p><strong>여러개가 생성되었을 경우 자동 입금 확인이 누락될 수 있어,</strong></p>
				   <p><strong>입금 확인 처리가 되지 않을 경우 고객센터 또는 문의 게시판에</strong></p>
				   <p><strong>입금자명 및 입금일 기재하여 입금확인요청 부탁드립니다 !</strong></p>
				   <p><strong>또한, 결제시 기재해주신 입금자명과 주문자명이 다를 경우 자동 입금 확인 처리가 불가한 점 안내드립니다.</strong></p>
				   <p><br></p>
				   <p><strong>*주문건이 여러개일 경우 입금확인 원하시는 주문번호 기재 부탁드리겠습니다 :)</strong></p>
				   <p><br></p>
				   <p><br></p>
				   <p><br></p>
				   <p><strong></strong><br></p>
				   <p><span style="font-size: 9pt;">해당 사항으로 인해 번거로움을 드린 점 사과말씀 드립니다.</span></p>
				   <p><span style="font-size: 9pt;">더욱 열심히 하는 오!데일리가 되겠습니다!</span></p>
				   <p><span style="font-size: 9pt;"><br></span></p>
				   <p><span style="font-size: 9pt;">감사합니다</span></p>
				   <p><br></p>
				   <p><br></p>
				   </td>		
				</tr>   
		 </table>
</div>
<br>
		<div class="button">	
            <a href="<%=ctxPath%>/board/notice.go">목록</a>
        </div>

<br><br><br><br><br><br><br><br><br><br><br><br>


</div>
</div>

<jsp:include page="../footer.jsp" />

