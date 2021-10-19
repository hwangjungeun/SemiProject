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
button {
	width: 90px;
	height: 31px;
	border: 1px solid #8c8c8c;
	background-color: #444444;
    float: right;
    text-align: center;
    font-size: 9pt;
    padding: 5px;
    margin-right: 10px;
}
button.btn {
	border: 1px solid #8c8c8c;
}


</style>

<body>


<script type="text/javascript">

	
		$(document).ready(function(){
	    
		    $("button#GoEdit").click(function(){ // 수정할 글정보를 작성하고 수정하기 버튼을 클릭하면 작동하는 이벤트처리
		       
		        if( $("input[name=notice_id]").val().trim() == "" ){
		          alert("글쓴이를 입력해야합니다!");
		          return;
		       }
		       
		       if(  $("input[name=notice_subject]").val().trim() == ""  ){
		          alert("글제목을 입력해야합니다!");
		          return;
		       }
		       
		       if(  $("textarea[name=notice_content]").val().trim() == ""  ){
		          alert("글내용을 입력해야합니다!");
		          return;
		       }
		       
		       if( parseInt($("input[name=notice_subject]").val().length) > 100  ){
		          alert("글제목은 100글자까지 가능합니다.!");
		          return;
		       }
		       
		       
		    // 값을 보내기 위해 꺼놨던 인풋을 다시 켜준다.
		       $("input#notice_num").prop("disabled", false);
		       $("input#notice_id").prop("disabled", false);
		       
		       var frm = document.registerFrm;
		       frm.action="noticeEditEnd.go";
		       frm.method="POST";
		       frm.submit();	       
		       
		    });// end of $("button#btnGoInsert").click(function(){})---------------------------------
		    
		});// end of $(document).ready(function(){})-------------------------------


</script>




<div id="container" >
    <div id="contents">

		<div class="titleArea">
	           <h2><font color="#333333">NOTICE</font> </h2>
	           <p class="desc">공지사항입니다.</p>
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
			      <td style="font-weight: bold;">글번호&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
				      <input type="text" id="notice_num" name="notice_num" value="${requestScope.notice_num}" disabled="disabled"/>
			      </td> 
			   </tr>
			   <tr>
			      <td style="font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
				      <input type="text" id="notice_id" name="notice_id" value="${requestScope.notice_id}" disabled="disabled"/>&nbsp;&nbsp;
				      <span id="idcheckResult"></span>
			      </td> 
			   </tr>
			   <tr>
			      <td style="font-weight: bold;">제목&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
			          <input type="text" id="notice_subject" name="notice_subject" maxlength="100"  style="width:50%" placeholder="${requestScope.notice_subject}" autofocus required />
			      </td>
			   </tr>
			   <tr>
			      <td style="font-weight: bold;">내용&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
			        <textarea name="notice_content" style="width:650px; height:400px;" placeholder="${requestScope.notice_content}" wrap="hard" required style="resize: none; width: 90%;" ></textarea>
			      </td>
			   </tr>
			   <tr>
			      <td style="font-weight: bold;"width="25%" class="prodInputName">파일첨부(선택)</td>
			      <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
			         <input type="file" name="prdmanualFile" />
			      </td>
			   </tr>
			   <tr>
			   </tr>
		     </tbody>
		 </table>
		 <br>
		 	<button id="GoEdit" type="button" class="btn btn-dark btn-md" style="margin-right: 125px;">수정</button>
      		<button type="button" class="btn" onclick="javascript:history.back()">취소</button>
		 </form>
		<br><br>
		
	</div>
</div>

<jsp:include page="../footer.jsp" />