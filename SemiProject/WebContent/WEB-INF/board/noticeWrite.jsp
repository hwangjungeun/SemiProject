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

<jsp:include page="../header.jsp" />

</head>
<script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
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

table.tbl {
	width: 1000px;
	margin: auto;
	text-align: center;
	border: 1px solid #d5d5d5;
	line-height: 25px;
}
td {
	border: 1px solid #d5d5d5;
	padding: 4px 3px 4px 6px;
}
input {
	border: 1px solid #d5d5d5;
}
textarea {
	border: 1px solid #d5d5d5;
}
/*
input {
	border: solid 1px white;
	border-bottom: solid 1px #d5d5d5;
	
}
*/
button {
	width: 90px;
	height: 31px;
	border: 1px solid #8c8c8c;
	background-color: #ffffff;
    float: right;
    text-align: center;
    font-size: 9pt;
    padding: 5px;
    margin-right: 120px;
}
button#btn {
	background-color: #444444;
	color: #ffffff;
}


</style>

<body>


<script type="text/javascript">

	
	$(document).ready(function() {
	
				var frm = document.registerFrm;
				frm.action = "<%=ctxPath%>/board/noticeList.go";
				frm.method = "post";
				frm.submit();

		});// end of $(document).ready(function(){})-------------------------------


</script>

<div id="container" >
    <div id="contents">

		<div class="titleArea">
	           <h2><font color="#333333">Q & A</font> </h2>
	           <p class="desc">Q&A 게시판입니다.</p>
	    </div>
		<br><br>   
    
		<form name="registerFrm">
		
		<table class="tbl" border="1" >
			<thead>
			 	<tr> 
			       <th colspan="2" id="th"><span style="font-size: 9pt; "><span class="star">*</span>표시는 필수입력사항 입니다.</span></th>
			  	</tr>
			</thead>
		    <tbody>
		    
			   <tr>
			      <td style="font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
				      <input type="text" name="board_id" id="board_id" class="requiredInfo" />&nbsp;&nbsp;
				      <span id="idcheckResult"></span>
				      <span class="error">아이디는 필수입력 사항입니다.</span>
			      </td> 
			   </tr>
			   <tr>
			      <td style="font-weight: bold;">제목&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
			         <input type="text" name="board_subject" id="board_subject" class="requiredInfo" style="width:60%"/> 
			         <span class="error">제목은 필수입력 사항입니다.</span>
			      </td>
			   </tr>
			   <tr>
			      <td style="font-weight: bold;">내용&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
			         <input type="text" name="board_content" id="board_content" class="requiredInfo" style="width:650px; height:250px;"/>
			         <span class="error">내용은 필수입력 사항입니다.</span>
			      </td>
			   </tr>
			   <tr>
				   <td style="font-weight: bold;">개인정보 수집 및 이용 동의&nbsp;<span class="star">*</span></td>
				   <td style="text-align: left; vertical-align: middle;">
			       		<iframe src="../iframeAgree/infoagree.html" width="80%" height="auto" class="box" ></iframe>   
			       </td>
			   </tr>
			  	<tr>
				   <td colspan="2" style="line-height: 50px;" class="text-center">
				    	<label for="agree">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
				   </td>
			  	</tr>
		     </tbody>
		 </table>
		 </form>
		<br><br>
		
		<button style="margin-right: 120px;" type="button" onclick="javascript:history.back();">취소</button>
		<button id="btn" style="margin-right: 5px;">등록</button>
		

		
	</div>
</div>

<jsp:include page="../footer.jsp" />